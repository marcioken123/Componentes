﻿// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElTrackBar.pas' rev: 31.00 (Windows)

#ifndef EltrackbarHPP
#define EltrackbarHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Math.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <System.Types.hpp>
#include <System.Classes.hpp>
#include <Vcl.Themes.hpp>
#include <Winapi.CommCtrl.hpp>
#include <ElXPThemedControl.hpp>
#include <ElVCLUtils.hpp>
#include <ElImgFrm.hpp>
#include <ElHintWnd.hpp>
#include <LMDClass.hpp>
#include <LMDThemes.hpp>
#include <LMDUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDHTMLUnit.hpp>
#include <LMDSysIn.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Eltrackbar
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElTrackBar;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TElTrackBarOrientation : unsigned char { toHorizontal, toVertical };

enum DECLSPEC_DENUM TElTrackTickPosition : unsigned char { tpNone, tpAbove, tpBelow, tpBoth };

enum DECLSPEC_DENUM TElTrackBarPart : unsigned char { tbpNowhere, tbSelMarkStart, tbSelMarkEnd, tbpTicksAbove, tbpTicksBelow, tbpTrack, tbpThumb };

enum DECLSPEC_DENUM TElTrackThumbType : unsigned char { tstPointerTop, tstPointerBottom, tstBox };

enum DECLSPEC_DENUM TTickMarkMode : unsigned char { tmmAuto, tmmManual };

typedef void __fastcall (__closure *TElTrackHitTestEvent)(System::TObject* Sender, int X, int Y, TElTrackBarPart &Part, bool &DefaultTest);

typedef void __fastcall (__closure *TElTrackDrawPartEvent)(System::TObject* Sender, Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, TElTrackBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);

typedef void __fastcall (__closure *TElTrackChangeEvent)(System::TObject* Sender, int NewPos);

typedef void __fastcall (__closure *TElTrackChangingEvent)(System::TObject* Sender, int &NewPos, bool &AllowChange);

typedef void __fastcall (__closure *TElTrackHintNeededEvent)(System::TObject* Sender, int TrackPosition, Lmdtypes::TLMDString &Hint);

typedef void __fastcall (__closure *TElTickMarkPositionEvent)(System::TObject* Sender, int PrevPos, int &TickPos);

