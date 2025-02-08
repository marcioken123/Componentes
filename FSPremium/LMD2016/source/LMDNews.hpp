// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDNews.pas' rev: 31.00 (Windows)

#ifndef LmdnewsHPP
#define LmdnewsHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <LMDDownload.hpp>
#include <LMDWebXML.hpp>
#include <LMDURLSupp.hpp>
#include <LMDWebConfig.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDWebBase.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdnews
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDWebNews;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDWebNewsState : unsigned char { LNS_NONE, LNS_PROCESSING, LNS_ERROR };

class PASCALIMPLEMENTATION TLMDWebNews : public Lmdwebconfig::TLMDMasterWebComponent
{
	typedef Lmdwebconfig::TLMDMasterWebComponent inherited;
	
private:
	Lmddownload::TLMDDownloadItem* FNewsDownloader;
	Lmddownload::TLMDDownloads* FDownload;
	System::UnicodeString FServer;
	System::UnicodeString FNewsDocument;
	System::Classes::TStrings* FNewsXML;
	System::Classes::TNotifyEvent FOnComplete;
	System::Classes::TNotifyEvent FOnProgress;
	Lmdwebxml::TLMDXMLTags* FNews;
	System::UnicodeString FCaption;
	Lmdwebxml::TLMDXMLTags* FImagesTags;
	System::UnicodeString FImagesBaseURL;
	bool FAutoLoadImages;
	Vcl::Controls::TImageList* FImageList;
	bool FCheckInternet;
	Lmdurlsupp::TLMDInternetOptions* FIO;
	Lmdwebconfig::TLMDWebConfig* FWebConfig;
	void __fastcall SetServer(const System::UnicodeString Value);
	void __fastcall SetNewsDocument(const System::UnicodeString Value);
	TLMDWebNewsState __fastcall GetState(void);
	void __fastcall DownloadProgress(Lmddownload::TLMDDownloadItem* Sender);
	void __fastcall DownloadProcessed(Lmddownload::TLMDDownloads* Sender);
	Lmdurlsupp::TLMDInternetOptions* __fastcall GetIO(void);
	void __fastcall IO(Lmdurlsupp::TLMDInternetOptions* const Value);
	void __fastcall SetNewsXML(System::Classes::TStrings* const Value);
	int __fastcall GetError(void);
	System::UnicodeString __fastcall GetErrorString(void);
	int __fastcall GetProgress(void);
	System::UnicodeString __fastcall GetProgressString(void);
	Lmddownload::TLMDDownloadItem* __fastcall GetNewsDownloader(void);
	void __fastcall SetOnComplete(const System::Classes::TNotifyEvent Value);
	void __fastcall SetOnProgress(const System::Classes::TNotifyEvent Value);
	void __fastcall SetNews(Lmdwebxml::TLMDXMLTags* const Value);
	void __fastcall SetCaption(const System::UnicodeString Value);
	void __fastcall SetImagesTags(Lmdwebxml::TLMDXMLTags* const Value);
	void __fastcall SetImagesBaseURL(const System::UnicodeString Value);
	void __fastcall SetAutoLoadImages(const bool Value);
	void __fastcall SetImageList(Vcl::Controls::TImageList* const Value);
	void __fastcall SetCheckInternet(const bool Value);
	Lmdurlsupp::TLMDInternetOptionsInteractiveEvent __fastcall GetOnInteractiveEvent(void);
	void __fastcall SetOnInteractiveEvent(const Lmdurlsupp::TLMDInternetOptionsInteractiveEvent Value);
	void __fastcall SetWebConfig(Lmdwebconfig::TLMDWebConfig* const Value);
	
protected:
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDWebNews(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDWebNews(void);
	bool __fastcall CheckNews(bool bAsync = true);
	void __fastcall StopProcessing(void);
	void __fastcall ParseXML(void);
	__classmethod int __fastcall GetVersion();
	int __fastcall DownloadImages(Vcl::Controls::TImageList* ImageList, bool bAsync = true);
	__property TLMDWebNewsState State = {read=GetState, nodefault};
	__property System::Classes::TStrings* NewsXML = {read=FNewsXML, write=SetNewsXML};
	__property Lmdwebxml::TLMDXMLTags* News = {read=FNews, write=SetNews};
	__property Lmdwebxml::TLMDXMLTags* ImagesTags = {read=FImagesTags, write=SetImagesTags};
	__property System::UnicodeString ImagesBaseURL = {read=FImagesBaseURL, write=SetImagesBaseURL};
	__property System::UnicodeString Caption = {read=FCaption, write=SetCaption};
	__property int Progress = {read=GetProgress, default=0};
	__property System::UnicodeString ProgressString = {read=GetProgressString};
	__property int Error = {read=GetError, default=0};
	__property System::UnicodeString ErrorString = {read=GetErrorString};
	virtual void __fastcall UpdateFromConfig(void);
	
__published:
	__property About = {default=0};
	__property bool CheckInternet = {read=FCheckInternet, write=SetCheckInternet, default=1};
	__property bool AutoLoadImages = {read=FAutoLoadImages, write=SetAutoLoadImages, default=1};
	__property System::UnicodeString Server = {read=FServer, write=SetServer};
	__property System::UnicodeString NewsDocument = {read=FNewsDocument, write=SetNewsDocument};
	__property Vcl::Controls::TImageList* ImageList = {read=FImageList, write=SetImageList};
	__property Lmdurlsupp::TLMDInternetOptions* InternetOptions = {read=GetIO, write=IO};
	__property Lmdwebconfig::TLMDWebConfig* WebConfig = {read=FWebConfig, write=SetWebConfig};
	__property System::Classes::TNotifyEvent OnProgress = {read=FOnProgress, write=SetOnProgress};
	__property System::Classes::TNotifyEvent OnComplete = {read=FOnComplete, write=SetOnComplete};
	__property Lmdurlsupp::TLMDInternetOptionsInteractiveEvent OnInteractiveEvent = {read=GetOnInteractiveEvent, write=SetOnInteractiveEvent};
};


//-- var, const, procedure ---------------------------------------------------
#define STD_NEWS_DOCUMENT L"news.xml"
static const System::Int8 LMDNewsVersionNumber = System::Int8(0x1);
}	/* namespace Lmdnews */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDNEWS)
using namespace Lmdnews;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdnewsHPP
