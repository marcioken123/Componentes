// Borland C++ Builder
// Copyright (c) 1995, 1999 by Borland International
// All rights reserved

// (DO NOT EDIT: machine generated header) 'CoolSplitter.pas' rev: 5.00

#ifndef CoolSplitterHPP
#define CoolSplitterHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <CoolCtrls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Coolsplitter
{
//-- type declarations -------------------------------------------------------
typedef int NaturalNumber;

typedef int PositionAfterOpen;

class DELPHICLASS TWinControlAccess;
class PASCALIMPLEMENTATION TWinControlAccess : public Controls::TWinControl 
{
	typedef Controls::TWinControl inherited;
	
public:
	#pragma option push -w-inl
	/* TWinControl.Create */ inline __fastcall virtual TWinControlAccess(Classes::TComponent* AOwner) : 
		Controls::TWinControl(AOwner) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.CreateParented */ inline __fastcall TWinControlAccess(HWND ParentWindow) : Controls::TWinControl(
		ParentWindow) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TWinControl.Destroy */ inline __fastcall virtual ~TWinControlAccess(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum TSplitterResizeStyle { rsUpdate, rsPattern };
#pragma option pop

#pragma option push -b-
enum TSplitterAlign { salBottom, salLeft, salRight, salTop };
#pragma option pop

#pragma option push -b-
enum TSplitterMouseState { sstNormal, sstResizing, sstSpotClick };
#pragma option pop

#pragma option push -b-
enum TSplitterState { ssOpen, ssClosed };
#pragma option pop

#pragma option push -b-
enum TCursorPosition { cpUnknown, cpInsideSpotRect, cpOutSideSpotRect };
#pragma option pop

typedef void __fastcall (__closure *TCanResizeEvent)(System::TObject* Sender, int &NewSize, bool &Accept
	);

typedef void __fastcall (__closure *TBeforeOpenSpotEvent)(System::TObject* Sender, bool &AllowOpen);
	

typedef void __fastcall (__closure *TBeforeCloseSpotEvent)(System::TObject* Sender, bool &AllowClose
	);

class DELPHICLASS TCoolSpotSplitter;
class PASCALIMPLEMENTATION TCoolSpotSplitter : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Coolctrls::TCCAboutBox* FAboutBox;
	TSplitterAlign FAlignSplitter;
	bool FAutoPosition;
	PositionAfterOpen FPositionAfterOpen;
	NaturalNumber FSpotSizePercent;
	bool FSpotVisible;
	Graphics::TColor FSpotHighlightColor;
	bool FAutoSnap;
	NaturalNumber FMinSize;
	TSplitterResizeStyle FResizeStyle;
	TCanResizeEvent FOnCanResize;
	Classes::TNotifyEvent FOnMoved;
	TBeforeOpenSpotEvent FOnBeforeOpen;
	Classes::TNotifyEvent FOnAfterOpen;
	TBeforeCloseSpotEvent FOnBeforeClose;
	Classes::TNotifyEvent FOnAfterClose;
	Controls::TWinControl* FActiveControl;
	TSplitterState FState;
	bool FPressed;
	Windows::TRect FSpotRect;
	int FPositionBeforeClose;
	TSplitterMouseState FSplitterState;
	TCursorPosition FCursorPosition;
	Graphics::TBrush* FBrush;
	Controls::TControl* FControl;
	Windows::TPoint FDownPos;
	HDC FLineDC;
	bool FLineVisible;
	Word FMaxSize;
	int FNewSize;
	int FOldSize;
	Controls::TKeyEvent FOldKeyDown;
	HBRUSH FPrevBrush;
	int FSplit;
	void __fastcall UpdateSpotRect(void);
	void __fastcall AllocateLineDC(void);
	void __fastcall CalcSplitSize(int X, int Y, int &NewSize, int &Split);
	void __fastcall DrawLine(void);
	Windows::TRect __fastcall DrawBounds(Graphics::TCanvas* Canvas, const Windows::TRect &Bounds, const 
		Graphics::TColor AUpperLeftColor, const Graphics::TColor ALowerRightColor);
	void __fastcall DrawSpot(const bool AHighlight, const bool APressed);
	Controls::TControl* __fastcall FindControl(void);
	void __fastcall FocusKeyDown(System::TObject* Sender, Word &Key, Classes::TShiftState Shift);
	void __fastcall ReleaseLineDC(void);
	void __fastcall UpdateControlSize(void);
	void __fastcall UpdateSize(int X, int Y);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	HIDESBASE void __fastcall SetAlign(TSplitterAlign Value);
	void __fastcall SetState(TSplitterState Value);
	void __fastcall SetSpotSizePercent(NaturalNumber Value);
	void __fastcall SetSpotVisible(bool Value);
	void __fastcall RecalcLastPosition(void);
	
protected:
	HIDESBASE virtual bool __fastcall CanResize(int &NewSize);
	HIDESBASE virtual bool __fastcall DoCanResize(int &NewSize);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, 
		int Y);
	DYNAMIC void __fastcall MouseMove(Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int 
		Y);
	virtual void __fastcall Paint(void);
	DYNAMIC void __fastcall StopSizing(void);
	__property Canvas ;
	virtual void __fastcall Notification(Classes::TComponent* ACOmponent, Classes::TOperation Operation
		);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TCoolSpotSplitter(Classes::TComponent* AOwner);
	__fastcall virtual ~TCoolSpotSplitter(void);
	void __fastcall OpenSplitter(void);
	void __fastcall CloseSplitter(void);
	__property TSplitterState State = {read=FState, write=SetState, nodefault};
	bool __fastcall IsCursorInSpot(const int X, const int Y);
	bool __fastcall IsCursorInSplitter(const int X, const int Y);
	
__published:
	__property Coolctrls::TCCAboutBox* About = {read=FAboutBox, write=FAboutBox};
	__property TSplitterAlign AlignSplitter = {read=FAlignSplitter, write=SetAlign, default=1};
	__property bool AutoPosition = {read=FAutoPosition, write=FAutoPosition, nodefault};
	__property PositionAfterOpen PositionAfterOpen = {read=FPositionAfterOpen, write=FPositionAfterOpen
		, nodefault};
	__property NaturalNumber SpotSizePercent = {read=FSpotSizePercent, write=SetSpotSizePercent, nodefault
		};
	__property bool SpotVisible = {read=FSpotVisible, write=SetSpotVisible, default=1};
	__property Graphics::TColor SpotHighlightColor = {read=FSpotHighlightColor, write=FSpotHighlightColor
		, default=-2147483628};
	__property bool AutoSnap = {read=FAutoSnap, write=FAutoSnap, default=1};
	__property NaturalNumber MinSize = {read=FMinSize, write=FMinSize, default=30};
	__property TSplitterResizeStyle ResizeStyle = {read=FResizeStyle, write=FResizeStyle, default=1};
	__property Controls::TControl* Control = {read=FControl, write=FControl};
	__property Color ;
	__property ParentColor ;
	__property Visible ;
	__property TCanResizeEvent OnCanResize = {read=FOnCanResize, write=FOnCanResize};
	__property Classes::TNotifyEvent OnMoved = {read=FOnMoved, write=FOnMoved};
	__property TBeforeOpenSpotEvent OnBeforeOpen = {read=FOnBeforeOpen, write=FOnBeforeOpen};
	__property Classes::TNotifyEvent OnAfterOpen = {read=FOnAfterOpen, write=FOnAfterOpen};
	__property TBeforeCloseSpotEvent OnBeforeClose = {read=FOnBeforeClose, write=FOnBeforeClose};
	__property Classes::TNotifyEvent OnAfterClose = {read=FOnAfterClose, write=FOnAfterClose};
};


//-- var, const, procedure ---------------------------------------------------

}	/* namespace Coolsplitter */
#if !defined(NO_IMPLICIT_NAMESPACE_USE)
using namespace Coolsplitter;
#endif
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// CoolSplitter
