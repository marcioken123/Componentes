// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebTree.pas' rev: 31.00 (Windows)

#ifndef LmdwebtreeHPP
#define LmdwebtreeHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDHTMLObjectUnit.hpp>
#include <LMDDownload.hpp>
#include <LMDClassLib.hpp>
#include <LMDHASHList.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebtree
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebTreeParams;
class DELPHICLASS TLMDWebTreeItem;
class DELPHICLASS TLMDWebTree;
class DELPHICLASS TLMDWebTaskItem;
class DELPHICLASS TLMDWebTasks;
class DELPHICLASS TLMDWebFolderItem;
class DELPHICLASS TLMDWebFolders;
class DELPHICLASS TLMDWebProject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDWebFileType : unsigned char { ftNone, ftHTML, ftImage, ftAudio, ftVideo, ftApplication, ftText, ftFolder, ftData };

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebTreeParams : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	Lmdhashlist::TLMDHashStringList* FLinks;
	NativeUInt FSem;
	void __fastcall InternalReplaceLink(System::Word Hash, int i, System::TObject* aObject);
	
public:
	bool bDontReplace;
	bool IsLoading;
	__fastcall TLMDWebTreeParams(void);
	__fastcall virtual ~TLMDWebTreeParams(void);
	__property Lmdhashlist::TLMDHashStringList* GlobalLinks = {read=FLinks};
	void __fastcall AddLink(const System::UnicodeString URL, System::TObject* aObject, bool bSafe = false);
	void __fastcall DelLink(System::TObject* aObject);
	void __fastcall AddSubLink(const System::UnicodeString URL, System::TObject* aObject, bool bCreateNew = true);
	bool __fastcall CheckLink(const System::UnicodeString URL, System::TObject* aObject, bool bReplace = true);
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDWebTreeItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FURL;
	Lmddownload::TLMDDownloadState FDS;
	System::UnicodeString FFilename;
	TLMDWebFileType FFileType;
	System::UnicodeString FsFileType;
	TLMDWebTree* FORTree;
	TLMDWebTreeItem* FORTreeItem;
	Lmdhtmlobjectunit::TLMDHTMLObject* FObject;
	Lmddownload::TLMDDownloadItem* FDownloadItem;
	unsigned FdwError;
	System::UnicodeString FErrorString;
	int FTag;
	System::TObject* FUserData;
	bool FNew;
	bool FIsTreeLink;
	System::Classes::TList* FLinkedItems;
	TLMDWebTreeItem* FParentLinkedItem;
	int FCPS;
	int FDataSize;
	System::TDateTime FDate;
	System::TObject* FData;
	void __fastcall SetURL(const System::UnicodeString Value);
	TLMDWebTree* __fastcall GetParent(void);
	void __fastcall SetdwError(const unsigned Value);
	void __fastcall SetErrorString(const System::UnicodeString Value);
	int __fastcall GetLevel(void);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall SetIsTreeLink(const bool Value);
	System::UnicodeString __fastcall GetTitle(void);
	System::UnicodeString __fastcall GetTitleEx(const System::UnicodeString szRelative);
	TLMDWebTreeItem* __fastcall GetLinkedItem(int Index);
	void __fastcall SetCPS(const int Value);
	void __fastcall SetDataSize(const int Value);
	void __fastcall SetDate(const System::TDateTime Value);
	
protected:
	virtual void __fastcall Loaded(void);
	virtual void __fastcall DefineProperties(System::Classes::TFiler* Filer);
	
public:
	__fastcall virtual TLMDWebTreeItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDWebTreeItem(void);
	void __fastcall DeleteLocalFile(void);
	void __fastcall AddLinked(TLMDWebTreeItem* Item);
	void __fastcall DelLinked(TLMDWebTreeItem* Item);
	__property TLMDWebTree* Parent = {read=GetParent};
	void __fastcall UpdateLinks(void);
	void __fastcall UpdateSubTree(void);
	void __fastcall UpdateFileType(void);
	__property System::UnicodeString Caption = {read=GetCaption};
	__property System::UnicodeString Title = {read=GetTitle};
	__property Lmddownload::TLMDDownloadItem* DownloadItem = {read=FDownloadItem, write=FDownloadItem};
	__property unsigned dwError = {read=FdwError, write=SetdwError, nodefault};
	__property System::UnicodeString ErrorString = {read=FErrorString, write=SetErrorString};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::TObject* Data = {read=FData, write=FData};
	__property System::TObject* UserData = {read=FUserData, write=FUserData};
	__property bool bNew = {read=FNew, write=FNew, default=1};
	__property TLMDWebTreeItem* ParentLinkedItem = {read=FParentLinkedItem, write=FParentLinkedItem};
	__property System::Classes::TList* LinkedItems = {read=FLinkedItems};
	__property TLMDWebTreeItem* LinkedItem[int Index] = {read=GetLinkedItem};
	__property Lmdhtmlobjectunit::TLMDHTMLObject* Object_ = {read=FObject, write=FObject};
	
__published:
	__property bool IsTreeLink = {read=FIsTreeLink, write=SetIsTreeLink, default=0};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
	__property System::TDateTime Date = {read=FDate, write=SetDate};
	__property Lmddownload::TLMDDownloadState DownloadState = {read=FDS, write=FDS, nodefault};
	__property System::UnicodeString Filename = {read=FFilename, write=FFilename};
	__property TLMDWebFileType FileType = {read=FFileType, write=FFileType, nodefault};
	__property System::UnicodeString StrFileType = {read=FsFileType, write=FsFileType};
	__property int Level = {read=GetLevel, default=0};
	__property TLMDWebTree* SubTree = {read=FORTree, write=FORTree};
	__property TLMDWebTreeItem* UpperTreeItem = {read=FORTreeItem, write=FORTreeItem};
	__property int CPS = {read=FCPS, write=SetCPS, default=0};
	__property int DataSize = {read=FDataSize, write=SetDataSize, default=0};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebTree : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDWebTreeItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TLMDWebTreeItem* FUpLevel;
	TLMDWebTaskItem* FTask;
	TLMDWebTreeParams* FParams;
	HIDESBASE TLMDWebTreeItem* __fastcall GetItem(int Index);
	int __fastcall GetIndexOf(const System::UnicodeString URL);
	int __fastcall GetCPS(void);
	int __fastcall GetTotalFiles(void);
	int __fastcall GetTotalImages(void);
	int __fastcall GetTotalB(void);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall TLMDWebTree(TLMDWebTreeParams* aParams, TLMDWebTaskItem* aTask);
	HIDESBASE TLMDWebTreeItem* __fastcall Add(void);
	void __fastcall DeleteLocalFiles(void);
	void __fastcall UpdateLinks(void);
	__property TLMDWebTreeItem* Item[int Index] = {read=GetItem/*, default*/};
	__property TLMDWebTreeItem* UpLevel = {read=FUpLevel};
	__property TLMDWebTreeParams* Params = {read=FParams};
	__property int IndexOf[const System::UnicodeString URL] = {read=GetIndexOf};
	__property TLMDWebTaskItem* Task = {read=FTask};
	__property int CPS = {read=GetCPS, default=0};
	__property int TotalB = {read=GetTotalB, default=0};
	__property int TotalFiles = {read=GetTotalFiles, default=0};
	__property int TotalImages = {read=GetTotalImages, default=0};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDWebTree(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDWebTaskItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	TLMDWebTree* FObject;
	bool FLoadOtherSites;
	int FDepth;
	System::UnicodeString FDefaultFileName;
	System::UnicodeString FDestinationDir;
	System::UnicodeString FBaseURL;
	System::UnicodeString FHost;
	System::UnicodeString FTaskName;
	int FTag;
	System::TObject* FUserData;
	System::UnicodeString FUserName;
	System::UnicodeString FPassword;
	System::Classes::TStringList* FExcludedExt;
	System::Classes::TStringList* FExcludedTypes;
	TLMDWebTree* FMap;
	int FItemID;
	System::TDateTime FWorkTime;
	System::TDateTime FCreateTime;
	System::TDateTime FUpdateTime;
	Lmdhtmlobjectunit::TLMDLinkConversion FLinkConversion;
	int FMaxDownloadKB;
	bool FUpdate;
	bool FStrongUpdate;
	TLMDWebTreeParams* FTreeParams;
	bool FSaveFiles;
	System::Classes::TStringList* FAcceptTypes;
	System::UnicodeString FDefaultExtension;
	bool FAutoReset;
	void __fastcall SetObject(TLMDWebTree* const Value);
	void __fastcall SetBaseURL(const System::UnicodeString Value);
	void __fastcall SetPassword(const System::UnicodeString Value);
	void __fastcall SetUserName(const System::UnicodeString Value);
	void __fastcall SetExcludedExt(System::Classes::TStringList* const Value);
	void __fastcall SetExcludedTypes(System::Classes::TStringList* const Value);
	void __fastcall SetMap(TLMDWebTree* const Value);
	void __fastcall SetItemID(const int Value);
	int __fastcall GetCPS(void);
	int __fastcall GetTotalFiles(void);
	int __fastcall GetTotalImages(void);
	int __fastcall GetTotalB(void);
	System::TDateTime __fastcall GetTotalTime(void);
	void __fastcall SetWorkTime(const System::TDateTime Value);
	void __fastcall SetCreateTime(const System::TDateTime Value);
	void __fastcall SetUpdateTime(const System::TDateTime Value);
	void __fastcall SeTLMDLinkConversion(const Lmdhtmlobjectunit::TLMDLinkConversion Value);
	void __fastcall SetMaxDownloadKB(const int Value);
	TLMDWebTree* __fastcall GetItemObject(void);
	void __fastcall SetStrongUpdate(const bool Value);
	void __fastcall SetUpdate(const bool Value);
	void __fastcall SetTreeParams(TLMDWebTreeParams* const Value);
	TLMDWebTreeParams* __fastcall GetTreeParams(void);
	void __fastcall SetSaveFiles(const bool Value);
	void __fastcall SetAcceptTypes(System::Classes::TStringList* const Value);
	void __fastcall SetDefaultExtension(const System::UnicodeString Value);
	void __fastcall SetAutoReset(const bool Value);
	
public:
	System::TDateTime StartTime;
	bool Activated;
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDWebTaskItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDWebTaskItem(void);
	void __fastcall AddToMap(TLMDWebTreeItem* TI, bool bOtherSites = true);
	void __fastcall BuildMap(bool bOtherSites = true);
	virtual void __fastcall ActivateProject(void);
	__property System::UnicodeString Host = {read=FHost};
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::TObject* UserData = {read=FUserData, write=FUserData};
	__property TLMDWebTree* Map = {read=FMap, write=SetMap};
	__property int CPS = {read=GetCPS, default=0};
	__property int TotalB = {read=GetTotalB, default=0};
	__property int TotalFiles = {read=GetTotalFiles, default=0};
	__property int TotalImages = {read=GetTotalImages, default=0};
	__property System::TDateTime TotalTime = {read=GetTotalTime};
	__property TLMDWebTreeParams* TreeParams = {read=GetTreeParams, write=SetTreeParams};
	
__published:
	__property int MaxDownloadKB = {read=FMaxDownloadKB, write=SetMaxDownloadKB, default=0};
	__property Lmdhtmlobjectunit::TLMDLinkConversion LinkConversion = {read=FLinkConversion, write=SeTLMDLinkConversion, nodefault};
	__property System::TDateTime CreateTime = {read=FCreateTime, write=SetCreateTime};
	__property System::TDateTime UpdateTime = {read=FUpdateTime, write=SetUpdateTime};
	__property System::TDateTime WorkTime = {read=FWorkTime, write=SetWorkTime};
	__property int ItemID = {read=FItemID, write=SetItemID, default=0};
	__property System::Classes::TStringList* ExcludedTypes = {read=FExcludedTypes, write=SetExcludedTypes};
	__property System::Classes::TStringList* ExcludedExt = {read=FExcludedExt, write=SetExcludedExt};
	__property TLMDWebTree* Tree = {read=GetItemObject, write=SetObject};
	__property int Depth = {read=FDepth, write=FDepth, default=4};
	__property bool LoadOtherSites = {read=FLoadOtherSites, write=FLoadOtherSites, default=0};
	__property System::UnicodeString DefaultFileName = {read=FDefaultFileName, write=FDefaultFileName};
	__property System::UnicodeString DestinationDir = {read=FDestinationDir, write=FDestinationDir};
	__property System::UnicodeString BaseURL = {read=FBaseURL, write=SetBaseURL};
	__property System::UnicodeString TaskName = {read=FTaskName, write=FTaskName};
	__property System::UnicodeString UserName = {read=FUserName, write=SetUserName};
	__property System::UnicodeString Password = {read=FPassword, write=SetPassword};
	__property bool Update = {read=FUpdate, write=SetUpdate, default=1};
	__property bool SaveFiles = {read=FSaveFiles, write=SetSaveFiles, default=1};
	__property bool StrongUpdate = {read=FStrongUpdate, write=SetStrongUpdate, default=1};
	__property System::Classes::TStringList* AcceptTypes = {read=FAcceptTypes, write=SetAcceptTypes};
	__property System::UnicodeString DefaultExtension = {read=FDefaultExtension, write=SetDefaultExtension};
	__property bool AutoReset = {read=FAutoReset, write=SetAutoReset, default=1};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebTasks : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDWebTaskItem* operator[](int Index) { return this->Item[Index]; }
	
private:
	TLMDWebTreeParams* FTreeParams;
	TLMDWebFolderItem* FFolderItem;
	HIDESBASE TLMDWebTaskItem* __fastcall GetItem(int Index);
	TLMDWebTaskItem* __fastcall GetItemByID(int ID);
	
public:
	__fastcall TLMDWebTasks(TLMDWebTreeParams* TreeParams, TLMDWebFolderItem* FolderItem);
	__fastcall virtual ~TLMDWebTasks(void);
	HIDESBASE TLMDWebTaskItem* __fastcall Add(void);
	int __fastcall GetUniqueID(void);
	__property TLMDWebTaskItem* ItemByID[int ID] = {read=GetItemByID};
	__property TLMDWebTaskItem* Item[int Index] = {read=GetItem/*, default*/};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebFolderItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FFolderName;
	TLMDWebTasks* FTasks;
	int FTag;
	System::TObject* FUserData;
	void __fastcall SetTasks(TLMDWebTasks* const Value);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDWebFolderItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDWebFolderItem(void);
	__property int Tag = {read=FTag, write=FTag, default=0};
	__property System::TObject* UserData = {read=FUserData, write=FUserData};
	
__published:
	__property TLMDWebTasks* Tasks = {read=FTasks, write=SetTasks};
	__property System::UnicodeString FolderName = {read=FFolderName, write=FFolderName};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebFolders : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDWebFolderItem* operator[](int Index) { return this->Folder[Index]; }
	
private:
	TLMDWebTreeParams* FTreeParams;
	TLMDWebFolderItem* __fastcall GetFolder(int Index);
	TLMDWebTaskItem* __fastcall GetTaskByID(int ID);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall TLMDWebFolders(TLMDWebTreeParams* TreeParams);
	HIDESBASE TLMDWebFolderItem* __fastcall Add(void);
	__property TLMDWebTaskItem* TaskByID[int ID] = {read=GetTaskByID};
	__property TLMDWebFolderItem* Folder[int Index] = {read=GetFolder/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDWebFolders(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDWebProject : public Lmdclasslib::TLMDSerializable
{
	typedef Lmdclasslib::TLMDSerializable inherited;
	
private:
	TLMDWebFolders* FFolders;
	TLMDWebTreeParams* FTreeParams;
	System::Classes::TStringList* FLog;
	System::Classes::TNotifyEvent FOnUpdateLog;
	void __fastcall SetFolders(TLMDWebFolders* const Value);
	void __fastcall SetLog(System::Classes::TStringList* const Value);
	void __fastcall SetOnUpdateLog(const System::Classes::TNotifyEvent Value);
	
protected:
	virtual void __fastcall Loading(void);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall TLMDWebProject(void);
	__fastcall virtual ~TLMDWebProject(void);
	void __fastcall AddToLog(System::UnicodeString szStr);
	__property TLMDWebTreeParams* TreeParams = {read=FTreeParams};
	__property System::Classes::TNotifyEvent OnUpdateLog = {read=FOnUpdateLog, write=SetOnUpdateLog};
	
__published:
	__property TLMDWebFolders* Folders = {read=FFolders, write=SetFolders};
	__property System::Classes::TStringList* Log = {read=FLog, write=SetLog};
	__property Compressed = {default=0};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebtree */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBTREE)
using namespace Lmdwebtree;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebtreeHPP
