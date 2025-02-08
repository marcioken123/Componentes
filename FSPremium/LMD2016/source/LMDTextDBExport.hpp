// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDTextDBExport.pas' rev: 31.00 (Windows)

#ifndef LmdtextdbexportHPP
#define LmdtextdbexportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Data.DB.hpp>
#include <LMDText.hpp>
#include <LMDTextObject.hpp>
#include <LMDWriter.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdtextdbexport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDTextDBExport;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDConverterEvent)(System::TObject* Sender, System::UnicodeString &eventText);

typedef void __fastcall (__closure *TLMDExportImageEvent)(System::TObject* Sender, System::UnicodeString &S, int RecNo, System::Classes::TMemoryStream* val);

typedef void __fastcall (__closure *TLMDExportUnknownEvent)(System::TObject* Sender, System::UnicodeString &S, int RecNo, Data::Db::TBlobField* field);

enum DECLSPEC_DENUM TLMDExportImage : unsigned char { eiNo, eiFile, eiData, eiCustom };

class PASCALIMPLEMENTATION TLMDTextDBExport : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	Data::Db::TDataLink* FDataLink;
	System::UnicodeString FRepDetect;
	Lmdtextobject::TLMDTextObject* FText;
	Lmdwriter::TLMDWriter* FTextWriter;
	Lmdwriter::TLMDWriterClass FWriterClass;
	System::Classes::TStrings* FLines;
	bool FFirstRepeat;
	TLMDConverterEvent FOnRecord;
	TLMDConverterEvent FOnData;
	System::Byte FMode;
	TLMDExportImage FExportImages;
	TLMDExportImageEvent FOnExportImage;
	TLMDExportUnknownEvent FOnExportUnknown;
	Lmdtext::TLMDGetVariableEvent FOnGetVariable;
	void __fastcall SetDataSource(Data::Db::TDataSource* aValue);
	Data::Db::TDataSource* __fastcall GetDatasource(void);
	void __fastcall SetLines(System::Classes::TStrings* aValue);
	System::UnicodeString __fastcall GetWriterClass(void);
	void __fastcall SetWriterClass(System::UnicodeString aValue);
	bool __fastcall IsNotDefault(void);
	
protected:
	int __fastcall getFieldCount(void);
	Data::Db::TField* __fastcall getField(int Index);
	System::UnicodeString __fastcall getFieldName(int Index);
	System::UnicodeString __fastcall getFieldString(int Index, int RecNo);
	System::UnicodeString __fastcall exportImage(Data::Db::TBlobField* Field, int RecNo);
	void __fastcall First(void);
	void __fastcall Next(void);
	virtual void __fastcall WriteToStream(System::Classes::TStream* Stream);
	virtual void __fastcall WriteToFile(System::UnicodeString filename);
	virtual void __fastcall WriteToStringList(System::Classes::TStrings* &stringlist);
	void __fastcall InitOutput(void);
	void __fastcall DoGraphicError(System::TObject* Sender, Vcl::Graphics::TPicture* aPicture, const System::UnicodeString aFileName, int aImageIndex);
	System::UnicodeString __fastcall DoGetVariable(System::TObject* Sender, const System::UnicodeString aVarName);
	void __fastcall DoRepeat(System::TObject* Sender, int aNumber);
	__property System::Byte Mode = {read=FMode, nodefault};
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDTextDBExport(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDTextDBExport(void);
	virtual void __fastcall SaveToStream(System::Classes::TStream* Stream);
	virtual void __fastcall SaveToFile(System::UnicodeString filename);
	virtual void __fastcall SaveToStringList(System::Classes::TStrings* &stringlist);
	
__published:
	__property About = {default=0};
	__property Data::Db::TDataSource* DataSource = {read=GetDatasource, write=SetDataSource};
	__property System::Classes::TStrings* Lines = {read=FLines, write=SetLines};
	__property System::UnicodeString Writer = {read=GetWriterClass, write=SetWriterClass, stored=IsNotDefault};
	__property TLMDExportImage ExportImages = {read=FExportImages, write=FExportImages, default=0};
	__property TLMDConverterEvent OnData = {read=FOnData, write=FOnData};
	__property TLMDConverterEvent OnRecord = {read=FOnRecord, write=FOnRecord};
	__property TLMDExportImageEvent OnExportImage = {read=FOnExportImage, write=FOnExportImage};
	__property TLMDExportUnknownEvent OnExportUnknown = {read=FOnExportUnknown, write=FOnExportUnknown};
	__property Lmdtext::TLMDGetVariableEvent OnGetVariable = {read=FOnGetVariable, write=FOnGetVariable};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdtextdbexport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDTEXTDBEXPORT)
using namespace Lmdtextdbexport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdtextdbexportHPP
