// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDMapFile.pas' rev: 31.00 (Windows)

#ifndef LmdmapfileHPP
#define LmdmapfileHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDProcs.hpp>
#include <LMDZLib.hpp>
#include <LMDRTLConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdmapfile
{
//-- forward type declarations -----------------------------------------------
struct TLMDMapUnit;
struct TLMDMapProc;
struct TLMDMapLine;
class DELPHICLASS TLMDMapFile;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDMapUnit
{
public:
	unsigned StartAddr;
	unsigned Length;
	int NameIndex;
	int LineNumberBegin;
	int LineNumberEnd;
};


struct DECLSPEC_DRECORD TLMDMapProc
{
public:
	unsigned Addr;
	int ClassNameIndex;
	int NameIndex;
};


struct DECLSPEC_DRECORD TLMDMapLine
{
public:
	unsigned Addr;
	unsigned Number;
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDMapFile : public System::TObject
{
	typedef System::TObject inherited;
	
	
private:
	typedef System::DynamicArray<TLMDMapLine> _TLMDMapFile__1;
	
	typedef System::DynamicArray<System::UnicodeString> _TLMDMapFile__2;
	
	typedef System::DynamicArray<TLMDMapProc> _TLMDMapFile__3;
	
	typedef System::DynamicArray<TLMDMapUnit> _TLMDMapFile__4;
	
	
private:
	_TLMDMapFile__1 FMapLines;
	_TLMDMapFile__2 FMapNames;
	_TLMDMapFile__3 FMapProcs;
	_TLMDMapFile__4 FMapUnits;
	System::Classes::TStringList* FBuffer;
	int FBufferIndex;
	
protected:
	__fastcall TLMDMapFile(void);
	
private:
	bool __fastcall FindSegmentBegin(System::UnicodeString ASegmentName, bool AReset = true);
	int __fastcall LineIndex(const unsigned AAddress);
	bool __fastcall LoadParsedInfo(void);
	System::UnicodeString __fastcall MapFileName(void);
	unsigned __fastcall MapNameIndex(System::UnicodeString AName);
	bool __fastcall ParseAddress(System::UnicodeString &ALine, System::UnicodeString AStopString, unsigned &AAddress, System::WideChar APrefix = (System::WideChar)(0x24));
	bool __fastcall ParseLineNumbers(System::UnicodeString &ALine, unsigned &AType, unsigned &AStartAddress, unsigned &ALineNumber);
	bool __fastcall ParseMapFile(void);
	bool __fastcall ParseProcedure(System::UnicodeString ALine, unsigned &AType, unsigned &AStartAddress, System::UnicodeString &AProcedureName);
	void __fastcall ParseProcName(System::UnicodeString AMapName, System::UnicodeString &AClassName, System::UnicodeString &AProcName);
	bool __fastcall ParseUnit(System::UnicodeString ALine, unsigned &AType, unsigned &AStartAddress, unsigned &ALength, System::UnicodeString &AUnitName);
	int __fastcall ProcedureIndex(const unsigned AAddress);
	bool __fastcall SaveParsedInfo(void);
	int __fastcall UnitIndex(const unsigned AAddress);
	void __fastcall SkipBlankLines(void);
	
public:
	__fastcall virtual ~TLMDMapFile(void);
	__classmethod TLMDMapFile* __fastcall Instance();
	bool __fastcall LineExists(const unsigned AAddress);
	System::UnicodeString __fastcall LineNumber(const unsigned AAddress);
	int __fastcall LineNumberAsInt(const unsigned AAddress);
	unsigned __fastcall MapFileAddress(const void * AAddress);
	bool __fastcall ProcedureExists(const unsigned AAddress);
	System::UnicodeString __fastcall ProcedureName(const unsigned AAddress);
	bool __fastcall UnitExists(const unsigned AAddress);
	HIDESBASE System::UnicodeString __fastcall UnitName(const unsigned AAddress);
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdmapfile */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDMAPFILE)
using namespace Lmdmapfile;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdmapfileHPP
