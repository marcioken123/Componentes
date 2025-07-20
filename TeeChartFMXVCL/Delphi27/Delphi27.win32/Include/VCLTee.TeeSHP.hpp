// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'VCLTee.TeeSHP.pas' rev: 34.00 (Windows)

#ifndef Vcltee_TeeshpHPP
#define Vcltee_TeeshpHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <VCLTee.TeeMapSeries.hpp>
#include <VCLTee.TeCanvas.hpp>
#include <VCLTee.TeeProcs.hpp>
#include <VCLTee.TeEngine.hpp>
#include <Data.DB.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Vcltee
{
namespace Teeshp
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
static const System::Int8 SHP_NULL = System::Int8(0x0);
static const System::Int8 SHP_POINT = System::Int8(0x1);
static const System::Int8 SHP_POLYLINE = System::Int8(0x3);
static const System::Int8 SHP_POLYGON = System::Int8(0x5);
static const System::Int8 SHP_MULTIPOINT = System::Int8(0x8);
static const System::Int8 SHP_POINTZ = System::Int8(0xb);
static const System::Int8 SHP_POLYLINEZ = System::Int8(0xd);
static const System::Int8 SHP_POLYGONZ = System::Int8(0xf);
static const System::Int8 SHP_MULTIPOINTZ = System::Int8(0x12);
static const System::Int8 SHP_POINTM = System::Int8(0x15);
static const System::Int8 SHP_POLYLINEM = System::Int8(0x17);
static const System::Int8 SHP_POLYGONM = System::Int8(0x19);
static const System::Int8 SHP_MULTIPOINTM = System::Int8(0x1c);
static const System::Int8 SHP_MULTIPATCH = System::Int8(0x1f);
static const int TeeSHPMaxRandom = int(0xf4240);
extern DELPHI_PACKAGE void __fastcall LoadMap(Vcltee::Teemapseries::TMapSeries* const Series, System::Classes::TStream* const ShpStream, System::Classes::TStream* const ShxStream, Data::Db::TDataSet* const ADataset = (Data::Db::TDataSet*)(0x0), const System::UnicodeString FieldName = System::UnicodeString(), const System::UnicodeString FieldValue = System::UnicodeString(), bool ClearSeries = true, const System::UnicodeString FieldSize = System::UnicodeString())/* overload */;
extern DELPHI_PACKAGE void __fastcall LoadMap(Vcltee::Teemapseries::TMapSeries* const Series, const System::UnicodeString FileName, Data::Db::TDataSet* const ADataset = (Data::Db::TDataSet*)(0x0), const System::UnicodeString FieldName = System::UnicodeString(), const System::UnicodeString FieldValue = System::UnicodeString(), bool ClearSeries = true, const System::UnicodeString FieldSize = System::UnicodeString())/* overload */;
}	/* namespace Teeshp */
}	/* namespace Vcltee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE_TEESHP)
using namespace Vcltee::Teeshp;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_VCLTEE)
using namespace Vcltee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Vcltee_TeeshpHPP
