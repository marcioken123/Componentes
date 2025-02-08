// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDURLSupp.pas' rev: 31.00 (Windows)

#ifndef LmdurlsuppHPP
#define LmdurlsuppHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <System.Win.Registry.hpp>
#include <Winapi.WinInet.hpp>
#include <LMDRAS.hpp>
#include <LMDFSSupport.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdurlsupp
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDURI;
class DELPHICLASS TLMDInternetOptions;
//-- type declarations -------------------------------------------------------
#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDURI : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod void __fastcall NormalizePath(System::UnicodeString &APath);
public:
	/* TObject.Create */ inline __fastcall TLMDURI(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~TLMDURI(void) { }
	
};

#pragma pack(pop)

enum DECLSPEC_DENUM TLMDInternetOptionsInteractiveAction : unsigned char { IA_DIAL_QUERY };

enum DECLSPEC_DENUM TLMDInternetOptionsInteractiveResult : unsigned char { IR_YES, IR_NO };

typedef TLMDInternetOptionsInteractiveResult __fastcall (__closure *TLMDInternetOptionsInteractiveEvent)(TLMDInternetOptions* Sender, TLMDInternetOptionsInteractiveAction Action);

enum DECLSPEC_DENUM TLMDSocksVersion : unsigned char { sv4, sv4A, sv5 };

class PASCALIMPLEMENTATION TLMDInternetOptions : public System::Classes::TPersistent
{
	typedef System::Classes::TPersistent inherited;
	
private:
	bool FUseProxy;
	bool FUseProxyAuth;
	int FConnectTimeOut;
	int FDataTimeout;
	int FProxyPort;
	System::UnicodeString FUserAgent;
	System::UnicodeString FProxyName;
	System::UnicodeString FProxyPassword;
	System::UnicodeString FProxyUserName;
	int FConnectRetries;
	bool FModemConnection;
	bool FUseDefaultOptions;
	int FServerThreads;
	bool FUseDefaultBows;
	bool FUseIEDUNSettings;
	bool FAutoDial;
	bool FAutoClose;
	System::UnicodeString FDUN;
	System::Classes::TStringList* FPathList;
	bool FSocksProxy;
	TLMDSocksVersion FSocksVersion;
	bool FForceInternetCheck;
	TLMDInternetOptionsInteractiveEvent FOnInteractiveEvent;
	void __fastcall SetUseDefaultOptions(const bool Value);
	void __fastcall SetAutoDial(const bool Value);
	void __fastcall SetAutoClose(const bool Value);
	void __fastcall SetDUN(const System::UnicodeString Value);
	void __fastcall SetPathList(System::Classes::TStringList* const Value);
	void __fastcall SetUseDefaultBows(const bool Value);
	void __fastcall SetUseIEDUNSettings(const bool Value);
	void __fastcall SetSocksProxy(const bool Value);
	void __fastcall SetSocksVersion(const TLMDSocksVersion Value);
	void __fastcall SetForceInternetCheck(const bool Value);
	void __fastcall SetOnInteractiveEvent(const TLMDInternetOptionsInteractiveEvent Value);
	
public:
	__fastcall TLMDInternetOptions(void);
	__fastcall virtual ~TLMDInternetOptions(void);
	virtual void __fastcall Assign(System::Classes::TPersistent* Source);
	__property System::Classes::TStringList* PathList = {read=FPathList, write=SetPathList};
	
__published:
	__property int ConnectRetries = {read=FConnectRetries, write=FConnectRetries, default=2};
	__property int ConnectTimeout = {read=FConnectTimeOut, write=FConnectTimeOut, default=30};
	__property int DataTimeout = {read=FDataTimeout, write=FDataTimeout, default=0};
	__property bool UseProxy = {read=FUseProxy, write=FUseProxy, default=0};
	__property bool SocksProxy = {read=FSocksProxy, write=SetSocksProxy, default=1};
	__property TLMDSocksVersion SocksVersion = {read=FSocksVersion, write=SetSocksVersion, nodefault};
	__property System::UnicodeString ProxyName = {read=FProxyName, write=FProxyName};
	__property int ProxyPort = {read=FProxyPort, write=FProxyPort, default=0};
	__property bool UseProxyAuth = {read=FUseProxyAuth, write=FUseProxyAuth, default=1};
	__property System::UnicodeString ProxyUserName = {read=FProxyUserName, write=FProxyUserName};
	__property System::UnicodeString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
	__property System::UnicodeString UserAgent = {read=FUserAgent, write=FUserAgent, stored=true};
	__property bool UseDefaultOptions = {read=FUseDefaultOptions, write=SetUseDefaultOptions, default=0};
	__property int ServerThreads = {read=FServerThreads, write=FServerThreads, default=4};
	__property bool ModemConnection = {read=FModemConnection, write=FModemConnection, default=1};
	__property bool UseDefaultBrowser = {read=FUseDefaultBows, write=SetUseDefaultBows, default=1};
	__property bool AutoDial = {read=FAutoDial, write=SetAutoDial, default=1};
	__property bool AutoClose = {read=FAutoClose, write=SetAutoClose, default=1};
	__property bool ForceInternetCheck = {read=FForceInternetCheck, write=SetForceInternetCheck, default=0};
	__property bool UseIEDUNSettings = {read=FUseIEDUNSettings, write=SetUseIEDUNSettings, default=1};
	__property System::UnicodeString DUN = {read=FDUN, write=SetDUN};
	__property TLMDInternetOptionsInteractiveEvent OnInteractiveEvent = {read=FOnInteractiveEvent, write=SetOnInteractiveEvent};
};


//-- var, const, procedure ---------------------------------------------------
#define CFSTR_MIME_HTML L"text/html"
#define GLOBALOFFLINE_KEY L"\\SOFTWARE\\MICROSOFT\\WINDOWS\\CURRENTVERSION\\INTERNET S"\
	L"ETTINGS\\"
extern DELPHI_PACKAGE bool __fastcall CheckConnected(void * hInet, bool bModem);
extern DELPHI_PACKAGE bool __fastcall CanCheckConnected(void);
extern DELPHI_PACKAGE bool __fastcall CheckInetConnected(bool bModem);
extern DELPHI_PACKAGE void __fastcall SetConnectionOptions(void * hInet, TLMDInternetOptions* Options);
extern DELPHI_PACKAGE void __fastcall SetProxyAuthOptions(void * hInet, TLMDInternetOptions* Options);
extern DELPHI_PACKAGE void __fastcall ParseURI(const System::UnicodeString AURI, System::UnicodeString &VProtocol, System::UnicodeString &VHost, System::UnicodeString &VPath, System::UnicodeString &VDocument, System::UnicodeString &VPort, System::UnicodeString &VBookmark, System::UnicodeString &VUserName, System::UnicodeString &VPassword)/* overload */;
extern DELPHI_PACKAGE void __fastcall ParseURI(const System::UnicodeString AURI, System::UnicodeString &VProtocol, System::UnicodeString &VHost, System::UnicodeString &VPath, System::UnicodeString &VDocument, System::UnicodeString &VPort, System::UnicodeString &VBookmark)/* overload */;
extern DELPHI_PACKAGE bool __fastcall GetGlobalOffline(void);
extern DELPHI_PACKAGE void __fastcall SetGlobalOffline(bool bOffline);
extern DELPHI_PACKAGE bool __fastcall CheckInCache(const System::UnicodeString szURL);
extern DELPHI_PACKAGE bool __fastcall CheckLocal(const System::UnicodeString szURL);
extern DELPHI_PACKAGE bool __fastcall InternetCompareURL(System::UnicodeString Url1, System::UnicodeString Url2);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetHost(const System::UnicodeString URL_);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetHostURL(const System::UnicodeString URL_);
extern DELPHI_PACKAGE System::UnicodeString __fastcall GetPath(const System::UnicodeString URL_);
extern DELPHI_PACKAGE void __fastcall LMDParseURI(const System::UnicodeString URI, System::UnicodeString &Protocol, System::UnicodeString &Host, System::UnicodeString &path, System::UnicodeString &Document, System::UnicodeString &Params, System::UnicodeString &Port, System::UnicodeString &Bookmark)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDParseURI(const System::UnicodeString AURI, System::UnicodeString &VProtocol, System::UnicodeString &VHost, System::UnicodeString &VPath, System::UnicodeString &VDocument, System::UnicodeString &VPort, System::UnicodeString &VBookmark, System::UnicodeString &VUserName, System::UnicodeString &VPassword, System::UnicodeString &VParams)/* overload */;
extern DELPHI_PACKAGE void __fastcall LMDParseURI(const System::UnicodeString URI, System::UnicodeString &Protocol, System::UnicodeString &Host, System::UnicodeString &path, System::UnicodeString &Document, System::UnicodeString &Port, System::UnicodeString &Bookmark)/* overload */;
extern DELPHI_PACKAGE System::UnicodeString __fastcall CombineURL(const System::UnicodeString szBaseURL, const System::UnicodeString szRelativeURL);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ExtractURLFileName(const System::UnicodeString FileName);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ExtractURLRelativePath(const System::UnicodeString BaseName, const System::UnicodeString DestName);
extern DELPHI_PACKAGE bool __fastcall CheckInet(TLMDInternetOptions* IO);
extern DELPHI_PACKAGE void __fastcall SetDisconnect(TLMDInternetOptions* IO);
extern DELPHI_PACKAGE System::UnicodeString __fastcall ExtractURLFilePath(const System::UnicodeString FileName);
extern DELPHI_PACKAGE void __fastcall LMDWebAllocTURLComponents(Winapi::Wininet::URL_COMPONENTSW &uComp, unsigned dwFlags);
extern DELPHI_PACKAGE void __fastcall LMDWebFreeTURLComponents(Winapi::Wininet::URL_COMPONENTSW &uComp, unsigned dwFlags);
extern DELPHI_PACKAGE System::LongBool __fastcall CallInternetCrackUrl(const System::UnicodeString URL, unsigned dwFlags, System::AnsiString &Scheme, System::AnsiString &HostName, System::AnsiString &UserName, System::AnsiString &Password, System::AnsiString &UrlPath, System::AnsiString &ExtraInfo, System::Word &nPort)/* overload */;
extern DELPHI_PACKAGE System::LongBool __fastcall CallInternetCrackUrl(const System::UnicodeString URL, unsigned dwFlags, System::UnicodeString &Scheme, System::UnicodeString &HostName, System::Word &nPort)/* overload */;
}	/* namespace Lmdurlsupp */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDURLSUPP)
using namespace Lmdurlsupp;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdurlsuppHPP
