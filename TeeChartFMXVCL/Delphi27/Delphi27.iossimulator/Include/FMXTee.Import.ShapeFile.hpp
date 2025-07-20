// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Import.ShapeFile.pas' rev: 34.00 (iOSSIM)

#ifndef Fmxtee_Import_ShapefileHPP
#define Fmxtee_Import_ShapefileHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <FMXTee.Series.Map.hpp>
#include <FMXTee.Canvas.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <Data.DB.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Import
{
namespace Shapefile
{
//-- forward type declarations -----------------------------------------------
struct TSHPHeader;
struct TSHPRecordHeader;
//-- type declarations -------------------------------------------------------
#pragma pack(push,1)
struct DECLSPEC_DRECORD TSHPHeader
{
public:
	int FileCode;
	int Unused1;
	int Unused2;
	int Unused3;
	int Unused4;
	int Unused5;
	int FileLength;
	int Version;
	int ShapeType;
	double XMin;
	double YMin;
	double XMax;
	double YMax;
	double ZMin;
	double ZMax;
	double MMin;
	double MMax;
};
#pragma pack(pop)


#pragma pack(push,1)
struct DECLSPEC_DRECORD TSHPRecordHeader
{
public:
	int RecordNumber;
	int RecordLength;
};
#pragma pack(pop)


//-- var, const, procedure ---------------------------------------------------
static constexpr System::Int8 SHP_NULL = System::Int8(0x0);
static constexpr System::Int8 SHP_POINT = System::Int8(0x1);
static constexpr System::Int8 SHP_POLYLINE = System::Int8(0x3);
static constexpr System::Int8 SHP_POLYGON = System::Int8(0x5);
static constexpr System::Int8 SHP_MULTIPOINT = System::Int8(0x8);
static constexpr System::Int8 SHP_POINTZ = System::Int8(0xb);
static constexpr System::Int8 SHP_POLYLINEZ = System::Int8(0xd);
static constexpr System::Int8 SHP_POLYGONZ = System::Int8(0xf);
static constexpr System::Int8 SHP_MULTIPOINTZ = System::Int8(0x12);
static constexpr System::Int8 SHP_POINTM = System::Int8(0x15);
static constexpr System::Int8 SHP_POLYLINEM = System::Int8(0x17);
static constexpr System::Int8 SHP_POLYGONM = System::Int8(0x19);
static constexpr System::Int8 SHP_MULTIPOINTM = System::Int8(0x1c);
static constexpr System::Int8 SHP_MULTIPATCH = System::Int8(0x1f);
static constexpr int TeeSHPMaxRandom = int(0xf4240);
extern DELPHI_PACKAGE void __fastcall LoadMap(Fmxtee::Series::Map::TMapSeries* const Series, System::Classes::TStream* const ShpStream, System::Classes::TStream* const ShxStream, Data::Db::TDataSet* const ADataset = (Data::Db::TDataSet*)(0x0), const System::UnicodeString FieldName = System::UnicodeString(), const System::UnicodeString FieldValue = System::UnicodeString(), bool ClearSeries = true, const System::UnicodeString FieldSize = System::UnicodeString())/* overload */;
extern DELPHI_PACKAGE void __fastcall LoadMap(Fmxtee::Series::Map::TMapSeries* const Series, const System::UnicodeString FileName, Data::Db::TDataSet* const ADataset = (Data::Db::TDataSet*)(0x0), const System::UnicodeString FieldName = System::UnicodeString(), const System::UnicodeString FieldValue = System::UnicodeString(), bool ClearSeries = true, const System::UnicodeString FieldSize = System::UnicodeString())/* overload */;
}	/* namespace Shapefile */
}	/* namespace Import */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_IMPORT_SHAPEFILE)
using namespace Fmxtee::Import::Shapefile;
#endif
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
#endif	// Fmxtee_Import_ShapefileHPP
