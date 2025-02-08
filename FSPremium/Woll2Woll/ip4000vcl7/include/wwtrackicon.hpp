// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwTrackIcon.pas' rev: 6.00

#ifndef wwTrackIconHPP
#define wwTrackIconHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Dialogs.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwtrackicon
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwTrackIcon;
class PASCALIMPLEMENTATION TwwTrackIcon : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	Graphics::TBitmap* TrackBmp;
	Classes::TNotifyEvent FOnEndDrag;
	AnsiString FBitmapName;
	int FMinValue;
	int FMaxValue;
	void __fastcall MouseLoop_Drag(int X, int Y);
	void __fastcall SetBitmapName(AnsiString val);
	
protected:
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	
public:
	__fastcall virtual TwwTrackIcon(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwTrackIcon(void);
	
__published:
	__property Classes::TNotifyEvent OnEndDrag = {read=FOnEndDrag, write=FOnEndDrag};
	__property AnsiString BitmapName = {read=FBitmapName, write=SetBitmapName};
	__property int MinValue = {read=FMinValue, write=FMinValue, nodefault};
	__property int MaxValue = {read=FMaxValue, write=FMaxValue, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwTrackIcon)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwtrackicon */
using namespace Wwtrackicon;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwTrackIcon
