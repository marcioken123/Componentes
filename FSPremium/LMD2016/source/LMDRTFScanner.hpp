// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRTFScanner.pas' rev: 31.00 (Windows)

#ifndef LmdrtfscannerHPP
#define LmdrtfscannerHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDRTFTape.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdrtfscanner
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDRTFScanner;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDRTFScanner : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	bool FEOF;
	System::Classes::TStream* FStream;
	Lmdrtftape::TLMDRTFTape* FTape;
	System::WideChar __fastcall GetNextChar(void);
	void __fastcall ParseControlWord(void);
	void __fastcall ParsePlainText(void);
	__property bool EOF = {read=FEOF, nodefault};
	
public:
	__fastcall TLMDRTFScanner(System::Classes::TStream* aStream, Lmdrtftape::TLMDRTFTape* aTape);
	void __fastcall Execute(void);
public:
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDRTFScanner(void) { }
	
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdrtfscanner */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRTFSCANNER)
using namespace Lmdrtfscanner;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrtfscannerHPP
