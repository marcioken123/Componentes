// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCSVImport.pas' rev: 31.00 (Windows)

#ifndef LmdcsvimportHPP
#define LmdcsvimportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDImport.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcsvimport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDCSVImport;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDOnCSVMissingToken)(System::TObject* Sender, __int64 tokenNum, System::UnicodeString &token);

typedef void __fastcall (__closure *TLMDOnCSVAdditionalToken)(System::TObject* Sender, __int64 tokenNum, System::UnicodeString token);

typedef void __fastcall (__closure *TLMDOnCSVToken)(System::TObject* Sender, System::UnicodeString &token);

typedef void __fastcall (__closure *TLMDOnCSVRecord)(System::TObject* Sender, __int64 recNo);

class PASCALIMPLEMENTATION TLMDCSVImport : public Lmdimport::TLMDImport
{
	typedef Lmdimport::TLMDImport inherited;
	
private:
	System::Classes::TStringList* FCurrentRecord;
	System::UnicodeString FRecordDelimiter;
	System::UnicodeString FFieldDelimiter;
	TLMDOnCSVMissingToken FOnMissingToken;
	TLMDOnCSVAdditionalToken FOnAdditionalToken;
	TLMDOnCSVToken FOnToken;
	TLMDOnCSVRecord FOnProcessRecord;
	
protected:
	virtual __int64 __fastcall getTokenCount(void) = 0 ;
	virtual void __fastcall ProcessToken(const System::UnicodeString aToken, __int64 aTokenNum);
	virtual void __fastcall ProcessTokens(void);
	virtual bool __fastcall ProcessRecordStart(void);
	virtual void __fastcall ProcessRecordEnd(void);
	__property System::Classes::TStringList* CurrentRecord = {read=FCurrentRecord};
	
public:
	virtual void __fastcall ImportStream(System::Classes::TStream* aStream);
	
__published:
	__property System::UnicodeString FieldDelimiter = {read=FFieldDelimiter, write=FFieldDelimiter};
	__property System::UnicodeString RecordDelimiter = {read=FRecordDelimiter, write=FRecordDelimiter};
	__property TLMDOnCSVToken OnToken = {read=FOnToken, write=FOnToken};
	__property TLMDOnCSVRecord OnProcessRecord = {read=FOnProcessRecord, write=FOnProcessRecord};
	__property TLMDOnCSVMissingToken OnMissingToken = {read=FOnMissingToken, write=FOnMissingToken};
	__property TLMDOnCSVAdditionalToken OnAdditionalToken = {read=FOnAdditionalToken, write=FOnAdditionalToken};
public:
	/* TLMDImport.Create */ inline __fastcall virtual TLMDCSVImport(System::Classes::TComponent* aOwner) : Lmdimport::TLMDImport(aOwner) { }
	/* TLMDImport.Destroy */ inline __fastcall virtual ~TLMDCSVImport(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdcsvimport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCSVIMPORT)
using namespace Lmdcsvimport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcsvimportHPP
