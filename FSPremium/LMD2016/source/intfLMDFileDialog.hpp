// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'intfLMDFileDialog.pas' rev: 31.00 (Windows)

#ifndef IntflmdfiledialogHPP
#define IntflmdfiledialogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDTypes.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>

//-- user supplied -----------------------------------------------------------
typedef DelphiInterface<IBindCtx> _di_IBindCtx;

namespace Intflmdfiledialog
{
//-- forward type declarations -----------------------------------------------
__interface IModalWindow;
typedef System::DelphiInterface<IModalWindow> _di_IModalWindow;
__interface IFileIsInUse;
typedef System::DelphiInterface<IFileIsInUse> _di_IFileIsInUse;
struct _COMDLG_FILTERSPEC;
__interface IShellItem;
typedef System::DelphiInterface<IShellItem> _di_IShellItem;
__interface IShellItemFilter;
typedef System::DelphiInterface<IShellItemFilter> _di_IShellItemFilter;
__interface IFileDialogEvents;
typedef System::DelphiInterface<IFileDialogEvents> _di_IFileDialogEvents;
__interface IFileDialogCustomize;
typedef System::DelphiInterface<IFileDialogCustomize> _di_IFileDialogCustomize;
__interface IFileDialogControlEvents;
typedef System::DelphiInterface<IFileDialogControlEvents> _di_IFileDialogControlEvents;
__interface IFileDialog;
typedef System::DelphiInterface<IFileDialog> _di_IFileDialog;
__interface IFileSaveDialog;
typedef System::DelphiInterface<IFileSaveDialog> _di_IFileSaveDialog;
__interface IEnumShellItems;
typedef System::DelphiInterface<IEnumShellItems> _di_IEnumShellItems;
__interface IShellItemArray;
typedef System::DelphiInterface<IShellItemArray> _di_IShellItemArray;
__interface IFileOpenDialog;
typedef System::DelphiInterface<IFileOpenDialog> _di_IFileOpenDialog;
//-- type declarations -------------------------------------------------------
__interface  INTERFACE_UUID("{B4DB1657-70D7-485E-8E3E-6FCB5A5C1802}") IModalWindow  : public System::IInterface 
{
	virtual HRESULT __stdcall Show(HWND hwndParent) = 0 ;
};

enum DECLSPEC_DENUM tagFILE_USAGE_TYPE : unsigned char { FUT_PLAYING, FUT_EDITING, FUT_GENERIC };

typedef tagFILE_USAGE_TYPE FILE_USAGE_TYPE;

__interface  INTERFACE_UUID("{64A1CBF0-3A1A-4461-9158-376969693950}") IFileIsInUse  : public System::IInterface 
{
	virtual HRESULT __stdcall GetAppName(/* out */ System::WideChar * &ppszName) = 0 ;
	virtual HRESULT __stdcall GetUsage(tagFILE_USAGE_TYPE &pfut) = 0 ;
	virtual HRESULT __stdcall GetCapabilities(unsigned &pdwCapFlags) = 0 ;
	virtual HRESULT __stdcall GetSwitchToHWND(HWND &phwnd) = 0 ;
	virtual HRESULT __stdcall CloseFile(void) = 0 ;
};

struct DECLSPEC_DRECORD _COMDLG_FILTERSPEC
{
public:
	System::WideChar *pszName;
	System::WideChar *pszSpec;
};


typedef _COMDLG_FILTERSPEC COMDLG_FILTERSPEC;

typedef _COMDLG_FILTERSPEC TComDlgFilterspec;

typedef _COMDLG_FILTERSPEC *PComDlgFilterspec;

typedef unsigned SIGDN;

typedef unsigned SICHINTF;

typedef unsigned SFGAOF;

typedef unsigned SHCONTF;

__interface  INTERFACE_UUID("{43826D1E-E718-42EE-BC55-A1E261C37BFE}") IShellItem  : public System::IInterface 
{
	virtual HRESULT __stdcall BindToHandler(const _di_IBindCtx pbc, const GUID &bhid, const GUID &riid, /* out */ void *ppv) = 0 ;
	virtual HRESULT __stdcall GetParent(_di_IShellItem &ppsi) = 0 ;
	virtual HRESULT __stdcall GetDisplayName(unsigned sigdnName, System::WideChar * &ppszName) = 0 ;
	virtual HRESULT __stdcall GetAttributes(unsigned sfgaoMask, unsigned &psfgaoAttribs) = 0 ;
	virtual HRESULT __stdcall Compare(const _di_IShellItem psi, unsigned hint, int &piOrder) = 0 ;
};

__interface  INTERFACE_UUID("{2659B475-EEB8-48B7-8F07-B378810F48CF}") IShellItemFilter  : public System::IInterface 
{
	virtual HRESULT __stdcall GetEnumFlagsForItem(_di_IShellItem psi, unsigned &pgrfFlags) = 0 ;
	virtual HRESULT __stdcall IncludeItem(_di_IShellItem psi) = 0 ;
};

__interface  INTERFACE_UUID("{973510DB-7D7F-452B-8975-74A85828D354}") IFileDialogEvents  : public System::IInterface 
{
	virtual HRESULT __stdcall OnFileOk(const _di_IFileDialog pfd) = 0 ;
	virtual HRESULT __stdcall OnFolderChanging(const _di_IFileDialog pfd, const _di_IShellItem psiFolder) = 0 ;
	virtual HRESULT __stdcall OnFolderChange(const _di_IFileDialog pfd) = 0 ;
	virtual HRESULT __stdcall OnSelectionChange(const _di_IFileDialog pfd) = 0 ;
	virtual HRESULT __stdcall OnShareViolation(const _di_IFileDialog pfd, const _di_IShellItem psi, /* out */ unsigned &pResponse) = 0 ;
	virtual HRESULT __stdcall OnTypeChange(const _di_IFileDialog pfd) = 0 ;
	virtual HRESULT __stdcall OnOverwrite(const _di_IFileDialog pfd, const _di_IShellItem psi, /* out */ unsigned &pResponse) = 0 ;
};

__interface  INTERFACE_UUID("{E6FDD21A-163F-4975-9C8C-A69F1BA37034}") IFileDialogCustomize  : public System::IInterface 
{
	virtual HRESULT __stdcall EnableOpenDropDown(unsigned dwIDCtl) = 0 ;
	virtual HRESULT __stdcall AddMenu(unsigned dwIDCtl, System::WideChar * pszLabel) = 0 ;
	virtual HRESULT __stdcall AddPushButton(unsigned dwIDCtl, System::WideChar * pszLabel) = 0 ;
	virtual HRESULT __stdcall AddComboBox(unsigned dwIDCtl) = 0 ;
	virtual HRESULT __stdcall AddRadioButtonList(unsigned dwIDCtl) = 0 ;
	virtual HRESULT __stdcall AddCheckButton(unsigned dwIDCtl, System::WideChar * pszLabel, System::LongBool bChecked) = 0 ;
	virtual HRESULT __stdcall AddEditBox(unsigned dwIDCtl, System::WideChar * pszText) = 0 ;
	virtual HRESULT __stdcall AddText(unsigned dwIDCtl, System::WideChar * pszText) = 0 ;
	virtual HRESULT __stdcall AddSeparator(unsigned dwIDCtl) = 0 ;
	virtual HRESULT __stdcall GetEditBoxText(unsigned dwIDCtl, /* out */ System::WideChar * &ppszText) = 0 ;
	virtual HRESULT __stdcall SetEditBoxText(unsigned dwIDCtl, System::WideChar * pszText) = 0 ;
	virtual HRESULT __stdcall SetControlLabel(unsigned dwIDCtl, System::WideChar * pszLabel) = 0 ;
	virtual HRESULT __stdcall GetControlState(unsigned dwIDCtl, /* out */ unsigned &pdwState) = 0 ;
	virtual HRESULT __stdcall SetControlState(unsigned dwIDCtl, unsigned dwState) = 0 ;
	virtual HRESULT __stdcall GetCheckButtonState(unsigned dwIDCtl, /* out */ System::LongBool &pbChecked) = 0 ;
	virtual HRESULT __stdcall SetCheckButtonState(unsigned dwIDCtl, System::LongBool bChecked) = 0 ;
	virtual HRESULT __stdcall AddControlItem(unsigned dwIDCtl, unsigned dwIDItem, System::WideChar * pszLabel) = 0 ;
	virtual HRESULT __stdcall RemoveControlItem(unsigned dwIDCtl, unsigned dwIDItem) = 0 ;
	virtual HRESULT __stdcall RemoveAllControlItems(unsigned dwIDCtl) = 0 ;
	virtual HRESULT __stdcall GetControlItemState(unsigned dwIDCtl, unsigned dwIDItem, /* out */ unsigned &pdwState) = 0 ;
	virtual HRESULT __stdcall SetControlItemState(unsigned dwIDCtl, unsigned dwIDItem, unsigned dwState) = 0 ;
	virtual HRESULT __stdcall GetSelectedControlItem(unsigned dwIDCtl, /* out */ unsigned &pdwIDItem) = 0 ;
	virtual HRESULT __stdcall SetSelectedControlItem(unsigned dwIDCtl, unsigned dwIDItem) = 0 ;
	virtual HRESULT __stdcall StartVisualGroup(unsigned dwIDCtl, System::WideChar * pszLabel) = 0 ;
	virtual HRESULT __stdcall EndVisualGroup(void) = 0 ;
	virtual HRESULT __stdcall MakeProminent(unsigned dwIDCtl) = 0 ;
};

__interface  INTERFACE_UUID("{36116642-D713-4B97-9B83-7484A9D00433}") IFileDialogControlEvents  : public System::IInterface 
{
	virtual HRESULT __stdcall OnItemSelected(const _di_IFileDialogCustomize pfdc, unsigned dwIDCtl, unsigned dwIDItem) = 0 ;
	virtual HRESULT __stdcall OnButtonClicked(const _di_IFileDialogCustomize pfdc, unsigned dwIDCtl) = 0 ;
	virtual HRESULT __stdcall OnCheckButtonToggled(const _di_IFileDialogCustomize pfdc, unsigned dwIDCtl, System::LongBool bChecked) = 0 ;
	virtual HRESULT __stdcall OnControlActivating(const _di_IFileDialogCustomize pfdc, unsigned dwIDCtl) = 0 ;
};

__interface  INTERFACE_UUID("{42F85136-DB7E-439C-85F1-E4075D135FC8}") IFileDialog  : public IModalWindow 
{
	virtual HRESULT __stdcall SetFileTypes(unsigned cFileTypes, const PComDlgFilterspec rgFilterSpec) = 0 ;
	virtual HRESULT __stdcall SetFileTypeIndex(unsigned iFileType) = 0 ;
	virtual HRESULT __stdcall GetFileTypeIndex(unsigned &piFileType) = 0 ;
	virtual HRESULT __stdcall Advise(const _di_IFileDialogEvents pfde, unsigned &pdwCookie) = 0 ;
	virtual HRESULT __stdcall Unadvise(unsigned dwCookie) = 0 ;
	virtual HRESULT __stdcall SetOptions(unsigned fos) = 0 ;
	virtual HRESULT __stdcall GetOptions(unsigned &pfos) = 0 ;
	virtual HRESULT __stdcall SetDefaultFolder(const _di_IShellItem psi) = 0 ;
	virtual HRESULT __stdcall SetFolder(const _di_IShellItem psi) = 0 ;
	virtual HRESULT __stdcall GetFolder(_di_IShellItem &ppsi) = 0 ;
	virtual HRESULT __stdcall GetCurrentSelection(_di_IShellItem &ppsi) = 0 ;
	virtual HRESULT __stdcall SetFileName(System::WideChar * pszName) = 0 ;
	virtual HRESULT __stdcall GetFileName(System::WideChar * &pszName) = 0 ;
	virtual HRESULT __stdcall SetTitle(System::WideChar * pszTitle) = 0 ;
	virtual HRESULT __stdcall SetOkButtonLabel(System::WideChar * pszText) = 0 ;
	virtual HRESULT __stdcall SetFileNameLabel(System::WideChar * pszLabel) = 0 ;
	virtual HRESULT __stdcall GetResult(_di_IShellItem &ppsi) = 0 ;
	virtual HRESULT __stdcall AddPlace(const _di_IShellItem psi, unsigned fdap) = 0 ;
	virtual HRESULT __stdcall SetDefaultExtension(System::WideChar * pszDefaultExtension) = 0 ;
	virtual HRESULT __stdcall Close(HRESULT hr) = 0 ;
	virtual HRESULT __stdcall SetClientGuid(const GUID &guid) = 0 ;
	virtual HRESULT __stdcall ClearClientData(void) = 0 ;
	virtual HRESULT __stdcall SetFilter(const _di_IShellItemFilter pFilter) = 0 ;
};

__interface  INTERFACE_UUID("{84BCCD23-5FDE-4CDB-AEA4-AF64B83D78AB}") IFileSaveDialog  : public IFileDialog 
{
	virtual HRESULT __stdcall SetSaveAsItem(_di_IShellItem psi) = 0 ;
	virtual HRESULT __stdcall SetProperties(System::_di_IInterface pStore) = 0 ;
	virtual HRESULT __stdcall SetCollectedProperties(System::_di_IInterface pList, System::LongBool fAppendDefault) = 0 ;
	virtual HRESULT __stdcall GetProperties(/* out */ System::_di_IInterface &ppStore) = 0 ;
	virtual HRESULT __stdcall ApplyProperties(_di_IShellItem psi, System::_di_IInterface pStore, HWND hwnd, System::_di_IInterface pSink) = 0 ;
};

__interface  INTERFACE_UUID("{70629033-E363-4A28-A567-0DB78006E6D7}") IEnumShellItems  : public System::IInterface 
{
	virtual HRESULT __stdcall Next(unsigned celt, /* out */ _di_IShellItem &rgelt, unsigned &pceltFetched) = 0 ;
	virtual HRESULT __stdcall Skip(unsigned celt) = 0 ;
	virtual HRESULT __stdcall Reset(void) = 0 ;
	virtual HRESULT __stdcall Clone(/* out */ _di_IEnumShellItems &ppenum) = 0 ;
};

__interface  INTERFACE_UUID("{B63EA76D-1F85-456F-A19C-48159EFA858B}") IShellItemArray  : public System::IInterface 
{
	virtual HRESULT __stdcall BindToHandler(_di_IBindCtx pbc, const GUID &rbhid, const GUID &riid, /* out */ void *ppvOut) = 0 ;
	virtual HRESULT __stdcall GetPropertyStore(unsigned flags, const GUID &riid, /* out */ void *ppv) = 0 ;
	virtual HRESULT __stdcall GetPropertyDescriptionList(const _tagpropertykey &keyType, const GUID &riid, /* out */ void *ppv) = 0 ;
	virtual HRESULT __stdcall GetAttrributes(int nEnum, unsigned dwRequested, /* out */ unsigned &pdwResult) = 0 ;
	virtual HRESULT __stdcall GetCount(unsigned &pCount) = 0 ;
	virtual HRESULT __stdcall GetItemAt(unsigned nIndex, /* out */ _di_IShellItem &ppItem) = 0 ;
	virtual HRESULT __stdcall EnumItems(_di_IEnumShellItems &enumShellItems) = 0 ;
};

__interface  INTERFACE_UUID("{D57C7288-D4AD-4768-BE02-9D969532D960}") IFileOpenDialog  : public IFileDialog 
{
	virtual HRESULT __stdcall GetResults(/* out */ _di_IShellItemArray &ppenum) = 0 ;
	virtual HRESULT __stdcall GetSelectedItems(/* out */ _di_IShellItemArray &ppsai) = 0 ;
};

//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE GUID CLSID_IShellItem;
extern DELPHI_PACKAGE GUID CLSID_FileOpenDialog;
extern DELPHI_PACKAGE GUID CLSID_FileSaveDialog;
extern DELPHI_PACKAGE GUID IID_FileOpenDialog;
extern DELPHI_PACKAGE GUID IID_FileSaveDialog;
#define SID_IModalWindow L"{b4db1657-70d7-485e-8e3e-6fcb5a5c1802}"
#define SID_IEnumShellItems L"{70629033-e363-4a28-a567-0db78006e6d7}"
#define SID_IShellItem L"{43826d1e-e718-42ee-bc55-a1e261c37bfe}"
#define SID_IShellItemFilter L"{2659B475-EEB8-48b7-8F07-B378810F48CF}"
#define SID_IShellItemArray L"{b63ea76d-1f85-456f-a19c-48159efa858b}"
#define SID_IPropertyStore L"{886d8eeb-8cf2-4446-8d02-cdba1dbdcf99}"
#define SID_IPropertyDescriptionList L"{1f9fc1d0-c39b-4b26-817f-011967d3440e}"
#define SID_IFileOperationProgressSink L"{04b0f1a7-9490-44bc-96e1-4296a31252e2}"
#define SID_IFileDialogCustomize L"{e6fdd21a-163f-4975-9c8c-a69f1ba37034}"
#define SID_IFileDialogEvents L"{973510db-7d7f-452b-8975-74a85828d354}"
#define SID_IFileDialogControlEvents L"{36116642-D713-4b97-9B83-7484A9D00433}"
#define SID_IFileDialog L"{42f85136-db7e-439c-85f1-e4075d135fc8}"
#define SID_IFileOpenDialog L"{d57c7288-d4ad-4768-be02-9d969532d960}"
#define SID_IFileSaveDialog L"{84bccd23-5fde-4cdb-aea4-af64b83d78ab}"
static const System::Int8 FDEOR_DEFAULT = System::Int8(0x0);
static const System::Int8 FDEOR_ACCEPT = System::Int8(0x1);
static const System::Int8 FDEOR_REFUSE = System::Int8(0x2);
static const System::Int8 FDESVR_DEFAULT = System::Int8(0x0);
static const System::Int8 FDESVR_ACCEPT = System::Int8(0x1);
static const System::Int8 FDESVR_REFUSE = System::Int8(0x2);
static const System::Int8 FDAP_BOTTOM = System::Int8(0x0);
static const System::Int8 FDAP_TOP = System::Int8(0x1);
static const System::Int8 SIGDN_NORMALDISPLAY = System::Int8(0x0);
static const unsigned SIGDN_PARENTRELATIVEPARSING = unsigned(0x80018001);
static const unsigned SIGDN_PARENTRELATIVEFORADDRESSBAR = unsigned(0x8001c001);
static const unsigned SIGDN_DESKTOPABSOLUTEPARSING = unsigned(0x80028000);
static const unsigned SIGDN_PARENTRELATIVEEDITING = unsigned(0x80031001);
static const unsigned SIGDN_DESKTOPABSOLUTEEDITING = unsigned(0x8004c000);
static const unsigned SIGDN_FILESYSPATH = unsigned(0x80058000);
static const unsigned SIGDN_URL = unsigned(0x80068000);
static const System::Int8 SICHINT_DISPLAY = System::Int8(0x0);
static const unsigned SICHINT_ALLFIELDS = unsigned(0x80000000);
static const int SICHINT_CANONICAL = int(0x10000000);
static const System::Int8 FOS_OVERWRITEPROMPT = System::Int8(0x2);
static const System::Int8 FOS_STRICTFILETYPES = System::Int8(0x4);
static const System::Int8 FOS_NOCHANGEDIR = System::Int8(0x8);
static const System::Int8 FOS_PICKFOLDERS = System::Int8(0x20);
static const System::Int8 FOS_FORCEFILESYSTEM = System::Int8(0x40);
static const System::Byte FOS_ALLNONSTORAGEITEMS = System::Byte(0x80);
static const System::Word FOS_NOVALIDATE = System::Word(0x100);
static const System::Word FOS_ALLOWMULTISELECT = System::Word(0x200);
static const System::Word FOS_PATHMUSTEXIST = System::Word(0x800);
static const System::Word FOS_FILEMUSTEXIST = System::Word(0x1000);
static const System::Word FOS_CREATEPROMPT = System::Word(0x2000);
static const System::Word FOS_SHAREAWARE = System::Word(0x4000);
static const System::Word FOS_NOREADONLYRETURN = System::Word(0x8000);
static const int FOS_NOTESTFILECREATE = int(0x10000);
static const int FOS_HIDEMRUPLACES = int(0x20000);
static const int FOS_HIDEPINNEDPLACES = int(0x40000);
static const int FOS_NODEREFERENCELINKS = int(0x100000);
static const int FOS_DONTADDTORECENT = int(0x2000000);
static const int FOS_FORCESHOWHIDDEN = int(0x10000000);
static const int FOS_DEFAULTNOMINIMODE = int(0x20000000);
static const int FOS_FORCEPREVIEWPANEON = int(0x40000000);
static const System::Word SHCONTF_INIT_ON_FIRST_NEXT = System::Word(0x100);
static const System::Word SHCONTF_NETPRINTERSRCH = System::Word(0x200);
static const System::Word SHCONTF_SHAREABLE = System::Word(0x400);
static const System::Word SHCONTF_STORAGE = System::Word(0x800);
static const System::Int8 CDCS_INACTIVE = System::Int8(0x0);
static const System::Int8 CDCS_ENABLED = System::Int8(0x1);
static const System::Int8 CDCS_VISIBLE = System::Int8(0x2);
extern DELPHI_PACKAGE HRESULT __fastcall SHCreateItemFromParsingName(System::WideString pszPath, const _di_IBindCtx pbc, const GUID &riid, /* out */ void *ppv);
}	/* namespace Intflmdfiledialog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_INTFLMDFILEDIALOG)
using namespace Intflmdfiledialog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// IntflmdfiledialogHPP
