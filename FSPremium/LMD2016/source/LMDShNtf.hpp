// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDShNtf.pas' rev: 31.00 (Windows)

#ifndef LmdshntfHPP
#define LmdshntfHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.ShlObj.hpp>
#include <Winapi.Messages.hpp>
#include <LMDShPIDL.hpp>
#include <LMDShBase.hpp>
#include <LMDShMisc.hpp>
#include <LMDShUtils.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdshntf
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDShellNotificationItem;
class DELPHICLASS TLMDShellNotificationEvents;
class DELPHICLASS TLMDShellNotify;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDShellNotifyEventType : unsigned char { snAnyEvent, snDiskEvent, snGlobalEvent, snAssociationChanged, snAttributesChanged, snDriveAdded, snDriveRemoved, snItemCreated, snItemDeleted, snItemUpdated, snItemRenamed, snFolderCreated, snFolderDeleted, snFolderRenamed, snFolderUpdated, snFreespaceChanged, snImageUpdated, snMediaInserted, snMediaRemoved, snNetworkDriveAdded, snResourceShared, snResourceUnshared, snServerDisconnected };

typedef System::Set<TLMDShellNotifyEventType, TLMDShellNotifyEventType::snAnyEvent, TLMDShellNotifyEventType::snServerDisconnected> TLMDShellNotifyEventTypes;

enum DECLSPEC_DENUM TLMDShellInterruptOption : unsigned char { ioAcceptInterrupts, ioAcceptNonInterrupts };

typedef System::Set<TLMDShellInterruptOption, TLMDShellInterruptOption::ioAcceptInterrupts, TLMDShellInterruptOption::ioAcceptNonInterrupts> TLMDShellInterruptOptions;

typedef void __fastcall (__closure *TLMDShellNotifyEvent1)(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL);

typedef void __fastcall (__closure *TLMDShellNotifyEvent2)(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);

typedef void __fastcall (__closure *TLMDShellNotifyEvent3)(System::TObject* aSender, Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2, TLMDShellNotifyEventTypes aEvents);

typedef void __fastcall (__closure *TLMDShellNotifyEvent4)(System::TObject* aSender, unsigned aDrive);

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellNotificationItem : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	_ITEMIDLIST *FPidl1;
	_ITEMIDLIST *FPidl2;
	unsigned FEventMask;
	
public:
	__fastcall TLMDShellNotificationItem(Winapi::Shlobj::PItemIDList aPidl1, Winapi::Shlobj::PItemIDList aPidl2, unsigned aMask);
	__fastcall virtual ~TLMDShellNotificationItem(void);
	__property unsigned EventMask = {read=FEventMask, write=FEventMask, nodefault};
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDShellNotificationEvents : public System::TObject
{
	typedef System::TObject inherited;
	
private:
	System::Classes::TList* FItems;
	int __fastcall GetCount(void);
	TLMDShellNotificationItem* __fastcall GetHead(void);
	
public:
	__fastcall TLMDShellNotificationEvents(void);
	__fastcall virtual ~TLMDShellNotificationEvents(void);
	TLMDShellNotificationItem* __fastcall Add(TLMDShellNotificationItem* aItem);
	void __fastcall Clear(void);
	void __fastcall PopHead(void);
	__property TLMDShellNotificationItem* Head = {read=GetHead};
	__property int Count = {read=GetCount, nodefault};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDShellNotify : public Lmdshbase::TLMDShellComponent
{
	typedef Lmdshbase::TLMDShellComponent inherited;
	
private:
	bool FActive;
	TLMDShellNotifyEventTypes FNotifyEvents;
	TLMDShellInterruptOptions FOptions;
	System::UnicodeString FWatchFolder;
	_ITEMIDLIST *FWatchPidl;
	bool FWatchSubFolders;
	Lmdshutils::TLMDRoot FRootFolder;
	int FMaxNotifications;
	HWND FHandle;
	bool FRegistered;
	NativeUInt FHNotify;
	TLMDShellNotificationEvents* FEvents;
	TLMDShellNotifyEventTypes FSNotifyEvents;
	int FRenameCounter;
	int FDeleteCounter;
	System::Classes::TNotifyEvent FOnAssociationChange;
	TLMDShellNotifyEvent2 FOnAttributeChange;
	TLMDShellNotifyEvent1 FOnDriveAdd;
	TLMDShellNotifyEvent1 FOnDriveRemove;
	TLMDShellNotifyEvent4 FOnDriveSpaceChange;
	TLMDShellNotifyEvent1 FOnFileChange;
	TLMDShellNotifyEvent1 FOnFileCreate;
	TLMDShellNotifyEvent2 FOnFileDelete;
	TLMDShellNotifyEvent2 FOnFileRename;
	TLMDShellNotifyEvent1 FOnFolderChange;
	TLMDShellNotifyEvent1 FOnFolderCreate;
	TLMDShellNotifyEvent1 FOnFolderDelete;
	TLMDShellNotifyEvent2 FOnFolderRename;
	System::Classes::TNotifyEvent FOnImageListChange;
	TLMDShellNotifyEvent1 FOnMediaInsert;
	TLMDShellNotifyEvent1 FOnMediaRemove;
	TLMDShellNotifyEvent1 FOnNetShare;
	TLMDShellNotifyEvent1 FOnNetUnShare;
	TLMDShellNotifyEvent1 FOnServerDisconnect;
	TLMDShellNotifyEvent3 FOnShellChangeNotify;
	TLMDShellNotifyEvent1 FOnShellDriveAdd;
	void __fastcall SetActive(const bool aValue);
	void __fastcall SetNotifyEvents(const TLMDShellNotifyEventTypes aValue);
	void __fastcall SetOptions(const TLMDShellInterruptOptions aValue);
	void __fastcall SetRootFolder(const Lmdshutils::TLMDRoot aValue);
	void __fastcall SetWatchFolder(const System::UnicodeString aValue);
	void __fastcall SetWatchPidl(Winapi::Shlobj::PItemIDList aValue);
	void __fastcall SetWatchSubFolders(const bool aValue);
	Winapi::Shlobj::PItemIDList __fastcall GetRenamedPIDL(Winapi::Shlobj::PItemIDList aPIDL);
	
protected:
	virtual void __fastcall Loaded(void);
	void __fastcall WndProc(Winapi::Messages::TMessage &Msg);
	void __fastcall ShellNotifyRegister(void);
	void __fastcall ShellNotifyUnRegister(void);
	virtual void __fastcall DoAssociationChange(void);
	virtual void __fastcall DoAttributesChange(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	virtual void __fastcall DoDriveAdd(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoDriveRemove(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoDriveSpaceChange(unsigned aDrives);
	virtual void __fastcall DoFileChange(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoFileCreate(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoFileDelete(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	virtual void __fastcall DoFileRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	virtual void __fastcall DoFolderChange(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoFolderCreate(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoFolderDelete(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoFolderRename(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2);
	virtual void __fastcall DoImageListChange(void);
	virtual void __fastcall DoMediaInsert(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoMediaRemove(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoNetShare(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoNetUnShare(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoServerDisconnect(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoShellDriveAdd(Winapi::Shlobj::PItemIDList aPIDL);
	virtual void __fastcall DoShellChangeNotify(Winapi::Shlobj::PItemIDList aPIDL1, Winapi::Shlobj::PItemIDList aPIDL2, TLMDShellNotifyEventTypes aEvents);
	
public:
	__fastcall virtual TLMDShellNotify(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDShellNotify(void);
	__property Winapi::Shlobj::PItemIDList WatchPidl = {read=FWatchPidl, write=SetWatchPidl};
	
__published:
	__property bool Active = {read=FActive, write=SetActive, nodefault};
	__property TLMDShellNotifyEventTypes NotifyEvents = {read=FNotifyEvents, write=SetNotifyEvents, nodefault};
	__property TLMDShellInterruptOptions Options = {read=FOptions, write=SetOptions, nodefault};
	__property System::UnicodeString WatchFolder = {read=FWatchFolder, write=SetWatchFolder};
	__property bool WatchSubFolders = {read=FWatchSubFolders, write=SetWatchSubFolders, nodefault};
	__property Lmdshutils::TLMDRoot RootFolder = {read=FRootFolder, write=SetRootFolder};
	__property int MaxNotifications = {read=FMaxNotifications, write=FMaxNotifications, nodefault};
	__property System::Classes::TNotifyEvent OnAssociationChange = {read=FOnAssociationChange, write=FOnAssociationChange};
	__property TLMDShellNotifyEvent2 OnAttributeChange = {read=FOnAttributeChange, write=FOnAttributeChange};
	__property TLMDShellNotifyEvent1 OnDriveAdd = {read=FOnDriveAdd, write=FOnDriveAdd};
	__property TLMDShellNotifyEvent1 OnDriveRemove = {read=FOnDriveRemove, write=FOnDriveRemove};
	__property TLMDShellNotifyEvent4 OnDriveSpaceChange = {read=FOnDriveSpaceChange, write=FOnDriveSpaceChange};
	__property TLMDShellNotifyEvent1 OnFileChange = {read=FOnFileChange, write=FOnFileChange};
	__property TLMDShellNotifyEvent1 OnFileCreate = {read=FOnFileCreate, write=FOnFileCreate};
	__property TLMDShellNotifyEvent2 OnFileDelete = {read=FOnFileDelete, write=FOnFileDelete};
	__property TLMDShellNotifyEvent2 OnFileRename = {read=FOnFileRename, write=FOnFileRename};
	__property TLMDShellNotifyEvent1 OnFolderChange = {read=FOnFolderChange, write=FOnFolderChange};
	__property TLMDShellNotifyEvent1 OnFolderCreate = {read=FOnFolderCreate, write=FOnFolderCreate};
	__property TLMDShellNotifyEvent1 OnFolderDelete = {read=FOnFolderDelete, write=FOnFolderDelete};
	__property TLMDShellNotifyEvent2 OnFolderRename = {read=FOnFolderRename, write=FOnFolderRename};
	__property System::Classes::TNotifyEvent OnImageListChange = {read=FOnImageListChange, write=FOnImageListChange};
	__property TLMDShellNotifyEvent1 OnMediaInsert = {read=FOnMediaInsert, write=FOnMediaInsert};
	__property TLMDShellNotifyEvent1 OnMediaRemove = {read=FOnMediaRemove, write=FOnMediaRemove};
	__property TLMDShellNotifyEvent1 OnNetShare = {read=FOnNetShare, write=FOnNetShare};
	__property TLMDShellNotifyEvent1 OnNetUnShare = {read=FOnNetUnShare, write=FOnNetUnShare};
	__property TLMDShellNotifyEvent1 OnServerDisconnect = {read=FOnServerDisconnect, write=FOnServerDisconnect};
	__property TLMDShellNotifyEvent3 OnShellChangeNotify = {read=FOnShellChangeNotify, write=FOnShellChangeNotify};
	__property TLMDShellNotifyEvent1 OnShellDriveAdd = {read=FOnShellDriveAdd, write=FOnShellDriveAdd};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdshntf */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSHNTF)
using namespace Lmdshntf;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdshntfHPP
