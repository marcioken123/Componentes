// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sBitBtn.pas' rev: 27.00 (Windows)

#ifndef SbitbtnHPP
#define SbitbtnHPP

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
#include <Vcl.ImgList.hpp>	// Pascal unit
#include <Vcl.StdCtrls.hpp>	// Pascal unit
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <sFade.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sbitbtn
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsBitBtn;
class PASCALIMPLEMENTATION TsBitBtn : public Vcl::Buttons::TBitBtn
{
	typedef Vcl::Buttons::TBitBtn inherited;
	
private:
	int FOldSpacing;
	Scommondata::TsCtrlSkinData* FCommonData;
	bool FMouseClicked;
	bool FDown;
	bool RegionChanged;
	int FFocusMargin;
	Sconst::TsDisabledKind FDisabledKind;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	Sfade::TsFadeTimer* FadeTimer;
	Sconst::TsDisabledGlyphKind FDisabledGlyphKind;
	bool FGrayed;
	int FBlend;
	int FOffset;
	int FImageIndex;
	Vcl::Imglist::TCustomImageList* FImages;
	bool FShowCaption;
	bool FShowFocus;
	System::Classes::TAlignment FAlignment;
	bool FDrawOverBorder;
	Sconst::TBmpPaintEvent FOnPaint;
	System::Classes::TAlignment FTextAlignment;
	Sconst::TacAnimatEvents FAnimatEvents;
	System::Types::TRect LastRect;
	bool FReflected;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	bool __fastcall GetGrayed(void);
	void __fastcall SetDown(const bool Value);
	void __fastcall SetFocusMargin(const int Value);
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	HIDESBASE MESSAGE void __fastcall WMKeyUp(Winapi::Messages::TWMKey &Message);
	HIDESBASE MESSAGE void __fastcall CNDrawItem(Winapi::Messages::TWMDrawItem &Message);
	void __fastcall SetDisabledGlyphKind(const Sconst::TsDisabledGlyphKind Value);
	void __fastcall SetBlend(const int Value);
	void __fastcall SetGrayed(const bool Value);
	void __fastcall SetOffset(const int Value);
	HIDESBASE void __fastcall SetImageIndex(const int Value);
	HIDESBASE void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetShowFocus(const bool Value);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	bool __fastcall GetDown(void);
	void __fastcall SetDrawOverBorder(const bool Value);
	void __fastcall SetReflected(const bool Value);
	void __fastcall SetTextAlignment(const System::Classes::TAlignment Value);
	HIDESBASE void __fastcall ImageListChange(System::TObject* Sender);
	
protected:
	bool IsFocused;
	HRGN FRegion;
	System::Types::TPoint GlyphPos;
	Vcl::Buttons::TButtonLayout OldLayout;
	System::Types::TRect CaptionRect;
	void __fastcall StdDrawItem(const tagDRAWITEMSTRUCT &DrawItemStruct);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	void __fastcall OurPaintHandler(HDC aDC);
	void __fastcall DoDrawText(System::Types::TRect &Rect, unsigned Flags);
	void __fastcall DrawCaption(Vcl::Graphics::TCanvas* Canvas = (Vcl::Graphics::TCanvas*)(0x0));
	System::Types::TSize __fastcall TextRectSize(void);
	int __fastcall GlyphWidth(void);
	int __fastcall GlyphHeight(void);
	bool __fastcall PrepareCache(void);
	
public:
	__fastcall virtual TsBitBtn(System::Classes::TComponent* AOwner);
	int __fastcall CurrentState(void);
	__fastcall virtual ~TsBitBtn(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Loaded(void);
	System::Types::TRect __fastcall ImgRect(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	virtual void __fastcall SetButtonStyle(bool ADefault);
	
__published:
	__property Sconst::TBmpPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property Sconst::TacAnimatEvents AnimatEvents = {read=FAnimatEvents, write=FAnimatEvents, default=16};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property int Blend = {read=FBlend, write=SetBlend, default=0};
	__property Scommondata::TsCtrlSkinData* SkinData = {read=FCommonData, write=FCommonData};
	__property Sconst::TsDisabledGlyphKind DisabledGlyphKind = {read=FDisabledGlyphKind, write=SetDisabledGlyphKind, default=1};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property bool Down = {read=GetDown, write=SetDown, default=0};
	__property int FocusMargin = {read=FFocusMargin, write=SetFocusMargin, default=1};
	__property bool Grayed = {read=GetGrayed, write=SetGrayed, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property bool Reflected = {read=FReflected, write=SetReflected, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property bool ShowFocus = {read=FShowFocus, write=SetShowFocus, default=1};
	__property bool DrawOverBorder = {read=FDrawOverBorder, write=SetDrawOverBorder, default=1};
	__property int TextOffset = {read=FOffset, write=SetOffset, default=0};
	__property System::Classes::TAlignment TextAlignment = {read=FTextAlignment, write=SetTextAlignment, default=2};
	__property WordWrap = {default=1};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
public:
	/* TWinControl.CreateParented */ inline __fastcall TsBitBtn(HWND ParentWindow) : Vcl::Buttons::TBitBtn(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sbitbtn */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SBITBTN)
using namespace Sbitbtn;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SbitbtnHPP
