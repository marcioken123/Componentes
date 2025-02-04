// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sTrackBar.pas' rev: 27.00 (Windows)

#ifndef StrackbarHPP
#define StrackbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Winapi.Messages.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <Vcl.Controls.hpp>	// Pascal unit
#include <Vcl.Forms.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Winapi.CommCtrl.hpp>	// Pascal unit
#include <Vcl.ExtCtrls.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sGraphUtils.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sFade.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Strackbar
{
//-- type declarations -------------------------------------------------------
typedef System::DynamicArray<System::Types::TPoint> TAPoint;

class DELPHICLASS TsTrackBar;
class PASCALIMPLEMENTATION TsTrackBar : public Vcl::Comctrls::TTrackBar
{
	typedef Vcl::Comctrls::TTrackBar inherited;
	
private:
	Sconst::TsDisabledKind FDisabledKind;
	System::Classes::TNotifyEvent FOnUserChange;
	System::Classes::TNotifyEvent FOnUserChanged;
	Scommondata::TsCommonData* FCommonData;
	Vcl::Graphics::TCanvas* FCanvas;
	Sconst::TacAnimatEvents FAnimatEvents;
	Sfade::TsFadeTimer* FadeTimer;
	bool FShowFocus;
	Sconst::TPaintEvent FOnSkinPaint;
	Vcl::Graphics::TBitmap* FThumbGlyph;
	System::Types::TPoint FBarOffset;
	bool EventFlag;
	void __fastcall SetHBarOffset(const int Value);
	void __fastcall SetVBarOffset(const int Value);
	int __fastcall GetHBarOffset(void);
	int __fastcall GetVBarOffset(void);
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetThumbGlyph(Vcl::Graphics::TBitmap* const Value);
	
protected:
	bool AppShowHint;
	virtual void __fastcall PaintWindow(HDC DC);
	__property Vcl::Graphics::TCanvas* Canvas = {read=FCanvas};
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	void __fastcall UserChanged(bool Finished);
	
public:
	int TickHeight;
	double iStep;
	Vcl::Graphics::TBitmap* Thumb;
	int TrackBarNdx;
	void __fastcall PaintBody(void);
	void __fastcall PaintBar(void);
	void __fastcall PaintTicksHor(void);
	void __fastcall PaintTicksVer(void);
	void __fastcall PaintTick(const System::Types::TPoint &P, bool Horz);
	void __fastcall PaintThumb(int i);
	System::Types::TRect __fastcall ThumbRect(void);
	System::Types::TRect __fastcall ChannelRect(void);
	int __fastcall TickPos(int i);
	int __fastcall TickCount(void);
	TAPoint __fastcall TicksArray(void);
	__fastcall virtual TsTrackBar(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsTrackBar(void);
	void __fastcall Paint(void);
	void __fastcall PrepareCache(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	int __fastcall Mode(void);
	
__published:
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property ThumbLength = {default=23};
	__property Sconst::TacAnimatEvents AnimatEvents = {read=FAnimatEvents, write=FAnimatEvents, default=16};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property Scommondata::TsCommonData* SkinData = {read=FCommonData, write=FCommonData};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=0};
	__property Vcl::Graphics::TBitmap* ThumbGlyph = {read=FThumbGlyph, write=SetThumbGlyph};
	__property Sconst::TPaintEvent OnSkinPaint = {read=FOnSkinPaint, write=FOnSkinPaint};
	__property System::Classes::TNotifyEvent OnUserChange = {read=FOnUserChange, write=FOnUserChange};
	__property System::Classes::TNotifyEvent OnUserChanged = {read=FOnUserChanged, write=FOnUserChanged};
	__property int BarOffsetV = {read=GetVBarOffset, write=SetVBarOffset, nodefault};
	__property int BarOffsetH = {read=GetHBarOffset, write=SetHBarOffset, nodefault};
	__property TickStyle = {default=1};
	__property TickMarks = {default=0};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsTrackBar(HWND ParentWindow) : Vcl::Comctrls::TTrackBar(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Strackbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_STRACKBAR)
using namespace Strackbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// StrackbarHPP
