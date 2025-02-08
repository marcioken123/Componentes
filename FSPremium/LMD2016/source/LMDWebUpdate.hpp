// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebUpdate.pas' rev: 31.00 (Windows)

#ifndef LmdwebupdateHPP
#define LmdwebupdateHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDWebBase.hpp>
#include <LMDURLSupp.hpp>
#include <LMDDownload.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebupdate
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebUpdateFileItem;
class DELPHICLASS TLMDWebUpdateFiles;
class DELPHICLASS TLMDCustomWebUpdate;
class DELPHICLASS TLMDWebUpdate;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDWebUpdateState : unsigned char { wusNone, wusGetServersURL, wusGetVersions, wusUpdate, wusReady, wusError };

enum DECLSPEC_DENUM TLMDWebUpdateFilestate : unsigned char { wufsNone, wufsUpdated, wufsUpdateDontNeeded, wufsLocalFileNotFound, wufsUpdateError };

enum DECLSPEC_DENUM TLMDWUFileAction : unsigned char { wufaUpdate, wufaUpdateCopy, wufaCopy, wufaExecute };

class PASCALIMPLEMENTATION TLMDWebUpdateFileItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	System::UnicodeString FTmpFileName;
	unsigned FLocalFileSize;
	System::TDateTime FLocalFileDate;
	System::UnicodeString FServerFileName;
	System::UnicodeString FServerPath;
	System::UnicodeString FFileName;
	TLMDWebUpdateFilestate FUpdateState;
	unsigned FError;
	System::UnicodeString FErrorString;
	TLMDWUFileAction FFileAction;
	bool FRequired;
	System::UnicodeString FUserName;
	System::UnicodeString FPassword;
	int FTag;
	System::TObject* FData;
	void __fastcall SetFileName(const System::UnicodeString Value);
	void __fastcall SetServerFileName(const System::UnicodeString Value);
	void __fastcall SetServerPath(const System::UnicodeString Value);
	void __fastcall FetchLocalFileProperties(void);
	System::UnicodeString __fastcall GetFullFileName(void);
	void __fastcall SetFileAction(const TLMDWUFileAction Value);
	void __fastcall SetRequired(const bool Value);
	void __fastcall SetPassword(const System::UnicodeString Value);
	void __fastcall SetUserName(const System::UnicodeString Value);
	void __fastcall SetData(System::TObject* const Value);
	void __fastcall SetTag(const int Value);
	
public:
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__fastcall virtual TLMDWebUpdateFileItem(System::Classes::TCollection* Collection);
	__property System::UnicodeString FullFileName = {read=GetFullFileName};
	__property System::UnicodeString ErrorString = {read=FErrorString};
	__property unsigned dwError = {read=FError, nodefault};
	__property TLMDWebUpdateFilestate UpdateState = {read=FUpdateState, nodefault};
	__property System::TObject* Data = {read=FData, write=SetData};
	__property int Tag = {read=FTag, write=SetTag, default=0};
	
__published:
	__property System::UnicodeString UserName = {read=FUserName, write=SetUserName};
	__property System::UnicodeString Password = {read=FPassword, write=SetPassword};
	__property bool Required = {read=FRequired, write=SetRequired, nodefault};
	__property TLMDWUFileAction FileAction = {read=FFileAction, write=SetFileAction, nodefault};
	__property System::UnicodeString FileName = {read=FFileName, write=SetFileName};
	__property System::UnicodeString ServerPath = {read=FServerPath, write=SetServerPath};
	__property System::UnicodeString ServerFileName = {read=FServerFileName, write=SetServerFileName};
public:
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDWebUpdateFileItem(void) { }
	
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDWebUpdateFiles : public System::Classes::TOwnedCollection
{
	typedef System::Classes::TOwnedCollection inherited;
	
public:
	TLMDWebUpdateFileItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	HIDESBASE TLMDWebUpdateFileItem* __fastcall GetItem(int Index);
	
public:
	__fastcall TLMDWebUpdateFiles(TLMDCustomWebUpdate* Owner);
	HIDESBASE TLMDWebUpdateFileItem* __fastcall Add(void);
	__property TLMDWebUpdateFileItem* Items[int Index] = {read=GetItem/*, default*/};
public:
	/* TCollection.Destroy */ inline __fastcall virtual ~TLMDWebUpdateFiles(void) { }
	
};

#pragma pack(pop)

typedef void __fastcall (__closure *TLMDWebUpdateProgress)(TLMDCustomWebUpdate* Sender, int iPercent, TLMDWebUpdateFileItem* FileItem, Lmddownload::TLMDDownloadItem* Item);

