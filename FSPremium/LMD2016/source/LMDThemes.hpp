// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemes.pas' rev: 31.00 (Windows)

#ifndef LmdthemesHPP
#define LmdthemesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Themes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.ImgList.hpp>
#include <System.TypInfo.hpp>
#include <LMDTypes.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemes
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDThemeRenderer;
class DELPHICLASS TLMDThemesControllerBase;
class DELPHICLASS TLMDThemeServices;
//-- type declarations -------------------------------------------------------
typedef System::Types::PRect TLMDRectPtr;

enum DECLSPEC_DENUM TLMDStateColorMode : unsigned char { scmTheme, scmNoChange, scmCustom };

enum DECLSPEC_DENUM TLMDFormThemeProviderOption : unsigned char { ftpShowSysButton, ftpThemedNCArea };

typedef System::Set<TLMDFormThemeProviderOption, TLMDFormThemeProviderOption::ftpShowSysButton, TLMDFormThemeProviderOption::ftpThemedNCArea> TLMDFormThemeProviderOptions;

enum DECLSPEC_DENUM TLMDThemedButtonState : unsigned char { btnsNormal, btnsHot, btnsPressed, btnsDisabled };

typedef void __fastcall (__closure *TLMDThemesOnDrawElement)(System::TObject* Sender, HDC DC, System::Typinfo::PTypeInfo aElementTypeInfo, System::Typinfo::PTypeInfo aDetailTypeInfo, int aElement, int aDetail, const System::Types::TRect &ARect, System::Types::PRect ClipRect, bool &aExitPainter);

typedef void __fastcall (__closure *TLMDThemesOnDrawCheckMarkEvent)(System::TObject* Sender, HDC DC, const System::Types::TRect &ARect, Vcl::Themes::TThemedButton aCheckBox, bool &aExitPainter);

typedef void __fastcall (__closure *TLMDThemesOnDrawArrowEvent)(System::TObject* Sender, HDC DC, const System::Types::TRect &ARect, Lmdgraph::TLMDDirection ADir, bool aDrawShadow, bool aEnabled, bool &aExitPainter);

typedef void __fastcall (__closure *TLMDThemesOnDrawGradientArrowEvent)(System::TObject* Sender, HDC DC, const System::Types::TRect &ARect, Lmdgraph::TLMDDirection ADir, TLMDThemedButtonState aState, bool &aExitPainter);

typedef void __fastcall (__closure *TLMDThemesOnDrawSimpleSignEvent)(System::TObject* Sender, HDC DC, const System::Types::TRect &ARect, bool aDrawShadow, bool &aExitPainter);

