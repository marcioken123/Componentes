// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDRAS.pas' rev: 31.00 (Windows)

#ifndef LmdrasHPP
#define LmdrasHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <Winapi.Messages.hpp>
#include <LMDWebBase.hpp>
#include <LMDProcs.hpp>
#include <LMDCustomComponent.hpp>
#include <LMDTypes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdras
{
//-- forward type declarations -----------------------------------------------
struct TRasConn;
struct TRasDialParams;
struct TRasConnStatus;
struct TRasEntryName;
struct TRasEntryDlg;
struct TRasDialExtensions;
struct TRasDialDlg;
struct TRasPBDlg;
struct TRasMonitorDlg;
class DELPHICLASS TLMDRAS;
//-- type declarations -------------------------------------------------------
typedef int THRasConn;

typedef int TRasConnState;

typedef TRasConn *LPRasConn;

struct DECLSPEC_DRECORD TRasConn
{
public:
	int dwSize;
	int hrasconn;
	System::StaticArray<char, 257> szEntryName;
	System::StaticArray<char, 17> szDeviceType;
	System::StaticArray<char, 129> szDeviceName;
};


typedef TRasDialParams *LPRasDialParams;

struct DECLSPEC_DRECORD TRasDialParams
{
public:
	int dwSize;
	System::StaticArray<char, 257> szEntryName;
	System::StaticArray<char, 129> szPhoneNumber;
	System::StaticArray<char, 129> szCallbackNumber;
	System::StaticArray<char, 257> szUserName;
	System::StaticArray<char, 257> szPassword;
	System::StaticArray<char, 16> szDomain;
};


typedef TRasConnStatus *LPRasConnStatus;

struct DECLSPEC_DRECORD TRasConnStatus
{
public:
	int dwSize;
	int rasconnstate;
	int dwError;
	System::StaticArray<char, 17> szDeviceType;
	System::StaticArray<char, 129> szDeviceName;
};


typedef TRasEntryName *LPRasEntryName;

struct DECLSPEC_DRECORD TRasEntryName
{
public:
	int dwSize;
	System::StaticArray<char, 257> szEntryName;
};


struct DECLSPEC_DRECORD TRasEntryDlg
{
public:
	unsigned dwSize;
	HWND hwndOwner;
	unsigned dwFlags;
	int xDlg;
	int yDlg;
	System::StaticArray<char, 257> szEntry;
	unsigned dwError;
	unsigned reserved;
	unsigned reserved2;
};


typedef TRasDialExtensions *LPRasDialExtensions;

struct DECLSPEC_DRECORD TRasDialExtensions
{
public:
	int dwSize;
	int dwfOptions;
	HWND hwndParent;
	int reserved;
};


struct DECLSPEC_DRECORD TRasDialDlg
{
public:
	unsigned dwSize;
	HWND hwndOwner;
	unsigned dwFlags;
	int xDlg;
	int yDlg;
	unsigned dwSubEntry;
	unsigned dwError;
	unsigned reserved;
	unsigned reserved2;
};


struct DECLSPEC_DRECORD TRasPBDlg
{
public:
	unsigned dwSize;
	HWND hwndOwner;
	unsigned dwFlags;
	int xDlg;
	int yDlg;
	unsigned dwCallbackId;
	void *pCallback;
	unsigned dwError;
	unsigned reserved;
	unsigned reserved2;
};


struct DECLSPEC_DRECORD TRasMonitorDlg
{
public:
	unsigned dwSize;
	HWND hwndOwner;
	unsigned dwFlags;
	unsigned dwStartPage;
	int xDlg;
	int yDlg;
	unsigned dwError;
	unsigned reserved;
	unsigned reserved2;
};


typedef void __fastcall (__closure *TOnAsyncEvent)(System::TObject* Sender, int State, int Error, System::UnicodeString MessageText);

class PASCALIMPLEMENTATION TLMDRAS : public Lmdwebbase::TLMDWebComponent
{
	typedef Lmdwebbase::TLMDWebComponent inherited;
	
private:
	System::UnicodeString FErrorString;
	System::UnicodeString FCurrentConnection;
	TOnAsyncEvent FOnAsyncEvent;
	void __fastcall SetErrorString(const System::UnicodeString Value);
	void __fastcall SetSelectConnection(const System::UnicodeString Value);
	bool __fastcall GetIsConnected(void);
	
protected:
	int hRAS;
	unsigned uMsg;
	NativeUInt hNotifier;
	void __fastcall NotifierProc(Winapi::Messages::TMessage &Message);
	
public:
	__fastcall virtual TLMDRAS(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TLMDRAS(void);
	void __fastcall GetEntries(System::Classes::TStrings* Entries);
	void __fastcall GetConnections(System::Classes::TStrings* Connections);
	TRasConnStatus __fastcall GetConnectionState(int hRAS);
	bool __fastcall Dial(const System::UnicodeString szEntry);
	int __fastcall HangUp(void);
	System::UnicodeString __fastcall GetStatusString(int State, int Error);
	System::UnicodeString __fastcall DefaultConnection(void);
	bool __fastcall ShowRasPhonebookDlg(const System::UnicodeString PhoneBook = System::UnicodeString(), const System::UnicodeString Entry = System::UnicodeString());
	bool __fastcall ShowRasEntryDlg(const System::UnicodeString PhoneBook = System::UnicodeString(), const System::UnicodeString Entry = System::UnicodeString());
	bool __fastcall ShowRasDialDlg(const System::UnicodeString PhoneBook, const System::UnicodeString Entry, const System::UnicodeString PhoneNumber = System::UnicodeString());
	bool __fastcall ShowRasMonitorDlg(const System::UnicodeString DeviceName);
	__property System::UnicodeString ErrorString = {read=FErrorString, write=SetErrorString};
	__property bool IsConnected = {read=GetIsConnected, default=1};
	__property System::UnicodeString SelectConnection = {read=FCurrentConnection, write=SetSelectConnection};
	__property int HRASCONN = {read=hRAS, nodefault};
	
__published:
	__property About = {default=0};
	__property TOnAsyncEvent OnAsyncEvent = {read=FOnAsyncEvent, write=FOnAsyncEvent};
};


//-- var, const, procedure ---------------------------------------------------
#define RASDIALEVENT L"RasDialEvent"
static const System::Word WM_RASDIALEVENT = System::Word(0xcccd);
static const System::Int8 DNLEN = System::Int8(0xf);
static const System::Word UNLEN = System::Word(0x100);
static const System::Word PWLEN = System::Word(0x100);
static const System::Int8 NETBIOS_NAME_LEN = System::Int8(0x10);
static const System::Int8 RASMaxDeviceType = System::Int8(0x10);
static const System::Byte RASMaxPhoneNumber = System::Byte(0x80);
static const System::Int8 RASMaxIpAddress = System::Int8(0xf);
static const System::Int8 RASMaxIpxAddress = System::Int8(0x15);
static const System::Word RASMaxEntryName = System::Word(0x100);
static const System::Byte RASMaxDeviceName = System::Byte(0x80);
static const System::Byte RASMaxCallbackNumber = System::Byte(0x80);
static const System::Word RASCS_PAUSED = System::Word(0x1000);
static const System::Word RASCS_DONE = System::Word(0x2000);
static const System::Int8 RASCS_OpenPort = System::Int8(0x0);
static const System::Int8 RASCS_PortOpened = System::Int8(0x1);
static const System::Int8 RASCS_ConnectDevice = System::Int8(0x2);
static const System::Int8 RASCS_DeviceConnected = System::Int8(0x3);
static const System::Int8 RASCS_AllDevicesConnected = System::Int8(0x4);
static const System::Int8 RASCS_Authenticate = System::Int8(0x5);
static const System::Int8 RASCS_AuthNotify = System::Int8(0x6);
static const System::Int8 RASCS_AuthRetry = System::Int8(0x7);
static const System::Int8 RASCS_AuthCallback = System::Int8(0x8);
static const System::Int8 RASCS_AuthChangePassword = System::Int8(0x9);
static const System::Int8 RASCS_AuthProject = System::Int8(0xa);
static const System::Int8 RASCS_AuthLinkSpeed = System::Int8(0xb);
static const System::Int8 RASCS_AuthAck = System::Int8(0xc);
static const System::Int8 RASCS_ReAuthenticate = System::Int8(0xd);
static const System::Int8 RASCS_Authenticated = System::Int8(0xe);
static const System::Int8 RASCS_PrepareForCallback = System::Int8(0xf);
static const System::Int8 RASCS_WaitForModemReset = System::Int8(0x10);
static const System::Int8 RASCS_WaitForCallback = System::Int8(0x11);
static const System::Int8 RASCS_Projected = System::Int8(0x12);
static const System::Int8 RASCS_StartAuthentication = System::Int8(0x13);
static const System::Int8 RASCS_CallbackComplete = System::Int8(0x14);
static const System::Int8 RASCS_LogonNetwork = System::Int8(0x15);
static const System::Word RASCS_Interactive = System::Word(0x1000);
static const System::Word RASCS_RetryAuthentication = System::Word(0x1001);
static const System::Word RASCS_CallbackSetByCaller = System::Word(0x1002);
static const System::Word RASCS_PasswordExpired = System::Word(0x1003);
static const System::Word RASCS_Connected = System::Word(0x2000);
static const System::Word RASCS_Disconnected = System::Word(0x2001);
static const System::Int8 RDEOPT_UsePrefixSuffix = System::Int8(0x1);
static const System::Int8 RDEOPT_PausedStates = System::Int8(0x2);
static const System::Int8 RDEOPT_IgnoreModemSpeaker = System::Int8(0x4);
static const System::Int8 RDEOPT_SetModemSpeaker = System::Int8(0x8);
static const System::Int8 RDEOPT_IgnoreSoftwareCompression = System::Int8(0x10);
static const System::Int8 RDEOPT_SetSoftwareCompression = System::Int8(0x20);
extern DELPHI_PACKAGE bool __fastcall IsRASExist(void);
}	/* namespace Lmdras */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDRAS)
using namespace Lmdras;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdrasHPP
