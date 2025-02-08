// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDBExport.pas' rev: 31.00 (Windows)

#ifndef LmddbexportHPP
#define LmddbexportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Data.DB.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmddbexport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDBExport;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDConverterEvent)(System::TObject* Sender, System::UnicodeString &eventText);

typedef void __fastcall (__closure *TLMDExportImageEvent)(System::TObject* Sender, System::UnicodeString &S, int RecNo, System::Classes::TMemoryStream* val);

typedef void __fastcall (__closure *TLMDExportUnknownEvent)(System::TObject* Sender, System::UnicodeString &S, int RecNo, Data::Db::TBlobField* field);

enum DECLSPEC_DENUM TLMDExportImage : unsigned char { eiNo, eiFile, eiData, eiCustom };

enum DECLSPEC_DENUM TLMDConverterOutput : unsigned char { coPlain, coHTML, coHTMLTable };

class PASCALIMPLEMENTATION TLMDDBExport : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Data::Db::TDataLink* FDataLink;
	System::UnicodeString FRecordDelimiter;
	System::UnicodeString FDelimiter;
	TLMDConverterEvent FOnHeader;
	TLMDConverterEvent FOnRecord;
	TLMDConverterEvent FOnDataHeader;
	TLMDConverterEvent FOnData;
	System::UnicodeString FOutStart;
	System::UnicodeString FOutEnd;
	System::UnicodeString FDataStart;
	System::UnicodeString FDataEnd;
	System::UnicodeString FFieldStart;
	System::UnicodeString FFieldEnd;
	System::UnicodeString FRecordStart;
	System::UnicodeString FRecordEnd;
	System::Byte FMode;
	TLMDExportImage FExportImages;
	TLMDConverterOutput FConverterOut;
	TLMDExportImageEvent FOnExportImage;
	TLMDExportUnknownEvent FOnExportUnknown;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDatasource(void);
	
protected:
	int __fastcall getFieldCount(void);
	Data::Db::TField* __fastcall getField(int Index);
	System::UnicodeString __fastcall getFieldName(int Index);
	System::UnicodeString __fastcall getFieldString(int Index, int RecNo);
	System::UnicodeString __fastcall exportImage(Data::Db::TBlobField* Field, int RecNo);
	virtual System::UnicodeString __fastcall getRecordStart(void);
	virtual System::UnicodeString __fastcall getRecordEnd(void);
	System::UnicodeString __fastcall getFieldStart(void);
	System::UnicodeString __fastcall getFieldEnd(void);
	virtual System::UnicodeString __fastcall getDataHeader(void);
	virtual System::UnicodeString __fastcall getDataStart(void);
	virtual System::UnicodeString __fastcall getDataEnd(void);
	System::UnicodeString __fastcall getOutStart(void);
	System::UnicodeString __fastcall getOutEnd(void);
	virtual System::UnicodeString __fastcall getRecord(int RecNo);
	void __fastcall First(void);
	void __fastcall Next(void);
	virtual void __fastcall WriteToStream(System::Classes::TStream* Stream);
	virtual void __fastcall WriteToFile(System::UnicodeString filename);
	virtual void __fastcall WriteToStringList(System::Classes::TStrings* &stringlist);
	void __fastcall InitOutput(void);
	__property System::Byte Mode = {read=FMode, nodefault};
	__property System::UnicodeString RecordStart = {read=FRecordStart, write=FRecordStart};
	__property System::UnicodeString RecordEnd = {read=FRecordEnd, write=FRecordEnd};
	__property System::UnicodeString FieldStart = {read=FFieldStart, write=FFieldStart};
	__property System::UnicodeString FieldEnd = {read=FFieldEnd, write=FFieldEnd};
	__property System::UnicodeString DataStart = {read=FDataStart, write=FDataStart};
	__property System::UnicodeString DataEnd = {read=FDataEnd, write=FDataEnd};
	__property System::UnicodeString OutStart = {read=FOutStart, write=FOutStart};
	__property System::UnicodeString OutEnd = {read=FOutEnd, write=FOutEnd};
	
public:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	__fastcall virtual TLMDDBExport(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDDBExport(void);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToFile(System::UnicodeString filename);
	virtual void __fastcall SaveToStringList(System::Classes::TStrings* &stringlist);
	
__published:
	__property About = {default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDatasource, write=SetDataSource};
	__property System::UnicodeString Delimiter = {read=FDelimiter, write=FDelimiter};
	__property TLMDExportImage ExportImages = {read=FExportImages, write=FExportImages, default=0};
	__property System::UnicodeString RecordDelimiter = {read=FRecordDelimiter, write=FRecordDelimiter};
	__property TLMDConverterOutput Output = {read=FConverterOut, write=FConverterOut, default=0};
	__property TLMDConverterEvent OnDataHeader = {read=FOnDataHeader, write=FOnDataHeader};
	__property TLMDConverterEvent OnHeader = {read=FOnHeader, write=FOnHeader};
	__property TLMDConverterEvent OnData = {read=FOnData, write=FOnData};
	__property TLMDConverterEvent OnRecord = {read=FOnRecord, write=FOnRecord};
	__property TLMDExportImageEvent OnExportImage = {read=FOnExportImage, write=FOnExportImage};
	__property TLMDExportUnknownEvent OnExportUnknown = {read=FOnExportUnknown, write=FOnExportUnknown};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmddbexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDBEXPORT)
using namespace Lmddbexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddbexportHPP
