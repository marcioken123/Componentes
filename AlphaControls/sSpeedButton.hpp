// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sSpeedButton.pas' rev: 27.00 (Windows)

#ifndef SspeedbuttonHPP
#define SspeedbuttonHPP

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
#include <Vcl.Buttons.hpp>	// Pascal unit
#include <Vcl.ComCtrls.hpp>	// Pascal unit
#include <Vcl.Menus.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit
#include <sCommonData.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <sDefaults.hpp>	// Pascal unit
#include <sFade.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Sspeedbutton
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsSpeedButton;
class PASCALIMPLEMENTATION TsSpeedButton : public Vcl::Buttons::TSpeedButton
{
	typedef Vcl::Buttons::TSpeedButton inherited;
	
private:
	int FOldNumGlyphs;
	int FOldSpacing;
	Vcl::Imglist::TChangeLink* FImageChangeLink;
	bool FStoredDown;
	Scommondata::TsCtrlSkinData* FCommonData;
	Sconst::TsDisabledKind FDisabledKind;
	System::Classes::TNotifyEvent FOnMouseEnter;
	System::Classes::TNotifyEvent FOnMouseLeave;
	Sfade::TsAnimTimer* FadeTimer;
	Sconst::TsDisabledGlyphKind FDisabledGlyphKind;
	int FBlend;
	int FOffset;
	int FImageIndex;
	Vcl::Imglist::TCustomImageList* FImages;
	bool FShowCaption;
	System::Classes::TAlignment FAlignment;
	Vcl::Comctrls::TToolButtonStyle FButtonStyle;
	Vcl::Menus::TPopupMenu* FDropdownMenu;
	bool FDrawOverBorder;
	Sconst::TBmpPaintEvent FOnPaint;
	System::Classes::TAlignment FTextAlignment;
	Sconst::TacAnimatEvents FAnimatEvents;
	void __fastcall ImageListChange(System::TObject* Sender);
	void __fastcall SetDisabledKind(const Sconst::TsDisabledKind Value);
	void __fastcall SetDisabledGlyphKind(const Sconst::TsDisabledGlyphKind Value);
	void __fastcall SetBlend(const int Value);
	void __fastcall SetGrayed(const bool Value);
	void __fastcall SetOffset(const int Value);
	void __fastcall SetImageIndex(const int Value);
	void __fastcall SetImages(Vcl::Imglist::TCustomImageList* const Value);
	void __fastcall SetShowCaption(const bool Value);
	void __fastcall SetAlignment(const System::Classes::TAlignment Value);
	void __fastcall SetButtonStyle(const Vcl::Comctrls::TToolButtonStyle Value);
	void __fastcall SetDropdownMenu(Vcl::Menus::TPopupMenu* const Value);
	void __fastcall SetDrawOverBorder(const bool Value);
	void __fastcall SetTextAlignment(const System::Classes::TAlignment Value);
	bool FReflected;
	bool FWordWrap;
	void __fastcall SetReflected(const bool Value);
	void __fastcall SetWordWrap(const bool Value);
	
protected:
	bool FGrayed;
	bool DroppedDown;
	bool FMenuOwnerMode;
	bool FHotState;
	System::Classes::TNotifyEvent OldOnChange;
	Vcl::Buttons::TButtonLayout OldLayout;
	System::UnicodeString OldCaption;
	bool MenuVisible;
	int __fastcall ArrowWidth(void);
	virtual bool __fastcall GetGrayed(void);
	void __fastcall DoDrawText(System::Types::TRect &R, int Flags);
	void __fastcall DrawCaption(void);
	virtual void __fastcall DrawGlyph(void);
	virtual int __fastcall GlyphWidth(void);
	virtual int __fastcall GlyphHeight(void);
	int __fastcall GenMargin(void);
	virtual bool __fastcall PrepareCache(void);
	void __fastcall PaintArrow(const System::Types::PRect pR, int Mode, bool CanOffset = true);
	void __fastcall ActionChanged(System::TObject* Sender);
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	void __fastcall Ac_CMMouseEnter(void);
	void __fastcall Ac_CMMouseLeave(void);
	void __fastcall StdPaint(bool PaintButton = true);
	virtual void __fastcall Paint(void);
	HIDESBASE void __fastcall GlyphChanged(System::TObject* Sender);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	virtual int __fastcall CurrentState(void);
	System::Types::TRect __fastcall CaptionRect(bool ShiftClicked = true);
	System::Types::TRect __fastcall ImgRect(bool ShiftClicked = true);
	System::Types::TRect __fastcall ArrowRect(void);
	__fastcall virtual TsSpeedButton(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TsSpeedButton(void);
	void __fastcall GraphRepaint(void);
	virtual void __fastcall AfterConstruction(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	System::Types::TSize __fastcall TextRectSize(void);
	__property Canvas;
	
__published:
	__property Align = {default=0};
	__property OnDragDrop;
	__property OnDragOver;
	__property DragKind = {default=0};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Sconst::TBmpPaintEvent OnPaint = {read=FOnPaint, write=FOnPaint};
	__property System::Classes::TNotifyEvent OnMouseEnter = {read=FOnMouseEnter, write=FOnMouseEnter};
	__property System::Classes::TNotifyEvent OnMouseLeave = {read=FOnMouseLeave, write=FOnMouseLeave};
	__property Sconst::TacAnimatEvents AnimatEvents = {read=FAnimatEvents, write=FAnimatEvents, default=16};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property int Blend = {read=FBlend, write=SetBlend, default=0};
	__property Vcl::Comctrls::TToolButtonStyle ButtonStyle = {read=FButtonStyle, write=SetButtonStyle, default=0};
	__property Scommondata::TsCtrlSkinData* SkinData = {read=FCommonData, write=FCommonData};
	__property Sconst::TsDisabledGlyphKind DisabledGlyphKind = {read=FDisabledGlyphKind, write=SetDisabledGlyphKind, default=1};
	__property Sconst::TsDisabledKind DisabledKind = {read=FDisabledKind, write=SetDisabledKind, default=1};
	__property Vcl::Menus::TPopupMenu* DropdownMenu = {read=FDropdownMenu, write=SetDropdownMenu};
	__property bool Grayed = {read=GetGrayed, write=SetGrayed, default=0};
	__property int ImageIndex = {read=FImageIndex, write=SetImageIndex, default=-1};
	__property Vcl::Imglist::TCustomImageList* Images = {read=FImages, write=SetImages};
	__property bool Reflected = {read=FReflected, write=SetReflected, default=0};
	__property bool ShowCaption = {read=FShowCaption, write=SetShowCaption, default=1};
	__property bool DrawOverBorder = {read=FDrawOverBorder, write=SetDrawOverBorder, default=1};
	__property int TextOffset = {read=FOffset, write=SetOffset, default=0};
	__property System::Classes::TAlignment TextAlignment = {read=FTextAlignment, write=SetTextAlignment, default=2};
	__property bool WordWrap = {read=FWordWrap, write=SetWordWrap, default=1};
};


class DELPHICLASS TsTimerSpeedButton;
class PASCALIMPLEMENTATION TsTimerSpeedButton : public TsSpeedButton
{
	typedef TsSpeedButton inherited;
	
private:
	bool FAllowTimer;
	
public:
	__fastcall virtual TsTimerSpeedButton(System::Classes::TComponent* AOwner);
	
__published:
	__property bool AllowTimer = {read=FAllowTimer, write=FAllowTimer, default=1};
public:
	/* TsSpeedButton.Destroy */ inline __fastcall virtual ~TsTimerSpeedButton(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Sspeedbutton */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SSPEEDBUTTON)
using namespace Sspeedbutton;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// SspeedbuttonHPP