class PASCALIMPLEMENTATION TLMDCustomWebUpdate : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	Lmddownload::TLMDDownloads* FDownloads;
	TLMDWebUpdateState FState;
	System::Classes::TStringList* FServers;
	unsigned FdwError;
	System::UnicodeString FErrorString;
	TLMDWebUpdateProgress FOnProgress;
	System::Classes::TNotifyEvent FOnError;
	System::Classes::TNotifyEvent FOnProcessed;
	TLMDWebUpdateFiles* FFiles;
	int FMaxPercent;
	int FInfoPercent;
	System::UnicodeString FDefaultScheme;
	bool FAutoApply;
	bool FRebootNeeded;
	System::UnicodeString FUserName;
	System::UnicodeString FPassword;
	System::Classes::TStringList* FVersions;
	void __fastcall SetServers(System::Classes::TStringList* const Value);
	void __fastcall OnDProgress(Lmddownload::TLMDDownloadItem* Sender);
	void __fastcall OnDProcessed(Lmddownload::TLMDDownloads* Sender);
	void __fastcall GetError(Lmddownload::TLMDDownloadItem* Sender);
	bool __fastcall FetchServersProcessed(Lmddownload::TLMDDownloadItem* Sender);
	void __fastcall SetOnError(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnProcessed(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnProgress(const TLMDWebUpdateProgress Value);
	void __fastcall SetFiles(TLMDWebUpdateFiles* const Value);
	void __fastcall SetInfoPercent(const int Value);
	void __fastcall SetMaxPercent(const int Value);
	void __fastcall SetDefaultScheme(const System::UnicodeString Value);
	void __fastcall SetAutoApply(const bool Value);
	void __fastcall SetPassword(const System::UnicodeString Value);
	void __fastcall SetUserName(const System::UnicodeString Value);
	void __fastcall SetIO(Lmdurlsupp::TLMDInternetOptions* const Value);
	Lmdurlsupp::TLMDInternetOptions* __fastcall GetIO(void);
	Lmdurlsupp::TLMDInternetOptionsInteractiveEvent __fastcall GetOnInteractiveEvent(void);
	void __fastcall SetOnInteractiveEvent(const Lmdurlsupp::TLMDInternetOptionsInteractiveEvent Value);
	
protected:
	__property System::UnicodeString UserName = {read=FUserName, write=SetUserName};
	__property System::UnicodeString Password = {read=FPassword, write=SetPassword};
	__property bool AutoApply = {read=FAutoApply, write=SetAutoApply, default=1};
	__property System::UnicodeString DefaultScheme = {read=FDefaultScheme, write=SetDefaultScheme};
	__property Lmdurlsupp::TLMDInternetOptions* InternetOptions = {read=GetIO, write=SetIO};
	__property TLMDWebUpdateState State = {read=FState, nodefault};
	__property System::Classes::TStringList* Servers = {read=FServers, write=SetServers};
	__property System::Classes::TStringList* Versions = {read=FVersions};
	__property TLMDWebUpdateFiles* Files = {read=FFiles, write=SetFiles};
	__property unsigned dwError = {read=FdwError, nodefault};
	__property System::UnicodeString ErrorString = {read=FErrorString};
	__property int MaxPercent = {read=FMaxPercent, write=SetMaxPercent, default=100};
	__property int InfoPercent = {read=FInfoPercent, write=SetInfoPercent, default=10};
	__property bool RebootNeeded = {read=FRebootNeeded, default=0};
	__property TLMDWebUpdateProgress OnProgress = {read=FOnProgress, write=SetOnProgress};
	__property System::Classes::TNotifyEvent OnProcessed = {read=FOnProcessed, write=SetOnProcessed};
	__property System::Classes::TNotifyEvent OnError = {read=FOnError, write=SetOnError};
	virtual System::UnicodeString __fastcall GetServerFilePath(System::UnicodeString szServerURL, int Index);
	virtual int __fastcall CalcPercent(void);
	void __fastcall ClearTmpLocalFiles(void);
	virtual bool __fastcall SaveLocalFile(TLMDWebUpdateFileItem* FileItem, Lmddownload::TLMDDownloadItem* DItem);
	
public:
	__fastcall virtual TLMDCustomWebUpdate(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDCustomWebUpdate(void);
	virtual bool __fastcall ApplyUpdate(void);
	__classmethod bool __fastcall TerminateApplication(const System::UnicodeString FileName);
	__classmethod bool __fastcall LMDGetFileVersion(const System::UnicodeString FileName, int &Major1, int &Major2, int &Minor1, int &Minor2)/* overload */;
	__classmethod bool __fastcall LMDGetFileVersion(System::UnicodeString FileName, System::UnicodeString &VersionString)/* overload */;
	virtual void __fastcall CancelUpdate(void);
	bool __fastcall ProcessUpdate(const System::UnicodeString szURL);
	void __fastcall StopProcess(void);
	void __fastcall WaitForStopProcess(void);
	bool __fastcall FetchServers(const System::UnicodeString szURL, bool Blocked);
	bool __fastcall FetchVersions(const System::UnicodeString szURL);
	__property Lmdurlsupp::TLMDInternetOptionsInteractiveEvent OnInteractiveEvent = {read=GetOnInteractiveEvent, write=SetOnInteractiveEvent};
};


class PASCALIMPLEMENTATION TLMDWebUpdate : public TLMDCustomWebUpdate
{
	typedef TLMDCustomWebUpdate inherited;
	
public:
	__property State;
	__property RebootNeeded = {default=0};
	__property dwError;
	__property ErrorString = {default=0};
	__property Versions;
	
__published:
	__property UserName = {default=0};
	__property Password = {default=0};
	__property AutoApply = {default=1};
	__property MaxPercent = {default=100};
	__property InfoPercent = {default=10};
	__property DefaultScheme = {default=0};
	__property InternetOptions;
	__property Servers;
	__property Files;
	__property OnProgress;
	__property OnProcessed;
	__property OnError;
	__property OnInteractiveEvent;
public:
	/* TLMDCustomWebUpdate.Create */ inline __fastcall virtual TLMDWebUpdate(System::Classes::TComponent* AOwner) : TLMDCustomWebUpdate(AOwner) { }
	/* TLMDCustomWebUpdate.Destroy */ inline __fastcall virtual ~TLMDWebUpdate(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebupdate */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBUPDATE)
using namespace Lmdwebupdate;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebupdateHPP
