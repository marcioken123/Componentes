// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBFReader.pas' rev: 31.00 (Windows)

#ifndef LmddbfreaderHPP
#define LmddbfreaderHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Controls.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbfreader
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBFFieldDef;
class DELPHICLASS TLMDDBFFieldDefs;
class DELPHICLASS TLMDDBFHeader;
class DELPHICLASS TLMDDBF;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDBFFieldType : unsigned char { ftChar, ftNumber, ftBoolean, ftMemo, ftDate, ftFloat, ftPattern };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBFFieldDef : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FFieldName;
	TLMDDBFFieldType FFieldType;
	int FFieldOffset;
	System::Word FFieldSize;
	
public:
	__fastcall virtual TLMDDBFFieldDef(System::Classes::TCollection* Collection);
	void __fastcall Load(System::Classes::TStream* aStream);
	void __fastcall Save(System::Classes::TStream* aStream);
	__property System::UnicodeString FieldName = {read=FFieldName, write=FFieldName};
	__property TLMDDBFFieldType FieldType = {read=FFieldType, write=FFieldType, nodefault};
	__property int FieldOffset = {read=FFieldOffset, write=FFieldOffset, nodefault};
	__property System::Word FieldSize = {read=FFieldSize, write=FFieldSize, nodefault};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDDBFFieldDef(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBFFieldDefs : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDDBFFieldDef* operator[](int index) { return this->Item[index]; }
	
private:
	HIDESBASE TLMDDBFFieldDef* __fastcall GetItem(int Index);
	
public:
	__fastcall TLMDDBFFieldDefs(void);
	HIDESBASE TLMDDBFFieldDef* __fastcall Add(void);
	__property TLMDDBFFieldDef* Item[int index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDDBFFieldDefs(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDDBFHeader : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Byte FVersion;
	System::TDate FModified;
	int FRecordCount;
	System::Word FFirstRecordOffset;
	System::Word FRecordSize;
	bool FCDXPresent;
	TLMDDBFFieldDefs* FFieldDefs;
	
public:
	__fastcall TLMDDBFHeader(void);
	__fastcall virtual ~TLMDDBFHeader(void);
	void __fastcall Load(System::Classes::TStream* aStream);
	void __fastcall Save(System::Classes::TStream* aStream);
	__property System::Byte Version = {read=FVersion, write=FVersion, nodefault};
	__property System::TDate Modified = {read=FModified, write=FModified};
	__property int RecordCount = {read=FRecordCount, write=FRecordCount, nodefault};
	__property System::Word FirstRecordOffset = {read=FFirstRecordOffset, write=FFirstRecordOffset, nodefault};
	__property System::Word RecordSize = {read=FRecordSize, write=FRecordSize, nodefault};
	__property bool CDXPresent = {read=FCDXPresent, write=FCDXPresent, nodefault};
	__property TLMDDBFFieldDefs* FieldDefs = {read=FFieldDefs};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDDBF : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TStream* FStream;
	TLMDDBFHeader* FHeader;
	int FRecord;
	
public:
	__fastcall TLMDDBF(System::Classes::TStream* aStream);
	__fastcall virtual ~TLMDDBF(void);
	bool __fastcall Eof(void);
	bool __fastcall Bof(void);
	void __fastcall MoveFirst(void);
	void __fastcall MoveLast(void);
	void __fastcall MoveNext(void);
	void __fastcall MovePrev(void);
	void __fastcall ReadField(int FieldNo, void *Buffer, int Count);
	System::UnicodeString __fastcall ReadFieldAsString(int FieldNo);
	__property TLMDDBFHeader* Header = {read=FHeader};
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbfreader */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBFREADER)
using namespace Lmddbfreader;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbfreaderHPP
