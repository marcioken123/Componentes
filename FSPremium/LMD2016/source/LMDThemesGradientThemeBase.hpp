// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesGradientThemeBase.pas' rev: 31.00 (Windows)

#ifndef LmdthemesgradientthemebaseHPP
#define LmdthemesgradientthemebaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.TypInfo.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDXML.hpp>
#include <LMDThemes.hpp>
#include <LMDGraph.hpp>
#include <LMDThemesCommonTypes.hpp>
#include <LMDFillers.hpp>
#include <LMDFigures.hpp>
#include <LMDGradientFrames.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemesgradientthemebase
{
//-- forward type declarations -----------------------------------------------
struct TLMDGradientThemeFillDescriptor;
struct TLMDGradientThemeFrameDescriptor;
struct TLMDGradientThemeTextDescriptor;
class DELPHICLASS TLMDBaseGradientThemeRenderer;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDGradientTheme : unsigned char { gtOffice2007, gtCustom, gtUnknown };

typedef System::StaticArray<System::UnicodeString, 3> Lmdthemesgradientthemebase__1;

enum DECLSPEC_DENUM TLMDGradientFillPart : unsigned char { gfpMain, gfpDeco1, gfpDeco2, gfpDeco3, gfpDeco4 };

typedef System::Set<TLMDGradientFillPart, TLMDGradientFillPart::gfpMain, TLMDGradientFillPart::gfpDeco4> TLMDGradientFillParts;

enum DECLSPEC_DENUM TLMDGradientThemeFillParam : unsigned char { gflpRenderMode };

enum DECLSPEC_DENUM TLMDGradientThemeFrameParam : unsigned char { gfrpRenderMode, gfrpOuterBorderSides, gfrpInnerBorderSides, gfrpOuterBorderEdgeWidth, gfrpInnerBorderEdgeWidth, gfrpSpaceEdgeWidth, gfrpOuterBorderWidth, gfrpInnerBorderWidth, gfrpOuterBorderGap, gfrpInnerBorderGap, gfrpTopSpaceWidth, gfrpRightSpaceWidth, gfrpBottomSpaceWidth, gfrpLeftSpaceWidth, gfrpCutValueUsage, gfrpOuterBorderInnerCutType, gfrpOuterBorderOuterCutType, gfrpOuterBorderInnerCutX, gfrpOuterBorderInnerCutY, gfrpOuterBorderOuterCutX, gfrpOuterBorderOuterCutY, gfrpOuterBorderInnerCutXValueType, gfrpOuterBorderInnerCutYValueType, gfrpOuterBorderOuterCutXValueType, gfrpOuterBorderOuterCutYValueType, gfrpInnerSpaceInnerCutType, gfrpInnerSpaceOuterCutType, gfrpInnerSpaceInnerCutX, 
	gfrpInnerSpaceInnerCutY, gfrpInnerSpaceOuterCutX, gfrpInnerSpaceOuterCutY, gfrpInnerSpaceInnerCutXValueType, gfrpInnerSpaceInnerCutYValueType, gfrpInnerSpaceOuterCutXValueType, gfrpInnerSpaceOuterCutYValueType, gfrpInnerBorderOuterCutType, gfrpInnerBorderInnerCutType, gfrpInnerBorderOuterCutX, gfrpInnerBorderOuterCutY, gfrpInnerBorderInnerCutX, gfrpInnerBorderInnerCutY, gfrpInnerBorderOuterCutXValueType, gfrpInnerBorderOuterCutYValueType, gfrpInnerBorderInnerCutXValueType, gfrpInnerBorderInnerCutYValueType };

typedef System::StaticArray<System::Byte, 1> TLMDGradientThemeFillParams;

typedef System::StaticArray<System::Byte, 45> TLMDGradientThemeFrameParams;

struct DECLSPEC_DRECORD TLMDGradientThemeFillDescriptor
{
public:
	TLMDGradientThemeFillParams Params;
	System::StaticArray<Lmdfillers::TLMDFiller*, 5> Fillers;
};


struct DECLSPEC_DRECORD TLMDGradientThemeFrameDescriptor
{
public:
	TLMDGradientThemeFrameParams Params;
	System::StaticArray<Lmdfillers::TLMDFiller*, 3> Fillers;
};


struct DECLSPEC_DRECORD TLMDGradientThemeTextDescriptor
{
public:
	tagLOGFONTW Params;
	System::Uitypes::TColor Color;
};


typedef System::StaticArray<TLMDGradientThemeFillDescriptor, 256> TLMDGradientThemeFillData;

typedef TLMDGradientThemeFillData *PLMDGradientThemeFillData;

typedef System::StaticArray<TLMDGradientThemeFrameDescriptor, 256> TLMDGradientThemeFrameData;

typedef TLMDGradientThemeFrameData *PLMDGradientThemeFrameData;

typedef System::StaticArray<TLMDGradientThemeTextDescriptor, 256> TLMDGradientThemeTextData;

typedef TLMDGradientThemeTextData *PLMDGradientThemeTextData;

class PASCALIMPLEMENTATION TLMDBaseGradientThemeRenderer : public Lmdthemes::TLMDThemeRenderer
{
	typedef Lmdthemes::TLMDThemeRenderer inherited;
	
private:
	bool FEnabled;
	TLMDGradientTheme FTheme;
	System::UnicodeString FThemeName;
	Lmdclass::TLMDColorScheme FColorScheme;
	System::UnicodeString FColorSchemeName;
	bool FIsUpdating;
	System::StaticArray<System::StaticArray<Lmdfillers::TLMDFiller*, 4>, 4> FGradientArrowFiller;
	System::StaticArray<System::Uitypes::TColor, 2> FSimpleArrowColors;
	System::StaticArray<System::Uitypes::TColor, 2> FSimpleArrowShadowColors;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 2> FCheckMarkFill;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 2> FRadioBtnCheckMarkFill;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 2> FMixedMarkFill;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 50> FButtonFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 50> FButtonFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 58> FToolbarFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 58> FToolbarFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 31> FComboboxFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 31> FComboboxFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 37> FEditFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 37> FEditFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 18> FSpinBtnFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 18> FSpinBtnFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 68> FScrollBarFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 68> FScrollBarFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 45> FTabFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 45> FTabFrame;
	System::StaticArray<TLMDGradientThemeTextDescriptor, 45> FTabText;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 16> FProgressFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 16> FProgressFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 21> FHeaderFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 21> FHeaderFrame;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 13> FTreeViewFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 36> FTrackBarFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 36> FTrackBarFrame;
	System::StaticArray<TLMDGradientThemeFillDescriptor, 5> FStatusBarFill;
	System::StaticArray<TLMDGradientThemeFrameDescriptor, 5> FStatusBarFrame;
	System::Uitypes::TColor FEnabledTextColor;
	System::Uitypes::TColor FDisabledTextColor;
	Lmdthemescommontypes::TLMDThemeElementMetaData FMetaData;
	System::Classes::TStringList* FMetaDataPool;
	System::Classes::TStringList* FFillerToolBox;
	Lmdgradientframes::TLMDGradientRectFrame* FRFrame;
	Lmdgradientframes::TLMDGradientCircleFrame* FCFrame;
	Lmdfigures::TLMDRoundRectangle* FRoundRectangle;
	Lmdfigures::TLMDCustomCutRectangle* FCCRectangle;
	Lmdfigures::TLMDCircle* FCircle;
	Lmdfigures::TLMDRectangle* FRectangle;
	Lmdfigures::TLMDLine* FLine1;
	Lmdfigures::TLMDLine* FLine2;
	System::Classes::TStringList* FBmpCache;
	Vcl::Graphics::TPixelFormat FPixelFormat;
	Lmdxml::_di_ILMDXmlDocument FXmlDoc;
	bool FModified;
	bool FUseCache;
	Lmdthemes::TLMDThemesOnDrawElement FOnDrawElement;
	Lmdthemes::TLMDThemesOnDrawCheckMarkEvent FOnDrawCheckMark;
	Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent FOnDrawScrollThumbGripper;
	Lmdthemes::TLMDThemesOnDrawArrowEvent FOnDrawArrow;
	Lmdthemes::TLMDThemesOnDrawGradientArrowEvent FOnDrawGradientArrow;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawPlus;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawMinus;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawCross;
	bool FSuppressUpdate;
	void __fastcall SetColorSchemeName(const System::UnicodeString Value);
	void __fastcall FinalizeFrameFillers(Lmdgradientframes::TLMDBaseGradientFrame* aFrame, const TLMDGradientThemeFrameDescriptor &aFrameDescriptor);
	System::Uitypes::TColor __fastcall GetDisabledTextColor(void);
	System::Uitypes::TColor __fastcall GetEnabledTextColor(void);
	void __fastcall SetDisabledTextColor(const System::Uitypes::TColor Value);
	void __fastcall SetEnabledTextColor(const System::Uitypes::TColor Value);
	Lmdthemescommontypes::TLMDThemeDetailMetaData __fastcall GetMetaData(Vcl::Themes::TThemedElement Element);
	Lmdfillers::TLMDFiller* __fastcall GetButtonFillFiller(Vcl::Themes::TThemedButton index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetButtonFillParam(Vcl::Themes::TThemedButton index, TLMDGradientThemeFillParam param);
	Lmdfillers::TLMDFiller* __fastcall GetButtonFrameFiller(Vcl::Themes::TThemedButton index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetButtonFrameParam(Vcl::Themes::TThemedButton index, TLMDGradientThemeFrameParam param);
	void __fastcall SetButtonFillFiller(Vcl::Themes::TThemedButton index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetButtonFillParam(Vcl::Themes::TThemedButton index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetButtonFrameFiller(Vcl::Themes::TThemedButton index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetButtonFrameParam(Vcl::Themes::TThemedButton index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetButtonFill(Vcl::Themes::TThemedButton index);
	TLMDGradientThemeFrameDescriptor __fastcall GetButtonFrame(Vcl::Themes::TThemedButton index);
	void __fastcall SetButtonFill(Vcl::Themes::TThemedButton index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetButtonFrame(Vcl::Themes::TThemedButton index, const TLMDGradientThemeFrameDescriptor &Value);
	TLMDGradientThemeFillDescriptor __fastcall GetComboBoxFill(Vcl::Themes::TThemedComboBox index);
	Lmdfillers::TLMDFiller* __fastcall GetComboBoxFillFiller(Vcl::Themes::TThemedComboBox index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetComboBoxFillParam(Vcl::Themes::TThemedComboBox index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetComboBoxFrame(Vcl::Themes::TThemedComboBox index);
	Lmdfillers::TLMDFiller* __fastcall GetComboBoxFrameFiller(Vcl::Themes::TThemedComboBox index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetComboBoxFrameParam(Vcl::Themes::TThemedComboBox index, TLMDGradientThemeFrameParam param);
	void __fastcall SetComboBoxFill(Vcl::Themes::TThemedComboBox index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetComboBoxFillFiller(Vcl::Themes::TThemedComboBox index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetComboBoxFillParam(Vcl::Themes::TThemedComboBox index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetComboBoxFrame(Vcl::Themes::TThemedComboBox index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetComboBoxFrameFiller(Vcl::Themes::TThemedComboBox index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetComboBoxFrameParam(Vcl::Themes::TThemedComboBox index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetEditFill(Vcl::Themes::TThemedEdit index);
	Lmdfillers::TLMDFiller* __fastcall GetEditFillFiller(Vcl::Themes::TThemedEdit index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetEditFillParam(Vcl::Themes::TThemedEdit index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetEditFrame(Vcl::Themes::TThemedEdit index);
	Lmdfillers::TLMDFiller* __fastcall GetEditFrameFiller(Vcl::Themes::TThemedEdit index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetEditFrameParam(Vcl::Themes::TThemedEdit index, TLMDGradientThemeFrameParam param);
	TLMDGradientThemeFillDescriptor __fastcall GetSpinBtnFill(Vcl::Themes::TThemedSpin index);
	Lmdfillers::TLMDFiller* __fastcall GetSpinBtnFillFiller(Vcl::Themes::TThemedSpin index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetSpinBtnFillParam(Vcl::Themes::TThemedSpin index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetSpinBtnFrame(Vcl::Themes::TThemedSpin index);
	Lmdfillers::TLMDFiller* __fastcall GetSpinBtnFrameFiller(Vcl::Themes::TThemedSpin index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetSpinBtnFrameParam(Vcl::Themes::TThemedSpin index, TLMDGradientThemeFrameParam param);
	void __fastcall SetEditFill(Vcl::Themes::TThemedEdit index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetEditFillFiller(Vcl::Themes::TThemedEdit index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetEditFillParam(Vcl::Themes::TThemedEdit index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetEditFrame(Vcl::Themes::TThemedEdit index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetEditFrameFiller(Vcl::Themes::TThemedEdit index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetEditFrameParam(Vcl::Themes::TThemedEdit index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	void __fastcall SetSpinBtnFill(Vcl::Themes::TThemedSpin index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetSpinBtnFillFiller(Vcl::Themes::TThemedSpin index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetSpinBtnFillParam(Vcl::Themes::TThemedSpin index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetSpinBtnFrame(Vcl::Themes::TThemedSpin index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetSpinBtnFrameFiller(Vcl::Themes::TThemedSpin index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetSpinBtnFrameParam(Vcl::Themes::TThemedSpin index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetToolbarFill(Vcl::Themes::TThemedToolBar index);
	Lmdfillers::TLMDFiller* __fastcall GetToolbarFillFiller(Vcl::Themes::TThemedToolBar index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetToolbarFillParam(Vcl::Themes::TThemedToolBar index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetToolbarFrame(Vcl::Themes::TThemedToolBar index);
	Lmdfillers::TLMDFiller* __fastcall GetToolbarFrameFiller(Vcl::Themes::TThemedToolBar index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetToolbarFrameParam(Vcl::Themes::TThemedToolBar index, TLMDGradientThemeFrameParam param);
	void __fastcall SetToolbarFill(Vcl::Themes::TThemedToolBar index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetToolbarFillFiller(Vcl::Themes::TThemedToolBar index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetToolbarFillParam(Vcl::Themes::TThemedToolBar index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetToolbarFrame(Vcl::Themes::TThemedToolBar index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetToolbarFrameFiller(Vcl::Themes::TThemedToolBar index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetToolbarFrameParam(Vcl::Themes::TThemedToolBar index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetScrollBarFill(Vcl::Themes::TThemedScrollBar index);
	Lmdfillers::TLMDFiller* __fastcall GetScrollBarFillFiller(Vcl::Themes::TThemedScrollBar index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetScrollBarFillParam(Vcl::Themes::TThemedScrollBar index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetScrollBarFrame(Vcl::Themes::TThemedScrollBar index);
	Lmdfillers::TLMDFiller* __fastcall GetScrollBarFrameFiller(Vcl::Themes::TThemedScrollBar index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetScrollBarFrameParam(Vcl::Themes::TThemedScrollBar index, TLMDGradientThemeFrameParam param);
	void __fastcall SetScrollBarFill(Vcl::Themes::TThemedScrollBar index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetScrollBarFillFiller(Vcl::Themes::TThemedScrollBar index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetScrollBarFillParam(Vcl::Themes::TThemedScrollBar index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetScrollBarFrame(Vcl::Themes::TThemedScrollBar index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetScrollBarFrameFiller(Vcl::Themes::TThemedScrollBar index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetScrollBarFrameParam(Vcl::Themes::TThemedScrollBar index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetTabFill(Vcl::Themes::TThemedTab index);
	Lmdfillers::TLMDFiller* __fastcall GetTabFillFiller(Vcl::Themes::TThemedTab index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetTabFillParam(Vcl::Themes::TThemedTab index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetTabFrame(Vcl::Themes::TThemedTab index);
	Lmdfillers::TLMDFiller* __fastcall GetTabFrameFiller(Vcl::Themes::TThemedTab index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetTabFrameParam(Vcl::Themes::TThemedTab index, TLMDGradientThemeFrameParam param);
	void __fastcall SetTabFill(Vcl::Themes::TThemedTab index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetTabFillFiller(Vcl::Themes::TThemedTab index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetTabFillParam(Vcl::Themes::TThemedTab index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetTabFrame(Vcl::Themes::TThemedTab index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetTabFrameFiller(Vcl::Themes::TThemedTab index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetTabFrameParam(Vcl::Themes::TThemedTab index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetProgressFill(Vcl::Themes::TThemedProgress index);
	Lmdfillers::TLMDFiller* __fastcall GetProgressFillFiller(Vcl::Themes::TThemedProgress index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetProgressFillParam(Vcl::Themes::TThemedProgress index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetProgressFrame(Vcl::Themes::TThemedProgress index);
	Lmdfillers::TLMDFiller* __fastcall GetProgressFrameFiller(Vcl::Themes::TThemedProgress index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetProgressFrameParam(Vcl::Themes::TThemedProgress index, TLMDGradientThemeFrameParam param);
	void __fastcall SetProgressFill(Vcl::Themes::TThemedProgress index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetProgressFillFiller(Vcl::Themes::TThemedProgress index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetProgressFillParam(Vcl::Themes::TThemedProgress index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetProgressFrame(Vcl::Themes::TThemedProgress index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetProgressFrameFiller(Vcl::Themes::TThemedProgress index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetProgressFrameParam(Vcl::Themes::TThemedProgress index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetHeaderFill(Vcl::Themes::TThemedHeader index);
	Lmdfillers::TLMDFiller* __fastcall GetHeaderFillFiller(Vcl::Themes::TThemedHeader index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetHeaderFillParam(Vcl::Themes::TThemedHeader index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetHeaderFrame(Vcl::Themes::TThemedHeader index);
	Lmdfillers::TLMDFiller* __fastcall GetHeaderFrameFiller(Vcl::Themes::TThemedHeader index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetHeaderFrameParam(Vcl::Themes::TThemedHeader index, TLMDGradientThemeFrameParam param);
	void __fastcall SetHeaderFill(Vcl::Themes::TThemedHeader index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetHeaderFillFiller(Vcl::Themes::TThemedHeader index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetHeaderFillParam(Vcl::Themes::TThemedHeader index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetHeaderFrame(Vcl::Themes::TThemedHeader index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetHeaderFrameFiller(Vcl::Themes::TThemedHeader index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetHeaderFrameParam(Vcl::Themes::TThemedHeader index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetTrackBarFill(Vcl::Themes::TThemedTrackBar index);
	Lmdfillers::TLMDFiller* __fastcall GetTrackBarFillFiller(Vcl::Themes::TThemedTrackBar index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetTrackBarFillParam(Vcl::Themes::TThemedTrackBar index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetTrackBarFrame(Vcl::Themes::TThemedTrackBar index);
	Lmdfillers::TLMDFiller* __fastcall GetTrackBarFrameFiller(Vcl::Themes::TThemedTrackBar index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetTrackBarFrameParam(Vcl::Themes::TThemedTrackBar index, TLMDGradientThemeFrameParam param);
	void __fastcall SetTrackBarFill(Vcl::Themes::TThemedTrackBar index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetTrackBarFillFiller(Vcl::Themes::TThemedTrackBar index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetTrackBarFillParam(Vcl::Themes::TThemedTrackBar index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetTrackBarFrame(Vcl::Themes::TThemedTrackBar index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetTrackBarFrameFiller(Vcl::Themes::TThemedTrackBar index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetTrackBarFrameParam(Vcl::Themes::TThemedTrackBar index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFillDescriptor __fastcall GetStatusBarFill(Vcl::Themes::TThemedStatus index);
	Lmdfillers::TLMDFiller* __fastcall GetStatusBarFillFiller(Vcl::Themes::TThemedStatus index, TLMDGradientFillPart flp);
	System::Byte __fastcall GetStatusBarFillParam(Vcl::Themes::TThemedStatus index, TLMDGradientThemeFillParam param);
	TLMDGradientThemeFrameDescriptor __fastcall GetStatusBarFrame(Vcl::Themes::TThemedStatus index);
	Lmdfillers::TLMDFiller* __fastcall GetStatusBarFrameFiller(Vcl::Themes::TThemedStatus index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetStatusBarFrameParam(Vcl::Themes::TThemedStatus index, TLMDGradientThemeFrameParam param);
	void __fastcall SetStatusBarFill(Vcl::Themes::TThemedStatus index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetStatusBarFillFiller(Vcl::Themes::TThemedStatus index, TLMDGradientFillPart flp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetStatusBarFillParam(Vcl::Themes::TThemedStatus index, TLMDGradientThemeFillParam param, const System::Byte Value);
	void __fastcall SetStatusBarFrame(Vcl::Themes::TThemedStatus index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetStatusBarFrameFiller(Vcl::Themes::TThemedStatus index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetStatusBarFrameParam(Vcl::Themes::TThemedStatus index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	TLMDGradientThemeFrameDescriptor __fastcall GetTreeViewFrame(Vcl::Themes::TThemedTreeview index);
	Lmdfillers::TLMDFiller* __fastcall GetTreeViewFrameFiller(Vcl::Themes::TThemedTreeview index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp);
	System::Byte __fastcall GetTreeViewFrameParam(Vcl::Themes::TThemedTreeview index, TLMDGradientThemeFrameParam param);
	void __fastcall SetTreeViewFrame(Vcl::Themes::TThemedTreeview index, const TLMDGradientThemeFrameDescriptor &Value);
	void __fastcall SetTreeViewFrameFiller(Vcl::Themes::TThemedTreeview index, Lmdgradientframes::TLMDGradientSimpleFramePartKind frp, Lmdfillers::TLMDFiller* const Value);
	void __fastcall SetTreeViewFrameParam(Vcl::Themes::TThemedTreeview index, TLMDGradientThemeFrameParam param, const System::Byte Value);
	Lmdfillers::TLMDFiller* __fastcall GetGradientArrowFiller(Lmdgraph::TLMDDirection index, Lmdthemes::TLMDThemedButtonState btns);
	void __fastcall SetGradientArrowFiller(Lmdgraph::TLMDDirection index, Lmdthemes::TLMDThemedButtonState btns, Lmdfillers::TLMDFiller* const Value);
	TLMDGradientThemeFillDescriptor __fastcall GetCheckMarkFill(bool index);
	TLMDGradientThemeFillDescriptor __fastcall GetMixedMarkFill(bool index);
	TLMDGradientThemeFillDescriptor __fastcall GetRadioBtnCheckMarkFill(bool index);
	System::Uitypes::TColor __fastcall GetSimpleArrowColors(bool index);
	System::Uitypes::TColor __fastcall GetSimpleArrowShadowColors(bool index);
	void __fastcall SetCheckMarkFill(bool index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetMixedMarkFill(bool index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetRadioBtnCheckMarkFill(bool index, const TLMDGradientThemeFillDescriptor &Value);
	void __fastcall SetSimpleArrowColors(bool index, const System::Uitypes::TColor Value);
	void __fastcall SetSimpleArrowShadowColors(bool index, const System::Uitypes::TColor Value);
	void __fastcall SetPixelFormat(const Vcl::Graphics::TPixelFormat Value);
	bool __fastcall GetSuppressUpdate(void);
	void __fastcall SetSuppressUpdate(const bool Value);
	bool __fastcall GetUseCache(void);
	void __fastcall SetUseCache(const bool Value);
	
protected:
	Lmdthemes::TLMDThemesControllerBase* FController;
	virtual void __fastcall DrawGradientFramedFigure(HDC DC, Vcl::Graphics::TBitmap* Bmp, const System::Types::TRect &aBoundsRect, System::Types::TRect &aContentsRect, System::Types::PRect ClipRect, const TLMDGradientThemeFrameDescriptor &aFrameD, const TLMDGradientThemeFillDescriptor &aFillD, Lmdgradientframes::TLMDBaseGradientFrame* aFrame, Lmdfigures::TLMDFigure* aFigure, Vcl::Graphics::TPixelFormat aPixelFormat = (Vcl::Graphics::TPixelFormat)(0x6));
	virtual void __fastcall DrawSimpleFrame(HDC DC, Vcl::Graphics::TBitmap* Bmp, const System::Types::TRect &aBoundsRect, System::Types::TRect &aContentsRect, System::Types::PRect ClipRect, const TLMDGradientThemeFrameDescriptor &aFrameD);
	virtual void __fastcall DrawArrow(HDC DC, const System::Types::TRect &ARect, Lmdgraph::TLMDDirection ADir, bool aDrawShadow, bool aEnabled);
	virtual void __fastcall DrawGradientArrow(HDC DC, const System::Types::TRect &ARect, Lmdgraph::TLMDDirection ADir, Lmdthemes::TLMDThemedButtonState aState);
	virtual void __fastcall DrawCross(HDC DC, const System::Types::TRect &ARect, bool aDrawShadow);
	virtual void __fastcall DrawMinus(HDC DC, const System::Types::TRect &ARect, System::Uitypes::TColor aFrameColor, System::Uitypes::TColor AFillColor1, System::Uitypes::TColor aFillColor2, System::Uitypes::TColor aShadowColor, bool aDrawShadow);
	virtual void __fastcall DrawPlus(HDC DC, const System::Types::TRect &ARect, System::Uitypes::TColor aFrameColor, System::Uitypes::TColor AFillColor1, System::Uitypes::TColor aFillColor2, System::Uitypes::TColor aShadowColor, bool aDrawShadow);
	virtual void __fastcall DrawCheckMark(HDC DC, const System::Types::TRect &ARect, Vcl::Themes::TThemedButton acb);
	virtual void __fastcall DrawScrollThumbGripper(HDC DC, const System::Types::TRect &aRect, Vcl::Themes::TThemedScrollBar Detail);
	virtual void __fastcall DoUpdateTheme(void);
	void __fastcall SetRectFrameParams(Lmdgradientframes::TLMDGradientRectFrame* aDstFrame, const TLMDGradientThemeFrameParams &aParams);
	virtual void __fastcall SetFillerParams(Lmdfillers::TLMDFiller* aDestFiller, Lmdfillers::TLMDFiller* aSrcFiller, const System::Types::TRect &aRect);
	Lmdfillers::TLMDFiller* __fastcall PrepareFillerFrom(Lmdfillers::TLMDFiller* const aSrcFiller, bool aCreateNew = false);
	Lmdfillers::TLMDFiller* __fastcall PrepareFiller(Lmdfillers::TLMDFiller* aSrcFiller, const System::Types::TRect &aRect);
	System::UnicodeString __fastcall Signature(const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &aRect);
	void __fastcall ReadFillDescriptorFromXML(TLMDGradientThemeFillDescriptor &aFillD, Lmdxml::_di_ILMDXmlElement aDetailNode);
	void __fastcall ReadFrameDescriptorFromXML(TLMDGradientThemeFrameDescriptor &aFrameD, Lmdxml::_di_ILMDXmlElement aDetailNode);
	void __fastcall ReadTextDescriptorFromXML(TLMDGradientThemeTextDescriptor &aTextD, Lmdxml::_di_ILMDXmlElement aDetailNode);
	void __fastcall WriteFillDescriptorToXML(const TLMDGradientThemeFillDescriptor &aFillD, Lmdxml::_di_ILMDXmlElement aDetail);
	void __fastcall WriteFrameDescriptorToXML(const TLMDGradientThemeFrameDescriptor &aFrameD, Lmdxml::_di_ILMDXmlElement aDetail);
	void __fastcall WriteTextDescriptorToXML(const TLMDGradientThemeTextDescriptor &aTextD, Lmdxml::_di_ILMDXmlElement aDetail);
	void __fastcall WriteFillerToXML(Lmdfillers::TLMDFiller* aFiller, Lmdxml::_di_ILMDXmlElement aNode, System::UnicodeString AttrName = System::UnicodeString(), System::UnicodeString AttrValue = System::UnicodeString());
	Lmdfillers::TLMDFiller* __fastcall ReadFillerFromXML(Lmdxml::_di_ILMDXmlElement aNode);
	virtual bool __fastcall GetEnabled(void);
	virtual void __fastcall SetEnabled(bool aValue);
	virtual Lmdtypes::TLMDString __fastcall GetActiveThemeName(void);
	virtual Lmdtypes::TLMDString __fastcall GetActiveColorSchemeName(void);
	
public:
	void __fastcall ClearCache(void);
	void __fastcall CloneDescriptor(TLMDGradientThemeFillDescriptor &aFldDest, TLMDGradientThemeFillDescriptor &aFldSrc)/* overload */;
	void __fastcall CloneDescriptor(TLMDGradientThemeFrameDescriptor &aFrdDest, TLMDGradientThemeFrameDescriptor &aFrdSrc)/* overload */;
	void __fastcall ClearDescriptorFillers(TLMDGradientThemeFillDescriptor &aFld)/* overload */;
	void __fastcall ClearDescriptorFillers(TLMDGradientThemeFrameDescriptor &aFrd)/* overload */;
	__fastcall virtual TLMDBaseGradientThemeRenderer(void);
	__fastcall virtual ~TLMDBaseGradientThemeRenderer(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(bool aDoApply = true);
	virtual bool __fastcall ActivateColorScheme(System::UnicodeString AColorScheme, bool ADoApply = true);
	virtual bool __fastcall ActivateDefaultTheme(System::UnicodeString AColorScheme = System::UnicodeString(), bool aDoApply = true);
	virtual bool __fastcall ActivateTheme(System::UnicodeString AFileName, System::UnicodeString AColorScheme = L"Blue");
	virtual void __fastcall DeactivateTheme(void);
	virtual System::Types::TRect __fastcall ContentRect(HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &BoundingRect);
	virtual bool __fastcall GetThemeBackgroundExtent(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartID, int iStateID, const System::Types::TRect &ContentRect, System::Types::TRect &ExtentRect);
	virtual unsigned __fastcall GetThemeColor(Vcl::Themes::TThemedElement AElement, int iPartId, int iStateId, int iPropId);
	virtual bool __fastcall GetThemeFont(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, int iPropId, tagLOGFONTW &font);
	virtual bool __fastcall GetThemePartSize(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, System::Types::TSize &size);
	virtual unsigned __fastcall GetThemeSysColor(Vcl::Themes::TThemedElement Detail, int ColorID);
	virtual int __fastcall GetThemeSysSize(Vcl::Themes::TThemedElement Detail, int iSizeId);
	virtual bool __fastcall GetThemeTextExtent(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, Lmdtypes::TLMDString Text, int CharCount, unsigned dwTextFlags, System::Types::PRect BoundingRect, System::Types::TRect &ExtentRect);
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedButton Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedButton Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedComboBox Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedComboBox Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedEdit Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedEdit Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedExplorerBar Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedExplorerBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedProgress Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedProgress Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedScrollBar Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedScrollBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedSpin Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedSpin Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedStatus Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedStatus Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTab Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTab Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolBar Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolTip Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolTip Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTrackBar Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTrackBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedWindow Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedWindow Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedListview Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedListview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedHeader Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedHeader Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTreeview Detail, const System::Types::TRect &R)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTreeview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect)/* overload */;
	virtual void __fastcall DrawElement(HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	virtual void __fastcall DrawThemeParentBackground(HWND Wnd, HDC DC, System::Types::PRect ARect);
	virtual bool __fastcall DrawThemeEdge(HDC DC, Vcl::Themes::TThemedElement aElement, int iPartId, int iStateId, const System::Types::TRect &pDestRect, unsigned uEdge, unsigned uFlags, System::Types::PRect pContentRect)/* overload */;
	virtual bool __fastcall DrawThemeText(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, Lmdtypes::TLMDString Text, int CharCount, unsigned dwTextFlags, unsigned dwTextFlags2, const System::Types::TRect &ARect);
	void __fastcall RegisterMetaData(System::Typinfo::PTypeInfo aElementTypeInfo, void * aMetaData);
	void __fastcall ChangeBrightness(int aPercent, const Lmdthemescommontypes::TThemedElementSet &aElements = Lmdthemescommontypes::TThemedElementSet() , System::UnicodeString aDetailNameMask = System::UnicodeString(), TLMDGradientFillParts aFillParts = (TLMDGradientFillParts() << TLMDGradientFillPart::gfpMain << TLMDGradientFillPart::gfpDeco1 << TLMDGradientFillPart::gfpDeco2 << TLMDGradientFillPart::gfpDeco3 << TLMDGradientFillPart::gfpDeco4 ), Lmdgradientframes::TLMDGradientSimpleFramePartKinds aFrameParts = (Lmdgradientframes::TLMDGradientSimpleFramePartKinds() << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpOuterBorder << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpInnerBorder << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpInnerSpace ), int aIndex = 0xffffffff);
	void __fastcall ReplaceColor(System::Uitypes::TColor aOldColor, System::Uitypes::TColor aNewColor, const Lmdthemescommontypes::TThemedElementSet &aElements = Lmdthemescommontypes::TThemedElementSet() , System::UnicodeString aDetailNameMask = System::UnicodeString(), TLMDGradientFillParts aFillParts = (TLMDGradientFillParts() << TLMDGradientFillPart::gfpMain << TLMDGradientFillPart::gfpDeco1 << TLMDGradientFillPart::gfpDeco2 << TLMDGradientFillPart::gfpDeco3 << TLMDGradientFillPart::gfpDeco4 ), Lmdgradientframes::TLMDGradientSimpleFramePartKinds aFrameParts = (Lmdgradientframes::TLMDGradientSimpleFramePartKinds() << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpOuterBorder << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpInnerBorder << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpInnerSpace ),
		int aIndex = 0xffffffff);
	void __fastcall SetNewColor(System::Uitypes::TColor aNewColor, const Lmdthemescommontypes::TThemedElementSet &aElements = Lmdthemescommontypes::TThemedElementSet() , System::UnicodeString aDetailNameMask = System::UnicodeString(), TLMDGradientFillParts aFillParts = (TLMDGradientFillParts() << TLMDGradientFillPart::gfpMain << TLMDGradientFillPart::gfpDeco1 << TLMDGradientFillPart::gfpDeco2 << TLMDGradientFillPart::gfpDeco3 << TLMDGradientFillPart::gfpDeco4 ), Lmdgradientframes::TLMDGradientSimpleFramePartKinds aFrameParts = (Lmdgradientframes::TLMDGradientSimpleFramePartKinds() << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpOuterBorder << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpInnerBorder << Lmdgradientframes::TLMDGradientSimpleFramePartKind::sfpInnerSpace ), int aIndex = 0x0);
	virtual bool __fastcall SaveColorSchemeToXML(Lmdxml::_di_ILMDXmlDocument aXmlDoc, Lmdtypes::TLMDString aColorScheme);
	virtual bool __fastcall SaveColorSchemeToStream(System::Classes::TStream* aStream, Lmdtypes::TLMDString aColorScheme);
	bool __fastcall SaveColorSchemeToFile(Lmdtypes::TLMDString aFileName, Lmdtypes::TLMDString aColorScheme);
	bool __fastcall SaveThemeToStream(System::Classes::TStream* aStream);
	bool __fastcall SaveThemeToFile(Lmdtypes::TLMDString aFileName);
	virtual bool __fastcall LoadColorSchemeFromXML(Lmdxml::_di_ILMDXmlDocument aXmlDoc, Lmdtypes::TLMDString aColorScheme, bool aDoApply = true);
	virtual bool __fastcall LoadThemeFromStream(System::Classes::TStream* aStream, Lmdtypes::TLMDString aColorScheme = Lmdtypes::TLMDString(), bool aDoApply = true);
	bool __fastcall LoadThemeFromFile(Lmdtypes::TLMDString aFile, Lmdtypes::TLMDString aColorScheme = Lmdtypes::TLMDString(), bool aDoApply = true);
	bool __fastcall ReloadFromInternalXML(void);
	__property bool SuppressUpdate = {read=GetSuppressUpdate, write=SetSuppressUpdate, default=0};
	__property TLMDGradientTheme Theme = {read=FTheme, nodefault};
	__property System::UnicodeString ThemeName = {read=FThemeName};
	__property Lmdclass::TLMDColorScheme ColorScheme = {read=FColorScheme, nodefault};
	__property System::UnicodeString ColorSchemeName = {read=FColorSchemeName, write=SetColorSchemeName};
	__property System::Uitypes::TColor EnabledTextColor = {read=GetEnabledTextColor, write=SetEnabledTextColor, nodefault};
	__property System::Uitypes::TColor DisabledTextColor = {read=GetDisabledTextColor, write=SetDisabledTextColor, nodefault};
	__property Lmdthemescommontypes::TLMDThemeDetailMetaData MetaData[Vcl::Themes::TThemedElement Element] = {read=GetMetaData};
	__property TLMDGradientThemeFillDescriptor ButtonFill[Vcl::Themes::TThemedButton index] = {read=GetButtonFill, write=SetButtonFill};
	__property TLMDGradientThemeFrameDescriptor ButtonFrame[Vcl::Themes::TThemedButton index] = {read=GetButtonFrame, write=SetButtonFrame};
	__property System::Byte ButtonFillParam[Vcl::Themes::TThemedButton index][TLMDGradientThemeFillParam param] = {read=GetButtonFillParam, write=SetButtonFillParam};
	__property System::Byte ButtonFrameParam[Vcl::Themes::TThemedButton index][TLMDGradientThemeFrameParam param] = {read=GetButtonFrameParam, write=SetButtonFrameParam};
	__property Lmdfillers::TLMDFiller* ButtonFillFiller[Vcl::Themes::TThemedButton index][TLMDGradientFillPart flp] = {read=GetButtonFillFiller, write=SetButtonFillFiller};
	__property Lmdfillers::TLMDFiller* ButtonFrameFiller[Vcl::Themes::TThemedButton index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetButtonFrameFiller, write=SetButtonFrameFiller};
	__property TLMDGradientThemeFillDescriptor ToolbarFill[Vcl::Themes::TThemedToolBar index] = {read=GetToolbarFill, write=SetToolbarFill};
	__property TLMDGradientThemeFrameDescriptor ToolbarFrame[Vcl::Themes::TThemedToolBar index] = {read=GetToolbarFrame, write=SetToolbarFrame};
	__property System::Byte ToolbarFillParam[Vcl::Themes::TThemedToolBar index][TLMDGradientThemeFillParam param] = {read=GetToolbarFillParam, write=SetToolbarFillParam};
	__property System::Byte ToolbarFrameParam[Vcl::Themes::TThemedToolBar index][TLMDGradientThemeFrameParam param] = {read=GetToolbarFrameParam, write=SetToolbarFrameParam};
	__property Lmdfillers::TLMDFiller* ToolbarFillFiller[Vcl::Themes::TThemedToolBar index][TLMDGradientFillPart flp] = {read=GetToolbarFillFiller, write=SetToolbarFillFiller};
	__property Lmdfillers::TLMDFiller* ToolbarFrameFiller[Vcl::Themes::TThemedToolBar index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetToolbarFrameFiller, write=SetToolbarFrameFiller};
	__property TLMDGradientThemeFillDescriptor ComboBoxFill[Vcl::Themes::TThemedComboBox index] = {read=GetComboBoxFill, write=SetComboBoxFill};
	__property TLMDGradientThemeFrameDescriptor ComboBoxFrame[Vcl::Themes::TThemedComboBox index] = {read=GetComboBoxFrame, write=SetComboBoxFrame};
	__property System::Byte ComboBoxFillParam[Vcl::Themes::TThemedComboBox index][TLMDGradientThemeFillParam param] = {read=GetComboBoxFillParam, write=SetComboBoxFillParam};
	__property System::Byte ComboBoxFrameParam[Vcl::Themes::TThemedComboBox index][TLMDGradientThemeFrameParam param] = {read=GetComboBoxFrameParam, write=SetComboBoxFrameParam};
	__property Lmdfillers::TLMDFiller* ComboBoxFillFiller[Vcl::Themes::TThemedComboBox index][TLMDGradientFillPart flp] = {read=GetComboBoxFillFiller, write=SetComboBoxFillFiller};
	__property Lmdfillers::TLMDFiller* ComboBoxFrameFiller[Vcl::Themes::TThemedComboBox index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetComboBoxFrameFiller, write=SetComboBoxFrameFiller};
	__property TLMDGradientThemeFillDescriptor EditFill[Vcl::Themes::TThemedEdit index] = {read=GetEditFill, write=SetEditFill};
	__property TLMDGradientThemeFrameDescriptor EditFrame[Vcl::Themes::TThemedEdit index] = {read=GetEditFrame, write=SetEditFrame};
	__property System::Byte EditFillParam[Vcl::Themes::TThemedEdit index][TLMDGradientThemeFillParam param] = {read=GetEditFillParam, write=SetEditFillParam};
	__property System::Byte EditFrameParam[Vcl::Themes::TThemedEdit index][TLMDGradientThemeFrameParam param] = {read=GetEditFrameParam, write=SetEditFrameParam};
	__property Lmdfillers::TLMDFiller* EditFillFiller[Vcl::Themes::TThemedEdit index][TLMDGradientFillPart flp] = {read=GetEditFillFiller, write=SetEditFillFiller};
	__property Lmdfillers::TLMDFiller* EditFrameFiller[Vcl::Themes::TThemedEdit index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetEditFrameFiller, write=SetEditFrameFiller};
	__property TLMDGradientThemeFillDescriptor SpinBtnFill[Vcl::Themes::TThemedSpin index] = {read=GetSpinBtnFill, write=SetSpinBtnFill};
	__property TLMDGradientThemeFrameDescriptor SpinBtnFrame[Vcl::Themes::TThemedSpin index] = {read=GetSpinBtnFrame, write=SetSpinBtnFrame};
	__property System::Byte SpinBtnFillParam[Vcl::Themes::TThemedSpin index][TLMDGradientThemeFillParam param] = {read=GetSpinBtnFillParam, write=SetSpinBtnFillParam};
	__property System::Byte SpinBtnFrameParam[Vcl::Themes::TThemedSpin index][TLMDGradientThemeFrameParam param] = {read=GetSpinBtnFrameParam, write=SetSpinBtnFrameParam};
	__property Lmdfillers::TLMDFiller* SpinBtnFillFiller[Vcl::Themes::TThemedSpin index][TLMDGradientFillPart flp] = {read=GetSpinBtnFillFiller, write=SetSpinBtnFillFiller};
	__property Lmdfillers::TLMDFiller* SpinBtnFrameFiller[Vcl::Themes::TThemedSpin index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetSpinBtnFrameFiller, write=SetSpinBtnFrameFiller};
	__property TLMDGradientThemeFillDescriptor ScrollBarFill[Vcl::Themes::TThemedScrollBar index] = {read=GetScrollBarFill, write=SetScrollBarFill};
	__property TLMDGradientThemeFrameDescriptor ScrollBarFrame[Vcl::Themes::TThemedScrollBar index] = {read=GetScrollBarFrame, write=SetScrollBarFrame};
	__property System::Byte ScrollBarFillParam[Vcl::Themes::TThemedScrollBar index][TLMDGradientThemeFillParam param] = {read=GetScrollBarFillParam, write=SetScrollBarFillParam};
	__property System::Byte ScrollBarFrameParam[Vcl::Themes::TThemedScrollBar index][TLMDGradientThemeFrameParam param] = {read=GetScrollBarFrameParam, write=SetScrollBarFrameParam};
	__property Lmdfillers::TLMDFiller* ScrollBarFillFiller[Vcl::Themes::TThemedScrollBar index][TLMDGradientFillPart flp] = {read=GetScrollBarFillFiller, write=SetScrollBarFillFiller};
	__property Lmdfillers::TLMDFiller* ScrollBarFrameFiller[Vcl::Themes::TThemedScrollBar index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetScrollBarFrameFiller, write=SetScrollBarFrameFiller};
	__property TLMDGradientThemeFillDescriptor TabFill[Vcl::Themes::TThemedTab index] = {read=GetTabFill, write=SetTabFill};
	__property TLMDGradientThemeFrameDescriptor TabFrame[Vcl::Themes::TThemedTab index] = {read=GetTabFrame, write=SetTabFrame};
	__property System::Byte TabFillParam[Vcl::Themes::TThemedTab index][TLMDGradientThemeFillParam param] = {read=GetTabFillParam, write=SetTabFillParam};
	__property System::Byte TabFrameParam[Vcl::Themes::TThemedTab index][TLMDGradientThemeFrameParam param] = {read=GetTabFrameParam, write=SetTabFrameParam};
	__property Lmdfillers::TLMDFiller* TabFillFiller[Vcl::Themes::TThemedTab index][TLMDGradientFillPart flp] = {read=GetTabFillFiller, write=SetTabFillFiller};
	__property Lmdfillers::TLMDFiller* TabFrameFiller[Vcl::Themes::TThemedTab index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetTabFrameFiller, write=SetTabFrameFiller};
	__property TLMDGradientThemeFillDescriptor ProgressFill[Vcl::Themes::TThemedProgress index] = {read=GetProgressFill, write=SetProgressFill};
	__property TLMDGradientThemeFrameDescriptor ProgressFrame[Vcl::Themes::TThemedProgress index] = {read=GetProgressFrame, write=SetProgressFrame};
	__property System::Byte ProgressFillParam[Vcl::Themes::TThemedProgress index][TLMDGradientThemeFillParam param] = {read=GetProgressFillParam, write=SetProgressFillParam};
	__property System::Byte ProgressFrameParam[Vcl::Themes::TThemedProgress index][TLMDGradientThemeFrameParam param] = {read=GetProgressFrameParam, write=SetProgressFrameParam};
	__property Lmdfillers::TLMDFiller* ProgressFillFiller[Vcl::Themes::TThemedProgress index][TLMDGradientFillPart flp] = {read=GetProgressFillFiller, write=SetProgressFillFiller};
	__property Lmdfillers::TLMDFiller* ProgressFrameFiller[Vcl::Themes::TThemedProgress index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetProgressFrameFiller, write=SetProgressFrameFiller};
	__property TLMDGradientThemeFillDescriptor HeaderFill[Vcl::Themes::TThemedHeader index] = {read=GetHeaderFill, write=SetHeaderFill};
	__property TLMDGradientThemeFrameDescriptor HeaderFrame[Vcl::Themes::TThemedHeader index] = {read=GetHeaderFrame, write=SetHeaderFrame};
	__property System::Byte HeaderFillParam[Vcl::Themes::TThemedHeader index][TLMDGradientThemeFillParam param] = {read=GetHeaderFillParam, write=SetHeaderFillParam};
	__property System::Byte HeaderFrameParam[Vcl::Themes::TThemedHeader index][TLMDGradientThemeFrameParam param] = {read=GetHeaderFrameParam, write=SetHeaderFrameParam};
	__property Lmdfillers::TLMDFiller* HeaderFillFiller[Vcl::Themes::TThemedHeader index][TLMDGradientFillPart flp] = {read=GetHeaderFillFiller, write=SetHeaderFillFiller};
	__property Lmdfillers::TLMDFiller* HeaderFrameFiller[Vcl::Themes::TThemedHeader index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetHeaderFrameFiller, write=SetHeaderFrameFiller};
	__property TLMDGradientThemeFillDescriptor TrackBarFill[Vcl::Themes::TThemedTrackBar index] = {read=GetTrackBarFill, write=SetTrackBarFill};
	__property TLMDGradientThemeFrameDescriptor TrackBarFrame[Vcl::Themes::TThemedTrackBar index] = {read=GetTrackBarFrame, write=SetTrackBarFrame};
	__property System::Byte TrackBarFillParam[Vcl::Themes::TThemedTrackBar index][TLMDGradientThemeFillParam param] = {read=GetTrackBarFillParam, write=SetTrackBarFillParam};
	__property System::Byte TrackBarFrameParam[Vcl::Themes::TThemedTrackBar index][TLMDGradientThemeFrameParam param] = {read=GetTrackBarFrameParam, write=SetTrackBarFrameParam};
	__property Lmdfillers::TLMDFiller* TrackBarFillFiller[Vcl::Themes::TThemedTrackBar index][TLMDGradientFillPart flp] = {read=GetTrackBarFillFiller, write=SetTrackBarFillFiller};
	__property Lmdfillers::TLMDFiller* TrackBarFrameFiller[Vcl::Themes::TThemedTrackBar index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetTrackBarFrameFiller, write=SetTrackBarFrameFiller};
	__property TLMDGradientThemeFillDescriptor StatusBarFill[Vcl::Themes::TThemedStatus index] = {read=GetStatusBarFill, write=SetStatusBarFill};
	__property TLMDGradientThemeFrameDescriptor StatusBarFrame[Vcl::Themes::TThemedStatus index] = {read=GetStatusBarFrame, write=SetStatusBarFrame};
	__property System::Byte StatusBarFillParam[Vcl::Themes::TThemedStatus index][TLMDGradientThemeFillParam param] = {read=GetStatusBarFillParam, write=SetStatusBarFillParam};
	__property System::Byte StatusBarFrameParam[Vcl::Themes::TThemedStatus index][TLMDGradientThemeFrameParam param] = {read=GetStatusBarFrameParam, write=SetStatusBarFrameParam};
	__property Lmdfillers::TLMDFiller* StatusBarFillFiller[Vcl::Themes::TThemedStatus index][TLMDGradientFillPart flp] = {read=GetStatusBarFillFiller, write=SetStatusBarFillFiller};
	__property Lmdfillers::TLMDFiller* StatusBarFrameFiller[Vcl::Themes::TThemedStatus index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetStatusBarFrameFiller, write=SetStatusBarFrameFiller};
	__property TLMDGradientThemeFrameDescriptor TreeViewFrame[Vcl::Themes::TThemedTreeview index] = {read=GetTreeViewFrame, write=SetTreeViewFrame};
	__property System::Byte TreeViewFrameParam[Vcl::Themes::TThemedTreeview index][TLMDGradientThemeFrameParam param] = {read=GetTreeViewFrameParam, write=SetTreeViewFrameParam};
	__property Lmdfillers::TLMDFiller* TreeViewFrameFiller[Vcl::Themes::TThemedTreeview index][Lmdgradientframes::TLMDGradientSimpleFramePartKind frp] = {read=GetTreeViewFrameFiller, write=SetTreeViewFrameFiller};
	__property Lmdfillers::TLMDFiller* GradientArrowFiller[Lmdgraph::TLMDDirection index][Lmdthemes::TLMDThemedButtonState btns] = {read=GetGradientArrowFiller, write=SetGradientArrowFiller};
	__property System::Uitypes::TColor SimpleArrowColors[bool index] = {read=GetSimpleArrowColors, write=SetSimpleArrowColors};
	__property System::Uitypes::TColor SimpleArrowShadowColors[bool index] = {read=GetSimpleArrowShadowColors, write=SetSimpleArrowShadowColors};
	__property TLMDGradientThemeFillDescriptor CheckMarkFill[bool index] = {read=GetCheckMarkFill, write=SetCheckMarkFill};
	__property TLMDGradientThemeFillDescriptor RadioBtnCheckMarkFill[bool index] = {read=GetRadioBtnCheckMarkFill, write=SetRadioBtnCheckMarkFill};
	__property TLMDGradientThemeFillDescriptor MixedMarkFill[bool index] = {read=GetMixedMarkFill, write=SetMixedMarkFill};
	__property Vcl::Graphics::TPixelFormat PixelFormat = {read=FPixelFormat, write=SetPixelFormat, default=6};
	__property Lmdxml::_di_ILMDXmlDocument XMLDoc = {read=FXmlDoc};
	__property bool Modified = {read=FModified, nodefault};
	__property bool UseCache = {read=GetUseCache, write=SetUseCache, default=1};
	__property Lmdthemes::TLMDThemesOnDrawElement OnDrawElement = {read=FOnDrawElement, write=FOnDrawElement};
	__property Lmdthemes::TLMDThemesOnDrawCheckMarkEvent OnDrawCheckMark = {read=FOnDrawCheckMark, write=FOnDrawCheckMark};
	__property Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent OnDrawScrollThumbGripper = {read=FOnDrawScrollThumbGripper, write=FOnDrawScrollThumbGripper};
	__property Lmdthemes::TLMDThemesOnDrawArrowEvent OnDrawArrow = {read=FOnDrawArrow, write=FOnDrawArrow};
	__property Lmdthemes::TLMDThemesOnDrawGradientArrowEvent OnDrawGradientArrow = {read=FOnDrawGradientArrow, write=FOnDrawGradientArrow};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawPlus = {read=FOnDrawPlus, write=FOnDrawPlus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawMinus = {read=FOnDrawMinus, write=FOnDrawMinus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawCross = {read=FOnDrawCross, write=FOnDrawCross};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdthemesgradientthemebase__1 cGradientThemeNames;
static const System::Int8 cStandardFillRenderMode = System::Int8(0x4);
static const System::Int8 cStandardFrameRenderMode = System::Int8(0x54);
static const System::Int8 cRM_OuterBorderAntiALiasing = System::Int8(0x4);
static const System::Int8 cRM_InnerSpaceAntiALiasing = System::Int8(0x10);
static const System::Int8 cRM_InnerBorderAntiALiasing = System::Int8(0x40);
static const System::Int8 cRM_OuterBorderSoftEdge = System::Int8(0x8);
static const System::Int8 cRM_InnerSpaceSoftEdge = System::Int8(0x20);
static const System::Byte cRM_InnerBorderSoftEdge = System::Byte(0x80);
static const System::Word cAllColors = System::Word(0x100);
#define cGradientFillAllParts (System::Set<TLMDGradientFillPart, TLMDGradientFillPart::gfpMain, TLMDGradientFillPart::gfpDeco4>() << TLMDGradientFillPart::gfpMain << TLMDGradientFillPart::gfpDeco1 << TLMDGradientFillPart::gfpDeco2 << TLMDGradientFillPart::gfpDeco3 << TLMDGradientFillPart::gfpDeco4 )
}	/* namespace Lmdthemesgradientthemebase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESGRADIENTTHEMEBASE)
using namespace Lmdthemesgradientthemebase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemesgradientthemebaseHPP
