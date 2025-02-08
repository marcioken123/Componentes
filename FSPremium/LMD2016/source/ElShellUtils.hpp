// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'ElShellUtils.pas' rev: 31.00 (Windows)

#ifndef ElshellutilsHPP
#define ElshellutilsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Win.ComObj.hpp>
#include <Winapi.ActiveX.hpp>
#include <Winapi.ShellAPI.hpp>
#include <System.Win.Registry.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.CommCtrl.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ImgList.hpp>
#include <System.Classes.hpp>
#include <System.SysUtils.hpp>
#include <Vcl.Forms.hpp>
#include <System.Types.hpp>
#include <LMDTypes.hpp>
#include <LMDDebugUnit.hpp>
#include <LMDObjectList.hpp>
#include <LMDProcs.hpp>
#include <LMDSysIn.hpp>
#include <LMDUnicode.hpp>
#include <LMDStrings.hpp>
#include <ElVCLUtils.hpp>

//-- user supplied -----------------------------------------------------------
DECLARE_DINTERFACE_TYPE(IEnumExtraSearch);

namespace Elshellutils
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TElShellIconCache;
__interface IShellFolder2;
typedef System::DelphiInterface<IShellFolder2> _di_IShellFolder2;
__interface IShellDetails;
typedef System::DelphiInterface<IShellDetails> _di_IShellDetails;
struct TSHChangeNotifyEntry;
struct TSHDwordItemID;
struct TSHChangeDWORDAsIDList;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TShellFolders : unsigned char { sfoDesktopExpanded, sfoDesktop, sfoPrograms, sfoControlPanel, sfoPrinters, sfoPersonal, sfoFavorites, sfoStartup, sfoRecent, sfoSendto, sfoRecycleBin, sfoStartMenu, sfoDesktopDirectory, sfoMyComputer, sfoNetwork, sfoNetworkNeighborhood, sfoFonts, sfoTemplates, sfoCommonStartMenu, sfoCommonPrograms, sfoCommonStartup, sfoCommonDesktopDirectory, sfoAppData, sfoPrintHood, sfoLocalAppData, sfoAltStartUp, sfoCommonAltStartUp, sfoCommonFavorites, sfoInternetCache, sfoCookies, sfoHistory, sfoCommonAppData, sfoWindows, sfoSystem, sfoProgramFiles, sfoMyPictures, sfoProfile, sfoSystemX86, sfoProgramFilesX86, sfoProgramFilesCommon, sfoProgramFilesCommonX86, sfoCommonTemplates, sfoCommonDocuments, sfoCommonAdminTools, 
	sfoAdminTools, sfoCustom };

typedef unsigned TShellAttr;

#pragma pack(push,4)
class PASCALIMPLEMENTATION TElShellIconCache : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Vcl::Imglist::TCustomImageList* FSmallImages;
	
public:
	__fastcall TElShellIconCache(void);
	__fastcall virtual ~TElShellIconCache(void);
	int __fastcall AddFromPIDL(Winapi::Shlobj::PItemIDList PIDL, unsigned Flags, bool OpenIcon);
	__property Vcl::Imglist::TCustomImageList* SmallImages = {read=FSmallImages};
};

#pragma pack(pop)

typedef SHCOLUMNID *PShColumnID;

typedef _SHELLDETAILS *PShellDetails;

typedef _SHELLDETAILS TShellDetails;

typedef System::OleVariant *POleVariant;

__interface  INTERFACE_UUID("{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}") IShellFolder2  : public IShellFolder 
{
	virtual HRESULT __stdcall GetDefaultSearchGUID(/* out */ GUID &pguid) = 0 ;
	virtual HRESULT __stdcall EnumSearches(/* out */ _di_IEnumExtraSearch &ppEnum) = 0 ;
	virtual HRESULT __stdcall GetDefaultColumn(unsigned dwRes, unsigned &pSort, unsigned &pDisplay) = 0 ;
	virtual HRESULT __stdcall GetDefaultColumnState(unsigned iColumn, unsigned &pcsFlags) = 0 ;
	virtual HRESULT __stdcall GetDetailsEx(Winapi::Shlobj::PItemIDList pidl, const SHCOLUMNID &pscid, POleVariant pv) = 0 ;
	virtual HRESULT __stdcall GetDetailsOf(Winapi::Shlobj::PItemIDList pidl, unsigned iColumn, _SHELLDETAILS &psd) = 0 ;
	virtual HRESULT __stdcall MapNameToSCID(System::WideChar * pwszName, SHCOLUMNID &pscid) = 0 ;
};

__interface  INTERFACE_UUID("{000214EC-0000-0000-C000-000000000046}") IShellDetails  : public System::IInterface 
{
	virtual HRESULT __stdcall GetDetailsOf(Winapi::Shlobj::PItemIDList pidl, unsigned iColumn, _SHELLDETAILS &pDetails) = 0 ;
	virtual HRESULT __stdcall ColumnClick(unsigned iColumn) = 0 ;
};

typedef TSHChangeNotifyEntry *PSHChangeNotifyEntry;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TSHChangeNotifyEntry
{
public:
	_ITEMIDLIST *PIDL;
	System::LongBool fRecursive;
};
#pragma pack(pop)


typedef TSHDwordItemID *PSHDwordItemID;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TSHDwordItemID
{
public:
	void *dwItem1;
	void *dwItem2;
};
#pragma pack(pop)


typedef TSHChangeDWORDAsIDList *PSHChangeDWORDAsIDList;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TSHChangeDWORDAsIDList
{
public:
	short cb;
	unsigned dwItem1;
	unsigned dwItem2;
	short cbZero;
};
#pragma pack(pop)


typedef unsigned __stdcall (*TSHChangeNotifyRegister)(HWND hWnd, unsigned fSources, unsigned wEventMask, unsigned wMsg, unsigned cEntries, const TSHChangeNotifyEntry &Items);

typedef System::LongBool __stdcall (*TSHChangeNotifyDeregister)(unsigned hNotify);

typedef System::LongBool __stdcall (*LMDELSHGetPathFromIDListProcW)(Winapi::Shlobj::PItemIDList pidl, System::WideChar * pszPath);

typedef System::LongBool __stdcall (*LMDELSHGetPathFromIDListProc)(Winapi::Shlobj::PItemIDList pidl, System::WideChar * pszPath);

//-- var, const, procedure ---------------------------------------------------
#define SID_IShellDetails L"{000214EC-0000-0000-C000-000000000046}"
#define SID_IShellFolder2 L"{93F2F68C-1D1B-11D3-A30E-00C04F79ABD1}"
#define SID_IEnumExtraSearch L"{0e700be1-9db6-11d1-A1CE-00C04FD75D13}"
extern DELPHI_PACKAGE GUID IID_IShellDetails;
extern DELPHI_PACKAGE GUID IID_IShellFolder2;
static const System::Int8 SHCNF_ACCEPT_INTERRUPTS = System::Int8(0x1);
static const System::Int8 SHCNF_ACCEPT_NON_INTERRUPTS = System::Int8(0x2);
static const System::Word SHCNF_NO_PROXY = System::Word(0x8000);
extern DELPHI_PACKAGE unsigned WM_SHCHANGENOTIFY;
extern DELPHI_PACKAGE unsigned __stdcall SHChangeNotifyRegister(HWND hWnd, unsigned fSources, unsigned wEventMask, unsigned wMsg, unsigned cEntries, TSHChangeNotifyEntry &Items);
extern DELPHI_PACKAGE System::LongBool __stdcall SHChangeNotifyDeregister(unsigned hNotify);
extern DELPHI_PACKAGE System::LongBool __stdcall LMDELSHGetPathFromIDList(Winapi::Shlobj::PItemIDList pidl, System::WideChar * pszPathW, System::WideChar * pszPath, bool &IsWideStr);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetFolderPIDL(TShellFolders FolderID, const Lmdtypes::TLMDString CustomName);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetFolderPIDL2(TShellFolders FolderID, const Lmdtypes::TLMDString CustomName);
extern DELPHI_PACKAGE void __fastcall FreeIDList(Winapi::Shlobj::PItemIDList &PIDL);
extern DELPHI_PACKAGE bool __fastcall GetPathFromPIDL(Winapi::Shlobj::PItemIDList PIDL, Lmdtypes::TLMDString &Path);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall GetPathFromPIDL2(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetPIDLFromPath(const Lmdtypes::TLMDString Path);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall SHGetPIDLFromPath(const _di_IShellFolder ShellFolder, const Lmdtypes::TLMDString Path);
extern DELPHI_PACKAGE bool __fastcall IsDesktopPIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall StrRetToPas(const _STRRET &str, Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE bool __fastcall ShellExecutePIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Lmdtypes::TLMDString __fastcall GetPIDLTypeName(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetLastPIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE _di_IShellFolder __fastcall GetDesktopFolder(void);
extern DELPHI_PACKAGE _di_IMalloc __fastcall GetShellMalloc(void);
extern DELPHI_PACKAGE _di_IShellFolder __fastcall GetShellFolder(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE _di_IShellFolder __fastcall GetParentFolder(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE bool __fastcall ExecutePIDLContextMenuVerb(NativeUInt Handle, Winapi::Shlobj::PItemIDList RelativePIDL, const _di_IShellFolder ParentFolder, const System::UnicodeString Verb);
extern DELPHI_PACKAGE void __fastcall StrRetFree(const _STRRET &str);
extern DELPHI_PACKAGE int __fastcall GetCompressedColor(void);
extern DELPHI_PACKAGE TElShellIconCache* __fastcall ShellIconCache(void);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetNextItemID(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE bool __fastcall PIDLStartsWith(Winapi::Shlobj::PItemIDList PIDL, Winapi::Shlobj::PItemIDList SubPIDL);
extern DELPHI_PACKAGE bool __fastcall PIDLContainsAt(Winapi::Shlobj::PItemIDList PIDL, Winapi::Shlobj::PItemIDList SubPIDL, int Pos);
extern DELPHI_PACKAGE int __fastcall CalcPIDLSize(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE bool __fastcall CompareIDLists(Winapi::Shlobj::PItemIDList IDList1, Winapi::Shlobj::PItemIDList IDList2);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall ClonePIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetOwnPIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetEmptyPIDL(void);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetItemIDOnly(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall AppendPIDL(Winapi::Shlobj::PItemIDList ParentPIDL, Winapi::Shlobj::PItemIDList ChildPIDL);
extern DELPHI_PACKAGE Winapi::Shlobj::PItemIDList __fastcall GetParentPIDL(Winapi::Shlobj::PItemIDList PIDL);
extern DELPHI_PACKAGE NativeUInt __fastcall GetModule(const System::UnicodeString ModuleName);
extern DELPHI_PACKAGE bool __fastcall SetAutoComplete(NativeUInt Handle, bool bFileSystem, bool bURL);
extern DELPHI_PACKAGE bool __fastcall ElCreateShellLinkA(const Lmdtypes::TLMDString sFileName, const Lmdtypes::TLMDString sShortcutTo, const Lmdtypes::TLMDString sWorkingDir, const Lmdtypes::TLMDString sArguments, const Lmdtypes::TLMDString sDescription, const Lmdtypes::TLMDString sIconFileName, int IconIndex, Winapi::Shlobj::PItemIDList IDList, int fShowCmd, System::Classes::TShortCut Hotkey);
extern DELPHI_PACKAGE bool __fastcall ElCreateShellLinkW(const System::WideString wsFileName, const System::WideString wsShortcutTo, const System::WideString wsWorkingDir, const System::WideString wsArguments, const System::WideString wsDescription, const System::WideString wsIconFileName, int IconIndex, Winapi::Shlobj::PItemIDList IDList, int fShowCmd, System::Classes::TShortCut Hotkey);
extern DELPHI_PACKAGE bool __fastcall ElCreateShellLink(const Lmdtypes::TLMDString wsFileName, const Lmdtypes::TLMDString wsShortcutTo, const Lmdtypes::TLMDString wsWorkingDir, const Lmdtypes::TLMDString wsArguments, const Lmdtypes::TLMDString wsDescription, const Lmdtypes::TLMDString wsIconFileName, int IconIndex, Winapi::Shlobj::PItemIDList IDList, int fShowCmd, System::Classes::TShortCut Hotkey);
extern DELPHI_PACKAGE bool __fastcall ElReadShellLinkA(const System::WideString wsFileName, Lmdtypes::TLMDString &sShortcutTo, Lmdtypes::TLMDString &sWorkingDir, Lmdtypes::TLMDString &sArguments, Lmdtypes::TLMDString &sDescription, Lmdtypes::TLMDString &sIconFileName, int &IconIndex, bool bReadIDList, Winapi::Shlobj::PItemIDList &IDList, int &fShowCmd, System::Classes::TShortCut &Hotkey);
extern DELPHI_PACKAGE bool __fastcall ElReadShellLinkW(const System::WideString wsFileName, System::WideString &wsShortcutTo, System::WideString &wsWorkingDir, System::WideString &wsArguments, System::WideString &wsDescription, System::WideString &wsIconFileName, int &IconIndex, bool bReadIDList, Winapi::Shlobj::PItemIDList &IDList, int &fShowCmd, System::Classes::TShortCut &Hotkey);
extern DELPHI_PACKAGE bool __fastcall ElReadShellLink(const System::WideString wsFileName, System::WideString &wsShortcutTo, System::WideString &wsWorkingDir, System::WideString &wsArguments, System::WideString &wsDescription, System::WideString &wsIconFileName, int &IconIndex, bool bReadIDList, Winapi::Shlobj::PItemIDList &IDList, int &fShowCmd, System::Classes::TShortCut &Hotkey);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ElGetFileSizeFormat(void);
}	/* namespace Elshellutils */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_ELSHELLUTILS)
using namespace Elshellutils;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// ElshellutilsHPP
