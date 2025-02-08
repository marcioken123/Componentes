// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDFSSupport.pas' rev: 31.00 (Windows)

#ifndef LmdfssupportHPP
#define LmdfssupportHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdfssupport
{
//-- forward type declarations -----------------------------------------------
//-- type declarations -------------------------------------------------------
//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebGetAppDataPath(void);
extern DELPHI_PACKAGE void __fastcall LMDWebCreateDirs(const System::UnicodeString szDir);
extern DELPHI_PACKAGE bool __fastcall LMDWebStreamToFile(const System::UnicodeString szName, System::Classes::TStream* Stream);
extern DELPHI_PACKAGE bool __fastcall LMDWebStringToStream(System::Classes::TStream* Stream, const System::UnicodeString Data, int DataSize = 0xffffffff);
extern DELPHI_PACKAGE bool __fastcall LMDWebStreamToString(System::Classes::TStream* Stream, System::UnicodeString &Data, int DataSize = 0xffffffff);
extern DELPHI_PACKAGE bool __fastcall LMDWebWriteFileFromString(const System::UnicodeString szName, const System::UnicodeString AData, int ADataSize = 0xffffffff, System::TDateTime AFileTime = 0.000000E+00, __int64 ARangeStart = 0LL);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebCreateFileName(const System::UnicodeString szPath, const System::UnicodeString szDefFileName, const System::UnicodeString URL, bool bCreateDirs);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebAddSlash(const System::UnicodeString szStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebDeleteSlash(const System::UnicodeString szStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebAddBackSlash(const System::UnicodeString szStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebDeleteBackSlash(const System::UnicodeString szStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebDeleteFirstBackSlash(const System::UnicodeString szStr);
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDWebGetWebFileURL(const System::UnicodeString URL, bool bExtraInfo = true);
extern DELPHI_PACKAGE bool __fastcall LMDWebFileSetDate(const System::UnicodeString FileName, System::TDateTime ATimeStamp);
extern DELPHI_PACKAGE __int64 __fastcall LMDWebGetFileSize(const System::UnicodeString FileName);
}	/* namespace Lmdfssupport */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDFSSUPPORT)
using namespace Lmdfssupport;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdfssupportHPP
