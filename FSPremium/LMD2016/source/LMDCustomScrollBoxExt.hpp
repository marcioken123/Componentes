// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCustomScrollBoxExt.pas' rev: 31.00 (Windows)

#ifndef LmdcustomscrollboxextHPP
#define LmdcustomscrollboxextHPP

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
#include <Vcl.StdCtrls.hpp>
#include <intfLMDBackGround.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDBevel.hpp>
#include <LMDGraph.hpp>
#include <LMDTypes.hpp>
#include <LMDCustomScrollBox.hpp>
#include <LMDBackPanel.hpp>
#include <LMDSBar.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDControl.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcustomscrollboxext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCustomScrollBoxExt;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDCanScrollEvent)(System::TObject* Sender, Vcl::Controls::TControl* aControl, int aDeltaX, int aDeltaY, bool &aCanScroll);

class PASCALIMPLEMENTATION TLMDCustomScrollBoxExt : public Lmdbackpanel::TLMDBackPanel
{
	typedef Lmdbackpanel::TLMDBackPanel inherited;
	
private:
	Lmdbackpanel::TLMDBackPanel* FBottomRightPanel;
	Vcl::Graphics::TCanvas* FCanvas;
	bool FOptScrollCodes;
	bool FTransparent;
	bool FInstantUpdate;
	bool FFullRepaint;
	System::Byte FDelta;
	System::Byte FInternal;
	System::Classes::TNotifyEvent FOnPaint;
	System::Classes::TNotifyEvent FOnScroll;
	TLMDCanScrollEvent FOnCanScroll;
	bool FSaveResources;
	bool FFirstTimePaint;
	Lmdsbar::TLMDScrollBar* FVScroll;
	Lmdsbar::TLMDScrollBar* FHScroll;
	Lmdsbar::TLMDScrollBarObject* FHScrollObj;
	Lmdsbar::TLMDScrollBarObject* FVScrollObj;
	int FDx;
	int FDy;
	void __fastcall SetDelta(System::Byte aValue);
	HIDESBASE void __fastcall SetTransparent(bool aValue);
	void __fastcall SetCtlXP(bool aValue);
	Vcl::Forms::TBorderStyle __fastcall GetBorderStyle(void);
	bool __fastcall ScrollBarsVisible(void);
	HIDESBASE void __fastcall ReadCtlXP(System::Classes::TReader* Reader);
	HIDESBASE MESSAGE void __fastcall CMColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMParentColorChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMDesignHitTest(Winapi::Messages::TWMMouse &Message);
	HIDESBASE MESSAGE void __fastcall WMThemeChanged(Winapi::Messages::TMessage &Msg);
	HIDESBASE MESSAGE void __fastcall CMCtl3DChanged(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMNCCalcSize(Winapi::Messages::TWMNCCalcSize &Message);
	HIDESBASE MESSAGE void __fastcall WMNCHitTest(Winapi::Messages::TWMNCHitTest &Message);
	HIDESBASE MESSAGE void __fastcall WMEraseBkGnd(Winapi::Messages::TWMEraseBkgnd &Message);
	HIDESBASE MESSAGE void __fastcall WMNCPaint(Winapi::Messages::TWMNCPaint &Msg);
	HIDESBASE MESSAGE void __fastcall WMMove(Winapi::Messages::TWMMove &Message);
	HIDESBASE MESSAGE void __fastcall WMPaint(Winapi::Messages::TWMPaint &Message);
	HIDESBASE MESSAGE void __fastcall WMSIZE(Winapi::Messages::TWMSize &Message);
	void __fastcall DestroyHandleForInvisibleControls(void);
	void __fastcall SetSaveResources(const bool Value);
	void __fastcall SetScrollObj(const int aIndex, Lmdsbar::TLMDScrollBarObject* const aValue);
	
protected:
	System::Types::TPoint FScrollRange;
	System::Types::TRect FScrollRect;
	virtual void __fastcall AdjustVScrollRect(System::Types::TRect &aRect);
	virtual void __fastcall AdjustHScrollRect(System::Types::TRect &aRect);
	virtual void __fastcall AlignControls(Vcl::Controls::TControl* AControl, System::Types::TRect &Rect);
	virtual void __fastcall CalcScrollRange(int &aMaxX, int &aMaxY);
	virtual void __fastcall ScrollByEx(int DeltaX, int DeltaY, const System::Types::TRect &aRect);
	virtual void __fastcall DoCheckCanScroll(Vcl::Controls::TControl* aControl, int aDeltaX, int aDeltaY, bool &aCanScroll);
	virtual void __fastcall ScrollX(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	virtual void __fastcall ScrollY(System::TObject* Sender, System::Uitypes::TScrollCode ScrollCode, int &ScrollPos);
	HIDESBASE System::Types::TRect __fastcall BeveledRect(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall CreateWnd(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	virtual void __fastcall Paint(void);
	virtual void __fastcall DrawThemeBevel(Lmdclass::TLMDThemeMode aTheme, Vcl::Graphics::TCanvas* aCanvas, const System::Types::TRect &aRect);
	void __fastcall PaintBevel(void);
	virtual void __fastcall PaintWindow(HDC DC);
	virtual void __fastcall DoThemeChanged(void);
	HIDESBASE Lmdclass::TLMDThemeMode __fastcall UseThemeMode(void);
	virtual void __fastcall CreateScrollBars(void);
	virtual void __fastcall UpdateVertScrollParams(const System::Types::TRect &aRect);
	virtual void __fastcall UpdateHorzScrollParams(const System::Types::TRect &aRect);
	virtual void __fastcall UpdateScrollBars(bool aPosOnly = false);
	virtual bool __fastcall NeedHorzScrollBar(void);
	virtual bool __fastcall NeedVertScrollBar(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__property bool CtlXP = {read=GetCtlXP, write=SetCtlXP, default=1};
	__property Lmdsbar::TLMDScrollBar* HScroll = {read=FHScroll};
	__property Lmdsbar::TLMDScrollBar* VScroll = {read=FVScroll};
	virtual void __fastcall CreateBevel(void);
	
public:
	__fastcall virtual TLMDCustomScrollBoxExt(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomScrollBoxExt(void);
	HIDESBASE bool __fastcall IsThemed(void);
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
	__property bool InstantUpdate = {read=FInstantUpdate, write=FInstantUpdate, default=1};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property System::Byte UpdateDelta = {read=FDelta, write=SetDelta, default=1};
	__property System::Classes::TNotifyEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property bool OptScrollCodes = {read=FOptScrollCodes, write=FOptScrollCodes, default=1};
	__property Lmdsbar::TLMDScrollBarObject* HorzScrollBar = {read=FHScrollObj, write=SetScrollObj, index=0};
	__property Lmdsbar::TLMDScrollBarObject* VertScrollBar = {read=FVScrollObj, write=SetScrollObj, index=1};
	__property bool SaveResources = {read=FSaveResources, write=SetSaveResources, default=0};
	
__published:
	__property Vcl::Forms::TBorderStyle BorderStyle = {read=GetBorderStyle, nodefault};
	__property Ctl3D = {default=1};
	__property ParentCtl3D = {default=0};
	__property bool FullRepaint = {read=FFullRepaint, write=FFullRepaint, default=0};
	__property System::Classes::TNotifyEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property TLMDCanScrollEvent OnCanScroll = {read=FOnCanScroll, write=FOnCanScroll};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDCustomScrollBoxExt(HWND ParentWindow) : Lmdbackpanel::TLMDBackPanel(ParentWindow) { }
	
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
}	/* namespace Lmdcustomscrollboxext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCUSTOMSCROLLBOXEXT)
using namespace Lmdcustomscrollboxext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcustomscrollboxextHPP
