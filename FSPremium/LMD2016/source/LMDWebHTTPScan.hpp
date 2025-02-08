// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDWebHTTPScan.pas' rev: 31.00 (Windows)

#ifndef LmdwebhttpscanHPP
#define LmdwebhttpscanHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <LMDWebConfig.hpp>
#include <LMDWebTree.hpp>
#include <LMDDownload.hpp>
#include <LMDWebBase.hpp>
#include <LMDURLSupp.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdwebhttpscan
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebHTTPScan;
//-- type declarations -------------------------------------------------------
typedef void __fastcall (__closure *TLMDWebHTTPScanProgress)(Lmdwebtree::TLMDWebTreeItem* Sender);

typedef void __fastcall (__closure *TLMDWebHTTPScanAddItem)(Lmdwebtree::TLMDWebTreeItem* Sender);

typedef void __fastcall (__closure *TLMDWebHTTPScanProcessed)(Lmdwebtree::TLMDWebTaskItem* Sender);

typedef void __fastcall (__closure *TLMDWebHTTPScanSaveFile)(Lmdwebtree::TLMDWebTaskItem* Sender, System::UnicodeString &FileName, bool &CanSave);

class PASCALIMPLEMENTATION TLMDWebHTTPScan : public Lmdwebconfig::TLMDMasterWebComponent
{
	typedef Lmdwebconfig::TLMDMasterWebComponent inherited;
	
private:
	Lmdwebtree::TLMDWebTreeParams* FTreeParams;
	Lmdwebtree::TLMDWebTasks* FTaskCollection;
	Lmdwebtree::TLMDWebTaskItem* FTask;
	Lmddownload::TLMDDownloads* Downloads;
	TLMDWebHTTPScanProcessed FOnProcessed;
	TLMDWebHTTPScanProgress FOnProgress;
	TLMDWebHTTPScanAddItem FOnAddItem;
	TLMDWebHTTPScanSaveFile FOnSaveFile;
	bool FUpdate;
	bool FStrongUpdate;
	Lmdwebconfig::TLMDWebConfig* FWebConfig;
	System::Classes::TNotifyEvent FOnStartProcess;
	void __fastcall DownloadItem(Lmdwebtree::TLMDWebTreeItem* TreeItem, bool bDontUpdate = false);
	void __fastcall DownloadItems(Lmdwebtree::TLMDWebTree* Tree);
	void __fastcall DownloadProcessed(Lmddownload::TLMDDownloads* dloads);
	void __fastcall DownloadProgress(Lmddownload::TLMDDownloadItem* dlitem);
	System::UnicodeString __fastcall CreateFileName(const System::UnicodeString URL);
	Lmddownload::TLMDDownloadState __fastcall GetState(void);
	void __fastcall SetOnProcessed(const TLMDWebHTTPScanProcessed Value);
	void __fastcall SetOnProgress(const TLMDWebHTTPScanProgress Value);
	void __fastcall SetOnAddItem(const TLMDWebHTTPScanAddItem Value);
	void __fastcall SetOnSaveFile(const TLMDWebHTTPScanSaveFile Value);
	void __fastcall SetStrongUpdate(const bool Value);
	void __fastcall SetWebConfig(Lmdwebconfig::TLMDWebConfig* const Value);
	void __fastcall SetTask(Lmdwebtree::TLMDWebTaskItem* const Value);
	Lmdurlsupp::TLMDInternetOptions* __fastcall GetIO(void);
	void __fastcall SetIO(Lmdurlsupp::TLMDInternetOptions* const Value);
	void __fastcall SetOnStartProcess(const System::Classes::TNotifyEvent Value);
	
protected:
	virtual void __fastcall Loaded(void);
	
public:
	void __fastcall Download(void);
	__fastcall virtual TLMDWebHTTPScan(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWebHTTPScan(void);
	void __fastcall Terminate(void);
	virtual void __fastcall UpdateFromConfig(void);
	void __fastcall Clear(void);
	__property bool Update = {read=FUpdate, write=FUpdate, default=1};
	__property Lmddownload::TLMDDownloads* DownloadObject = {read=Downloads};
	__property Lmdwebtree::TLMDWebTreeParams* TreeParams = {read=FTreeParams};
	
__published:
	__property Lmdurlsupp::TLMDInternetOptions* InternetOptions = {read=GetIO, write=SetIO};
	__property Lmdwebtree::TLMDWebTaskItem* Task = {read=FTask, write=SetTask};
	__property Lmdwebconfig::TLMDWebConfig* WebConfig = {read=FWebConfig, write=SetWebConfig};
	__property bool StrongUpdate = {read=FStrongUpdate, write=SetStrongUpdate, default=1};
	__property Lmddownload::TLMDDownloadState State = {read=GetState, nodefault};
	__property System::Classes::TNotifyEvent OnStartProcess = {read=FOnStartProcess, write=SetOnStartProcess};
	__property TLMDWebHTTPScanAddItem OnAddItem = {read=FOnAddItem, write=SetOnAddItem};
	__property TLMDWebHTTPScanProgress OnProgress = {read=FOnProgress, write=SetOnProgress};
	__property TLMDWebHTTPScanProcessed OnProcessed = {read=FOnProcessed, write=SetOnProcessed};
	__property TLMDWebHTTPScanSaveFile OnSaveFile = {read=FOnSaveFile, write=SetOnSaveFile};
};


//-- var, const, procedure ---------------------------------------------------
}	/* namespace Lmdwebhttpscan */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDWEBHTTPSCAN)
using namespace Lmdwebhttpscan;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdwebhttpscanHPP
