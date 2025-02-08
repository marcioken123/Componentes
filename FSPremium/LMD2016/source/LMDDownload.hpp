// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDDownload.pas' rev: 31.00 (Windows)

#ifndef LmddownloadHPP
#define LmddownloadHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <System.SyncObjs.hpp>
#include <System.Variants.hpp>
#include <Winapi.WinInet.hpp>
#include <LMDSyncUnit.hpp>
#include <LMDURLSupp.hpp>
#include <LMDWebBase.hpp>

//-- user supplied -----------------------------------------------------------
class DELPHICLASS TLMDProcessDownloadThread;

namespace Lmddownload
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDProcessThread;
class DELPHICLASS TLMDCookiesList;
class DELPHICLASS TLMDDownloadItem;
class DELPHICLASS TLMDDownloads;
class DELPHICLASS TLMDProcessDownloadThread;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDDownloadState : unsigned char { DS_NONE, DS_PROCESSING, DS_PROCESSED, DS_ERROR, DS_PREPARED };

enum DECLSPEC_DENUM TLMDIVerb : unsigned char { IV_GET, IV_POST };

typedef void __fastcall (__closure *TLMDDownloadProgress)(TLMDDownloadItem* Sender);

typedef void __fastcall (__closure *TLMDDownloadProcessed)(TLMDDownloads* Sender);

typedef void __fastcall (__closure *TLMDDownloadLogEvent)(TLMDDownloadItem* Sender, int iEvent, System::UnicodeString szDescription, System::UnicodeString szData);

class PASCALIMPLEMENTATION TLMDProcessThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDDownloads* FDownloads;
	
protected:
	virtual void __fastcall Execute(void);
	
public:
	__fastcall TLMDProcessThread(TLMDDownloads* Downloads);
	__fastcall virtual ~TLMDProcessThread(void);
};


class PASCALIMPLEMENTATION TLMDCookiesList : public System::Classes::TStringList
{
	typedef System::Classes::TStringList inherited;
	
public:
	void __fastcall AddText(const System::UnicodeString szText);
public:
	/* TStringList.Create */ inline __fastcall TLMDCookiesList(void)/* overload */ : System::Classes::TStringList() { }
	/* TStringList.Create */ inline __fastcall TLMDCookiesList(bool OwnsObjects)/* overload */ : System::Classes::TStringList(OwnsObjects) { }
	/* TStringList.Create */ inline __fastcall TLMDCookiesList(System::WideChar QuoteChar, System::WideChar Delimiter)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter) { }
	/* TStringList.Create */ inline __fastcall TLMDCookiesList(System::WideChar QuoteChar, System::WideChar Delimiter, System::Classes::TStringsOptions Options)/* overload */ : System::Classes::TStringList(QuoteChar, Delimiter, Options) { }
	/* TStringList.Create */ inline __fastcall TLMDCookiesList(System::Types::TDuplicates Duplicates, bool Sorted, bool CaseSensitive)/* overload */ : System::Classes::TStringList(Duplicates, Sorted, CaseSensitive) { }
	/* TStringList.Destroy */ inline __fastcall virtual ~TLMDCookiesList(void) { }
	
};


class PASCALIMPLEMENTATION TLMDDownloadItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	NativeUInt FSem;
	void *hInet;
	void *hSession;
	System::UnicodeString FURL;
	unsigned FError;
	int FProgress;
	System::UnicodeString FErrorString;
	TLMDDownloadState FState;
	unsigned FDataSize;
	System::UnicodeString FResultType;
	System::UnicodeString FActualType;
	int FTag;
	System::UnicodeString FStringData;
	System::TObject* FUserData;
	System::Variant FPostData;
	System::UnicodeString FHeaders;
	TLMDIVerb FVerb;
	System::UnicodeString FUserName;
	System::UnicodeString FUserPassword;
	bool FCheckOnly;
	bool FReady;
	Lmdurlsupp::TLMDInternetOptions* FInternetOptions;
	System::UnicodeString FCaption;
	bool FReload;
	System::TDateTime FLastModified;
	System::Classes::TStringList* FExcludedTypes;
	TLMDCookiesList* FSetCookies;
	TLMDCookiesList* FGetCookies;
	System::UnicodeString FLocalURL;
	System::TObject* FUserObject;
	System::UnicodeString FReferer;
	bool FFreeOnProcessed;
	System::UnicodeString FActualURL;
	bool FDeleteExCookies;
	bool FHeaderLoaded;
	bool FNoRedirect;
	__int64 FRangeStart;
	__int64 FRangeEnd;
	System::UnicodeString __fastcall GetProgressString(void);
	System::UnicodeString __fastcall GetStatusString(void);
	void __fastcall SetUserName(const System::UnicodeString Value);
	void __fastcall SetUserPassword(const System::UnicodeString Value);
	void __fastcall SetCheckOnly(const bool Value);
	void __fastcall SetReady(const bool Value);
	void __fastcall SeTLMDInternetOptions(Lmdurlsupp::TLMDInternetOptions* const Value);
	System::UnicodeString __fastcall GetCaption(void);
	void __fastcall SetReload(const bool Value);
	void __fastcall SetExcludedTypes(System::Classes::TStringList* const Value);
	void __fastcall SetUserData(System::TObject* const Value);
	void __fastcall SetLocalURL(const System::UnicodeString Value);
	void __fastcall SetUserObject(System::TObject* const Value);
	void __fastcall SetSetCookies(TLMDCookiesList* const Value);
	void __fastcall SetGetCookies(TLMDCookiesList* const Value);
	void __fastcall SetDeleteExCookies(const bool Value);
	void __fastcall SetHeaderLoaded(const bool Value);
	void __fastcall SetNoRedirect(const bool Value);
	
public:
	System::Classes::TMemoryStream* DataStream;
	System::Classes::TStream* PersistStream;
	int iStatusCode;
	bool Terminated;
	int LickedID;
	__fastcall virtual TLMDDownloadItem(System::Classes::TCollection* Collection);
	__fastcall virtual ~TLMDDownloadItem(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	void __fastcall Prepare(void);
	void __fastcall Process(void);
	void __fastcall Terminate(void);
	void __fastcall ResetData(void);
	void __fastcall Log(int iEvent, System::UnicodeString szDescription, System::UnicodeString szData);
	void __fastcall SetError(int iError, System::UnicodeString ErrorString);
	bool __fastcall BufferStartedWith(const System::UnicodeString Str, bool CheckCase = true);
	__property System::UnicodeString Caption = {read=GetCaption, write=FCaption};
	__property System::UnicodeString ResultType = {read=FResultType, write=FResultType};
	__property System::UnicodeString ActualType = {read=FActualType, write=FActualType};
	__property System::UnicodeString ActualURL = {read=FActualURL, write=FActualURL};
	__property System::UnicodeString URL = {read=FURL, write=FURL};
	__property System::UnicodeString LocalURL = {read=FLocalURL, write=SetLocalURL};
	__property int Tag = {read=FTag, write=FTag, nodefault};
	__property System::TObject* UserData = {read=FUserData, write=SetUserData};
	__property System::TObject* UserObject = {read=FUserObject, write=SetUserObject};
	__property System::UnicodeString StringData = {read=FStringData, write=FStringData};
	__property unsigned DataSize = {read=FDataSize, nodefault};
	__property System::TDateTime LastModified = {read=FLastModified};
	__property unsigned dwError = {read=FError, write=FError, nodefault};
	__property System::UnicodeString ErrorString = {read=FErrorString, write=FErrorString};
	__property int Progress = {read=FProgress, write=FProgress, nodefault};
	__property TLMDDownloadState State = {read=FState, nodefault};
	__property System::UnicodeString ProgressString = {read=GetProgressString};
	__property System::UnicodeString StatusString = {read=GetStatusString};
	__property System::Variant PostData = {read=FPostData, write=FPostData};
	__property System::UnicodeString Headers = {read=FHeaders, write=FHeaders};
	__property TLMDCookiesList* SetCookies = {read=FSetCookies, write=SetSetCookies};
	__property TLMDCookiesList* GetCookies = {read=FGetCookies, write=SetGetCookies};
	__property System::UnicodeString Referer = {read=FReferer, write=FReferer};
	__property TLMDIVerb Verb = {read=FVerb, write=FVerb, nodefault};
	__property System::UnicodeString UserName = {read=FUserName, write=SetUserName};
	__property System::UnicodeString UserPassword = {read=FUserPassword, write=SetUserPassword};
	__property bool CheckOnly = {read=FCheckOnly, write=SetCheckOnly, nodefault};
	__property bool Ready = {read=FReady, write=SetReady, nodefault};
	__property bool Reload = {read=FReload, write=SetReload, nodefault};
	__property bool HeaderLoaded = {read=FHeaderLoaded, write=SetHeaderLoaded, nodefault};
	__property bool DeleteExCookies = {read=FDeleteExCookies, write=SetDeleteExCookies, nodefault};
	__property Lmdurlsupp::TLMDInternetOptions* InternetOptions = {read=FInternetOptions, write=SeTLMDInternetOptions};
	__property System::Classes::TStringList* ExcludedTypes = {read=FExcludedTypes, write=SetExcludedTypes};
	__property bool FreeOnProcessed = {read=FFreeOnProcessed, write=FFreeOnProcessed, nodefault};
	__property bool NoRedirect = {read=FNoRedirect, write=SetNoRedirect, nodefault};
	__property __int64 RangeStart = {read=FRangeStart, write=FRangeStart};
	__property __int64 RangeEnd = {read=FRangeEnd, write=FRangeEnd};
};


typedef System::DynamicArray<TLMDProcessDownloadThread*> TLMDProcessDownloadThreadArray;

class PASCALIMPLEMENTATION TLMDDownloads : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDDownloadItem* operator[](int index) { return this->Items[index]; }
	
private:
	unsigned FStartTime;
	__int64 FAllSize;
	System::Classes::TList* FDelItems;
	System::Classes::TThread* FProcessThread;
	NativeUInt FSem;
	NativeUInt FSemP;
	int iServerIndex;
	TLMDDownloadState FState;
	int FServerThreads;
	TLMDDownloadProcessed FOnProcessed;
	TLMDDownloadProgress FOnProgress;
	Lmdsyncunit::TLMDSyncObject* FSyncObj;
	TLMDDownloadItem* FProgressObj;
	TLMDProcessDownloadThreadArray aT;
	Lmdurlsupp::TLMDInternetOptions* FInternetOptions;
	TLMDDownloadLogEvent FOnLog;
	bool FReload;
	TLMDDownloadItem* __fastcall GetItems(int index);
	void __fastcall SetOnProcessed(const TLMDDownloadProcessed Value);
	void __fastcall SetOnProgress(const TLMDDownloadProgress Value);
	void __fastcall SendProgress(TLMDDownloadItem* Sender, bool bNonCritical = false);
	void __fastcall Progress(void);
	void __fastcall Processed(void);
	void __fastcall SeTLMDInternetOptions(Lmdurlsupp::TLMDInternetOptions* const Value);
	void __fastcall DeleteItem(TLMDDownloadItem* Item);
	int __fastcall GetCPS(void);
	void __fastcall SizeChanged(__int64 iSize, unsigned lTime);
	void __fastcall SetOnLog(const TLMDDownloadLogEvent Value);
	void __fastcall SetReload(const bool Value);
	
public:
	bool Terminated;
	__fastcall TLMDDownloads(void);
	__fastcall virtual ~TLMDDownloads(void);
	bool __fastcall Process(void);
	void __fastcall ThreadProcess(void);
	HIDESBASE TLMDDownloadItem* __fastcall Add(void);
	TLMDDownloadItem* __fastcall GetNextServer(TLMDProcessDownloadThread* Sender);
	void __fastcall ClearState(void);
	void __fastcall Terminate(void);
	void __fastcall WaitForEnd(void);
	void __fastcall ContinueProcess(void);
	__property TLMDDownloadItem* Items[int index] = {read=GetItems/*, default*/};
	__property TLMDDownloadState State = {read=FState, nodefault};
	__property bool Reload = {read=FReload, write=SetReload, nodefault};
	__property Lmdurlsupp::TLMDInternetOptions* InternetOptions = {read=FInternetOptions, write=SeTLMDInternetOptions};
	__property int ServerThreads = {read=FServerThreads, write=FServerThreads, nodefault};
	__property __int64 AllSize = {read=FAllSize};
	__property int CPS = {read=GetCPS, nodefault};
	__property TLMDDownloadProgress OnProgress = {read=FOnProgress, write=SetOnProgress};
	__property TLMDDownloadProcessed OnProcessed = {read=FOnProcessed, write=SetOnProcessed};
	__property TLMDDownloadLogEvent OnLog = {read=FOnLog, write=SetOnLog};
};


class PASCALIMPLEMENTATION TLMDProcessDownloadThread : public System::Classes::TThread
{
	typedef System::Classes::TThread inherited;
	
private:
	TLMDDownloads* FDownloads;
	bool FThreadTerminated;
	System::Syncobjs::TEvent* FWaitEvent;
	
protected:
	virtual void __fastcall Execute(void);
	void __fastcall Process(void);
	
public:
	bool NullItem;
	__fastcall TLMDProcessDownloadThread(TLMDDownloads* Downloads);
	__fastcall virtual ~TLMDProcessDownloadThread(void);
};


//-- var, const, procedure ---------------------------------------------------
static const System::Word BUF_SIZE = System::Word(0x400);
#define RT_APPLICATION L"application/octet-stream"
#define RT_HTML L"text/html"
static const System::Word MIN_SENDTIME = System::Word(0x1f4);
static const System::Int8 LE_INFO = System::Int8(0x0);
static const System::Int8 LE_ERROR = System::Int8(0x1);
}	/* namespace Lmddownload */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDDOWNLOAD)
using namespace Lmddownload;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmddownloadHPP
