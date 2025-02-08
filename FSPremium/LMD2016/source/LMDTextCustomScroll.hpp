// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextCustomScroll.pas' rev: 31.00 (Windows)

#ifndef LmdtextcustomscrollHPP
#define LmdtextcustomscrollHPP

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
#include <LMDTimer.hpp>
#include <LMDClass.hpp>
#include <LMDGraph.hpp>
#include <LMDTextPanel.hpp>
#include <LMDTextObject.hpp>
#include <LMDTextCustomPanel.hpp>
#include <LMDCustomPanelFill.hpp>
#include <LMDCustomParentPanel.hpp>
#include <LMDCustomBevelPanel.hpp>
#include <LMDCustomPanel.hpp>
#include <LMDCustomControl.hpp>
#include <LMDControl.hpp>
#include <Vcl.Controls.hpp>
#include <System.Types.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextcustomscroll
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextCustomScroll;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDTextScrollMode : unsigned char { tmTopDown, tmBottomUp, tmLeftRight, tmRightLeft };

enum DECLSPEC_DENUM TLMDTextScrollStyle : unsigned char { tsOnce, tsLoop, tsLoopReverse };

enum DECLSPEC_DENUM TLMDTextScrollStartPos : unsigned char { spHidden, spCentered, spFull };

class PASCALIMPLEMENTATION TLMDTextCustomScroll : public Lmdtextpanel::TLMDTextPanel
{
	typedef Lmdtextpanel::TLMDTextPanel inherited;
	
private:
	System::Word FTimerID;
	bool FRestart;
	bool FScroll;
	int FScrollStep;
	int FScrollDelay;
	TLMDTextScrollStyle FScrollStyle;
	TLMDTextScrollMode FScrollingMode;
	TLMDTextScrollMode FScrollMode;
	System::Types::TPoint FScrolled;
	Vcl::Graphics::TBitmap* FHelpBmp;
	System::Types::TRect FTextRect;
	System::Types::TRect FTDimens;
	Lmdclass::TLMDTimerMode FTimerMode;
	Lmdtimer::TLMDHiTimer* FTimer;
	System::Classes::TThreadPriority FThreadPriority;
	TLMDTextScrollStartPos FTStartPos;
	void __fastcall SetThreadPriority(System::Classes::TThreadPriority aValue);
	void __fastcall SetTimerMode(Lmdclass::TLMDTimerMode aValue);
	void __fastcall SetScrollMode(TLMDTextScrollMode aValue);
	void __fastcall SetScroll(bool aValue);
	
protected:
	void __fastcall Scroll(void);
	void __fastcall EndScroll(void);
	void __fastcall DoStep(System::TObject* Sender);
	virtual void __fastcall DrawCaption(const System::Types::TRect &aRect, Lmdgraph::TLMDAlignment aAlignment);
	void __fastcall DrawState(const System::Types::TRect &aRect);
	
public:
	__fastcall virtual TLMDTextCustomScroll(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextCustomScroll(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Paint(void);
	void __fastcall Start(void);
	void __fastcall Execute(void);
	void __fastcall Stop(void);
	void __fastcall SetStartPos(TLMDTextScrollStartPos aValue);
	
__published:
	__property bool Active = {read=FScroll, write=SetScroll, default=0};
	__property TLMDTextScrollMode Mode = {read=FScrollMode, write=SetScrollMode, default=1};
	__property TLMDTextScrollStyle Style = {read=FScrollStyle, write=FScrollStyle, default=1};
	__property int Interval = {read=FScrollDelay, write=FScrollDelay, default=100};
	__property int Step = {read=FScrollStep, write=FScrollStep, default=1};
	__property Lmdclass::TLMDTimerMode TimerMode = {read=FTimerMode, write=SetTimerMode, default=1};
	__property System::Classes::TThreadPriority ThreadPriority = {read=FThreadPriority, write=SetThreadPriority, default=3};
public:
	/* TWinControl.CreateParented */ inline __fastcall TLMDTextCustomScroll(HWND ParentWindow) : Lmdtextpanel::TLMDTextPanel(ParentWindow) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextcustomscroll */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTCUSTOMSCROLL)
using namespace Lmdtextcustomscroll;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextcustomscrollHPP
