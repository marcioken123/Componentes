// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'FMXTee.Dataset.pas' rev: 34.00 (Windows)

#ifndef Fmxtee_DatasetHPP
#define Fmxtee_DatasetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Data.DB.hpp>
#include <System.Classes.hpp>
#include <System.Generics.Collections.hpp>
#include <System.AnsiStrings.hpp>
#include <FMXTee.Procs.hpp>
#include <FMXTee.Engine.hpp>
#include <FMXTee.Chart.hpp>
#include <System.Generics.Defaults.hpp>
#include <System.Types.hpp>
#include <System.SysUtils.hpp>

//-- user supplied -----------------------------------------------------------

namespace Fmxtee
{
namespace Dataset
{
//-- forward type declarations -----------------------------------------------
struct TSeriesPoint;
struct TRecInfo;
class DELPHICLASS TTeeDataSet;
class DELPHICLASS TSeriesDataSet;
class DELPHICLASS TChartDataSet;
//-- type declarations -------------------------------------------------------
typedef TSeriesPoint *PSeriesPoint;

struct DECLSPEC_DRECORD TSeriesPoint
{
public:
	unsigned Color;
	double X;
	System::StaticArray<double, 11> Values;
	System::SmallString<128> ALabel;
};


typedef System::StaticArray<TSeriesPoint, 1> TSeriesPoints;

typedef TSeriesPoints *PSeriesPoints;

typedef TRecInfo *PRecInfo;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TRecInfo
{
public:
	int Bookmark;
	Data::Db::TBookmarkFlag BookmarkFlag;
};
#pragma pack(pop)


class PASCALIMPLEMENTATION TTeeDataSet : public Data::Db::TDataSet
{
	typedef Data::Db::TDataSet inherited;
	
private:
	System::Generics::Collections::TList__1<int>* FBookMarks;
	int FCurRec;
	int FLastBookmark;
	PRecInfo __fastcall BufferRecord(const System::PByte Buffer);
	void __fastcall DoCreateField(const System::UnicodeString AFieldName, Data::Db::TFieldType AType, int ASize);
	void __fastcall DoInternalGotoBookmark(int BookMark);
	bool __fastcall FieldsAreAutomatic();
	int __fastcall RecBufSize();
	
protected:
	void __fastcall AddSeriesFields(Fmxtee::Engine::TChartSeries* const Series, bool PrefixSeriesName = false);
	virtual System::PByte __fastcall AllocRecordBuffer();
	virtual void __fastcall FreeRecordBuffer(System::PByte &Buffer);
	void __fastcall DoAddSeriesPoint(const TSeriesPoint &Buffer, Fmxtee::Engine::TChartSeries* const Series);
	virtual void __fastcall DoFillBuffer(const System::PByte Buffer) = 0 ;
	void __fastcall FillSeriesBuffer(TSeriesPoint &Buffer, Fmxtee::Engine::TChartSeries* const Series);
	virtual void __fastcall GetBookmarkData(System::PByte Buffer, System::DynamicArray<System::Byte> Data)/* overload */;
	virtual Data::Db::TBookmarkFlag __fastcall GetBookmarkFlag(System::PByte Buffer)/* overload */;
	virtual int __fastcall GetRecNo();
	virtual Data::Db::TGetResult __fastcall GetRecord(System::PByte Buffer, Data::Db::TGetMode GetMode, bool DoCheck)/* overload */;
	bool __fastcall GetSeriesBuffer(int FieldIndex, TSeriesPoint &Active, System::DynamicArray<System::Byte> &Buffer, Fmxtee::Engine::TChartSeries* const Series);
	virtual void __fastcall InternalAddRecord(System::PByte Buffer, bool Append)/* overload */;
	virtual void __fastcall InternalClose();
	virtual void __fastcall InternalDelete();
	virtual void __fastcall InternalFirst();
	virtual void __fastcall InternalGotoBookmark(System::DynamicArray<System::Byte> Bookmark)/* overload */;
	virtual void __fastcall InternalHandleException();
	virtual void __fastcall InternalInitRecord(System::PByte Buffer)/* overload */;
	virtual void __fastcall InternalLast();
	virtual void __fastcall InternalOpen();
	virtual void __fastcall InternalPost();
	virtual void __fastcall InternalSetToRecord(System::PByte Buffer)/* overload */;
	virtual bool __fastcall IsCursorOpen();
	void __fastcall PostToSeries(Fmxtee::Engine::TChartSeries* const Series, const TSeriesPoint &Buffer);
	virtual int __fastcall RecInfoOfs() = 0 ;
	virtual void __fastcall SetBookmarkData(System::PByte Buffer, System::DynamicArray<System::Byte> Data)/* overload */;
	virtual void __fastcall SetBookmarkFlag(System::PByte Buffer, Data::Db::TBookmarkFlag Value)/* overload */;
	virtual void __fastcall SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer)/* overload */;
	virtual void __fastcall SetRecNo(int Value);
	void __fastcall SetSeriesBuffer(int FieldIndex, TSeriesPoint &Active, void * Buffer, Fmxtee::Engine::TChartSeries* const Series);
	bool __fastcall ValidActiveBuffer();
	
__published:
	__property Active = {default=0};
	__property AutoCalcFields = {default=1};
	__property BeforeOpen;
	__property AfterOpen;
	__property BeforeClose;
	__property AfterClose;
	__property BeforeInsert;
	__property AfterInsert;
	__property BeforeEdit;
	__property AfterEdit;
	__property BeforePost;
	__property AfterPost;
	__property BeforeCancel;
	__property AfterCancel;
	__property BeforeDelete;
	__property AfterDelete;
	__property BeforeScroll;
	__property AfterScroll;
	__property AfterRefresh;
	__property BeforeRefresh;
	__property OnCalcFields;
	__property OnDeleteError;
	__property OnEditError;
	__property OnNewRecord;
	__property OnPostError;
public:
	/* TDataSet.Create */ inline __fastcall virtual TTeeDataSet(System::Classes::TComponent* AOwner) : Data::Db::TDataSet(AOwner) { }
	/* TDataSet.Destroy */ inline __fastcall virtual ~TTeeDataSet() { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  GetBookmarkData(NativeInt Buffer, System::DynamicArray<System::Byte> Data){ Data::Db::TDataSet::GetBookmarkData(Buffer, Data); }
	inline void __fastcall  GetBookmarkData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (System::PByte Buffer, void * Data){ Data::Db::TDataSet::GetBookmarkData(Buffer, Data); }
	inline Data::Db::TBookmarkFlag __fastcall  GetBookmarkFlag(NativeInt Buffer){ return Data::Db::TDataSet::GetBookmarkFlag(Buffer); }
	inline Data::Db::TGetResult __fastcall  GetRecord(NativeInt Buffer, Data::Db::TGetMode GetMode, bool DoCheck){ return Data::Db::TDataSet::GetRecord(Buffer, GetMode, DoCheck); }
	inline void __fastcall  InternalAddRecord(NativeInt Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  InternalAddRecord _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (void * Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  InternalGotoBookmark _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (void * Bookmark){ Data::Db::TDataSet::InternalGotoBookmark(Bookmark); }
	inline void __fastcall  InternalInitRecord(NativeInt Buffer){ Data::Db::TDataSet::InternalInitRecord(Buffer); }
	inline void __fastcall  InternalSetToRecord(NativeInt Buffer){ Data::Db::TDataSet::InternalSetToRecord(Buffer); }
	inline void __fastcall  SetBookmarkData(NativeInt Buffer, System::DynamicArray<System::Byte> Data){ Data::Db::TDataSet::SetBookmarkData(Buffer, Data); }
	inline void __fastcall  SetBookmarkData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (System::PByte Buffer, void * Data){ Data::Db::TDataSet::SetBookmarkData(Buffer, Data); }
	inline void __fastcall  SetBookmarkFlag(NativeInt Buffer, Data::Db::TBookmarkFlag Value){ Data::Db::TDataSet::SetBookmarkFlag(Buffer, Value); }
	inline void __fastcall  SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer, bool NativeFormat){ Data::Db::TDataSet::SetFieldData(Field, Buffer, NativeFormat); }
	inline void __fastcall  SetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer){ Data::Db::TDataSet::SetFieldData(Field, Buffer); }
	inline void __fastcall  SetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer, bool NativeFormat){ Data::Db::TDataSet::SetFieldData(Field, Buffer, NativeFormat); }
	
};


class PASCALIMPLEMENTATION TSeriesDataSet : public TTeeDataSet
{
	typedef TTeeDataSet inherited;
	
private:
	Fmxtee::Engine::TChartSeries* FSeries;
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	
protected:
	virtual void __fastcall DoFillBuffer(const System::PByte Buffer);
	virtual System::Word __fastcall GetRecordSize();
	virtual void __fastcall InternalAddRecord(System::PByte Buffer, bool Append)/* overload */;
	virtual void __fastcall InternalDelete();
	virtual void __fastcall InternalInitFieldDefs();
	virtual void __fastcall InternalOpen();
	virtual void __fastcall InternalPost();
	virtual bool __fastcall IsCursorOpen();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer)/* overload */;
	virtual int __fastcall GetRecordCount();
	virtual int __fastcall RecInfoOfs();
	virtual void __fastcall SetSeries(Fmxtee::Engine::TChartSeries* ASeries);
	
public:
	virtual bool __fastcall GetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> &Buffer)/* overload */;
	
__published:
	__property Fmxtee::Engine::TChartSeries* Series = {read=FSeries, write=SetSeries, stored=true};
public:
	/* TDataSet.Create */ inline __fastcall virtual TSeriesDataSet(System::Classes::TComponent* AOwner) : TTeeDataSet(AOwner) { }
	/* TDataSet.Destroy */ inline __fastcall virtual ~TSeriesDataSet() { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  InternalAddRecord(NativeInt Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  InternalAddRecord _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (void * Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer, bool NativeFormat){ Data::Db::TDataSet::SetFieldData(Field, Buffer, NativeFormat); }
	inline void __fastcall  SetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer){ Data::Db::TDataSet::SetFieldData(Field, Buffer); }
	inline void __fastcall  SetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer, bool NativeFormat){ Data::Db::TDataSet::SetFieldData(Field, Buffer, NativeFormat); }
	
public:
	inline bool __fastcall  GetFieldData(int FieldNo, System::DynamicArray<System::Byte> &Buffer){ return Data::Db::TDataSet::GetFieldData(FieldNo, Buffer); }
	inline bool __fastcall  GetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> &Buffer, bool NativeFormat){ return Data::Db::TDataSet::GetFieldData(Field, Buffer, NativeFormat); }
	inline bool __fastcall  GetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer){ return Data::Db::TDataSet::GetFieldData(Field, Buffer); }
	inline bool __fastcall  GetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (int FieldNo, void * Buffer){ return Data::Db::TDataSet::GetFieldData(FieldNo, Buffer); }
	inline bool __fastcall  GetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer, bool NativeFormat){ return Data::Db::TDataSet::GetFieldData(Field, Buffer, NativeFormat); }
	
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};


class PASCALIMPLEMENTATION TChartDataSet : public TTeeDataSet
{
	typedef TTeeDataSet inherited;
	
private:
	Fmxtee::Chart::TCustomChart* FChart;
	void __fastcall CalcFieldSeries(int Field, /* out */ int &Index, /* out */ int &Series);
	void __fastcall SetChart(Fmxtee::Chart::TCustomChart* const Value);
	void __fastcall TeeEvent(Fmxtee::Procs::TTeeEvent* Event);
	
protected:
	virtual void __fastcall DoFillBuffer(const System::PByte Buffer);
	virtual int __fastcall GetRecordCount();
	virtual System::Word __fastcall GetRecordSize();
	virtual void __fastcall InternalAddRecord(System::PByte Buffer, bool Append)/* overload */;
	virtual void __fastcall InternalDelete();
	virtual void __fastcall InternalInitFieldDefs();
	virtual void __fastcall InternalOpen();
	virtual void __fastcall InternalPost();
	virtual bool __fastcall IsCursorOpen();
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual int __fastcall RecInfoOfs();
	virtual void __fastcall SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer)/* overload */;
	
public:
	virtual bool __fastcall GetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> &Buffer)/* overload */;
	
__published:
	__property Fmxtee::Chart::TCustomChart* Chart = {read=FChart, write=SetChart};
public:
	/* TDataSet.Create */ inline __fastcall virtual TChartDataSet(System::Classes::TComponent* AOwner) : TTeeDataSet(AOwner) { }
	/* TDataSet.Destroy */ inline __fastcall virtual ~TChartDataSet() { }
	
	/* Hoisted overloads: */
	
protected:
	inline void __fastcall  InternalAddRecord(NativeInt Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  InternalAddRecord _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (void * Buffer, bool Append){ Data::Db::TDataSet::InternalAddRecord(Buffer, Append); }
	inline void __fastcall  SetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> Buffer, bool NativeFormat){ Data::Db::TDataSet::SetFieldData(Field, Buffer, NativeFormat); }
	inline void __fastcall  SetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer){ Data::Db::TDataSet::SetFieldData(Field, Buffer); }
	inline void __fastcall  SetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer, bool NativeFormat){ Data::Db::TDataSet::SetFieldData(Field, Buffer, NativeFormat); }
	
public:
	inline bool __fastcall  GetFieldData(int FieldNo, System::DynamicArray<System::Byte> &Buffer){ return Data::Db::TDataSet::GetFieldData(FieldNo, Buffer); }
	inline bool __fastcall  GetFieldData(Data::Db::TField* Field, System::DynamicArray<System::Byte> &Buffer, bool NativeFormat){ return Data::Db::TDataSet::GetFieldData(Field, Buffer, NativeFormat); }
	inline bool __fastcall  GetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer){ return Data::Db::TDataSet::GetFieldData(Field, Buffer); }
	inline bool __fastcall  GetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (int FieldNo, void * Buffer){ return Data::Db::TDataSet::GetFieldData(FieldNo, Buffer); }
	inline bool __fastcall  GetFieldData _DEPRECATED_ATTRIBUTE1("Use overloaded method instead") (Data::Db::TField* Field, void * Buffer, bool NativeFormat){ return Data::Db::TDataSet::GetFieldData(Field, Buffer, NativeFormat); }
	
private:
	void *__ITeeEventListener;	// Fmxtee::Procs::ITeeEventListener 
	
public:
	operator Fmxtee::Procs::ITeeEventListener*(void) { return (Fmxtee::Procs::ITeeEventListener*)&__ITeeEventListener; }
	
};


//-- var, const, procedure ---------------------------------------------------
static const System::Byte MaxLabelLen = System::Byte(0x80);
}	/* namespace Dataset */
}	/* namespace Fmxtee */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE_DATASET)
using namespace Fmxtee::Dataset;
#endif
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_FMXTEE)
using namespace Fmxtee;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Fmxtee_DatasetHPP
