// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShBase.pas' rev: 31.00 (Windows)

#ifndef LmdshbaseHPP
#define LmdshbaseHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.SysUtils.hpp>
#include <System.Classes.hpp>
#include <Vcl.Forms.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Graphics.hpp>
#include <Winapi.ActiveX.hpp>
#include <Winapi.Messages.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.ShellAPI.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ImgList.hpp>
#include <Vcl.StdCtrls.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------
DECLARE_DINTERFACE_TYPE(IDropTarget)

namespace Lmdshbase
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellComponent;
class DELPHICLASS TLMDShellBaseDialog;
class DELPHICLASS TLMDShellDummyItems;
struct TShellItemDetailsInfo;
class DELPHICLASS TLMDCustomShellItem;
class DELPHICLASS TLMDShellItemsList;
class DELPHICLASS TLMDShellItems;
class DELPHICLASS TLMDCustomShellController;
//-- type declarations -------------------------------------------------------
typedef _STRRET TStrRetEx;

typedef _SHELLDETAILS TShellDetailsEx;

class PASCALIMPLEMENTATION TLMDShellComponent : public Lmdcustomcomponent::TLMDCustomComponent
{
	typedef Lmdcustomcomponent::TLMDCustomComponent inherited;
	
public:
	virtual Lmdtypes::TLMDPackageID __fastcall getLMDPackage(void);
	
__published:
	__property About = {default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDShellComponent(System::Classes::TComponent* AOwner) : Lmdcustomcomponent::TLMDCustomComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellComponent(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellParentHandle : unsigned char { pwNone, pwApplication, pwOwnerForm };

class PASCALIMPLEMENTATION TLMDShellBaseDialog : public TLMDShellComponent
{
	typedef TLMDShellComponent inherited;
	
private:
	TLMDShellParentHandle FParent;
	
protected:
	HWND __fastcall GetOwnerHandle(HWND aHWND = (HWND)(0x0));
	
public:
	virtual bool __fastcall Execute(HWND aHWND = (HWND)(0x0)) = 0 ;
	
__published:
	__property TLMDShellParentHandle OwnerHandle = {read=FParent, write=FParent, default=0};
public:
	/* TLMDCustomComponent.Create */ inline __fastcall virtual TLMDShellBaseDialog(System::Classes::TComponent* AOwner) : TLMDShellComponent(AOwner) { }
	
public:
	/* TComponent.Destroy */ inline __fastcall virtual ~TLMDShellBaseDialog(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellFileAttribute : unsigned char { faReadOnly, faHidden, faSystem, faArchive, faCompressed };

typedef System::Set<TLMDShellFileAttribute, TLMDShellFileAttribute::faReadOnly, TLMDShellFileAttribute::faCompressed> TLMDShellFileAttributes;

enum DECLSPEC_DENUM TLMDShellFolderCapability : unsigned char { fcCanCopy, fcCanDelete, fcCanLink, fcCanMove, fcCanRename, fcDropTarget, fcHasPropSheet };

typedef System::Set<TLMDShellFolderCapability, TLMDShellFolderCapability::fcCanCopy, TLMDShellFolderCapability::fcHasPropSheet> TLMDShellFolderCapabilities;

enum DECLSPEC_DENUM TLMDShellFolderProperty : unsigned char { fpCut, fpIsLink, fpShared, fpFolder, fpHasSubFolder, fpCompressed, fpRemovable, fpFileSystemAncestor, fpFileSystem };

typedef System::Set<TLMDShellFolderProperty, TLMDShellFolderProperty::fpCut, TLMDShellFolderProperty::fpFileSystem> TLMDShellFolderProperties;

enum DECLSPEC_DENUM TLMDShellBoolExt : unsigned char { boolUnknown, boolTrue, boolFalse };

enum DECLSPEC_DENUM TLMDShellItemDetailsColumn : unsigned char { cdName, cdTypeName, cdSize, cdAttributes, cdWriteDate, cdWriteTime, cdWriteDateTime, cdCreateDate, cdCreateTime, cdCreateDateTime, cdAccessDate, cdAccessTime, cdAccessDateTime, cdCustom };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellDummyItems : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDCustomShellItem* operator[](int index) { return this->Items[index]; }
	
private:
	int __fastcall GetCount(void);
	TLMDCustomShellItem* __fastcall GetItem(int index);
	
public:
	__property TLMDCustomShellItem* Items[int index] = {read=GetItem/*, default*/};
	__property int Count = {read=GetCount, nodefault};
public:
	/* TObject.Create */ inline __fastcall TLMDShellDummyItems(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDShellDummyItems(void) { }
	
};

#pragma pack(pop)

struct DECLSPEC_DRECORD TShellItemDetailsInfo
{
public:
	System::UnicodeString Title;
	System::UnicodeString View;
	unsigned Flags;
};


typedef System::DynamicArray<TShellItemDetailsInfo> TShellItemDetailsInfoArray;

typedef void __fastcall (__closure *TLMDCustomShellItemCheckedEvent)(System::TObject* Sender, bool AChecked);

class PASCALIMPLEMENTATION TLMDCustomShellItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::TObject* FCustomData;
	bool FOwnedCustomData;
	System::UnicodeString __fastcall int_GetDetailsEx(int ColID);
	
protected:
	TLMDShellComponent* FController;
	_ITEMIDLIST *FAbsoluteID;
	_ITEMIDLIST *FRelativeID;
	System::UnicodeString FDisplayName;
	System::UnicodeString FExtDisplayName;
	System::UnicodeString FShortFileName;
	System::UnicodeString FPath;
	System::UnicodeString FTypeName;
	System::UnicodeString FExtension;
	unsigned FDWFileAttributes;
	TLMDShellFileAttributes FFileAttributes;
	System::UnicodeString FFileAttributesStr;
	TLMDShellFolderProperties FFileProperties;
	TLMDShellFolderCapabilities FFileCapabilities;
	__int64 FFileSize;
	System::TDateTime FModifiedDate;
	System::TDateTime FAccessDate;
	System::TDateTime FCreationDate;
	int FIconIndex;
	int FOpenIconIndex;
	int FOverlayIconIndex;
	Vcl::Graphics::TIcon* FLargeIcon;
	Vcl::Graphics::TIcon* FLargeOpenIcon;
	Vcl::Graphics::TIcon* FSmallIcon;
	Vcl::Graphics::TIcon* FSmallOpenIcon;
	int FDriveType;
	TLMDShellBoolExt FIsNamespaceRoot;
	TLMDShellBoolExt FIsFile;
	TLMDShellBoolExt FIsFileFolder;
	TLMDShellBoolExt FIsFileSystem;
	TLMDShellBoolExt FIsLink;
	TLMDShellBoolExt FIsFolder;
	System::Classes::TStringList* FDetails;
	System::Classes::TStringList* FDetailsEx;
	unsigned FData;
	bool FChecked;
	TLMDCustomShellItemCheckedEvent FOnCheckItem;
	int FLevel;
	TLMDShellDummyItems* FDummyItems;
	virtual System::UnicodeString __fastcall GetDisplayName(void) = 0 ;
	virtual System::UnicodeString __fastcall GetExtDisplayName(void) = 0 ;
	virtual System::UnicodeString __fastcall GetShortFileName(void) = 0 ;
	virtual System::UnicodeString __fastcall GetPath(void) = 0 ;
	virtual System::UnicodeString __fastcall GetTypeName(void) = 0 ;
	virtual System::UnicodeString __fastcall GetExtension(void) = 0 ;
	virtual unsigned __fastcall GetDWFileAttributes(void) = 0 ;
	virtual TLMDShellFileAttributes __fastcall GetFileAttributes(void) = 0 ;
	virtual System::UnicodeString __fastcall GetFileAttributesStr(void) = 0 ;
	virtual TLMDShellFolderProperties __fastcall GetFileProperties(void) = 0 ;
	virtual TLMDShellFolderCapabilities __fastcall GetFileCapabilities(void) = 0 ;
	virtual __int64 __fastcall GetFileSize(void) = 0 ;
	virtual System::TDateTime __fastcall GetModifiedDate(void) = 0 ;
	virtual System::TDateTime __fastcall GetAccessDate(void) = 0 ;
	virtual System::TDateTime __fastcall GetCreationDate(void) = 0 ;
	virtual int __fastcall GetIconIndex(void) = 0 ;
	virtual int __fastcall GetOpenIconIndex(void) = 0 ;
	virtual int __fastcall GetOverlayIconIndex(void) = 0 ;
	virtual Vcl::Graphics::TIcon* __fastcall GetLargeIcon(void) = 0 ;
	virtual Vcl::Graphics::TIcon* __fastcall GetLargeOpenIcon(void) = 0 ;
	virtual Vcl::Graphics::TIcon* __fastcall GetSmallIcon(void) = 0 ;
	virtual Vcl::Graphics::TIcon* __fastcall GetSmallOpenIcon(void) = 0 ;
	virtual int __fastcall GetDriveType(void) = 0 ;
	virtual bool __fastcall GetIsNamespaceRoot(void) = 0 ;
	virtual bool __fastcall GetIsFile(void) = 0 ;
	virtual bool __fastcall GetIsFileFolder(void) = 0 ;
	virtual bool __fastcall GetIsFileSystem(void) = 0 ;
	virtual bool __fastcall GetIsLink(void) = 0 ;
	virtual bool __fastcall GetIsShared(void) = 0 ;
	virtual bool __fastcall GetCanCopy(void) = 0 ;
	virtual bool __fastcall GetCanPaste(void) = 0 ;
	virtual bool __fastcall GetCanLink(void) = 0 ;
	virtual bool __fastcall GetCanRename(void) = 0 ;
	virtual bool __fastcall GetHasPropSheet(void) = 0 ;
	virtual bool __fastcall GetHasRemovableMedia(void) = 0 ;
	virtual bool __fastcall GetHasSubFolder(void) = 0 ;
	virtual bool __fastcall GetIsCompressed(void) = 0 ;
	virtual bool __fastcall GetIsDropTarget(void) = 0 ;
	virtual bool __fastcall GetIsFileSystemAncestor(void) = 0 ;
	virtual bool __fastcall GetIsFolder(void) = 0 ;
	virtual bool __fastcall GetIsGhosted(void) = 0 ;
	virtual bool __fastcall GetIsHidden(void) = 0 ;
	virtual bool __fastcall GetIsReadOnly(void) = 0 ;
	virtual System::Classes::TStringList* __fastcall GetDetails(void) = 0 ;
	virtual _di_IShellFolder __fastcall GetParentShellFolderIntf(void) = 0 ;
	virtual _di_IDropTarget __fastcall GetDropTargetIntf(void) = 0 ;
	virtual bool __fastcall GetDetailsEx(int ColID, System::UnicodeString &Res);
	virtual void __fastcall SetChecked(const bool Value);
	
public:
	__fastcall virtual TLMDCustomShellItem(TLMDShellComponent* aController);
	__fastcall virtual ~TLMDCustomShellItem(void);
	virtual void __fastcall Delete(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Assign(TLMDCustomShellItem* aSource);
	TShellItemDetailsInfoArray __fastcall GetDetailsInfo(void);
	System::UnicodeString __fastcall GetDetailItem(TLMDShellItemDetailsColumn ItemType);
	virtual void __fastcall LoadDetailsEx(const int *ColIDs, const int ColIDs_High);
	__property TLMDShellComponent* Controller = {read=FController};
	__property Winapi::Shlobj::PItemIDList AbsoluteID = {read=FAbsoluteID};
	__property System::TDateTime AccessDate = {read=GetAccessDate};
	__property bool CanCopy = {read=GetCanCopy, nodefault};
	__property bool CanLink = {read=GetCanLink, nodefault};
	__property bool CanPaste = {read=GetCanPaste, nodefault};
	__property bool CanRename = {read=GetCanRename, nodefault};
	__property TLMDShellFolderCapabilities Capabilities = {read=GetFileCapabilities, nodefault};
	__property bool Checked = {read=FChecked, write=SetChecked, nodefault};
	__property System::TDateTime CreationDate = {read=GetCreationDate};
	__property unsigned Data = {read=FData, write=FData, nodefault};
	__property System::Classes::TStringList* Details = {read=GetDetails};
	__property System::UnicodeString DetailsEx[int ColID] = {read=int_GetDetailsEx};
	__property System::UnicodeString DisplayName = {read=GetDisplayName};
	__property int DriveType = {read=GetDriveType, nodefault};
	__property _di_IDropTarget DropTargetIntf = {read=GetDropTargetIntf};
	__property unsigned DWFileAttributes = {read=GetDWFileAttributes, nodefault};
	__property System::UnicodeString ExtDisplayName = {read=GetExtDisplayName};
	__property System::UnicodeString Extension = {read=GetExtension};
	__property TLMDShellFileAttributes FileAttributes = {read=GetFileAttributes, nodefault};
	__property System::UnicodeString FileAttributesStr = {read=GetFileAttributesStr};
	__property TLMDShellFolderCapabilities FileCapabilities = {read=GetFileCapabilities, nodefault};
	__property TLMDShellFolderProperties FileProperties = {read=GetFileProperties, nodefault};
	__property __int64 FileSize = {read=GetFileSize};
	__property bool HasPropSheet = {read=GetHasPropSheet, nodefault};
	__property bool HasRemovableMedia = {read=GetHasRemovableMedia, nodefault};
	__property bool HasSubFolder = {read=GetHasSubFolder, nodefault};
	__property int IconIndex = {read=GetIconIndex, nodefault};
	__property bool IsCompressed = {read=GetIsCompressed, nodefault};
	__property bool IsDropTarget = {read=GetIsDropTarget, nodefault};
	__property bool IsFile = {read=GetIsFile, nodefault};
	__property bool IsFileFolder = {read=GetIsFileFolder, nodefault};
	__property bool IsFileSystem = {read=GetIsFileSystem, nodefault};
	__property bool IsFileSystemAncestor = {read=GetIsFileSystemAncestor, nodefault};
	__property bool IsFolder = {read=GetIsFolder, nodefault};
	__property bool IsGhosted = {read=GetIsGhosted, nodefault};
	__property bool IsHidden = {read=GetIsHidden, nodefault};
	__property bool IsLink = {read=GetIsLink, nodefault};
	__property bool IsNamespaceRoot = {read=GetIsNamespaceRoot, nodefault};
	__property bool IsReadOnly = {read=GetIsReadOnly, nodefault};
	__property bool IsShared = {read=GetIsShared, nodefault};
	__property Vcl::Graphics::TIcon* LargeIcon = {read=GetLargeIcon};
	__property Vcl::Graphics::TIcon* LargeOpenIcon = {read=GetLargeOpenIcon};
	__property int Level = {read=FLevel, write=FLevel, nodefault};
	__property System::TDateTime ModifiedDate = {read=GetModifiedDate};
	__property int OpenIconIndex = {read=GetOpenIconIndex, nodefault};
	__property int OverlayIconIndex = {read=GetOverlayIconIndex, nodefault};
	__property _di_IShellFolder ParentShellFolderIntf = {read=GetParentShellFolderIntf};
	__property System::UnicodeString Path = {read=GetPath};
	__property System::UnicodeString PathName = {read=GetPath};
	__property Winapi::Shlobj::PItemIDList RelativeID = {read=FRelativeID};
	__property System::UnicodeString ShortFileName = {read=GetShortFileName};
	__property Vcl::Graphics::TIcon* SmallIcon = {read=GetSmallIcon};
	__property Vcl::Graphics::TIcon* SmallOpenIcon = {read=GetSmallOpenIcon};
	__property System::UnicodeString TypeName = {read=GetTypeName};
	__property System::TObject* CustomData = {read=FCustomData, write=FCustomData};
	__property bool OwnedCustomData = {read=FOwnedCustomData, write=FOwnedCustomData, nodefault};
	__property TLMDCustomShellItemCheckedEvent OnCheckItem = {read=FOnCheckItem, write=FOnCheckItem};
	__property TLMDShellDummyItems* Items = {read=FDummyItems};
};


typedef int __fastcall (__closure *TLMDShellItemsCompareFunc)(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);

class PASCALIMPLEMENTATION TLMDShellItemsList : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	TLMDCustomShellItem* operator[](int index) { return this->Item[index]; }
	
private:
	TLMDShellItemDetailsColumn FDetailsColumn;
	System::Classes::TList* FList;
	System::Classes::TStrings* FDetailsData;
	TLMDCustomShellItemCheckedEvent FOnCheckItem;
	TLMDCustomShellItem* __fastcall GetItem(int index);
	int __fastcall GetCount(void);
	int __fastcall CompareByAbsoluteID(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByRelativeID(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByName(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByDetails(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByDetailsEx(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByExtension(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByTypeName(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByAttributes(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByFileSize(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByModifiedDate(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByAccessDate(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	int __fastcall CompareByCreationDate(TLMDCustomShellItem* Item1, TLMDCustomShellItem* Item2);
	void __fastcall Sort(TLMDShellItemsCompareFunc aCompareFunc);
	
public:
	__fastcall TLMDShellItemsList(void);
	__fastcall virtual ~TLMDShellItemsList(void);
	TLMDCustomShellItem* __fastcall Add(TLMDCustomShellItem* aItem);
	void __fastcall Insert(int aIndex, TLMDCustomShellItem* aItem);
	void __fastcall Clear(void);
	void __fastcall Delete(int aIndex)/* overload */;
	void __fastcall Delete(TLMDCustomShellItem* AItem)/* overload */;
	void __fastcall SortByAbsoluteID(void);
	void __fastcall SortByRelativeID(void);
	void __fastcall SortByName(void);
	void __fastcall SortByDetails(int Index)/* overload */;
	void __fastcall SortByDetails(TLMDShellItemDetailsColumn aColumn)/* overload */;
	void __fastcall SortByDetailsEx(TLMDShellItemDetailsColumn aColumn);
	void __fastcall SortByExtension(void);
	void __fastcall SortByTypeName(void);
	void __fastcall SortByAttributes(void);
	void __fastcall SortByFileSize(void);
	void __fastcall SortByModifiedDate(void);
	void __fastcall SortByAccessDate(void);
	void __fastcall SortByCreationDate(void);
	__property TLMDCustomShellItem* Item[int index] = {read=GetItem/*, default*/};
	__property int Count = {read=GetCount, nodefault};
	__property TLMDCustomShellItemCheckedEvent OnCheckItem = {read=FOnCheckItem, write=FOnCheckItem};
};


class PASCALIMPLEMENTATION TLMDShellItems : public TLMDShellItemsList
{
	typedef TLMDShellItemsList inherited;
	
public:
	HIDESBASE void __fastcall Clear(void);
	HIDESBASE void __fastcall Delete(int aIndex);
public:
	/* TLMDShellItemsList.Create */ inline __fastcall TLMDShellItems(void) : TLMDShellItemsList() { }
	/* TLMDShellItemsList.Destroy */ inline __fastcall virtual ~TLMDShellItems(void) { }
	
};


enum DECLSPEC_DENUM TLMDShellEnumOption : unsigned char { eoFolders, eoNonFolders, eoIncludeHidden };

typedef System::Set<TLMDShellEnumOption, TLMDShellEnumOption::eoFolders, TLMDShellEnumOption::eoIncludeHidden> TLMDShellEnumOptions;

class PASCALIMPLEMENTATION TLMDCustomShellController : public TLMDShellComponent
{
	typedef TLMDShellComponent inherited;
	
private:
	System::Classes::TList* FViews;
	System::TObject* FDragSource;
	void __fastcall ClearViews(void);
	void __fastcall NotifyParentChange(Winapi::Shlobj::PItemIDList aPIDL);
	
protected:
	TLMDCustomShellItem* FActiveFolder;
	void __fastcall DoFileChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFileDelete(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFileRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoFolderChange(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderCreate(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderDelete(Winapi::Shlobj::PItemIDList aPIDL);
	void __fastcall DoFolderRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	void __fastcall DoDriveChanged(Winapi::Shlobj::PItemIDList aPIDL, bool IsAdded);
	void __fastcall DoMediaChanged(Winapi::Shlobj::PItemIDList aPIDL, bool IsInserted);
	void __fastcall DoNetShare(Winapi::Shlobj::PItemIDList aPIDL, bool IsShared);
	void __fastcall SetActiveFolder(TLMDCustomShellItem* const aValue);
	System::TObject* __fastcall GetView(int Index);
	int __fastcall GetViewCount(void);
	void __fastcall ActiveFolderChanged(void);
	virtual void __fastcall TriggerActiveFolderChanged(void);
	
public:
	__fastcall virtual TLMDCustomShellController(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDCustomShellController(void);
	void __fastcall RegisterView(System::TObject* aView);
	void __fastcall UnRegisterView(System::TObject* aView);
	virtual TLMDCustomShellItem* __fastcall CreateShellItem(Winapi::Shlobj::PItemIDList aPIDL) = 0 /* overload */;
	virtual TLMDCustomShellItem* __fastcall CreateShellItem(const System::UnicodeString aPath) = 0 /* overload */;
	virtual void __fastcall Enumerate(Winapi::Shlobj::PItemIDList aPIDL, System::TObject* aView, TLMDShellEnumOptions aEnumOptions) = 0 ;
	virtual Winapi::Shlobj::PItemIDList __fastcall GetNamespaceRootID(void) = 0 ;
	virtual Winapi::Shlobj::PItemIDList __fastcall GetComboExtID(void) = 0 ;
	virtual bool __fastcall ID_HasChildren(Winapi::Shlobj::PItemIDList aPIDL, TLMDShellEnumOptions aEnumOptions) = 0 ;
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_Clone(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_FindLast(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_CloneFirst(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_Combine(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2) = 0 ;
	virtual Winapi::Shlobj::PItemIDList __fastcall ID_Next(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual bool __fastcall ID_RemoveLastID(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual System::Word __fastcall ID_Size(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual int __fastcall ID_Compare(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2, Winapi::Shlobj::PItemIDList aAbsoluteID = (Winapi::Shlobj::PItemIDList)(0x0)) = 0 ;
	virtual void __fastcall ID_Free(Winapi::Shlobj::PItemIDList aPIDL) = 0 ;
	virtual void __fastcall ChDir(Winapi::Shlobj::PItemIDList aPIDL)/* overload */;
	virtual void __fastcall ChDir(const System::UnicodeString aPath)/* overload */;
	virtual void __fastcall LevelUp(void) = 0 ;
	virtual void __fastcall GoBack(int index = 0xffffffff) = 0 ;
	virtual void __fastcall GoForward(int index = 0xffffffff) = 0 ;
	virtual bool __fastcall ExecuteDefault(TLMDCustomShellItem* aItem) = 0 ;
	virtual bool __fastcall ShowPropertySheet(TLMDCustomShellItem* aItem) = 0 ;
	virtual bool __fastcall CopyToClipboard(TLMDCustomShellItem* aItem) = 0 ;
	virtual bool __fastcall CutToClipboard(TLMDCustomShellItem* aItem) = 0 ;
	virtual bool __fastcall PasteFromClipboard(TLMDCustomShellItem* aItem) = 0 ;
	virtual bool __fastcall RenameItem(TLMDCustomShellItem* aItem, const System::UnicodeString aNewName) = 0 ;
	virtual bool __fastcall DeleteItem(TLMDCustomShellItem* aItem) = 0 ;
	virtual System::UnicodeString __fastcall NewFolder(void) = 0 ;
	__property System::TObject* Views[int Index] = {read=GetView};
	__property int ViewCount = {read=GetViewCount, nodefault};
	__property TLMDCustomShellItem* ActiveFolder = {read=FActiveFolder, write=SetActiveFolder};
	__property Winapi::Shlobj::PItemIDList NamespaceRootID = {read=GetNamespaceRootID};
	__property Winapi::Shlobj::PItemIDList ComboExtID = {read=GetComboExtID};
	__property System::TObject* DragSource = {read=FDragSource, write=FDragSource};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 cErrShVersion = System::Int8(0x0);
static const System::Int8 cErrInvalidFolder = System::Int8(0x1);
static const System::Int8 cMaxCode = System::Int8(0x1);
#define sRFDesktop L"sfDesktop"
#define sRFFavorites L"sfFavorites"
#define sDisplayPositionPrefix L" on "
extern DELPHI_PACKAGE TLMDShellBoolExt __fastcall BoolToExt(bool aValue);
extern DELPHI_PACKAGE bool __fastcall ExtToBool(TLMDShellBoolExt aValue);
extern DELPHI_PACKAGE bool __fastcall i_BindToISHellFolder(_di_IShellFolder Folder, Winapi::Shlobj::PItemIDList PIDL, _di_IShellFolder &Res);
extern DELPHI_PACKAGE GUID __fastcall i_CLSIDFromString(const System::UnicodeString psz);
}	/* namespace Lmdshbase */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHBASE)
using namespace Lmdshbase;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshbaseHPP
