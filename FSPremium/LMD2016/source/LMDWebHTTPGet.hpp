// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebHTTPGet.pas' rev: 31.00 (Windows)

#ifndef LmdwebhttpgetHPP
#define LmdwebhttpgetHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDStrings.hpp>
#include <LMDWebBase.hpp>
#include <LMDWebConfig.hpp>
#include <LMDDownload.hpp>
#include <LMDURLSupp.hpp>
#include <LMDWebDownloadFormUnit.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebhttpget
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDDownloadParams;
class DELPHICLASS TLMDWebHTTPGet;
//-- type declarations -------------------------------------------------------
class PASCALIMPLEMENTATION TLMDDownloadParams : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FCheckOnly;
	bool FLoadImages;
	unsigned FSizeLimit;
	System::TDateTime FOlder;
	bool FLoadScripts;
	bool FLoadCssFiles;
	void __fastcall SetCheckOnly(const bool Value);
	void __fastcall SetLoadImages(const bool Value);
	void __fastcall SetOlder(const System::TDateTime Value);
	void __fastcall SetSizeLimit(const unsigned Value);
	void __fastcall SetLoadCssFiles(const bool Value);
	void __fastcall SetLoadScripts(const bool Value);
	
public:
	__fastcall TLMDDownloadParams(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	
__published:
	__property bool CheckOnly = {read=FCheckOnly, write=SetCheckOnly, default=0};
	__property bool LoadImages = {read=FLoadImages, write=SetLoadImages, default=0};
	__property bool LoadScripts = {read=FLoadScripts, write=SetLoadScripts, default=0};
	__property bool LoadCssFiles = {read=FLoadCssFiles, write=SetLoadCssFiles, default=0};
	__property unsigned SizeLimit = {read=FSizeLimit, write=SetSizeLimit, nodefault};
	__property System::TDateTime Older = {read=FOlder, write=SetOlder};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDDownloadParams(void) { }
	
};


typedef void __fastcall (__closure *TOnCustomizeForm)(TLMDWebHTTPGet* Sender, Lmdwebdownloadformunit::TLMDWebDownload* LMDWebDownload);

typedef void __fastcall (__closure *TOnLMDWebProgress)(TLMDWebHTTPGet* Sender, Lmddownload::TLMDDownloadItem* Item);

typedef void __fastcall (__closure *TOnLMDWebGetFileName)(TLMDWebHTTPGet* Sender, Lmddownload::TLMDDownloadItem* Item, System::UnicodeString &FileName);

class PASCALIMPLEMENTATION TLMDWebHTTPGet : public Lmdwebconfig::TLMDMasterWebComponent
{
	typedef Lmdwebconfig::TLMDMasterWebComponent inherited;
	
private:
	Lmddownload::TLMDDownloads* FDownloads;
	Lmddownload::TLMDDownloadItem* FFileDownloader;
	Lmdwebconfig::TLMDWebConfig* FWebConfig;
	System::UnicodeString FPassword;
	System::UnicodeString FReferer;
	System::Classes::TStringList* FAcceptTypes;
	System::UnicodeString FUserName;
	System::UnicodeString FURL;
	System::Classes::TMemoryStream* FData;
	TOnLMDWebProgress FOnProgress;
	System::Classes::TNotifyEvent FOnProcessed;
	System::Classes::TStringList* FPostParams;
	TLMDDownloadParams* FDownloadParams;
	System::UnicodeString FDownloadDir;
	System::UnicodeString FCaption;
	TOnCustomizeForm FOnCustomizeForm;
	TOnLMDWebGetFileName FOnGetFileName;
	System::UnicodeString FDestinationName;
	__int64 FRangeStart;
	__int64 FRangeEnd;
	bool FResume;
	void __fastcall SetWebConfig(Lmdwebconfig::TLMDWebConfig* const Value);
	void __fastcall SetAcceptTypes(System::Classes::TStringList* const Value);
	void __fastcall SetPassword(const System::UnicodeString Value);
	void __fastcall SetReferer(const System::UnicodeString Value);
	void __fastcall SetURL(const System::UnicodeString Value);
	void __fastcall SetUserName(const System::UnicodeString Value);
	void __fastcall DownloadProgress(Lmddownload::TLMDDownloadItem* Sender);
	void __fastcall DownloadProcessed(Lmddownload::TLMDDownloads* Sender);
	int __fastcall GetProgress(void);
	Lmddownload::TLMDDownloadState __fastcall GetState(void);
	Lmddownload::TLMDDownloadItem* __fastcall GetFileDownloader(void);
	int __fastcall GetError(void);
	System::UnicodeString __fastcall GetErrorString(void);
	System::UnicodeString __fastcall GetProgressString(void);
	Lmdurlsupp::TLMDInternetOptions* __fastcall GetIO(void);
	void __fastcall SetIO(Lmdurlsupp::TLMDInternetOptions* const Value);
	void __fastcall SetOnProcessed(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnProgress(const TOnLMDWebProgress Value);
	System::UnicodeString __fastcall GetDataAsString(void);
	void __fastcall SetPostParams(System::Classes::TStringList* const Value);
	void __fastcall SetDownloadParams(TLMDDownloadParams* const Value);
	void __fastcall SetDownloadDir(const System::UnicodeString Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetOnCustomizeForm(const TOnCustomizeForm Value);
	void __fastcall SetOnGetFileName(const TOnLMDWebGetFileName Value);
	void __fastcall SetDestinationName(const System::UnicodeString Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	virtual void __fastcall Loaded(void);
	
public:
	__fastcall virtual TLMDWebHTTPGet(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWebHTTPGet(void);
	virtual void __fastcall UpdateFromConfig(void);
	bool __fastcall Process(bool bFillOnly = false, bool bAsync = false);
	bool __fastcall InteractiveProcess(void);
	void __fastcall Stop(void);
	__property Lmddownload::TLMDDownloads* Downloader = {read=FDownloads};
	__property Lmddownload::TLMDDownloadItem* FileDownloader = {read=GetFileDownloader};
	__property Lmddownload::TLMDDownloadState State = {read=GetState, nodefault};
	__property System::Classes::TMemoryStream* Data = {read=FData};
	__property System::UnicodeString DataAsString = {read=GetDataAsString};
	__property int Progress = {read=GetProgress, default=0};
	__property System::UnicodeString ProgressString = {read=GetProgressString};
	__property int Error = {read=GetError, default=0};
	__property System::UnicodeString ErrorString = {read=GetErrorString};
	
__published:
	__property System::Classes::TStringList* AcceptTypes = {read=FAcceptTypes, write=SetAcceptTypes, stored=true};
	__property System::UnicodeString URL = {read=FURL, write=SetURL};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property System::UnicodeString UserName = {read=FUserName, write=SetUserName};
	__property System::UnicodeString Password = {read=FPassword, write=SetPassword};
	__property System::UnicodeString Referer = {read=FReferer, write=SetReferer};
	__property System::Classes::TStringList* PostParams = {read=FPostParams, write=SetPostParams};
	__property System::UnicodeString DownloadDir = {read=FDownloadDir, write=SetDownloadDir};
	__property System::UnicodeString DestinationName = {read=FDestinationName, write=SetDestinationName};
	__property TLMDDownloadParams* DownloadParams = {read=FDownloadParams, write=SetDownloadParams};
	__property TOnLMDWebProgress OnProgress = {read=FOnProgress, write=SetOnProgress};
	__property System::Classes::TNotifyEvent OnProcessed = {read=FOnProcessed, write=SetOnProcessed};
	__property TOnLMDWebGetFileName OnGetFileName = {read=FOnGetFileName, write=SetOnGetFileName};
	__property TOnCustomizeForm OnCustomizeForm = {read=FOnCustomizeForm, write=SetOnCustomizeForm};
	__property Lmdurlsupp::TLMDInternetOptions* InternetOptions = {read=GetIO, write=SetIO};
	__property Lmdwebconfig::TLMDWebConfig* WebConfig = {read=FWebConfig, write=SetWebConfig};
	__property __int64 RangeStart = {read=FRangeStart, write=FRangeStart};
	__property __int64 RangeEnd = {read=FRangeEnd, write=FRangeEnd};
	__property bool Resume = {read=FResume, write=FResume, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebhttpget */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBHTTPGET)
using namespace Lmdwebhttpget;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebhttpgetHPP
