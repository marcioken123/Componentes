// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDLED.pas' rev: 31.00 (Windows)

#ifndef LmdledHPP
#define LmdledHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Messages.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Menus.hpp>
#include <LMDObject.hpp>
#include <LMDGraph.hpp>
#include <System.Types.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdled
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDLED;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDLEDLights : unsigned char { llTop, llTopLeft, llTopRight, llMiddle, llBottomLeft, llBottomRight, llBottom, llInTopMiddle, llInBottomMiddle, llInTopLeft, llInTopRight, llInBottomLeft, llInBottomRight, llPointMiddle, llPointTop, llPointBottom };

typedef System::Set<TLMDLEDLights, TLMDLEDLights::llTop, TLMDLEDLights::llPointBottom> TLMDLEDSET;

enum DECLSPEC_DENUM TLMDLEDStyle : unsigned char { lsString, lsInteger };

typedef System::StaticArray<System::Types::TPoint, 6> TLMDLEDPoints;

typedef System::StaticArray<System::StaticArray<System::Types::TPoint, 6>, 16> TLMDLEDCalc;

class PASCALIMPLEMENTATION TLMDLED : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	System::Uitypes::TColor FBack;
	System::Uitypes::TColor FInactive;
	System::Uitypes::TColor FActive;
	System::Byte FHorz;
	System::Byte FThick;
	System::Byte FVert;
	bool FIsFlashing;
	bool FFlag;
	bool FEnhEnabled;
	System::Byte FRows;
	System::Byte FCols;
	TLMDLEDCalc FLEDs;
	Vcl::Graphics::TBitmap* FBitmap;
	System::UnicodeString FCaption;
	void __fastcall SetByte(int Index, System::Byte aValue);
	void __fastcall SetColor(int Index, System::Uitypes::TColor aColor);
	void __fastcall SetEnabled(bool aValue);
	void __fastcall CreateBmp(void);
	
protected:
	int __fastcall GetHeight(void);
	int __fastcall GetWidth(void);
	
public:
	__fastcall virtual TLMDLED(System::Classes::TPersistent* Owner);
	__fastcall virtual ~TLMDLED(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	System::Types::TRect __fastcall CalcBoundsRect(const System::UnicodeString sText, int Ext);
	void __fastcall PaintLED(Vcl::Graphics::TCanvas* ACanvas, const System::Types::TRect &ARect, const System::UnicodeString sText, bool Enabled, bool flag);
	virtual void __fastcall BeginFlash(void);
	virtual void __fastcall EndFlash(void);
	__property System::Byte Rows = {read=FRows, nodefault};
	__property System::Byte Columns = {read=FCols, nodefault};
	__property System::UnicodeString Caption = {read=FCaption};
	__property System::Uitypes::TColor BackColor = {read=FBack, write=SetColor, index=2, nodefault};
	__property int LEDHeight = {read=GetHeight, nodefault};
	__property int LEDWidth = {read=GetWidth, nodefault};
	
__published:
	__property System::Uitypes::TColor ActiveColor = {read=FActive, write=SetColor, index=0, default=65280};
	__property bool DisabledDigits = {read=FEnhEnabled, write=SetEnabled, default=1};
	__property System::Byte Horzsize = {read=FHorz, write=SetByte, index=1, default=7};
	__property System::Uitypes::TColor InActiveColor = {read=FInactive, write=SetColor, index=1, default=32768};
	__property System::Byte Thickness = {read=FThick, write=SetByte, index=2, default=2};
	__property System::Byte Vertsize = {read=FVert, write=SetByte, index=3, default=9};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdled */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDLED)
using namespace Lmdled;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdledHPP
