// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFormThemeProvider.pas' rev: 31.00 (Windows)

#ifndef LmdformthemeproviderHPP
#define LmdformthemeproviderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.UxTheme.hpp>
#include <Vcl.Themes.hpp>
#include <LMDTypes.hpp>
#include <LMDThemes.hpp>
#include <LMDThemesMain.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDThemesEngine.hpp>
#include <LMDWndProcComponent.hpp>
#include <LMDCustomComponent.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdformthemeprovider
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFormThemeProvider;
//-- type declarations -------------------------------------------------------
typedef System::Int8 TLMDNCButtonIDs;

typedef System::Int8 TLMDNCMetricIDs;

typedef System::Set<TLMDNCMetricIDs, 1, 12> TLMDNCMetricIDSet;

typedef System::Set<TLMDNCButtonIDs, 13, 24> TLMDNCButtonIDSet;

class PASCALIMPLEMENTATION TLMDFormThemeProvider : public Lmdwndproccomponent::TLMDWndProcComponent
{
	typedef Lmdwndproccomponent::TLMDWndProcComponent inherited;
	
private:
	Lmdthemes::TLMDFormThemeProviderOptions FOptions;
	bool FUseGlobalOptions;
	System::StaticArray<System::StaticArray<System::Types::TRect, 4>, 12> FBtnRects;
	System::StaticArray<System::StaticArray<int, 2>, 12> FMetrics;
	_MARGINS FContentMargins;
	_MARGINS FCaptionMargins;
	_MARGINS FSizingMargins;
	unsigned FFrameLeftID;
	unsigned FFrameRightID;
	unsigned FFrameBottomID;
	unsigned FCaptionID;
	unsigned FLastPaintedBtnID;
	TLMDNCButtonIDSet FButtonSet;
	bool FWndActive;
	Vcl::Graphics::TBitmap* FTitleBarBmp;
	Vcl::Graphics::TBitmap* FIconBitmap;
	bool FPainting;
	System::Types::TRect FNCDeltaRect;
	bool FThemeAvailableWhenCreated;
	bool FCanNullifyRegion;
	unsigned FNCLButtonDownAreaID;
	bool FNCLButtonDown;
	System::Types::TPoint FNCMouseDownPos;
	System::Types::TRect FWindowMouseDownRect;
	void __fastcall PrepareTitleBarBmp(void);
	void __fastcall PrepareFormIconBitmap(void);
	void __fastcall PaintTitleBarTo(HDC DC);
	void __fastcall PaintTitleBar(void);
	void __fastcall PaintNCArea(void);
	void __fastcall PaintNCAreaBgrTo(HDC DC, unsigned StateID);
	void __fastcall PaintButton(HDC DC, unsigned BtnID, unsigned StateID);
	unsigned __fastcall UpdateButton(const Winapi::Messages::TMessage &Msg);
	void __fastcall UpdateRegion(void);
	void __fastcall SetOptions(Lmdthemes::TLMDFormThemeProviderOptions aValue);
	void __fastcall SetUseGlobalOptions(bool aValue);
	Lmdthemes::TLMDFormThemeProviderOptions __fastcall CurrentOptions(void);
	bool __fastcall IsEnabled(void);
	
protected:
	virtual void __fastcall EnabledChanged(void);
	void __fastcall GetNCAreaThemeMetrics(void);
	void __fastcall GetButtonRects(void);
	unsigned __fastcall GetButtonIDAtPos(int x, int y);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDFormThemeProvider(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDFormThemeProvider(void);
	void __fastcall DoThemeChange(void);
	void __fastcall ReInit(void);
	void __fastcall UpdateControls(void);
	void __fastcall UpdateForm(void);
	
__published:
	__property About = {default=0};
	__property Enabled = {default=1};
	__property Lmdthemes::TLMDFormThemeProviderOptions Options = {read=FOptions, write=SetOptions, default=3};
	__property bool UseGlobalOptions = {read=FUseGlobalOptions, write=SetUseGlobalOptions, default=1};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdformthemeprovider */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFORMTHEMEPROVIDER)
using namespace Lmdformthemeprovider;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdformthemeproviderHPP
