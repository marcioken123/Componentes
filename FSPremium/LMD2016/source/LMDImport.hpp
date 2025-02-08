// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDImport.pas' rev: 31.00 (Windows)

#ifndef LmdimportHPP
#define LmdimportHPP

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

namespace Lmdimport
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDImport;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDFinishedImport)(System::TObject* Sender, __int64 recordCount);

class PASCALIMPLEMENTATION TLMDImport : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
private:
	TLMDFinishedImport FOnFinished;
	
protected:
	void __fastcall DoImportFinished(__int64 records);
	virtual bool __fastcall BeginImport(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDImport(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDImport(void);
	virtual void __fastcall ImportStream(System::Classes::TStream* aStream) = 0 ;
	void __fastcall ImportFile(System::UnicodeString aFilename);
	void __fastcall ImportStrings(System::Classes::TStrings* aStrings);
	void __fastcall ImportString(const System::UnicodeString aString);
	
__published:
	__property About = {default=0};
	__property TLMDFinishedImport OnFinished = {read=FOnFinished, write=FOnFinished};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdimport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDIMPORT)
using namespace Lmdimport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdimportHPP
