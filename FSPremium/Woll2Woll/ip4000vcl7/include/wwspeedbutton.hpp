// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwSpeedButton.pas' rev: 6.00

#ifndef wwSpeedButtonHPP
#define wwSpeedButtonHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <ActnList.hpp>	// Pascal unit
#include <Wwcommon.hpp>	// Pascal unit
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

namespace Wwspeedbutton
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TwwDisabledTextColors;
class PASCALIMPLEMENTATION TwwDisabledTextColors : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	Graphics::TColor FShadeColor;
	Graphics::TColor FHighlightColor;
	
__published:
	__property Graphics::TColor ShadeColor = {read=FShadeColor, write=FShadeColor, nodefault};
	__property Graphics::TColor HighlightColor = {read=FHighlightColor, write=FHighlightColor, nodefault};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwDisabledTextColors(void) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Create */ inline __fastcall TwwDisabledTextColors(void) : Classes::TPersistent() { }
	#pragma option pop
	
};


class DELPHICLASS TwwSpeedButton;
class PASCALIMPLEMENTATION TwwSpeedButton : public Controls::TGraphicControl 
{
	typedef Controls::TGraphicControl inherited;
	
private:
	bool FTransparent;
	bool FFlat;
	int FImageIndex;
	Controls::TImageList* FImageList;
	int FMargin;
	int FNumGlyphs;
	bool FShowText;
	int FSpacing;
	TwwDisabledTextColors* FDisabledTextColors;
	bool FMouseInControl;
	void __fastcall SetTransparent(bool Value);
	HIDESBASE MESSAGE void __fastcall CMMouseEnter(Messages::TMessage &Message);
	HIDESBASE MESSAGE void __fastcall CMMouseLeave(Messages::TMessage &Message);
	
protected:
	DYNAMIC void __fastcall ActionChange(System::TObject* Sender, bool CheckDefaults);
	virtual int __fastcall GetImageIndex(void);
	void __fastcall SetFlat(bool Value);
	virtual void __fastcall SetImageIndex(int Value);
	void __fastcall SetImageList(Controls::TImageList* Value);
	void __fastcall SetMargin(int Value);
	void __fastcall SetNumGlyphs(int Value);
	void __fastcall SetShowText(bool Value);
	void __fastcall SetSpacing(int Value);
	DYNAMIC void __fastcall MouseDown(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	DYNAMIC void __fastcall MouseUp(Controls::TMouseButton Button, Classes::TShiftState Shift, int X, int Y);
	virtual void __fastcall Paint(void);
	HIDESBASE HRESULT __stdcall QueryInterface(const GUID &IID, /* out */ void *Obj);
	HIDESBASE int __stdcall _AddRef(void);
	HIDESBASE int __stdcall _Release(void);
	
public:
	__fastcall virtual TwwSpeedButton(Classes::TComponent* AOwner);
	__fastcall virtual ~TwwSpeedButton(void);
	__property Controls::TImageList* ImageList = {read=FImageList, write=SetImageList};
	__property bool Flat = {read=FFlat, write=SetFlat, nodefault};
	
__published:
	__property Action ;
	__property int ImageIndex = {read=GetImageIndex, write=SetImageIndex, nodefault};
	__property int Margin = {read=FMargin, write=SetMargin, default=-1};
	__property int NumGlyphs = {read=FNumGlyphs, write=SetNumGlyphs, nodefault};
	__property bool ShowText = {read=FShowText, write=SetShowText, default=0};
	__property int Spacing = {read=FSpacing, write=SetSpacing, nodefault};
	__property bool Transparent = {read=FTransparent, write=SetTransparent, default=1};
	__property Caption ;
	__property Enabled  = {default=1};
	__property TwwDisabledTextColors* DisabledTextColors = {read=FDisabledTextColors, write=FDisabledTextColors};
	__property Font ;
	__property ParentFont  = {default=1};
	__property ParentShowHint  = {default=1};
	__property ShowHint ;
	__property OnClick ;
	__property OnMouseDown ;
	__property OnMouseUp ;
	__property OnMouseMove ;
private:
	void *__IInterface;	/* System::IInterface */
	
public:
	operator IInterface*(void) { return (IInterface*)&__IInterface; }
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwSpeedButton)
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wwspeedbutton */
using namespace Wwspeedbutton;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwSpeedButton
