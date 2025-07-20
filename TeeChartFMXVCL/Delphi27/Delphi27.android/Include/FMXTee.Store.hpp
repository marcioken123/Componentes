// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Store.pas' rev: 34.00 (Android)

#ifndef Fmxtee_StoreHPP
#define Fmxtee_StoreHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Generics.Collections.hpp>
#include <System.UITypes.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Store
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TSeriesData;
class DELPHICLASS TSeriesDataText;
class DELPHICLASS TSeriesDataXML;
class DELPHICLASS TSeriesDataHTML;
class DELPHICLASS TSeriesDataXLS;
class DELPHICLASS TSeriesDataJSON;
//-- type declarations -------------------------------------------------------
typedef bool __fastcall (__closure *TProcTeeCheckError)(const System::UnicodeString Message);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesData : public Fmxtee::Procs::TTeeExportData
{
	typedef Fmxtee::Procs::TTeeExportData inherited;
	
private:
	Fmxtee::Chart::TCustomChart* FChart;
	bool FIncludeColors;
	bool FIncludeIndex;
	bool FIncludeHeader;
	bool FIncludeLabels;
	Fmxtee::Engine::TChartSeries* FSeries;
	Fmxtee::Engine::TCustomSeriesList* FSeriesList;
	bool FUseSeriesFormat;
	System::UnicodeString FValueFormat;
	void __fastcall Prepare()/* overload */;
	
protected:
	Fmxtee::Engine::TeeFormatFlag IFormat;
	virtual void __fastcall GuessSeriesFormat()/* overload */;
	virtual void __fastcall GuessSeriesFormat(Fmxtee::Engine::TChartSeries* ASeries)/* overload */;
	int __fastcall MaxSeriesCount();
	virtual System::UnicodeString __fastcall PointToString(int Index);
	void __fastcall Prepare(Fmxtee::Engine::TChartSeries* const ASeries)/* overload */;
	int __fastcall TotalColumns();
	int __fastcall TotalRows();
	int __fastcall TotalSeries();
	
public:
	__fastcall virtual TSeriesData(Fmxtee::Chart::TCustomChart* AChart, Fmxtee::Engine::TChartSeries* ASeries);
	__fastcall virtual ~TSeriesData();
	virtual System::UnicodeString __fastcall AsString();
	DYNAMIC void __fastcall SaveToStream(System::Classes::TStream* AStream);
	bool __fastcall ValidSeries(Fmxtee::Engine::TChartSeries* const ASeries);
	System::UnicodeString __fastcall ValueToString(Fmxtee::Engine::TChartSeries* const ASeries, const double Value);
	__property Fmxtee::Chart::TCustomChart* Chart = {read=FChart, write=FChart};
	__property Fmxtee::Engine::TChartSeries* Series = {read=FSeries, write=FSeries};
	__property Fmxtee::Engine::TCustomSeriesList* SeriesList = {read=FSeriesList};
	
__published:
	__property bool IncludeColors = {read=FIncludeColors, write=FIncludeColors, default=0};
	__property bool IncludeHeader = {read=FIncludeHeader, write=FIncludeHeader, default=0};
	__property bool IncludeIndex = {read=FIncludeIndex, write=FIncludeIndex, default=0};
	__property bool IncludeLabels = {read=FIncludeLabels, write=FIncludeLabels, default=1};
	__property bool UseSeriesFormat = {read=FUseSeriesFormat, write=FUseSeriesFormat, default=0};
	__property System::UnicodeString ValueFormat = {read=FValueFormat, write=FValueFormat};
};

#pragma pack(pop)

_DECLARE_METACLASS(System::TMetaClass, TSeriesDataClass);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesDataText : public TSeriesData
{
	typedef TSeriesData inherited;
	
private:
	System::WideChar FTextDelimiter;
	System::UnicodeString FTextQuotes;
	
protected:
	virtual void __fastcall GuessSeriesFormat()/* overload */;
	virtual System::UnicodeString __fastcall PointToString(int Index);
	
public:
	__fastcall virtual TSeriesDataText(Fmxtee::Chart::TCustomChart* AChart, Fmxtee::Engine::TChartSeries* ASeries);
	virtual System::UnicodeString __fastcall AsString();
	
__published:
	__property System::WideChar TextDelimiter = {read=FTextDelimiter, write=FTextDelimiter, default=9};
	__property System::UnicodeString TextQuotes = {read=FTextQuotes, write=FTextQuotes};
public:
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TSeriesDataText() { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  GuessSeriesFormat(Fmxtee::Engine::TChartSeries* ASeries){ TSeriesData::GuessSeriesFormat(ASeries); }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesDataXML : public TSeriesData
{
	typedef TSeriesData inherited;
	
private:
	System::UnicodeString FEncoding;
	bool __fastcall IsEncodingStored();
	
public:
	__fastcall virtual TSeriesDataXML(Fmxtee::Chart::TCustomChart* AChart, Fmxtee::Engine::TChartSeries* ASeries);
	virtual System::UnicodeString __fastcall AsString();
	
__published:
	__property System::UnicodeString Encoding = {read=FEncoding, write=FEncoding, stored=IsEncodingStored};
	__property IncludeHeader = {default=1};
public:
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TSeriesDataXML() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesDataHTML : public TSeriesData
{
	typedef TSeriesData inherited;
	
protected:
	virtual System::UnicodeString __fastcall PointToString(int Index);
	
public:
	bool FirstSeriesLabels;
	virtual System::UnicodeString __fastcall AsString();
public:
	/* TSeriesData.Create */ inline __fastcall virtual TSeriesDataHTML(Fmxtee::Chart::TCustomChart* AChart, Fmxtee::Engine::TChartSeries* ASeries) : TSeriesData(AChart, ASeries) { }
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TSeriesDataHTML() { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesDataXLS : public TSeriesData
{
	typedef TSeriesData inherited;
	
public:
	DYNAMIC void __fastcall SaveToStream(System::Classes::TStream* AStream);
public:
	/* TSeriesData.Create */ inline __fastcall virtual TSeriesDataXLS(Fmxtee::Chart::TCustomChart* AChart, Fmxtee::Engine::TChartSeries* ASeries) : TSeriesData(AChart, ASeries) { }
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TSeriesDataXLS() { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TJSONDateTimeFormat : unsigned char { jdTimeStamp, jdJavaScript };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TSeriesDataJSON : public TSeriesData
{
	typedef TSeriesData inherited;
	
private:
	TJSONDateTimeFormat FDateFormat;
	
public:
	__fastcall virtual TSeriesDataJSON(Fmxtee::Chart::TCustomChart* AChart, Fmxtee::Engine::TChartSeries* ASeries);
	virtual System::UnicodeString __fastcall AsString();
	__property TJSONDateTimeFormat DateTimeFormat = {read=FDateFormat, write=FDateFormat, nodefault};
public:
	/* TSeriesData.Destroy */ inline __fastcall virtual ~TSeriesDataJSON() { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE void __fastcall ConvertTeeToBinary(System::Classes::TStream* const SInput, System::Classes::TStream* const SOutput);
extern DELPHI_PACKAGE void __fastcall ConvertTeeToText(System::Classes::TStream* const SInput, System::Classes::TStream* const SOutput);
extern DELPHI_PACKAGE void __fastcall LoadChartFromStreamCheck(Fmxtee::Chart::TCustomChart* const AChart, System::Classes::TStream* const AStream, TProcTeeCheckError ACheckError = 0x0, bool TryReadData = false);
extern DELPHI_PACKAGE void __fastcall LoadChartFromStream(Fmxtee::Chart::TCustomChart* const AChart, System::Classes::TStream* const AStream);
extern DELPHI_PACKAGE System::UnicodeString __fastcall TeeCheckExtension(const System::UnicodeString AFileName);
extern DELPHI_PACKAGE void __fastcall LoadChartFromFileCheck(Fmxtee::Chart::TCustomChart* const AChart, const System::UnicodeString AName, TProcTeeCheckError ACheckError);
extern DELPHI_PACKAGE void __fastcall LoadChartFromFile(Fmxtee::Chart::TCustomChart* const AChart, const System::UnicodeString AFileName);
extern DELPHI_PACKAGE void __fastcall ConvertTeeFileToText(const System::UnicodeString InputFile, const System::UnicodeString OutputFile);
extern DELPHI_PACKAGE void __fastcall ConvertTeeFileToBinary(const System::UnicodeString InputFile, const System::UnicodeString OutputFile);
extern DELPHI_PACKAGE void __fastcall SaveChartToStream(Fmxtee::Chart::TCustomChart* const AChart, System::Classes::TStream* const AStream, bool IncludeData = true, bool TextFormat = false);
extern DELPHI_PACKAGE void __fastcall SaveChartToXMLStream(Fmxtee::Chart::TCustomChart* const AChart, System::Classes::TStream* const AStream, bool IncludeData = true, bool XMLHeader = true);
extern DELPHI_PACKAGE void __fastcall SaveChartToFile(Fmxtee::Chart::TCustomChart* const AChart, const System::UnicodeString AFileName, bool IncludeData = true, bool TextFormat = false);
extern DELPHI_PACKAGE void __fastcall SaveChartToXMLFile(Fmxtee::Chart::TCustomChart* const AChart, const System::UnicodeString AFileName, bool IncludeData = true, bool XMLHeader = true);
}	/* namespace Store */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_STORE)
using namespace Fmxtee::Store;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_StoreHPP