class PASCALIMPLEMENTATION TElTrackBar : public Elxpthemedcontrol::TElXPThemedControl
{
	typedef Elxpthemedcontrol::TElXPThemedControl inherited;
	
protected:
	TElTrackBarPart FMouseOverPart;
	Elvclutils::TElFlatBorderType FActiveBorderType;
	Elvclutils::TElFlatBorderType FInactiveBorderType;
	bool FTransparent;
	TElTrackBarOrientation FOrientation;
	int FMax;
	int FMin;
	int FPage;
	bool FShowTrackHint;
	int FThumbPos;
	bool FMouseDown;
	Elimgfrm::TImgFormChangeLink* FImgFormChLink;
	Elimgfrm::TElImageForm* FImgForm;
	TElTrackTickPosition FTickPosition;
	int FOffsetLeft;
	int FOffsetRight;
	TElTrackDrawPartEvent FOnDrawPart;
	bool FOwnerDraw;
	TElTrackChangeEvent FOnChange;
	TElTrackChangingEvent FOnChanging;
	TElTrackHintNeededEvent FOnTrackHintNeeded;
	TElTrackThumbType FThumbType;
	int FTickWidth;
	int FSelStart;
	int FSelEnd;
	TElTickMarkPositionEvent FOnTickMark;
	int FFrequency;
	TTickMarkMode FTickMarkMode;
	System::Uitypes::TColor FTickColor;
	System::Uitypes::TColor FTrackColor;
	System::Uitypes::TColor FTrackFrameColor;
	int FTrackWidth;
	System::Uitypes::TColor FTrackSelColor;
	bool FShowSelection;
	int FSelectionMarkSize;
	Elhintwnd::TElHintWindow* FHintWnd;
	int FThumbWidth;
	bool FThumbVisible;
	bool FDown;
	bool FDragging;
	System::Types::TPoint FDragPos;
	int FSavePosition;
	System::Types::TRect FSaveThumb;
	HWND FSaveCapture;
	int FPosition;
	TElTrackHitTestEvent FOnHitTest;
	Vcl::Extctrls::TTimer* FDownTimer;
	System::Uitypes::TColor FThumbColor;
	TElTrackChangeEvent FOnTrack;
	bool FFlat;
	System::Uitypes::TColor FLineBorderActiveColor;
	System::Uitypes::TColor FLineBorderInactiveColor;
	Elvclutils::TElFlatBorderType FThumbActiveBorderType;
	Elvclutils::TElFlatBorderType FThumbInactiveBorderType;
	Lmdtypes::TLMDString FHint;
	System::Uitypes::TColor FBorderColorDkShadow;
	System::Uitypes::TColor FBorderColorFace;
	System::Uitypes::TColor FBorderColorHighlight;
	System::Uitypes::TColor FBorderColorShadow;
	System::Uitypes::TColor FBorderColorWindow;
	void __fastcall SetActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	MESSAGE void __fastcall WMGetDlgCode(Winapi::Messages::TWMNoParams &Msg);
	int __fastcall GetPosition(void);
	void __fastcall SetOrientation(TElTrackBarOrientation newValue);
	void __fastcall SetMax(int newValue);
	void __fastcall SetMin(int newValue);
	void __fastcall SetPage(int newValue);
	void __fastcall SetPosition(int newValue);
	void __fastcall DoSetMax(int newValue, bool Redraw);
	void __fastcall DoSetMin(int newValue, bool Redraw);
	void __fastcall DoSetPage(int newValue, bool Redraw);
	void __fastcall DoSetPosition(int newValue, bool Redraw);
	int __fastcall AdjustThumbPos(void);
	virtual void __fastcall SetImageForm(Elimgfrm::TElImageForm* newValue);
	void __fastcall ImageFormChange(System::TObject* Sender);
	DYNAMIC void __fastcall KeyDown(System::Word &Key, System::Classes::TShiftState Shift);
	void __fastcall SetTickPosition(TElTrackTickPosition Value);
	void __fastcall SetOffsetLeft(int Value);
	void __fastcall SetOffsetRight(int Value);
	virtual void __fastcall TriggerDrawPartEvent(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &R, TElTrackBarPart Part, bool Enabled, bool Focused, bool Pressed, bool &DefaultDraw);
	void __fastcall SetOwnerDraw(bool Value);
	virtual void __fastcall TriggerChangeEvent(int NewPos);
	virtual void __fastcall TriggerChangingEvent(int &NewPos, bool &AllowChange);
	virtual int __fastcall GetAutoThumbSize(void);
	virtual void __fastcall CreateParams(Vcl::Controls::TCreateParams &Params);
	virtual void __fastcall SetTransparent(bool newValue);
	void __fastcall SetThumbType(TElTrackThumbType Value);
	HIDESBASE MESSAGE void __fastcall WMEraseBkgnd(Winapi::Messages::TWMEraseBkgnd &Msg);
	void __fastcall SetTickWidth(int Value);
	void __fastcall SetSelStart(int Value);
	void __fastcall SetSelEnd(int Value);
	virtual void __fastcall TriggerTickMarkPositionEvent(int PrevPos, int &TickPos);
	void __fastcall SetFrequency(int Value);
	void __fastcall SetTickMarkMode(TTickMarkMode Value);
	void __fastcall SetTickColor(System::Uitypes::TColor Value);
	void __fastcall SetTrackColor(System::Uitypes::TColor Value);
	void __fastcall SetTrackFrameColor(System::Uitypes::TColor Value);
	void __fastcall SetTrackWidth(int Value);
	void __fastcall SetTrackSelColor(System::Uitypes::TColor Value);
	void __fastcall SetShowSelection(bool Value);
	void __fastcall SetSelectionMarkSize(int Value);
	System::Types::TRect __fastcall CalcThumbRect(void);
	void __fastcall ShowHintAt(int APosition, int X, int Y);
	void __fastcall SetThumbWidth(int Value);
	void __fastcall SetThumbVisible(bool Value);
	void __fastcall DrawThumb(Vcl::Graphics::TCanvas* Canvas, const System::Types::TRect &Rect);
	DYNAMIC void __fastcall MouseDown(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseMove(System::Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall TriggerHitTestEvent(int X, int Y, TElTrackBarPart &Part, bool &DefaultTest);
	virtual void __fastcall TriggerTrackHintNeededEvent(int TrackPosition, Lmdtypes::TLMDString &Hint);
	void __fastcall OnDownTimer(System::TObject* Sender);
	DYNAMIC void __fastcall MouseUp(System::Uitypes::TMouseButton Button, System::Classes::TShiftState Shift, int X, int Y);
	HIDESBASE MESSAGE void __fastcall WMKillFocus(Winapi::Messages::TWMSetFocus &Message);
	MESSAGE void __fastcall IFMRepaintChildren(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall WMWindowPosChanged(Winapi::Messages::TWMWindowPosMsg &Message);
	void __fastcall SetThumbColor(System::Uitypes::TColor Value);
	virtual void __fastcall TriggerTrackEvent(int NewPos);
	HIDESBASE MESSAGE void __fastcall WMMouseWheel(Winapi::Messages::TWMMouseWheel &Msg);
	HIDESBASE MESSAGE void __fastcall CMEnter(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMExit(Winapi::Messages::TWMNoParams &Msg);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Winapi::Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMEnabledChanged(Winapi::Messages::TMessage &Message);
	void __fastcall SetFlat(bool Value);
	void __fastcall SetHint(Lmdtypes::TLMDString Value);
	HIDESBASE MESSAGE void __fastcall CMHintShow(Vcl::Controls::TCMHintShow &Message);
	virtual void __fastcall SetLineBorderActiveColor(System::Uitypes::TColor Value);
	virtual void __fastcall SetLineBorderInactiveColor(System::Uitypes::TColor Value);
	void __fastcall SetThumbActiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetThumbInactiveBorderType(const Elvclutils::TElFlatBorderType Value);
	void __fastcall SetBorderColorDkShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorFace(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorHighlight(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorShadow(System::Uitypes::TColor Value);
	void __fastcall SetBorderColorWindow(System::Uitypes::TColor Value);
	virtual void __fastcall WndProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TElTrackBar(System::Classes::TComponent* AOwner);
	virtual void __fastcall Paint(void);
	__fastcall virtual ~TElTrackBar(void);
	TElTrackBarPart __fastcall GetHitTest(int X, int Y);
	__property bool Tracking = {read=FDragging, nodefault};
	
__published:
	__property TElTrackBarOrientation Orientation = {read=FOrientation, write=SetOrientation, default=0};
	__property Elimgfrm::TElImageForm* ImageForm = {read=FImgForm, write=SetImageForm};
	__property int Max = {read=FMax, write=SetMax, default=20};
	__property int Min = {read=FMin, write=SetMin, default=0};
	__property int Page = {read=FPage, write=SetPage, default=5};
	__property int Position = {read=GetPosition, write=SetPosition, default=0};
	__property bool ShowTrackHint = {read=FShowTrackHint, write=FShowTrackHint, default=0};
	__property TElTrackTickPosition TickPosition = {read=FTickPosition, write=SetTickPosition, default=1};
	__property int OffsetLeft = {read=FOffsetLeft, write=SetOffsetLeft, default=5};
	__property int OffsetRight = {read=FOffsetRight, write=SetOffsetRight, default=5};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=0};
	__property bool OwnerDraw = {read=FOwnerDraw, write=SetOwnerDraw, default=0};
	__property TElTrackThumbType ThumbType = {read=FThumbType, write=SetThumbType, default=0};
	__property int TickWidth = {read=FTickWidth, write=SetTickWidth, default=3};
	__property int SelStart = {read=FSelStart, write=SetSelStart, default=0};
	__property int SelEnd = {read=FSelEnd, write=SetSelEnd, default=0};
	__property int Frequency = {read=FFrequency, write=SetFrequency, default=2};
	__property TTickMarkMode TickMarkMode = {read=FTickMarkMode, write=SetTickMarkMode, default=0};
	__property System::Uitypes::TColor TickColor = {read=FTickColor, write=SetTickColor, default=-16777198};
	__property System::Uitypes::TColor TrackColor = {read=FTrackColor, write=SetTrackColor, default=-16777211};
	__property System::Uitypes::TColor TrackFrameColor = {read=FTrackFrameColor, write=SetTrackFrameColor, default=-16777200};
	__property int TrackWidth = {read=FTrackWidth, write=SetTrackWidth, default=10};
	__property System::Uitypes::TColor TrackSelColor = {read=FTrackSelColor, write=SetTrackSelColor, default=-16777203};
	__property bool ShowSelection = {read=FShowSelection, write=SetShowSelection, default=0};
	__property int SelectionMarkSize = {read=FSelectionMarkSize, write=SetSelectionMarkSize, default=3};
	__property int ThumbWidth = {read=FThumbWidth, write=SetThumbWidth, default=9};
	__property bool ThumbVisible = {read=FThumbVisible, write=SetThumbVisible, default=1};
	__property bool Flat = {read=FFlat, write=SetFlat, default=0};
	__property Elvclutils::TElFlatBorderType ActiveBorderType = {read=FActiveBorderType, write=SetActiveBorderType, default=1};
	__property Elvclutils::TElFlatBorderType InactiveBorderType = {read=FInactiveBorderType, write=SetInactiveBorderType, default=3};
	__property System::Uitypes::TColor LineBorderActiveColor = {read=FLineBorderActiveColor, write=SetLineBorderActiveColor, default=0};
	__property System::Uitypes::TColor LineBorderInactiveColor = {read=FLineBorderInactiveColor, write=SetLineBorderInactiveColor, default=0};
	__property TElTrackDrawPartEvent OnDrawPart = {read=FOnDrawPart, write=FOnDrawPart};
	__property TElTrackChangeEvent OnChange = {read=FOnChange, write=FOnChange};
	__property TElTrackChangingEvent OnChanging = {read=FOnChanging, write=FOnChanging};
	__property TElTickMarkPositionEvent OnTickMark = {read=FOnTickMark, write=FOnTickMark};
	__property TElTrackHitTestEvent OnHitTest = {read=FOnHitTest, write=FOnHitTest};
	__property TElTrackHintNeededEvent OnTrackHintNeeded = {read=FOnTrackHintNeeded, write=FOnTrackHintNeeded};
	__property System::Uitypes::TColor ThumbColor = {read=FThumbColor, write=SetThumbColor, default=-16777201};
	__property TElTrackChangeEvent OnTrack = {read=FOnTrack, write=FOnTrack};
	__property Elvclutils::TElFlatBorderType ThumbActiveBorderType = {read=FThumbActiveBorderType, write=SetThumbActiveBorderType, default=5};
	__property Elvclutils::TElFlatBorderType ThumbInactiveBorderType = {read=FThumbInactiveBorderType, write=SetThumbInactiveBorderType, default=5};
	__property Lmdtypes::TLMDString Hint = {read=FHint, write=SetHint};
	__property Anchors = {default=3};
	__property Constraints;
	__property DragKind = {default=0};
	__property Align = {default=0};
	__property Color = {default=-16777211};
	__property Ctl3D;
	__property Enabled = {default=1};
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property ParentThemeMode = {default=1};
	__property ShowHint;
	__property TabOrder = {default=-1};
	__property TabStop = {default=0};
	__property Visible = {default=1};
	__property ThemeMode = {default=1};
	__property ThemeGlobalMode = {default=0};
	__property OnStartDock;
	__property OnEndDock;
	__property OnContextPopup;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnEnter;
	__property OnExit;
	__property OnMouseDown;
	__property OnMouseUp;
	__property OnMouseMove;
	__property OnKeyDown;
	__property OnKeyPress;
	__property OnKeyUp;
	__property OnStartDrag;
	__property System::Uitypes::TColor BorderColorDkShadow = {read=FBorderColorDkShadow, write=SetBorderColorDkShadow, default=-16777195};
	__property System::Uitypes::TColor BorderColorFace = {read=FBorderColorFace, write=SetBorderColorFace, default=-16777201};
	__property System::Uitypes::TColor BorderColorHighlight = {read=FBorderColorHighlight, write=SetBorderColorHighlight, default=-16777196};
	__property System::Uitypes::TColor BorderColorShadow = {read=FBorderColorShadow, write=SetBorderColorShadow, default=-16777200};
	__property System::Uitypes::TColor BorderColorWindow = {read=FBorderColorWindow, write=SetBorderColorWindow, default=-16777211};
public:
	/* TWinControl.CreateParented */ inline __fastcall TElTrackBar(HWND ParentWindow) : Elxpthemedcontrol::TElXPThemedControl(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Eltrackbar */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELTRACKBAR)
using namespace Eltrackbar;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// EltrackbarHPP