typedef void __fastcall (__closure *TLMDThemesOnDrawScrollThumbGripperEvent)(System::TObject* Sender, HDC DC, const System::Types::TRect &aRect, Vcl::Themes::TThemedScrollBar Detail, bool &aExitPainter);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDThemeRenderer : public System::TObject
{
	typedef System::TObject inherited;
	
protected:
	virtual bool __fastcall GetEnabled(void) = 0 ;
	virtual void __fastcall SetEnabled(bool aValue) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetActiveThemeName(void) = 0 ;
	virtual Lmdtypes::TLMDString __fastcall GetActiveColorSchemeName(void) = 0 ;
	virtual TLMDFormThemeProviderOptions __fastcall GetFormThemeProviderOptions(void);
	virtual bool __fastcall GetFormThemeProvidersEnabled(void);
	virtual void __fastcall SetFormThemeProviderOptions(const TLMDFormThemeProviderOptions Value);
	virtual void __fastcall SetFormThemeProvidersEnabled(const bool Value);
	
public:
	__classmethod virtual TLMDThemesControllerBase* __fastcall Controller();
	__classmethod virtual void __fastcall Init();
	__classmethod virtual Lmdtypes::TLMDString __fastcall GetThemeRendererName();
	virtual bool __fastcall ActivateColorScheme(System::UnicodeString AColorScheme = System::UnicodeString(), bool ADoApply = true) = 0 ;
	virtual bool __fastcall ActivateTheme(System::UnicodeString AFileName, System::UnicodeString AColorScheme = System::UnicodeString()) = 0 ;
	virtual bool __fastcall ActivateDefaultTheme(System::UnicodeString AColorScheme = System::UnicodeString(), bool aDoApply = true) = 0 ;
	virtual void __fastcall DeactivateTheme(void) = 0 ;
	__fastcall virtual TLMDThemeRenderer(void) = 0 ;
	virtual System::Types::TRect __fastcall ContentRect(HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &BoundingRect) = 0 ;
	virtual bool __fastcall GetThemeBackgroundExtent(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartID, int iStateID, const System::Types::TRect &ContentRect, System::Types::TRect &ExtentRect) = 0 ;
	virtual unsigned __fastcall GetThemeColor(Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, int iPropId) = 0 ;
	virtual bool __fastcall GetThemeFont(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, int iPropId, tagLOGFONTW &font) = 0 ;
	virtual bool __fastcall GetThemePartSize(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, System::Types::TSize &size) = 0 ;
	virtual unsigned __fastcall GetThemeSysColor(Vcl::Themes::TThemedElement Detail, int ColorID) = 0 ;
	virtual int __fastcall GetThemeSysSize(Vcl::Themes::TThemedElement Detail, int iSizeId) = 0 ;
	virtual bool __fastcall GetThemeTextExtent(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, Lmdtypes::TLMDString Text, int CharCount, unsigned dwTextFlags, System::Types::PRect BoundingRect, System::Types::TRect &ExtentRect) = 0 ;
	virtual NativeUInt __fastcall GetCurrentThemeHandle(void);
	virtual void __fastcall RegisterFormThemeProvider(System::TObject* Value);
	virtual void __fastcall UnregisterFormThemeProvider(System::TObject* Value);
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedButton Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedButton Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedComboBox Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedComboBox Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedEdit Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedEdit Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedExplorerBar Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedExplorerBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedProgress Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedProgress Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedScrollBar Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedScrollBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedSpin Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedSpin Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedStatus Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedStatus Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTab Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTab Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolBar Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolTip Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedToolTip Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTrackBar Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTrackBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedWindow Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedWindow Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedListview Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedListview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedHeader Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedHeader Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTreeview Detail, const System::Types::TRect &R) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, Vcl::Themes::TThemedTreeview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect) = 0 /* overload */;
	virtual void __fastcall DrawElement(HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0)) = 0 /* overload */;
	virtual void __fastcall DrawThemeParentBackground(HWND Wnd, HDC DC, System::Types::PRect ARect) = 0 ;
	virtual bool __fastcall DrawThemeEdge(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, const System::Types::TRect &pDestRect, unsigned uEdge, unsigned uFlags, System::Types::PRect pContentRect) = 0 /* overload */;
	virtual bool __fastcall DrawThemeText(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, Lmdtypes::TLMDString Text, int CharCount, unsigned dwTextFlags, unsigned dwTextFlags2, const System::Types::TRect &pRect) = 0 ;
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, nodefault};
	__property Lmdtypes::TLMDString ActiveThemeName = {read=GetActiveThemeName};
	__property Lmdtypes::TLMDString ActiveColorSchemeName = {read=GetActiveColorSchemeName};
	__property bool FormThemeProvidersEnabled = {read=GetFormThemeProvidersEnabled, write=SetFormThemeProvidersEnabled, nodefault};
	__property TLMDFormThemeProviderOptions FormThemeProviderOptions = {read=GetFormThemeProviderOptions, write=SetFormThemeProviderOptions, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDThemeRenderer(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDThemesControllerBase : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	bool FEnabled;
	bool FFormThemeProvidersEnabled;
	TLMDFormThemeProviderOptions FFormThemeProviderOptions;
	bool __fastcall GetEnabled(void);
	void __fastcall SetEnabled(const bool Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall RegisterController(void);
	virtual void __fastcall UnregisterController(void);
	virtual TLMDThemeRenderer* __fastcall GetThemeRenderer(void);
	virtual TLMDFormThemeProviderOptions __fastcall GetFormThemeProviderOptions(void);
	virtual bool __fastcall GetFormThemeProvidersEnabled(void);
	virtual void __fastcall SetFormThemeProviderOptions(const TLMDFormThemeProviderOptions Value);
	virtual void __fastcall SetFormThemeProvidersEnabled(const bool Value);
	__property bool FormThemeProvidersEnabled = {read=GetFormThemeProvidersEnabled, write=SetFormThemeProvidersEnabled, nodefault};
	__property TLMDFormThemeProviderOptions FormThemeProviderOptions = {read=GetFormThemeProviderOptions, write=SetFormThemeProviderOptions, nodefault};
	
public:
	__fastcall virtual TLMDThemesControllerBase(System::Classes::TComponent* AOwner);
	__property TLMDThemeRenderer* ThemeRenderer = {read=GetThemeRenderer};
	
__published:
	__property About = {default=0};
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDThemesControllerBase(void) { }
	
};


class PASCALIMPLEMENTATION TLMDThemeServices : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	HWND FHWND;
	bool FSystemThemeIsChanging;
	bool FUseThemes;
	System::Classes::TNotifyEvent FOnThemeChange;
	TLMDThemeRenderer* FCurrentRenderer;
	System::Classes::TStringList* FAvailableRenderers;
	bool FSubstToolBarToButton;
	void __fastcall SetSubstToolBarToButton(const bool Value);
	
protected:
	void __fastcall DoOnThemeChange(void);
	void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDThemeServices(void);
	__fastcall virtual ~TLMDThemeServices(void);
	bool __fastcall ActivateColorScheme(System::UnicodeString AColorScheme = System::UnicodeString());
	bool __fastcall ActivateTheme(System::UnicodeString AFileName, System::UnicodeString AColorScheme = System::UnicodeString());
	void __fastcall DeactivateTheme(void);
	void __fastcall ApplyThemeChange(void);
	int __fastcall GetDetailOrd(const Vcl::Themes::TThemedElementDetails &Details);
	Vcl::Themes::TThemedElementDetails __fastcall GetDetails(Vcl::Themes::TThemedElement aElement, int aDetail);
	void __fastcall RegisterThemeRenderer(TLMDThemeRenderer* aThemeRenderer);
	void __fastcall SelectThemeRenderer(System::UnicodeString aRendererName)/* overload */;
	void __fastcall SelectThemeRenderer(int aRendererIndex)/* overload */;
	__property bool SystemThemeIsChanging = {read=FSystemThemeIsChanging, nodefault};
	System::Types::TRect __fastcall ContentRect(Lmdclass::TLMDThemeMode Theme, HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &BoundingRect);
	bool __fastcall GetThemePartSize(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, System::Types::TSize &size)/* overload */;
	bool __fastcall GetThemePartSize(Lmdclass::TLMDThemeMode Theme, HDC DC, const Vcl::Themes::TThemedElementDetails &Details, System::Types::TSize &size)/* overload */;
	bool __fastcall GetThemePartSizeNew(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, System::Types::TSize &size)/* overload */;
	bool __fastcall GetThemePartSizeNew(Lmdclass::TLMDThemeMode Theme, HDC DC, const Vcl::Themes::TThemedElementDetails &Details, System::Types::TSize &size)/* overload */;
	int __fastcall GetThemeSysSize(Lmdclass::TLMDThemeMode Theme, Vcl::Themes::TThemedElement Detail, int iSizeId);
	bool __fastcall GetThemeFont(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, int iPropId, tagLOGFONTW &font);
	bool __fastcall GetThemeTextExtent(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, Lmdtypes::TLMDString Text, int CharCount, unsigned dwTextFlags, System::Types::PRect BoundingRect, System::Types::TRect &ExtentRect)/* overload */;
	bool __fastcall GetThemeTextExtent(Lmdclass::TLMDThemeMode Theme, HDC DC, const Vcl::Themes::TThemedElementDetails &Details, Lmdtypes::TLMDString Text, int CharCount, unsigned dwTextFlags, System::Types::PRect BoundingRect, System::Types::TRect &ExtentRect)/* overload */;
	bool __fastcall GetThemeBackgroundExtent(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedElement Detail, int iPartID, int iStateID, const System::Types::TRect &ContentRect, System::Types::TRect &ExtentRect)/* overload */;
	bool __fastcall GetThemeBackgroundExtent(Lmdclass::TLMDThemeMode Theme, HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &ContentRect, System::Types::TRect &ExtentRect)/* overload */;
	unsigned __fastcall GetThemeColor(Lmdclass::TLMDThemeMode Theme, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, int iPropId)/* overload */;
	unsigned __fastcall GetThemeColor(Lmdclass::TLMDThemeMode Theme, const Vcl::Themes::TThemedElementDetails &ADetails, int iPropId)/* overload */;
	unsigned __fastcall GetThemeSysColor(Lmdclass::TLMDThemeMode Theme, Vcl::Themes::TThemedElement Detail, int ColorID);
	void __fastcall DrawThemeParentBackground(Lmdclass::TLMDThemeMode Theme, HWND Wnd, HDC DC, System::Types::PRect ARect);
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedButton Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedComboBox Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedEdit Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedExplorerBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedProgress Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedScrollBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedSpin Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedStatus Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedTab Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedToolBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedToolTip Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedTrackBar Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedWindow Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedListview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedHeader Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedTreeview Detail, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawElement(Lmdclass::TLMDThemeMode Theme, HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &R, System::Types::PRect ClipRect = (System::Types::PRect)(0x0))/* overload */;
	bool __fastcall DrawThemeEdge(Lmdclass::TLMDThemeMode Theme, HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, const System::Types::TRect &pDestRect, unsigned uEdge, unsigned uFlags, System::Types::PRect pContentRect = (System::Types::PRect)(0x0))/* overload */;
	void __fastcall DrawThemeText(Lmdclass::TLMDThemeMode Theme, HDC DC, const Vcl::Themes::TThemedElementDetails &Details, Lmdtypes::TLMDString Text, int CharCount, unsigned Flags, unsigned Flags2, const System::Types::TRect &R);
	Lmdclass::TLMDThemeMode __fastcall UseTheme(const Lmdclass::TLMDThemeMode Value);
	bool __fastcall ThemesEnabled(const Lmdclass::TLMDThemeMode Value = (Lmdclass::TLMDThemeMode)(0x1));
	__property TLMDThemeRenderer* CurrentRenderer = {read=FCurrentRenderer};
	__property System::Classes::TStringList* AvailableRenderers = {read=FAvailableRenderers};
	__property bool SubstToolBarToButton = {read=FSubstToolBarToButton, write=SetSubstToolBarToButton, nodefault};
	__property System::Classes::TNotifyEvent OnThemeChange = {read=FOnThemeChange, write=FOnThemeChange};
};


//-- var, const, procedure ---------------------------------------------------
#define LMDNullRectPtr (void*)(0)
static const System::Int8 CBS_SCROLLSIZEGRIP = System::Int8(0x1);
static const System::Int8 CBS_SCROLLSIZEGRIPRIGHT = System::Int8(0x2);
extern DELPHI_PACKAGE TLMDThemeServices* __fastcall LMDThemeServices(void);
extern DELPHI_PACKAGE void __fastcall LMDSetThemeMode(Vcl::Forms::TCustomForm* aParent, const Lmdclass::TLMDThemeMode Value)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDSetThemeMode(Vcl::Controls::TWinControl* aParent, const Lmdclass::TLMDThemeMode Value)/* overload */;
}	/* namespace Lmdthemes */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMES)
using namespace Lmdthemes;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemesHPP
