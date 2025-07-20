// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeJavaScript.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeejavascriptHPP
#define Vcltee_TeejavascriptHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <System.UITypes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.Forms.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeeExport.hpp>
#include <VCLTee.Chart.hpp>
#include <VCLTee.TeEngine.hpp>
#include <VCLTee.TeeTools.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teejavascript
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TCustomJSExportFormat;
class DELPHICLASS TJavascriptExportFormat;
//-- type declarations -------------------------------------------------------
typedef System::UnicodeString __fastcall (__closure *TJavascriptGetSeries)(Vcltee::Teengine::TChartSeries* const ASeries);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TCustomJSExportFormat : public Vcltee::Teeexport::TTeeExportFormat
{
	typedef Vcltee::Teeexport::TTeeExportFormat inherited;
	
private:
	Vcl::Forms::TForm* FProperties;
	System::UnicodeString FPanelName;
	System::UnicodeString FCanvasName;
	System::Classes::TStrings* FCustomCode;
	bool FDoFullPage;
	bool FMinify;
	System::UnicodeString FSourceScriptPath;
	void __fastcall AddHeader(System::Classes::TStrings* const S);
	void __fastcall CheckProperties();
	void __fastcall EmitCustomCode(System::Classes::TStrings* const S);
	System::UnicodeString __fastcall GetCanvasName();
	System::UnicodeString __fastcall GetPanelName();
	void __fastcall SetSourceScriptPath(const System::UnicodeString Value);
	void __fastcall SetCanvasName(const System::UnicodeString Value);
	void __fastcall SetPanelName(const System::UnicodeString Value);
	void __fastcall SetCustomCode(System::Classes::TStrings* const S);
	void __fastcall SetDoFullPage(const bool Value);
	void __fastcall SetMinify(const bool Value);
	HIDESBASE void __fastcall SaveToFile(Vcltee::Chart::TCustomChart* const Chart, const System::UnicodeString FileName);
	
protected:
	void __fastcall AddStrings(System::Classes::TStrings* const S);
	virtual void __fastcall DoAddStrings(System::Classes::TStrings* const S) = 0 ;
	virtual void __fastcall DoCopyToClipboard();
	virtual int __fastcall FileFilterIndex();
	virtual void __fastcall IncFileFilterIndex(int &FilterIndex);
	
public:
	__fastcall virtual TCustomJSExportFormat();
	__fastcall virtual ~TCustomJSExportFormat();
	virtual System::UnicodeString __fastcall Description();
	__classmethod virtual System::UnicodeString __fastcall FileFilter();
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream)/* overload */;
	virtual Vcl::Forms::TForm* __fastcall Options(bool Check = true);
	virtual System::UnicodeString __fastcall FileExtension();
	System::Classes::TStringList* __fastcall JScript();
	__property System::UnicodeString CanvasName = {read=GetCanvasName, write=SetCanvasName};
	__property System::UnicodeString PanelName = {read=GetPanelName, write=SetPanelName};
	__property System::Classes::TStrings* CustomCode = {read=FCustomCode, write=SetCustomCode};
	__property bool DoFullPage = {read=FDoFullPage, write=SetDoFullPage, nodefault};
	__property bool Minify = {read=FMinify, write=SetMinify, nodefault};
	__property System::UnicodeString SourceScriptPath = {read=FSourceScriptPath, write=SetSourceScriptPath};
	/* Hoisted overloads: */
	
public:
	inline void __fastcall  SaveToStream(System::Classes::TStream* Stream, Vcl::Forms::TForm* const AOptions){ Vcltee::Teeexport::TTeeExportFormat::SaveToStream(Stream, AOptions); }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TJavascriptExportFormat : public TCustomJSExportFormat
{
	typedef TCustomJSExportFormat inherited;
	
private:
	bool IEmptiedChart;
	bool IHasDateTime;
	bool IHasExtras;
	bool IHasGauges;
	Vcltee::Chart::TCustomChart* __fastcall Chart();
	HIDESBASE void __fastcall AddHeader(System::Classes::TStrings* const S);
	void __fastcall EmitEmptyChart(System::Classes::TStrings* const S);
	System::UnicodeString __fastcall GetChartName();
	void __fastcall ResetFlags();
	void __fastcall SetChartName(const System::UnicodeString Value);
	
protected:
	TJavascriptGetSeries FOnGetSeries;
	virtual void __fastcall DoAddStrings(System::Classes::TStrings* const S);
	
public:
	HIDESBASE void __fastcall SaveToFile(Vcltee::Chart::TCustomChart* const Chart, const System::UnicodeString FileName);
	__property System::UnicodeString ChartName = {read=GetChartName, write=SetChartName};
public:
	/* TCustomJSExportFormat.Create */ inline __fastcall virtual TJavascriptExportFormat() : TCustomJSExportFormat() { }
	/* TCustomJSExportFormat.Destroy */ inline __fastcall virtual ~TJavascriptExportFormat() { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall TeeSaveToJavascriptFile(Vcltee::Chart::TCustomChart* const APanel, const System::UnicodeString FileName, int AWidth = 0x0, int AHeight = 0x0, bool AMinify = false, System::Sysutils::TEncoding* const AEncoding = (System::Sysutils::TEncoding*)(0x0));
}	/* namespace Teejavascript */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEEJAVASCRIPT)
using namespace Vcltee::Teejavascript;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeejavascriptHPP
