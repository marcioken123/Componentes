// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBFWriter.pas' rev: 31.00 (Windows)

#ifndef LmddbfwriterHPP
#define LmddbfwriterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <System.SysUtils.hpp>
#include <LMDWriter.hpp>
#include <LMDStringsList.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbfwriter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBFWriter;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBFWriter : public Lmdwriter::TLMDWriter
{
	typedef Lmdwriter::TLMDWriter inherited;
	
private:
	int FTableRef;
	System::UnicodeString FStrData;
	Lmdstringslist::TLMDStringsList* FStringsList;
	
public:
	__fastcall virtual TLMDDBFWriter(System::Classes::TStream* aStream)/* overload */;
	__fastcall virtual ~TLMDDBFWriter(void);
	virtual void __fastcall WriteDocumentStart(void);
	virtual void __fastcall WriteDocumentEnd(void);
	virtual void __fastcall WriteOpenTable(int aWidth, int aAlign, int aVAlign, int aCellspacing, int aCellpadding, int aBorder, System::Uitypes::TColor aBgColor);
	virtual void __fastcall WriteCloseTable(void);
	virtual void __fastcall WriteOpenTableRow(void);
	virtual void __fastcall WriteCloseTableRow(void);
	virtual void __fastcall WriteOpenTableData(int aWidth, int aHeight, int aRowspan, int aColspan, int aAlign, int aVAlign, System::Uitypes::TColor BgColor);
	virtual void __fastcall WriteCloseTableData(void);
	virtual void __fastcall WriteImage(const System::UnicodeString aSrc, int aWidth, int aHeight);
	virtual void __fastcall WriteHLine(void);
	virtual void __fastcall WriteLineBreak(void);
	virtual void __fastcall WriteOpenList(int aListType);
	virtual void __fastcall WriteCloseList(int aListType);
	virtual void __fastcall WriterListBullet(int aListType, int aNo);
	virtual void __fastcall WriteOpenLink(const System::UnicodeString aHREF);
	virtual void __fastcall WriteCloseLink(void);
	virtual void __fastcall WriteText(const System::UnicodeString aText, bool aLink, const System::UnicodeString aHREF, const System::UnicodeString aFontFace, const System::UnicodeString aFontSize, System::Uitypes::TColor aFontColor, System::Uitypes::TFontStyles aFontStyle, int aSubscriptStyle, int aTextStyle, System::Uitypes::TColor aLightColor, int aLightDepth, System::Uitypes::TColor aShadowColor, int aShadowDepth);
	virtual void __fastcall WriteOpenParagraph(void);
	virtual void __fastcall WriteCloseParagraph(void);
	virtual void __fastcall WriteOpenTree(void);
	virtual void __fastcall WriteCloseTree(void);
	virtual void __fastcall WriterOpenTreeItem(void);
	virtual void __fastcall WriterCloseTreeItem(void);
	virtual void __fastcall WriteEmbdControl(const System::UnicodeString aControlClass, const System::UnicodeString aControlName, int aHeight, int aWidth);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbfwriter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBFWRITER)
using namespace Lmddbfwriter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbfwriterHPP
