// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesSGThemeBase.pas' rev: 31.00 (Windows)

#ifndef LmdthemessgthemebaseHPP
#define LmdthemessgthemebaseHPP

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
#include <LMDThemes.hpp>
#include <LMDGraph.hpp>
#include <LMDGradient.hpp>
#include <LMDThemesCommonTypes.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemessgthemebase
{
//-- forward type declarations -----------------------------------------------
struct TLMDSimpleGradientSettings;
class DELPHICLASS TLMDBaseSGThemeRenderer;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSimpleGradientTheme : unsigned char { sgtOffice2003, sgtCustom, sgtUnknown };

typedef System::StaticArray<System::UnicodeString, 3> Lmdthemessgthemebase__1;

struct DECLSPEC_DRECORD TLMDSimpleGradientSettings
{
public:
	Lmdthemescommontypes::TLMDGradientColorCountType CountType;
	int FixedNumber;
	int CalcDivizor;
	Lmdgraph::TLMDGradientStyle GradientStyle;
};


class PASCALIMPLEMENTATION TLMDBaseSGThemeRenderer : public Lmdthemes::TLMDThemeRenderer
{
	typedef Lmdthemes::TLMDThemeRenderer inherited;
	
private:
	bool FEnabled;
	TLMDSimpleGradientTheme FTheme;
	System::UnicodeString FThemeName;
	Lmdclass::TLMDColorScheme FColorScheme;
	System::UnicodeString FColorSchemeName;
	bool FIsUpdating;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 50> FBtnFillColors;
	System::StaticArray<System::Uitypes::TColor, 50> FBtnFrameColors;
	System::StaticArray<System::Uitypes::TColor, 43> FMenuItemFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 58> FToolbarFillColors;
	System::StaticArray<System::Uitypes::TColor, 58> FToolbarFrameColors;
	System::Uitypes::TColor FEnabledTextColor;
	System::Uitypes::TColor FDisabledTextColor;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 31> FComboboxColors;
	System::StaticArray<System::Uitypes::TColor, 31> FComboboxFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 37> FEditFillColors;
	System::StaticArray<System::Uitypes::TColor, 37> FEditFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 18> FSpinBtnFillColors;
	System::StaticArray<System::Uitypes::TColor, 18> FSpinBtnFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 68> FScrollBarFillColors;
	System::StaticArray<System::Uitypes::TColor, 68> FScrollBarFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 45> FTabColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 16> FProgressColors;
	System::StaticArray<System::Uitypes::TColor, 16> FProgressFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 21> FHeaderColors;
	System::StaticArray<System::Uitypes::TColor, 21> FHeaderFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 36> FTrackBarFillColors;
	System::StaticArray<System::Uitypes::TColor, 36> FTrackBarFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 5> FStatusBarFillColors;
	System::StaticArray<System::Uitypes::TColor, 5> FStatusBarFrameColors;
	System::StaticArray<System::StaticArray<System::Uitypes::TColor, 2>, 33> FExplorerBarFillColors;
	System::StaticArray<Lmdthemescommontypes::TLMDThemeDetailMetaData, 45> FMetaData;
	System::StaticArray<TLMDSimpleGradientSettings, 45> FGradientSettings;
	Lmdthemes::TLMDThemesOnDrawCheckMarkEvent FOnDrawCheckMark;
	Lmdthemes::TLMDThemesOnDrawCheckMarkEvent FOnDrawRadioBtn;
	Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent FOnDrawScrollThumbGripper;
	Lmdthemes::TLMDThemesOnDrawArrowEvent FOnDrawArrow;
	Lmdthemes::TLMDThemesOnDrawGradientArrowEvent FOnDrawGradientArrow;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawPlus;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawMinus;
	Lmdthemes::TLMDThemesOnDrawSimpleSignEvent FOnDrawCross;
	System::Uitypes::TColor __fastcall GetBtnFillColors(Vcl::Themes::TThemedButton Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	void __fastcall SetBtnFillColors(Vcl::Themes::TThemedButton Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetBtnFrameColors(Vcl::Themes::TThemedButton Element);
	void __fastcall SetBtnFrameColors(Vcl::Themes::TThemedButton Element, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetMenuItemFrameColors(Vcl::Themes::TThemedMenu Element);
	void __fastcall SetMenuItemFrameColors(Vcl::Themes::TThemedMenu Element, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetComboboxColors(Vcl::Themes::TThemedComboBox Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	System::Uitypes::TColor __fastcall GetComboboxFrameColors(Vcl::Themes::TThemedComboBox Element);
	System::Uitypes::TColor __fastcall GetEditFillColors(Vcl::Themes::TThemedEdit Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	System::Uitypes::TColor __fastcall GetEditFrameColors(Vcl::Themes::TThemedEdit Element);
	System::Uitypes::TColor __fastcall GetToolbarFillColors(Vcl::Themes::TThemedToolBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	void __fastcall SetComboboxColors(Vcl::Themes::TThemedComboBox Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	void __fastcall SetComboboxFrameColors(Vcl::Themes::TThemedComboBox Element, const System::Uitypes::TColor Value);
	void __fastcall SetEditFillColors(Vcl::Themes::TThemedEdit Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	void __fastcall SetEditFrameColors(Vcl::Themes::TThemedEdit Element, const System::Uitypes::TColor Value);
	void __fastcall SetToolbarFillColors(Vcl::Themes::TThemedToolBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	void __fastcall SetToolbarFrameColors(Vcl::Themes::TThemedToolBar Element, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetToolbarFrameColors(Vcl::Themes::TThemedToolBar Element);
	TLMDSimpleGradientSettings __fastcall GetGradientSettings(Vcl::Themes::TThemedElement Element);
	System::Uitypes::TColor __fastcall GetProgressColors(Vcl::Themes::TThemedProgress Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	System::Uitypes::TColor __fastcall GetProgressFrameColors(Vcl::Themes::TThemedProgress Element);
	System::Uitypes::TColor __fastcall GetSpinBtnFillColors(Vcl::Themes::TThemedSpin Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	System::Uitypes::TColor __fastcall GetSpinBtnFrameColors(Vcl::Themes::TThemedSpin Element);
	void __fastcall SetSpinBtnFrameColors(Vcl::Themes::TThemedSpin Element, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetTabColors(Vcl::Themes::TThemedTab Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	void __fastcall SetGradientSettings(Vcl::Themes::TThemedElement Element, const TLMDSimpleGradientSettings &Value);
	void __fastcall SetProgressColors(Vcl::Themes::TThemedProgress Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	void __fastcall SetProgressFrameColors(Vcl::Themes::TThemedProgress Element, const System::Uitypes::TColor Value);
	void __fastcall SetSpinBtnFillColors(Vcl::Themes::TThemedSpin Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	void __fastcall SetTabColors(Vcl::Themes::TThemedTab Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetDisabledTextColor(void);
	System::Uitypes::TColor __fastcall GetEnabledTextColor(void);
	void __fastcall SetDisabledTextColor(const System::Uitypes::TColor Value);
	void __fastcall SetEnabledTextColor(const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetScrollBarFillColors(Vcl::Themes::TThemedScrollBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	void __fastcall SetScrollBarFillColors(Vcl::Themes::TThemedScrollBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetScrollBarFrameColors(Vcl::Themes::TThemedScrollBar Element);
	void __fastcall SetScrollBarFrameColors(Vcl::Themes::TThemedScrollBar Element, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetHeaderColors(Vcl::Themes::TThemedHeader Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	void __fastcall SetHeaderColors(Vcl::Themes::TThemedHeader Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetHeaderFrameColors(Vcl::Themes::TThemedHeader Element);
	void __fastcall SetHeaderFrameColors(Vcl::Themes::TThemedHeader Element, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetTrackBarFillColors(Vcl::Themes::TThemedTrackBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	System::Uitypes::TColor __fastcall GetTrackBarFrameColors(Vcl::Themes::TThemedTrackBar Element);
	void __fastcall SetTrackBarFillColors(Vcl::Themes::TThemedTrackBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	void __fastcall SetTrackBarFrameColors(Vcl::Themes::TThemedTrackBar Element, const System::Uitypes::TColor Value);
	void __fastcall SetColorSchemeName(const System::UnicodeString Value);
	System::Uitypes::TColor __fastcall GetStatusBarFillColors(Vcl::Themes::TThemedStatus Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	void __fastcall SetStatusBarFillColors(Vcl::Themes::TThemedStatus Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetStatusBarFrameColors(Vcl::Themes::TThemedStatus Element);
	void __fastcall SetStatusBarFrameColors(Vcl::Themes::TThemedStatus Element, const System::Uitypes::TColor Value);
	System::Uitypes::TColor __fastcall GetExplorerBarFillColors(Vcl::Themes::TThemedExplorerBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex);
	void __fastcall SetExplorerBarFillColors(Vcl::Themes::TThemedExplorerBar Element, Lmdthemescommontypes::TLMDColorIndex ColorIndex, const System::Uitypes::TColor Value);
	Lmdthemescommontypes::TLMDThemeDetailMetaData __fastcall GetMetaData(Vcl::Themes::TThemedElement Element);
	
protected:
	Lmdthemes::TLMDThemesControllerBase* FController;
	virtual void __fastcall DrawArrow(HDC DC, const System::Types::TRect &ARect, Lmdgraph::TLMDDirection ADir);
	virtual void __fastcall DrawCross(HDC DC, const System::Types::TRect &ARect);
	virtual void __fastcall DrawMinus(HDC DC, const System::Types::TRect &ARect, System::Uitypes::TColor aColor);
	virtual void __fastcall DrawPlus(HDC DC, const System::Types::TRect &ARect, System::Uitypes::TColor aColor);
	virtual void __fastcall DrawCheckMark(HDC DC, const System::Types::TRect &ARect, Vcl::Themes::TThemedButton acb);
	virtual void __fastcall DrawRadioBtn(HDC DC, const System::Types::TRect &ARect, Vcl::Themes::TThemedButton arb);
	virtual void __fastcall DrawScrollThumbGripper(HDC DC, const System::Types::TRect &aRect, Vcl::Themes::TThemedScrollBar Detail);
	virtual void __fastcall DrawGradientFramedRect(HDC DC, const System::Types::TRect &R, System::Types::PRect ClipRect, System::Uitypes::TColor AStartFillColor, System::Uitypes::TColor AEndFillColor, System::Uitypes::TColor AFrameColor, Lmdgraph::TLMDGradientStyle AGradientStyle, System::Word AFlags, Lmdgraph::TLMDFrameSides AFrame = (Lmdgraph::TLMDFrameSides() << Lmdgraph::TLMDFrameSide::fsBottom << Lmdgraph::TLMDFrameSide::fsLeft << Lmdgraph::TLMDFrameSide::fsRight << Lmdgraph::TLMDFrameSide::fsTop ));
	virtual void __fastcall DoUpdateTheme(void);
	virtual bool __fastcall GetEnabled(void);
	virtual void __fastcall SetEnabled(bool aValue);
	
public:
	__fastcall virtual TLMDBaseSGThemeRenderer(void);
	void __fastcall BeginUpdate(void);
	void __fastcall EndUpdate(void);
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
	virtual Lmdtypes::TLMDString __fastcall GetActiveThemeName(void);
	virtual Lmdtypes::TLMDString __fastcall GetActiveColorSchemeName(void);
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
	void __fastcall ChangeBrightness(int aPercent, const Lmdthemescommontypes::TThemedElementSet &aElements = Lmdthemescommontypes::TThemedElementSet() , System::UnicodeString aDetailNameMask = System::UnicodeString(), Lmdthemescommontypes::TLMDColorIndexSet aIndices = (Lmdthemescommontypes::TLMDColorIndexSet() << Lmdthemescommontypes::TLMDColorIndex::ciStart << Lmdthemescommontypes::TLMDColorIndex::ciEnd ), bool aChangeFrameColors = true);
	void __fastcall ReplaceColor(System::Uitypes::TColor aOldColor, System::Uitypes::TColor aNewColor, const Lmdthemescommontypes::TThemedElementSet &aElements = Lmdthemescommontypes::TThemedElementSet() , System::UnicodeString aDetailNameMask = System::UnicodeString(), Lmdthemescommontypes::TLMDColorIndexSet aIndices = (Lmdthemescommontypes::TLMDColorIndexSet() << Lmdthemescommontypes::TLMDColorIndex::ciStart << Lmdthemescommontypes::TLMDColorIndex::ciEnd ), Lmdthemescommontypes::TLMDDetailPropKindSet aDetailProps = (Lmdthemescommontypes::TLMDDetailPropKindSet() << Lmdthemescommontypes::TLMDDetailPropKind::dpkFill << Lmdthemescommontypes::TLMDDetailPropKind::dpkFrame << Lmdthemescommontypes::TLMDDetailPropKind::dpkEnabledText << Lmdthemescommontypes::TLMDDetailPropKind::dpkDisabledText ));
	void __fastcall SetNewColor(System::Uitypes::TColor aNewColor, const Lmdthemescommontypes::TThemedElementSet &aElements = Lmdthemescommontypes::TThemedElementSet() , System::UnicodeString aDetailNameMask = System::UnicodeString(), Lmdthemescommontypes::TLMDColorIndexSet aIndices = (Lmdthemescommontypes::TLMDColorIndexSet() << Lmdthemescommontypes::TLMDColorIndex::ciStart << Lmdthemescommontypes::TLMDColorIndex::ciEnd ), Lmdthemescommontypes::TLMDDetailPropKindSet aDetailProps = (Lmdthemescommontypes::TLMDDetailPropKindSet() << Lmdthemescommontypes::TLMDDetailPropKind::dpkFill << Lmdthemescommontypes::TLMDDetailPropKind::dpkFrame << Lmdthemescommontypes::TLMDDetailPropKind::dpkEnabledText << Lmdthemescommontypes::TLMDDetailPropKind::dpkDisabledText ));
	virtual bool __fastcall SaveThemeToStream(System::Classes::TStream* aStream, Lmdtypes::TLMDString aThemeName = Lmdtypes::TLMDString(), Lmdtypes::TLMDString aColorScheme = Lmdtypes::TLMDString());
	virtual bool __fastcall LoadThemeFromStream(System::Classes::TStream* aStream, Lmdtypes::TLMDString aColorScheme = Lmdtypes::TLMDString());
	void __fastcall SaveThemeToFile(Lmdtypes::TLMDString aFileName, Lmdtypes::TLMDString aThemeName = Lmdtypes::TLMDString(), Lmdtypes::TLMDString aColorScheme = Lmdtypes::TLMDString());
	bool __fastcall LoadThemeFromFile(Lmdtypes::TLMDString aFile, Lmdtypes::TLMDString aColorScheme = Lmdtypes::TLMDString());
	__property TLMDSimpleGradientTheme Theme = {read=FTheme, nodefault};
	__property System::UnicodeString ThemeName = {read=FThemeName};
	__property Lmdclass::TLMDColorScheme ColorScheme = {read=FColorScheme, nodefault};
	__property System::UnicodeString ColorSchemeName = {read=FColorSchemeName, write=SetColorSchemeName};
	__property System::Uitypes::TColor BtnFillColors[Vcl::Themes::TThemedButton Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetBtnFillColors, write=SetBtnFillColors};
	__property System::Uitypes::TColor BtnFrameColors[Vcl::Themes::TThemedButton Element] = {read=GetBtnFrameColors, write=SetBtnFrameColors};
	__property System::Uitypes::TColor EnabledTextColor = {read=GetEnabledTextColor, write=SetEnabledTextColor, nodefault};
	__property System::Uitypes::TColor DisabledTextColor = {read=GetDisabledTextColor, write=SetDisabledTextColor, nodefault};
	__property System::Uitypes::TColor HeaderColors[Vcl::Themes::TThemedHeader Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetHeaderColors, write=SetHeaderColors};
	__property System::Uitypes::TColor HeaderFrameColors[Vcl::Themes::TThemedHeader Element] = {read=GetHeaderFrameColors, write=SetHeaderFrameColors};
	__property System::Uitypes::TColor MenuItemFrameColors[Vcl::Themes::TThemedMenu Element] = {read=GetMenuItemFrameColors, write=SetMenuItemFrameColors};
	__property System::Uitypes::TColor ToolbarFillColors[Vcl::Themes::TThemedToolBar Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetToolbarFillColors, write=SetToolbarFillColors};
	__property System::Uitypes::TColor ToolbarFrameColors[Vcl::Themes::TThemedToolBar Element] = {read=GetToolbarFrameColors, write=SetToolbarFrameColors};
	__property System::Uitypes::TColor ComboboxColors[Vcl::Themes::TThemedComboBox Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetComboboxColors, write=SetComboboxColors};
	__property System::Uitypes::TColor ComboboxFrameColors[Vcl::Themes::TThemedComboBox Element] = {read=GetComboboxFrameColors, write=SetComboboxFrameColors};
	__property System::Uitypes::TColor EditFillColors[Vcl::Themes::TThemedEdit Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetEditFillColors, write=SetEditFillColors};
	__property System::Uitypes::TColor EditFrameColors[Vcl::Themes::TThemedEdit Element] = {read=GetEditFrameColors, write=SetEditFrameColors};
	__property System::Uitypes::TColor ExplorerBarFillColors[Vcl::Themes::TThemedExplorerBar Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetExplorerBarFillColors, write=SetExplorerBarFillColors};
	__property Lmdthemescommontypes::TLMDThemeDetailMetaData MetaData[Vcl::Themes::TThemedElement Element] = {read=GetMetaData};
	__property System::Uitypes::TColor SpinBtnFillColors[Vcl::Themes::TThemedSpin Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetSpinBtnFillColors, write=SetSpinBtnFillColors};
	__property System::Uitypes::TColor SpinBtnFrameColors[Vcl::Themes::TThemedSpin Element] = {read=GetSpinBtnFrameColors, write=SetSpinBtnFrameColors};
	__property System::Uitypes::TColor ScrollBarFillColors[Vcl::Themes::TThemedScrollBar Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetScrollBarFillColors, write=SetScrollBarFillColors};
	__property System::Uitypes::TColor ScrollBarFrameColors[Vcl::Themes::TThemedScrollBar Element] = {read=GetScrollBarFrameColors, write=SetScrollBarFrameColors};
	__property System::Uitypes::TColor StatusBarFillColors[Vcl::Themes::TThemedStatus Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetStatusBarFillColors, write=SetStatusBarFillColors};
	__property System::Uitypes::TColor StatusBarFrameColors[Vcl::Themes::TThemedStatus Element] = {read=GetStatusBarFrameColors, write=SetStatusBarFrameColors};
	__property System::Uitypes::TColor TabColors[Vcl::Themes::TThemedTab Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetTabColors, write=SetTabColors};
	__property System::Uitypes::TColor ProgressColors[Vcl::Themes::TThemedProgress Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetProgressColors, write=SetProgressColors};
	__property System::Uitypes::TColor ProgressFrameColors[Vcl::Themes::TThemedProgress Element] = {read=GetProgressFrameColors, write=SetProgressFrameColors};
	__property System::Uitypes::TColor TrackBarFillColors[Vcl::Themes::TThemedTrackBar Element][Lmdthemescommontypes::TLMDColorIndex ColorIndex] = {read=GetTrackBarFillColors, write=SetTrackBarFillColors};
	__property System::Uitypes::TColor TrackBarFrameColors[Vcl::Themes::TThemedTrackBar Element] = {read=GetTrackBarFrameColors, write=SetTrackBarFrameColors};
	__property TLMDSimpleGradientSettings GradientSettings[Vcl::Themes::TThemedElement Element] = {read=GetGradientSettings, write=SetGradientSettings};
	__property Lmdthemes::TLMDThemesOnDrawCheckMarkEvent OnDrawCheckMark = {read=FOnDrawCheckMark, write=FOnDrawCheckMark};
	__property Lmdthemes::TLMDThemesOnDrawCheckMarkEvent OnDrawRadioBtn = {read=FOnDrawRadioBtn, write=FOnDrawRadioBtn};
	__property Lmdthemes::TLMDThemesOnDrawScrollThumbGripperEvent OnDrawScrollThumbGripper = {read=FOnDrawScrollThumbGripper, write=FOnDrawScrollThumbGripper};
	__property Lmdthemes::TLMDThemesOnDrawArrowEvent OnDrawArrow = {read=FOnDrawArrow, write=FOnDrawArrow};
	__property Lmdthemes::TLMDThemesOnDrawGradientArrowEvent OnDrawGradientArrow = {read=FOnDrawGradientArrow, write=FOnDrawGradientArrow};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawPlus = {read=FOnDrawPlus, write=FOnDrawPlus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawMinus = {read=FOnDrawMinus, write=FOnDrawMinus};
	__property Lmdthemes::TLMDThemesOnDrawSimpleSignEvent OnDrawCross = {read=FOnDrawCross, write=FOnDrawCross};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDBaseSGThemeRenderer(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdthemessgthemebase__1 CSimpleGradientThemeNames;
}	/* namespace Lmdthemessgthemebase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESSGTHEMEBASE)
using namespace Lmdthemessgthemebase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemessgthemebaseHPP
