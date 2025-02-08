// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomScrollBox.pas' rev: 31.00 (Windows)

#ifndef LmdcustomscrollboxHPP
#define LmdcustomscrollboxHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Themes.hpp>
#include <intfLMDBackGround.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDBevel.hpp>
#include <LMDGraph.hpp>
#include <LMDTypes.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomscrollbox
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDScrollBoxBevel;
class DELPHICLASS TLMDCustomScrollBox;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDScrollBoxBevel : public Lmdbevel::TLMDBevel
{
	typedef Lmdbevel::TLMDBevel inherited;
	
public:
	__fastcall virtual TLMDScrollBoxBevel(System::Classes::TPersistent* Owner);
	
__published:
	__property Mode = {default=3};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDScrollBoxBevel(void) { }
	
};


class PASCALIMPLEMENTATION TLMDCustomScrollBox : public Vcl::Forms::TScrollBox
{
	typedef Vcl::Forms::TScrollBox inherited;
	
private:
	Lmdtypes::TLMDAboutVar FAbout;
	TLMDScrollBoxBevel* FBevel;
	Vcl::Graphics::TCanvas* FCanvas;
	bool FOptScrollCodes;
	bool FTransparent;
	bool FInstantUpdate;
	bool FFullRepaint;
	System::Byte FDelta;
	System::Byte FInternal;
	System::Classes::TNotifyEvent FOnPaint;
	System::Classes::TNotifyEvent FOnScroll;
	bool FSaveResources;
	bool FFirstTimePaint;
	bool FThemeGlobalMode;
	void __fastcall SetBevel(TLMDScrollBoxBevel* aValue);
	void __fastcall SetDelta(System::Byte aValue);
	void __fastcall SetTransparent(bool aValue);
	void __fastcall SetCtlXP(bool aValue);
	Vcl::Forms::TBorderStyle __fastcall GetBorderStyle(void);
	bool __fastcall ScrollBarsVisible(void);
	void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
	MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Winapi::Messages::TWMSize &Message);
	HIDESBASE MESSAGE void __fastcall WMHScroll(Winapi::Messages::TWMScroll &Message);
	HIDESBASE MESSAGE void __fastcall WMVScroll(Winapi::Messages::TWMScroll &Message);
	void __fastcall DestroyHandleForInvisibleControls(void);
	void __fastcall SetSaveResources(const bool Value);
	void __fastcall SetThemeMode(const Lmdclass::TLMDThemeMode Value);
	void __fastcall SetThemeGlobalMode(const bool Value);
	bool __fastcall GetCtlXP(void);
	void __fastcall SetParentThemeMode(const bool Value);
	
protected:
	Lmdclass::TLMDThemeMode FThemeMode;
	bool FParentThemeMode;
	System::Types::TRect __fastcall BeveledRect(void);
	bool __fastcall CheckOptimized(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	void __fastcall Paint(void);
	System::Types::TRect __fastcall DrawThemeBevel(Lmdclass::TLMDThemeMode aTheme, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	void __fastcall PaintBevel(void);
	virtual void __fastcall PaintWindow(HDC DC);
	virtual void __fastcall DoThemeChanged(void);
	Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	__property bool CtlXP = {read=GetCtlXP, write=SetCtlXP, default=1};
	
public:
	__fastcall virtual TLMDCustomScrollBox(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomScrollBox(void);
	bool __fastcall IsThemed(void);
	virtual bool __fastcall BackBitmapCheck(void);
	virtual Vcl::Graphics::TBitmap* __fastcall BackBitmap(void);
	virtual System::Types::TPoint __fastcall BackMapPoint(const System::Types::TPoint &aValue);
	virtual bool __fastcall BackDrawArea(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &dest, const System::Types::TPoint &src, System::Word flags = (System::Word)(0x0));
	bool __fastcall isTransparentSet(void);
	HPALETTE __fastcall BackBitmapPalette(void);
	void __fastcall BackUpdate(void);
	Vcl::Controls::TControl* __fastcall BackControl(int index);
	int __fastcall BackControlCount(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property TLMDScrollBoxBevel* Bevel = {read=FBevel, write=SetBevel};
	__property bool InstantUpdate = {read=FInstantUpdate, write=FInstantUpdate, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property System::Byte UpdateDelta = {read=FDelta, write=SetDelta, default=1};
	__property System::Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property bool ParentThemeMode = {read=FParentThemeMode, write=SetParentThemeMode, nodefault};
	__property Lmdclass::TLMDThemeMode ThemeMode = {read=FThemeMode, write=SetThemeMode, default=1};
	__property bool ThemeGlobalMode = {read=FThemeGlobalMode, write=SetThemeGlobalMode, default=0};
	__property bool OptScrollCodes = {read=FOptScrollCodes, write=FOptScrollCodes, default=1};
	
__published:
	__property Lmdtypes::TLMDAboutVar About = {read=FAbout, write=FAbout};
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=GetBorderStyle, nodefault};
	__property Ctl3D = {default=1};
	__property ParentCtl3D = {default=0};
	__property bool FullRepaint = {read=FFullRepaint, write=FFullRepaint, default=0};
	__property System::Classes::TNotifyEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property bool SaveResources = {read=FSaveResources, write=SetSaveResources, default=0};
	__property OnGesture;
	__property Touch;
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomScrollBox(HWND ParentWindow) : Vcl::Forms::TScrollBox(ParentWindow) { }
	
private:
	void *__ILMDBackground;	// Intflmdbackground::ILMDBackground 
	
public:
	#if defined(MANAGED_INTERFACE_OPERATORS)
	// {0068598D-C5C6-488F-8E00-D813525C9163}
	operator Intflmdbackground::_di_ILMDBackground()
	{
		Intflmdbackground::_di_ILMDBackground intf;
		this->GetInterface(intf);
		return intf;
	}
	#else
	operator Intflmdbackground::ILMDBackground*(void) { return (Intflmdbackground::ILMDBackground*)&__ILMDBackground; }
	#endif
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcustomscrollbox */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSCROLLBOX)
using namespace Lmdcustomscrollbox;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomscrollboxHPP
