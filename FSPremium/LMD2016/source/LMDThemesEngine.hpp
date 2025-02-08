// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDThemesEngine.pas' rev: 31.00 (Windows)

#ifndef LmdthemesengineHPP
#define LmdthemesengineHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <LMDThemes.hpp>
#include <LMDClass.hpp>
#include <LMDTypes.hpp>
#include <LMDStrings.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDThemesMain.hpp>
#include <LMDThemesGeneral.hpp>
#include <System.UITypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdthemesengine
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDThemeEngineController;
class DELPHICLASS TLMDThemeEngine;
//-- type declarations -------------------------------------------------------
typedef Vcl::Themes::TThemeData TLMDThemeData;

typedef Vcl::Themes::TThemedElement TLMDThemedElement;

class PASCALIMPLEMENTATION TLMDThemeEngineController : public Lmdthemes::TLMDThemesControllerBase
{
	typedef Lmdthemes::TLMDThemesControllerBase inherited;
	
private:
	bool FFTPNotification;
	System::Uitypes::TColor FCustomReadOnlyColor;
	System::Uitypes::TColor FCustomDisabledColor;
	Lmdthemes::TLMDStateColorMode FReadOnlyColorMode;
	Lmdthemes::TLMDStateColorMode FDisabledColorMode;
	System::Uitypes::TColor __fastcall GetCustomReadOnlyColor(void);
	void __fastcall SetCustomReadonlyColor(System::Uitypes::TColor Value);
	Lmdthemes::TLMDStateColorMode __fastcall GetReadOnlyColorMode(void);
	void __fastcall SetReadOnlyColorMode(Lmdthemes::TLMDStateColorMode Value);
	Lmdthemes::TLMDStateColorMode __fastcall GetDisabledColorMode(void);
	void __fastcall SetDisabledColorMode(Lmdthemes::TLMDStateColorMode Value);
	System::Uitypes::TColor __fastcall GetCustomDisabledColor(void);
	void __fastcall SetCustomDisabledColor(const System::Uitypes::TColor Value);
	TLMDThemeEngine* __fastcall GetThemeEngine(void);
	bool __fastcall GetFTPNotification(void);
	void __fastcall SetFTPNotification(const bool Value);
	
protected:
	virtual Lmdthemes::TLMDThemeRenderer* __fastcall GetThemeRenderer(void);
	virtual void __fastcall RegisterController(void);
	virtual void __fastcall UnregisterController(void);
	virtual void __fastcall SetFormThemeProviderOptions(const Lmdthemes::TLMDFormThemeProviderOptions Value);
	virtual void __fastcall SetFormThemeProvidersEnabled(const bool Value);
	
public:
	__fastcall virtual TLMDThemeEngineController(System::Classes::TComponent* AOwner);
	__property TLMDThemeEngine* ThemeEngine = {read=GetThemeEngine};
	
__published:
	__property System::Uitypes::TColor CustomReadOnlyColor = {read=GetCustomReadOnlyColor, write=SetCustomReadonlyColor, nodefault};
	__property System::Uitypes::TColor CustomDisabledColor = {read=GetCustomDisabledColor, write=SetCustomDisabledColor, nodefault};
	__property Lmdthemes::TLMDStateColorMode ReadOnlyColorMode = {read=GetReadOnlyColorMode, write=SetReadOnlyColorMode, nodefault};
	__property Lmdthemes::TLMDStateColorMode DisabledColorMode = {read=GetDisabledColorMode, write=SetDisabledColorMode, nodefault};
	__property FormThemeProvidersEnabled;
	__property FormThemeProviderOptions;
	__property bool FTPNotification = {read=GetFTPNotification, write=SetFTPNotification, nodefault};
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDThemeEngineController(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDThemeEngine : public Lmdthemes::TLMDThemeRenderer
{
	typedef Lmdthemes::TLMDThemeRenderer inherited;
	
private:
	Vcl::Themes::TThemeData FThemeData;
	bool FEnabled;
	System::WideString FCurrentSystemColorScheme;
	System::WideString FLastColorScheme;
	bool FDontLoadSystemTheme;
	System::Classes::TList* FFormThemeProviders;
	System::Uitypes::TColor FCustomReadOnlyColor;
	System::Uitypes::TColor FCustomDisabledColor;
	Lmdthemes::TLMDStateColorMode FDisabledColorMode;
	Lmdthemes::TLMDStateColorMode FReadOnlyColorMode;
	bool FFTPNotification;
	bool FFormThemeProvidersEnabled;
	Lmdthemes::TLMDFormThemeProviderOptions FFormThemeProviderOptions;
	bool __fastcall UseFTPNotification(void);
	Lmdthemesgeneral::TThemeManager* __fastcall GetCurrentTheme(void);
	NativeUInt __fastcall GetTheme(Vcl::Themes::TThemedElement Element);
	void __fastcall SetCustomDisabledColor(const System::Uitypes::TColor Value);
	void __fastcall SetCustomReadOnlyColor(const System::Uitypes::TColor Value);
	
protected:
	void __fastcall ApplyThemeChange(void);
	void __fastcall UnloadThemeData(void);
	virtual bool __fastcall GetEnabled(void);
	virtual void __fastcall SetEnabled(bool Value);
	virtual Lmdtypes::TLMDString __fastcall GetActiveThemeName(void);
	virtual Lmdtypes::TLMDString __fastcall GetActiveColorSchemeName(void);
	virtual void __fastcall SetFormThemeProviderOptions(const Lmdthemes::TLMDFormThemeProviderOptions Value);
	virtual void __fastcall SetFormThemeProvidersEnabled(const bool Value);
	virtual Lmdthemes::TLMDFormThemeProviderOptions __fastcall GetFormThemeProviderOptions(void);
	virtual bool __fastcall GetFormThemeProvidersEnabled(void);
	
public:
	__classmethod virtual Lmdthemes::TLMDThemesControllerBase* __fastcall Controller();
	__classmethod virtual void __fastcall Init();
	__classmethod virtual Lmdtypes::TLMDString __fastcall GetThemeRendererName();
	__fastcall virtual TLMDThemeEngine(void);
	__fastcall virtual ~TLMDThemeEngine(void);
	virtual bool __fastcall ActivateColorScheme(System::UnicodeString AColorScheme = System::UnicodeString(), bool ADoApply = true);
	virtual bool __fastcall ActivateDefaultTheme(System::UnicodeString AColorScheme = System::UnicodeString(), bool aDoApply = true);
	bool __fastcall LoadCurrentSystemTheme(void);
	virtual bool __fastcall ActivateTheme(System::UnicodeString AFileName, System::UnicodeString AColorScheme = System::UnicodeString());
	virtual void __fastcall DeactivateTheme(void);
	bool __fastcall EnumThemeColorSchemes(NativeUInt ThemeManagerHandle, System::Classes::TStringList* &Schemes);
	bool __fastcall GetThemeDisplayName(System::WideString &DisplayName);
	bool __fastcall GetThemeColorSchemeDisplayName(System::WideString SchemeName, System::WideString &DisplayName);
	bool __fastcall GetCurrentThemeDisplayName(System::WideString &DisplayName);
	bool __fastcall GetCurrentColorScheme(System::WideString &ColorScheme);
	virtual NativeUInt __fastcall GetCurrentThemeHandle(void);
	bool __fastcall IsSystemThemeEnabled(void);
	virtual void __fastcall RegisterFormThemeProvider(System::TObject* Value);
	virtual void __fastcall UnregisterFormThemeProvider(System::TObject* Value);
	bool __fastcall IsCurrentThemeSystem(void);
	__property Lmdthemesgeneral::TThemeManager* CurrentTheme = {read=GetCurrentTheme};
	__property NativeUInt Theme[Vcl::Themes::TThemedElement Element] = {read=GetTheme};
	virtual System::Types::TRect __fastcall ContentRect(HDC DC, const Vcl::Themes::TThemedElementDetails &Details, const System::Types::TRect &BoundingRect);
	virtual bool __fastcall GetThemeBackgroundExtent(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartID, int iStateID, const System::Types::TRect &ContentRect, System::Types::TRect &ExtentRect);
	virtual unsigned __fastcall GetThemeColor(Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, int iPropId)/* overload */;
	virtual bool __fastcall GetThemeFont(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, int iPropId, tagLOGFONTW &font)/* overload */;
	virtual bool __fastcall GetThemePartSize(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, System::Types::TSize &size)/* overload */;
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
	virtual bool __fastcall DrawThemeEdge(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, const System::Types::TRect &pDestRect, unsigned uEdge, unsigned uFlags, System::Types::PRect pContentRect)/* overload */;
	virtual bool __fastcall DrawThemeText(HDC DC, Vcl::Themes::TThemedElement Detail, int iPartId, int iStateId, Lmdtypes::TLMDString Text, int CharCount, unsigned dwTextFlags, unsigned dwTextFlags2, const System::Types::TRect &pRect);
	__property bool Enabled = {read=GetEnabled, write=SetEnabled, nodefault};
	__property System::Uitypes::TColor CustomReadOnlyColor = {read=FCustomReadOnlyColor, write=SetCustomReadOnlyColor, nodefault};
	__property System::Uitypes::TColor CustomDisabledColor = {read=FCustomDisabledColor, write=SetCustomDisabledColor, nodefault};
	__property bool FTPNotification = {read=FFTPNotification, write=FFTPNotification, default=0};
	__property Lmdthemes::TLMDStateColorMode ReadOnlyColorMode = {read=FReadOnlyColorMode, write=FReadOnlyColorMode, default=0};
	__property Lmdthemes::TLMDStateColorMode DisabledColorMode = {read=FDisabledColorMode, write=FDisabledColorMode, default=0};
	__property bool FormThemeProvidersEnabled = {read=GetFormThemeProvidersEnabled, write=SetFormThemeProvidersEnabled, nodefault};
	__property Lmdthemes::TLMDFormThemeProviderOptions FormThemeProviderOptions = {read=GetFormThemeProviderOptions, write=SetFormThemeProviderOptions, nodefault};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 cSpecialColorArraySize = System::Int8(0x1e);
extern DELPHI_PACKAGE bool UxThemeLibraryAvailable;
extern DELPHI_PACKAGE TLMDThemeEngine* LMDThemeEngine;
extern DELPHI_PACKAGE TLMDThemeEngineController* LMDThemeEngineController;
extern DELPHI_PACKAGE void __fastcall RegisterRenderer(void);
}	/* namespace Lmdthemesengine */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTHEMESENGINE)
using namespace Lmdthemesengine;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdthemesengineHPP
