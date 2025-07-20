// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Import.pas' rev: 34.00 (Android)

#ifndef Fmxtee_ImportHPP
#define Fmxtee_ImportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <System.Variants.hpp>
#include <System.IOUtils.hpp>
#include <FMX.Types.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <FMXTee.Store.hpp>
#include <FMXTee.Series.World.hpp>
#include <FMXTee.Series.Candle.hpp>
#include <FMX.Graphics.hpp>
#include <FMX.Grid.hpp>
#include <REST.Client.hpp>
#include <System.Rtti.hpp>
#include <System.Generics.Collections.hpp>
#include <System.Zip.hpp>
#include <System.JSON.hpp>
#include <Xml.XMLIntf.hpp>
#include <Xml.XMLDoc.hpp>
#include <System.Types.hpp>
#include <Data.DB.hpp>
#include <FMXTee.Procs.hpp>
#include <FMX.Controls.hpp>
#include <System.Generics.Defaults.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Import
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS EDataImport;
class DELPHICLASS TDataFormat;
class DELPHICLASS TDataImport;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION EDataImport : public System::Sysutils::Exception
{
	typedef System::Sysutils::Exception inherited;
	
public:
	/* Exception.Create */ inline __fastcall EDataImport(const System::UnicodeString Msg) : System::Sysutils::Exception(Msg) { }
	/* Exception.CreateFmt */ inline __fastcall EDataImport(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High) : System::Sysutils::Exception(Msg, Args, Args_High) { }
	/* Exception.CreateRes */ inline __fastcall EDataImport(NativeUInt Ident)/* overload */ : System::Sysutils::Exception(Ident) { }
	/* Exception.CreateRes */ inline __fastcall EDataImport(System::PResStringRec ResStringRec)/* overload */ : System::Sysutils::Exception(ResStringRec) { }
	/* Exception.CreateResFmt */ inline __fastcall EDataImport(NativeUInt Ident, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High) { }
	/* Exception.CreateResFmt */ inline __fastcall EDataImport(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High) { }
	/* Exception.CreateHelp */ inline __fastcall EDataImport(const System::UnicodeString Msg, int AHelpContext) : System::Sysutils::Exception(Msg, AHelpContext) { }
	/* Exception.CreateFmtHelp */ inline __fastcall EDataImport(const System::UnicodeString Msg, const System::TVarRec *Args, const int Args_High, int AHelpContext) : System::Sysutils::Exception(Msg, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDataImport(NativeUInt Ident, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, AHelpContext) { }
	/* Exception.CreateResHelp */ inline __fastcall EDataImport(System::PResStringRec ResStringRec, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDataImport(System::PResStringRec ResStringRec, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(ResStringRec, Args, Args_High, AHelpContext) { }
	/* Exception.CreateResFmtHelp */ inline __fastcall EDataImport(NativeUInt Ident, const System::TVarRec *Args, const int Args_High, int AHelpContext)/* overload */ : System::Sysutils::Exception(Ident, Args, Args_High, AHelpContext) { }
	/* Exception.Destroy */ inline __fastcall virtual ~EDataImport() { }
	
};


typedef void __fastcall (__closure *TDataImportProgress)(TDataImport* Sender, unsigned Current, unsigned Total, bool &Cancel);

enum DECLSPEC_DENUM TDataImportStyle : unsigned char { isAutomatic, is2D, isXY, isGrid, isXYZ, isFinancial, isGeographic };

enum DECLSPEC_DENUM TKeepSetting : unsigned char { ksSeries, ksTitle, ksAxesTitle, ksLegendTitle, ksView3D };

typedef System::Set<TKeepSetting, TKeepSetting::ksSeries, TKeepSetting::ksView3D> TKeepSettings;

class PASCALIMPLEMENTATION TDataFormat : public Fmxtee::Chart::TCustomChart
{
	typedef Fmxtee::Chart::TCustomChart inherited;
	
	
private:
	typedef System::DynamicArray<System::UnicodeString> _TDataFormat__1;
	
	typedef System::DynamicArray<System::UnicodeString> _TDataFormat__2;
	
	typedef System::DynamicArray<System::Word> _TDataFormat__3;
	
	
private:
	System::Sysutils::TFormatSettings ISettings;
	Fmxtee::Series::World::TWorldMap IGeoMap;
	unsigned FirstRow;
	unsigned LastRow;
	bool AutoLoaded;
	bool DecimalDetected;
	Fmxtee::Engine::TChartSeriesList* __fastcall CloneSeries(System::Classes::TComponent* const AOwner);
	bool __fastcall GuessValue(const System::UnicodeString AText, const int AIndex, const System::UnicodeString ATitle);
	void __fastcall NewSeriesIndex(const int AIndex, const System::UnicodeString ATitle);
	void __fastcall TitleFromHeaders(System::Classes::TStrings* const AStrings);
	void __fastcall TrySetTextField(const int AIndex, const System::UnicodeString ATitle);
	
protected:
	virtual void __fastcall Analyze();
	virtual void __fastcall BeginLoop();
	virtual void __fastcall EndLoop();
	virtual void __fastcall ChangedOption(System::TObject* Sender);
	virtual System::UnicodeString __fastcall GetText(const unsigned ARow);
	virtual bool __fastcall GetValue(const int ACol, const unsigned ARow, /* out */ double &Value);
	virtual bool __fastcall NextIteration();
	virtual System::Classes::TStrings* __fastcall Options();
	virtual void __fastcall PrepareOption(System::Classes::TComponent* const AComponent, const int AIndex);
	void __fastcall SetTitles(Fmxtee::Chart::TCustomChart* const AChart, const TKeepSettings AKeep);
	virtual bool __fastcall ValidRow(const unsigned ARow);
	
public:
	TDataImportStyle ActualStyle;
	int TextField;
	System::UnicodeString TextFieldName;
	_TDataFormat__1 Headers;
	System::Word HeaderLines;
	_TDataFormat__2 SeriesTitles;
	_TDataFormat__3 SeriesIndex;
	unsigned DataQuantity;
	__fastcall TDataFormat();
	void __fastcall CreateSeries(System::Classes::TComponent* const AOwner);
public:
	/* TCustomChart.Destroy */ inline __fastcall virtual ~TDataFormat() { }
	
};


enum DECLSPEC_DENUM TDataImportStreamFormat : unsigned char { ifCSV, ifXML, ifJSON };

class PASCALIMPLEMENTATION TDataImport : public Fmxtee::Chart::TCustomChartLink
{
	typedef Fmxtee::Chart::TCustomChartLink inherited;
	
private:
	TKeepSettings FKeep;
	TDataImportProgress FOnProgress;
	TDataImportStyle FStyle;
	unsigned ICurrent;
	unsigned ITotal;
	bool ICancel;
	int __fastcall FindGeoEntity(Fmxtee::Series::World::TWorldSeries* const ASeries, const System::UnicodeString AEntity);
	void __fastcall Finish(TDataFormat* const AFormat, Fmxtee::Chart::TCustomChart* const AChart, Fmxtee::Engine::TChartSeriesList* const ASeries);
	void __fastcall FinishLocalFormat(TDataFormat* const AFormat);
	TDataFormat* __fastcall InitFormat(const unsigned AQuantity);
	void __fastcall SetGeoEntity(Fmxtee::Series::World::TWorldSeries* const ASeries, const System::UnicodeString AEntity, const double AValue);
	void __fastcall SynchronizeProgress();
	void __fastcall TryFreeSeries(Fmxtee::Chart::TCustomChart* const AChart, bool Force = false);
	void __fastcall TryProgress(const unsigned Current, const unsigned Total);
	
protected:
	TDataFormat* IFormat;
	void __fastcall LocalImport(Data::Db::TDataSet* const ADataset, bool DoFree)/* overload */;
	void __fastcall LocalImport(System::Classes::TStrings* const AStrings, bool DoFree)/* overload */;
	
public:
	bool AnalyzeMode;
	__fastcall virtual ~TDataImport();
	__classmethod bool __fastcall CanImport(System::Classes::TComponent* const AComponent);
	__classmethod void __fastcall GroupSimilarSeries(Fmxtee::Engine::TCustomSeriesList* const AList);
	void __fastcall Import(TDataFormat* const AFormat)/* overload */;
	void __fastcall Import(System::TObject* const AObject)/* overload */;
	void __fastcall Import(System::Classes::TComponent* const AComponent)/* overload */;
	void __fastcall Import(System::Classes::TStrings* const AStrings)/* overload */;
	void __fastcall Import(System::Classes::TStream* const AStream, const TDataImportStreamFormat AFormat)/* overload */;
	void __fastcall Import(System::Classes::TStringStream* const AStream)/* overload */;
	void __fastcall Import(Data::Db::TDataSet* const ADataset)/* overload */;
	void __fastcall Import(const System::UnicodeString AText)/* overload */;
	void __fastcall Import(Fmx::Graphics::TBitmap* const AGraphic)/* overload */;
	void __fastcall Import(const double *Data, const int Data_High)/* overload */;
	void __fastcall Import(const int *Data, const int Data_High)/* overload */;
	void __fastcall Import(const __int64 *Data, const int Data_High)/* overload */;
	void __fastcall Import(Fmxtee::Chart::TCustomChart* const AChart)/* overload */;
	void __fastcall Import(Fmxtee::Engine::TChartSeries* const ASeries)/* overload */;
	void __fastcall Import(Fmx::Grid::TStringGrid* const AGrid, Fmx::Grid::TColumn* const *AColumns, const int AColumns_High)/* overload */;
	void __fastcall Import(Xml::Xmldoc::TXMLDocument* const AXML)/* overload */;
	void __fastcall Import(const Xml::Xmlintf::_di_IXMLDocument AXML)/* overload */;
	void __fastcall ImportXML(System::Classes::TStrings* const AStrings)/* overload */;
	void __fastcall ImportXML(const System::UnicodeString AXML)/* overload */;
	void __fastcall ImportHTML(const System::UnicodeString AHTML, const System::UnicodeString ATableID = System::UnicodeString())/* overload */;
	void __fastcall Import(const System::Rtti::TValue &AData)/* overload */;
	void __fastcall Import(System::Classes::TCollection* const ACollection)/* overload */;
	void __fastcall ImportJSON(System::Classes::TStrings* const AStrings, const System::UnicodeString Root = System::UnicodeString(), const System::UnicodeString Field = System::UnicodeString())/* overload */;
	void __fastcall ImportJSON(const System::UnicodeString AText, const System::UnicodeString Root = System::UnicodeString(), const System::UnicodeString Field = System::UnicodeString())/* overload */;
	void __fastcall Import(System::Json::TJSONValue* const AJSON, const System::UnicodeString Root = System::UnicodeString(), const System::UnicodeString Field = System::UnicodeString())/* overload */;
	void __fastcall Import(Rest::Client::TRESTResponse* const AResponse)/* overload */;
	void __fastcall ImportFromFile(const System::UnicodeString APath)/* overload */;
	void __fastcall ImportFromURL(const System::UnicodeString AURL)/* overload */;
	void __fastcall ImportToChart(TDataFormat* const AFormat, Fmxtee::Chart::TCustomChart* const AChart);
	
__published:
	__property Chart;
	__property TKeepSettings KeepSettings = {read=FKeep, write=FKeep, default=0};
	__property TDataImportStyle Style = {read=FStyle, write=FStyle, default=0};
	__property TDataImportProgress OnProgress = {read=FOnProgress, write=FOnProgress};
public:
	/* TComponent.Create */ inline __fastcall virtual TDataImport(System::Classes::TComponent* AOwner) : Fmxtee::Chart::TCustomChartLink(AOwner) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Import */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_IMPORT)
using namespace Fmxtee::Import;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_ImportHPP
