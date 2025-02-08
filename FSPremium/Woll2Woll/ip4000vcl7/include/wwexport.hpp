// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'wwexport.pas' rev: 6.00

#ifndef wwexportHPP
#define wwexportHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <Controls.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Graphics.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wwexport
{
//-- type declarations -------------------------------------------------------
#pragma option push -b-
enum TwwGridExportType { wwgetTxt, wwgetHTML, wwgetSYLK, wwgetXML };
#pragma option pop

#pragma option push -b-
enum TwwExportSaveOption { esoShowHeader, esoShowFooter, esoDynamicColors, esoShowTitle, esoDblQuoteFields, esoSaveSelectedOnly, esoAddControls, esoBestColFit, esoShowRecordNo, esoEmbedURL, esoShowAlternating, esoTransparentGrid, esoClipboard };
#pragma option pop

typedef Set<TwwExportSaveOption, esoShowHeader, esoClipboard>  TwwExportSaveOptions;

class DELPHICLASS TwwExportOptions;
class PASCALIMPLEMENTATION TwwExportOptions : public Classes::TPersistent 
{
	typedef Classes::TPersistent inherited;
	
private:
	AnsiString FFileName;
	TwwGridExportType FExportType;
	AnsiString FDelimiter;
	TwwExportSaveOptions FOptions;
	AnsiString FTitleName;
	int FOutputWidthinTwips;
	int FHTMLBorderWidth;
	bool FUseOldClipboardSaving;
	bool FUseA1SYLKReference;
	AnsiString __fastcall GetFileName();
	void __fastcall SetFileName(AnsiString val);
	AnsiString __fastcall GetDelimiter();
	void __fastcall SetDelimiter(AnsiString val);
	bool __fastcall IsDelimiterStored(void);
	
protected:
	virtual AnsiString __fastcall AddQuotes(AnsiString s);
	int __fastcall XRecNoOffset(void);
	int __fastcall QuotesPad(void);
	
public:
	Classes::TComponent* Owner;
	virtual void __fastcall Save(void);
	void __fastcall ExportToStream(Classes::TStream* fs);
	__fastcall virtual TwwExportOptions(Classes::TComponent* AOwner);
	__property bool UseOldClipboardSaving = {read=FUseOldClipboardSaving, write=FUseOldClipboardSaving, default=0};
	__property bool UseA1SYLKReference = {read=FUseA1SYLKReference, write=FUseA1SYLKReference, default=0};
	
__published:
	__property AnsiString Delimiter = {read=GetDelimiter, write=SetDelimiter, stored=IsDelimiterStored};
	__property TwwGridExportType ExportType = {read=FExportType, write=FExportType, default=0};
	__property AnsiString FileName = {read=GetFileName, write=SetFileName};
	__property int HTMLBorderWidth = {read=FHTMLBorderWidth, write=FHTMLBorderWidth, default=1};
	__property TwwExportSaveOptions Options = {read=FOptions, write=FOptions, default=1049};
	__property int OutputWidthinTwips = {read=FOutputWidthinTwips, write=FOutputWidthinTwips, default=0};
	__property AnsiString TitleName = {read=FTitleName, write=FTitleName};
public:
	#pragma option push -w-inl
	/* TPersistent.Destroy */ inline __fastcall virtual ~TwwExportOptions(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
#pragma error Unsupported symbol type (23, wwexport)

}	/* namespace Wwexport */
using namespace Wwexport;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// wwexport
