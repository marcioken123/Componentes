// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFiles.pas' rev: 34.00 (Windows)

#ifndef LmdfilesHPP
#define LmdfilesHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <System.Types.hpp>
#include <LMDRTLConst.hpp>
#include <LMDTypes.hpp>
#include <LMDProcs.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfiles
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDFileStream;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDFileStream : public System::Classes::THandleStream
{
	typedef System::Classes::THandleStream inherited;
	
public:
	__fastcall TLMDFileStream(const Lmdtypes::TLMDString FileName, System::Word Mode)/* overload */;
	__fastcall TLMDFileStream(const Lmdtypes::TLMDString FileName, System::Word Mode, unsigned Rights)/* overload */;
	__fastcall virtual ~TLMDFileStream();
};

#pragma pack(pop)

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE NativeUInt __fastcall LMDFileOpen(const Lmdtypes::TLMDString FileName, unsigned Mode);
extern DELPHI_PACKAGE NativeUInt __fastcall LMDFileCreate(const Lmdtypes::TLMDString FileName);
extern DELPHI_PACKAGE Lmdtypes::TLMDBOM __fastcall LMDReadBOMEx(System::Classes::TStream* const AStream, int &ABomLen, bool ARestorePos = false);
extern DELPHI_PACKAGE Lmdtypes::TLMDBOM __fastcall LMDReadBOM(System::Classes::TStream* const AStream, bool ARestorePos = false);
extern DELPHI_PACKAGE void __fastcall LMDWriteBOM(System::Classes::TStream* const AStream, const Lmdtypes::TLMDBOM ABOM);
extern DELPHI_PACKAGE int __fastcall LMDFileAge(const Lmdtypes::TLMDString FileName);
extern DELPHI_PACKAGE bool __fastcall LMDFileExists(const Lmdtypes::TLMDString FileName);
}	/* namespace Lmdfiles */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFILES)
using namespace Lmdfiles;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfilesHPP
