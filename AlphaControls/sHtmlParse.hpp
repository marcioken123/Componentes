// CodeGear C++Builder
// Copyright (c) 1995, 2014 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'sHtmlParse.pas' rev: 27.00 (Windows)

#ifndef ShtmlparseHPP
#define ShtmlparseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <Winapi.Windows.hpp>	// Pascal unit
#include <Vcl.Graphics.hpp>	// Pascal unit
#include <System.SysUtils.hpp>	// Pascal unit
#include <System.Classes.hpp>	// Pascal unit
#include <System.Math.hpp>	// Pascal unit
#include <System.UITypes.hpp>	// Pascal unit
#include <acntUtils.hpp>	// Pascal unit
#include <sConst.hpp>	// Pascal unit
#include <System.Types.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Shtmlparse
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TsHtml;
#pragma pack(push,4)
class PASCALIMPLEMENTATION TsHtml : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	typedef System::DynamicArray<Vcl::Graphics::TFont*> _TsHtml__1;
	
	
protected:
	bool Calculating;
	
public:
	Vcl::Graphics::TBitmap* Bitmap;
	int CurX;
	int CurY;
	int Len;
	System::UnicodeString Origin;
	System::UnicodeString UppedText;
	_TsHtml__1 aFonts;
	System::Types::TRect Area;
	int WrapWidth;
	int MaxBmpWidth;
	int MaxBmpHeight;
	int CurWidthValue;
	int CurrentRowHeight;
	__fastcall virtual ~TsHtml(void);
	void __fastcall ShowCut(int inCurPos, int inLastPos);
	void __fastcall Init(Vcl::Graphics::TBitmap* Bmp, const System::UnicodeString Text, const System::Types::TRect &aRect);
	bool __fastcall ExecTag(const System::UnicodeString s);
	void __fastcall NewRow(void);
	void __fastcall NewFont(const System::UnicodeString s);
	void __fastcall BackFont(void);
	System::Types::TRect __fastcall HTMLText(bool CalcOnly = false);
	System::UnicodeString __fastcall GetSpecialCharacter(const System::UnicodeString inString, int inPos);
public:
	/* TObject.Create */ inline __fastcall TsHtml(void) : System::TObject() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall SetFont(Vcl::Graphics::TFont* Font, const System::UnicodeString Tag);
}	/* namespace Shtmlparse */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_SHTMLPARSE)
using namespace Shtmlparse;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ShtmlparseHPP
