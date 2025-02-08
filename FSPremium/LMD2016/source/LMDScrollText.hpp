// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDScrollText.pas' rev: 31.00 (Windows)

#ifndef LmdscrolltextHPP
#define LmdscrolltextHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDGraph.hpp>
#include <LMDClass.hpp>
#include <LMDBase.hpp>
#include <LMDTimer.hpp>
#include <LMD3DCaption.hpp>
#include <LMDGraphicControl.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDBaseControl.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDBitmapEffectObject.hpp>
#include <LMDBevel.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Menus.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdscrolltext
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDScrollText;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDScrollDirection : unsigned char { sdBottomToTop, sdLeftToRight, sdRightToLeft, sdTopToBottom };

enum DECLSPEC_DENUM TLMDScrollStyle : unsigned char { ssLoop, ssLoopReverse, ssOnce };

enum DECLSPEC_DENUM TLMDScrollMode : unsigned char { smMarquee, smTicker };

class PASCALIMPLEMENTATION TLMDScrollText : public Lmdgraphiccontrol::TLMDGraphicControl
{
	typedef Lmdgraphiccontrol::TLMDGraphicControl inherited;
	
private:
	System::Classes::TAlignment FAlignment;
	Vcl::Graphics::TBitmap* FBack;
	TLMDScrollDirection FDirection;
	Lmd3dcaption::TLMD3DCaption* FFont3D;
	Lmdclass::TLMDTimerInterval FInterval;
	System::Classes::TStringList* FLines;
	bool FMakeVisible;
	bool FRestore;
	bool FScroll;
	TLMDScrollStyle FStyle;
	TLMDScrollMode FMode;
	Lmdclass::TLMDTimer* FTimerID;
	bool FTransparent;
	int FSteps;
	int bmw;
	int bmh;
	int th;
	int tw;
	int lh;
	int FCurrent;
	System::Types::TPoint pos;
	System::Classes::TNotifyEvent FOnScrollStart;
	System::Classes::TNotifyEvent FOnScroll;
	System::Classes::TNotifyEvent FOnScrollEnd;
	Lmdclass::TLMDTimerMode FTimerMode;
	Lmdtimer::TLMDHiTimer* FTimer;
	System::Classes::TThreadPriority FThreadPriority;
	void __fastcall SetThreadPriority(System::Classes::TThreadPriority aValue);
	void __fastcall SetTimerMode(Lmdclass::TLMDTimerMode aValue);
	void __fastcall SetAlignment(System::Classes::TAlignment aValue);
	void __fastcall SetBool(int index, bool aValue);
	void __fastcall SetDirection(TLMDScrollDirection aValue);
	void __fastcall SetFont3D(Lmd3dcaption::TLMD3DCaption* aValue);
	void __fastcall SetInterval(Lmdclass::TLMDTimerInterval aValue);
	void __fastcall SetLines(System::Classes::TStringList* aValue);
	void __fastcall SetSteps(int aValue);
	void __fastcall SetStyle(TLMDScrollStyle aValue);
	void __fastcall SetMode(TLMDScrollMode aValue);
	void __fastcall GetTimer(System::TObject* Sender);
	void __fastcall ActivateTimer(void);
	void __fastcall DeActivateTimer(Lmdclass::TLMDTimerMode aValue);
	void __fastcall EnableTimer(bool aValue);
	HIDESBASE MESSAGE void __fastcall CMFontChanged(Winapi::Messages::TMessage &Message);
	
protected:
	System::UnicodeString __fastcall GetAsTickerText(void);
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	void __fastcall CalculateDimensions(void);
	virtual void __fastcall GetChange(System::TObject* Sender);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	void __fastcall PaintImage(void);
	
public:
	__fastcall virtual TLMDScrollText(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDScrollText(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall BackUpdate(void);
	void __fastcall Execute(void);
	void __fastcall ExecuteEnh(int StartStep);
	void __fastcall Reverse(void);
	void __fastcall Stop(void);
	__property int Step = {read=FCurrent, nodefault};
	
__published:
	__property About = {default=0};
	__property System::Classes::TAlignment Alignment = {read=FAlignment, write=SetAlignment, default=2};
	__property BackFX;
	__property TLMDScrollDirection Direction = {read=FDirection, write=SetDirection, default=0};
	__property Lmd3dcaption::TLMD3DCaption* Font3D = {read=FFont3D, write=SetFont3D};
	__property Lmdclass::TLMDTimerInterval Interval = {read=FInterval, write=SetInterval, default=100};
	__property System::Classes::TStringList* Lines = {read=FLines, write=SetLines};
	__property bool MakeVisible = {read=FMakeVisible, write=SetBool, index=0, default=1};
	__property bool Scroll = {read=FScroll, write=SetBool, stored=false, index=1, nodefault};
	__property TLMDScrollStyle ScrollStyle = {read=FStyle, write=SetStyle, default=0};
	__property TLMDScrollMode ScrollMode = {read=FMode, write=SetMode, default=0};
	__property int Steps = {read=FSteps, write=SetSteps, default=100};
	__property bool Transparent = {read=FTransparent, write=SetBool, index=2, default=0};
	__property System::Classes::TNotifyEvent OnStart = {read=FOnScrollStart, write=FOnScrollStart};
	__property System::Classes::TNotifyEvent OnScroll = {read=FOnScroll, write=FOnScroll};
	__property System::Classes::TNotifyEvent OnStop = {read=FOnScrollEnd, write=FOnScrollEnd};
	__property Lmdclass::TLMDTimerMode TimerMode = {read=FTimerMode, write=SetTimerMode, default=0};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=SetThreadPriority, default=3};
	__property Align = {default=0};
	__property Bevel;
	__property Color = {default=-16777211};
	__property DragCursor = {default=-12};
	__property DragMode = {default=0};
	__property Font;
	__property ParentColor = {default=1};
	__property ParentShowHint = {default=1};
	__property PopupMenu;
	__property ShowHint;
	__property Visible = {default=1};
	__property OnClick;
	__property OnDblClick;
	__property OnDragDrop;
	__property OnDragOver;
	__property OnEndDrag;
	__property OnMouseDown;
	__property OnMouseMove;
	__property OnMouseUp;
	__property OnStartDrag;
	__property Anchors = {default=3};
	__property BiDiMode;
	__property DragKind = {default=0};
	__property Constraints;
	__property ParentBiDiMode = {default=1};
	__property OnEndDock;
	__property OnStartDock;
	__property OnContextPopup;
	__property OnMouseActivate;
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdscrolltext */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSCROLLTEXT)
using namespace Lmdscrolltext;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdscrolltextHPP
