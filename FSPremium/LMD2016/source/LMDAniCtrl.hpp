// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDAniCtrl.pas' rev: 31.00 (Windows)

#ifndef LmdanictrlHPP
#define LmdanictrlHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <LMDBase.hpp>
#include <LMDClass.hpp>
#include <LMDTimer.hpp>
#include <LMDCustomLImage.hpp>
#include <LMDBaseGraphicControl.hpp>
#include <LMDGraphicControl.hpp>
#include <Vcl.Controls.hpp>
#include <LMDBaseImage.hpp>
#include <LMDBaseControl.hpp>
#include <LMDBevel.hpp>
#include <Vcl.ImgList.hpp>
#include <LMDGraph.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdanictrl
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDAniCtrl;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDAnimationStyle : unsigned char { asLoop, asLoopHide, asLoopReverse, asRepeat, asRepeatFirst, asRepeatHide };

class PASCALIMPLEMENTATION TLMDAniCtrl : public Lmdcustomlimage::TLMDCustomLImage
{
	typedef Lmdcustomlimage::TLMDCustomLImage inherited;
	
private:
	Vcl::Graphics::TBitmap* FBack;
	bool FRestore;
	bool FMakeVisible;
	bool FForward;
	bool FUseBitmap;
	bool FReverse;
	bool FPlaying;
	Lmdclass::TLMDTimerInterval FInterval;
	TLMDAnimationStyle FAniStyle;
	int FStartFrame;
	int FStopFrame;
	System::Byte FRepeat;
	System::Byte FCounter;
	Lmdclass::TLMDTimer* FTimerId;
	Lmdclass::TLMDTimerMode FTimerMode;
	Lmdtimer::TLMDHiTimer* FTimer;
	System::Classes::TThreadPriority FThreadPriority;
	System::Classes::TNotifyEvent FOnStart;
	System::Classes::TNotifyEvent FOnAnimate;
	System::Classes::TNotifyEvent FOnStop;
	void __fastcall SetAniStyle(TLMDAnimationStyle aValue);
	HIDESBASE void __fastcall SetBool(int Index, bool aValue);
	void __fastcall SetInterval(Lmdclass::TLMDTimerInterval aValue);
	void __fastcall SetRepetitions(System::Byte aValue);
	void __fastcall SetStartFrame(int aValue);
	void __fastcall SetStopFrame(int aValue);
	void __fastcall SetThreadPriority(System::Classes::TThreadPriority aValue);
	void __fastcall SetTimerMode(Lmdclass::TLMDTimerMode aValue);
	void __fastcall GetTimer(System::TObject* Sender);
	int __fastcall GetCurrentFrame(void);
	int __fastcall GetFirstFrame(void);
	int __fastcall GetLastFrame(void);
	void __fastcall ActivateTimer(void);
	void __fastcall DeActivateTimer(Lmdclass::TLMDTimerMode aValue);
	void __fastcall EnableTimer(bool aValue);
	HIDESBASE MESSAGE void __fastcall CMTRANSPARENTCHANGED(Winapi::Messages::TMessage &Message);
	
protected:
	virtual void __fastcall BoundsChange(Lmdclass::TLMDBoundsChangeStates State);
	virtual bool __fastcall GetEmpty(void);
	virtual void __fastcall GetIMLChange(System::TObject* Sender);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	void __fastcall PaintImage(bool f);
	
public:
	__fastcall virtual TLMDAniCtrl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDAniCtrl(void);
	virtual void __fastcall Invalidate(void);
	virtual void __fastcall BackUpdate(void);
	void __fastcall Play(void);
	void __fastcall Stop(void);
	void __fastcall First(void);
	void __fastcall Last(void);
	void __fastcall Move(int aValue);
	void __fastcall Next(void);
	void __fastcall Prev(void);
	__property int Current = {read=GetCurrentFrame, nodefault};
	
__published:
	__property bool Animate = {read=FPlaying, write=SetBool, stored=false, index=0, nodefault};
	__property TLMDAnimationStyle AnimationStyle = {read=FAniStyle, write=SetAniStyle, default=0};
	__property Bevel;
	__property bool MakeVisible = {read=FMakeVisible, write=SetBool, index=1, default=1};
	__property Lmdclass::TLMDTimerInterval Interval = {read=FInterval, write=SetInterval, default=200};
	__property System::Byte Repetitions = {read=FRepeat, write=SetRepetitions, default=1};
	__property bool Reverse = {read=FReverse, write=SetBool, index=3, default=0};
	__property int StartFrame = {read=FStartFrame, write=SetStartFrame, nodefault};
	__property int StopFrame = {read=FStopFrame, write=SetStopFrame, nodefault};
	__property bool UseBitmap = {read=FUseBitmap, write=SetBool, index=2, default=1};
	__property ForceTransparent = {index=0, default=1};
	__property ImageList;
	__property ListIndex = {index=1, default=0};
	__property SilentMove = {index=1, default=0};
	__property Style = {default=0};
	__property Transparent = {default=0};
	__property Lmdclass::TLMDTimerMode TimerMode = {read=FTimerMode, write=SetTimerMode, default=0};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=SetThreadPriority, default=3};
	__property System::Classes::TNotifyEvent OnStart = {read=FOnStart, write=FOnStart};
	__property System::Classes::TNotifyEvent OnAnimate = {read=FOnAnimate, write=FOnAnimate};
	__property System::Classes::TNotifyEvent OnStop = {read=FOnStop, write=FOnStop};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdanictrl */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDANICTRL)
using namespace Lmdanictrl;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdanictrlHPP
