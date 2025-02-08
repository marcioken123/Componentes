// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWriter.pas' rev: 31.00 (Windows)

#ifndef LmdwriterHPP
#define LmdwriterHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.Graphics.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.UITypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwriter
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWriter;
struct TLMDWriterRec;
//-- type declarations -------------------------------------------------------
typedef System::TMetaClass* TLMDWriterClass;

enum DECLSPEC_DENUM TLMDWriterMode : unsigned char { wmWindows, wmUnix };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWriter : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStream* FStream;
	int FIndent;
	TLMDWriterMode FMode;
	System::UnicodeString __fastcall GetIndent(void);
	
public:
	__fastcall virtual TLMDWriter(System::Classes::TStream* aStream)/* overload */;
	void __fastcall Indent(void);
	void __fastcall RevIndent(void);
	void __fastcall Write(const System::UnicodeString aText);
	void __fastcall Writeln(const System::UnicodeString aText)/* overload */;
	void __fastcall Writeln(void)/* overload */;
	void __fastcall WriteIndent(void);
	virtual void __fastcall WriteDocumentStart(void) = 0 ;
	virtual void __fastcall WriteDocumentEnd(void) = 0 ;
	virtual void __fastcall WriteOpenTable(int aWidth, int aAlign, int aVAlign, int aCellspacing, int aCellpadding, int aBorder, System::Uitypes::TColor aBgColor) = 0 ;
	virtual void __fastcall WriteCloseTable(void) = 0 ;
	virtual void __fastcall WriteOpenTableRow(void) = 0 ;
	virtual void __fastcall WriteCloseTableRow(void) = 0 ;
	virtual void __fastcall WriteOpenTableData(int aWidth, int aHeight, int aRowspan, int aColspan, int aAlign, int aVAlign, System::Uitypes::TColor BgColor) = 0 ;
	virtual void __fastcall WriteCloseTableData(void) = 0 ;
	virtual void __fastcall WriteImage(const System::UnicodeString aSrc, int aWidth, int aHeight) = 0 ;
	virtual void __fastcall WriteHLine(void) = 0 ;
	virtual void __fastcall WriteLineBreak(void) = 0 ;
	virtual void __fastcall WriteOpenList(int aListType) = 0 ;
	virtual void __fastcall WriteCloseList(int aListType) = 0 ;
	virtual void __fastcall WriterListBullet(int aListType, int aNo) = 0 ;
	virtual void __fastcall WriteOpenLink(const System::UnicodeString aHREF) = 0 ;
	virtual void __fastcall WriteCloseLink(void) = 0 ;
	virtual void __fastcall WriteText(const System::UnicodeString aText, bool aLink, const System::UnicodeString aHREF, const System::UnicodeString aFontFace, const System::UnicodeString aFontSize, System::Uitypes::TColor aFontColor, System::Uitypes::TFontStyles aFontStyle, int aSubscriptStyle, int aTextStyle, System::Uitypes::TColor aLightColor, int aLightDepth, System::Uitypes::TColor aShadowColor, int aShadowDepth) = 0 ;
	virtual void __fastcall WriteOpenParagraph(void) = 0 ;
	virtual void __fastcall WriteCloseParagraph(void) = 0 ;
	virtual void __fastcall WriteOpenTree(void) = 0 ;
	virtual void __fastcall WriteCloseTree(void) = 0 ;
	virtual void __fastcall WriterOpenTreeItem(void) = 0 ;
	virtual void __fastcall WriterCloseTreeItem(void) = 0 ;
	virtual void __fastcall WriteEmbdControl(const System::UnicodeString aControlClass, const System::UnicodeString aControlName, int aHeight, int aWidth) = 0 ;
	__property System::Classes::TStream* Stream = {read=FStream, write=FStream};
	__property TLMDWriterMode Mode = {read=FMode, write=FMode, nodefault};
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDWriter(void) { }
	
};

#pragma pack(pop)

typedef TLMDWriterRec *PLMDWriterRec;

struct DECLSPEC_DRECORD TLMDWriterRec
{
public:
	bool Default;
	TLMDWriterClass WriterClass;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall RegisterWriter(TLMDWriterClass aWriterClass, const System::UnicodeString *aExtentions, const int aExtentions_High, bool aDefault);
extern DELPHI_PACKAGE void __fastcall UnregisterWriter(TLMDWriterClass aWriterClass);
extern DELPHI_PACKAGE System::Classes::TList* __fastcall Writers(void);
extern DELPHI_PACKAGE TLMDWriterClass __fastcall DefaultWriterClass(void);
}	/* namespace Lmdwriter */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWRITER)
using namespace Lmdwriter;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwriterHPP
