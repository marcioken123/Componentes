// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShUtils.pas' rev: 34.00 (Windows)

#ifndef LmdshutilsHPP
#define LmdshutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Winapi.ShlObj.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshutils
{
//-- forward type declarations -----------------------------------------------
struct TLMDChangeFilterStruct;
//-- type declarations -------------------------------------------------------
typedef Vcl::Extctrls::TBalloonFlags TLMDBalloonFlags;

typedef _NOTIFYICONDATAW TLMDNotifyIconData;

enum DECLSPEC_DENUM TLMDSystemFolder : unsigned char { sfDesktop, sfMyComputer, sfProgramMenu, sfControlPanel, sfPrinters, sfPersonal, sfFavorites, sfStartup, sfRecentDocuments, sfSendto, sfRecycleBin, sfStartMenu, sfDesktopDirectory, sfNetworkFolder, sfNetworkNeighborhood, sfInternet, sfFonts, sfTemplates, sfCommonStartMenu, sfCommonPrograms, sfCommonStartup, sfCommonDesktopDirectory, sfAppData, sfPrintHood, sfAltStartup, sfCommonAltStartup, sfCommonFavorites, sfInternetCache, sfCookies, sfHistory, sfMyVideo, sfCommonVideo, sfMyPictures, sfCommonPictures, sfMyMusic, sfCommonMusic, sfMyDocuments, sfAdminTools, sfCommonAdminTools, sfBurnArea, sfProfile, sfProfiles, sfProgramFiles, sfCommonProgramFiles, sfWindows, sfSystem, sfCustomFolder };

typedef TLMDSystemFolder TLMDRootFolder;

typedef System::UnicodeString TLMDRoot;

struct DECLSPEC_DRECORD TLMDChangeFilterStruct
{
public:
	unsigned cbSize;
	unsigned ExtStatus;
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE System::UnicodeString __fastcall LMDGetSpecialFolderPath(const TLMDSystemFolder Folder);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDGetRootFolderID(TLMDRoot aValue)/* overload */;
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall LMDGetRootFolderID(TLMDSystemFolder aValue)/* overload */;
extern DELPHI_PACKAGE unsigned __fastcall LMDSHGetFileInfo(const System::UnicodeString pszPath, unsigned dwFileAttributes, /* out */ _SHFILEINFOW &psfi, unsigned uFlags)/* overload */;
extern DELPHI_PACKAGE unsigned __fastcall LMDSHGetFileInfo(Winapi::Shlobj::PItemIDList aPIDL, unsigned dwFileAttributes, /* out */ _SHFILEINFOW &psfi, unsigned uFlags)/* overload */;
extern DELPHI_PACKAGE unsigned __fastcall LMDExtractIconEx(const System::UnicodeString lpszFile, int nIconIndex, HICON &phiconLarge, HICON &phiconSmall);
extern DELPHI_PACKAGE int __fastcall LMDGetIconCount(const System::UnicodeString lpszFile);
extern DELPHI_PACKAGE __int64 __fastcall LMDGetFileSize(const Lmdtypes::TLMDString FileName);
extern DELPHI_PACKAGE bool __fastcall LMDBrowseForFolder(int Handle, System::UnicodeString Caption, System::UnicodeString &strFolder);
extern DELPHI_PACKAGE bool __fastcall LMDBrowseForFolderEx(int Handle, System::UnicodeString Caption, unsigned AddFlags, unsigned RemoveFlags, System::UnicodeString &strFolder);
extern DELPHI_PACKAGE bool __fastcall LMDIsElevated(void);
extern DELPHI_PACKAGE bool __fastcall LMDRunElevated(HWND AWindow, const Lmdtypes::TLMDString APath, const Lmdtypes::TLMDString AParams, const Lmdtypes::TLMDString AWorkDir);
extern DELPHI_PACKAGE bool __fastcall LMDChangeWindowMessageFilterEx(HWND AWindow, System::Word AMessage, bool AAddMessage, TLMDChangeFilterStruct &pChangeFilterStruct);
extern DELPHI_PACKAGE bool __fastcall LMDChangeWindowMessageFilter(System::Word AMessage, bool AAddMessage);
}	/* namespace Lmdshutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHUTILS)
using namespace Lmdshutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshutilsHPP
