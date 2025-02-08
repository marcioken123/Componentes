// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysEventLog.pas' rev: 31.00 (Windows)

#ifndef LmdsyseventlogHPP
#define LmdsyseventlogHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <Vcl.Forms.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysEventListView.hpp>
#include <LMDSysConst.hpp>
#include <LMDCustomComponent.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyseventlog
{
//-- forward type declarations -----------------------------------------------
struct TLMDSysEventLogRecord;
struct TLMDSysEventInfo;
class DELPHICLASS TLMDSysEventLog;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDSysEventLogRecord
{
public:
	unsigned Length;
	unsigned Reserved;
	unsigned RecordNumber;
	unsigned TimeGenerated;
	unsigned TimeWritten;
	unsigned EventID;
	System::Word EventType;
	System::Word NumStrings;
	System::Word EventCategory;
	System::Word ReservedFlags;
	unsigned ClosingRecordNumber;
	unsigned StringOffset;
	unsigned UserSidLength;
	unsigned UserSidOffset;
	unsigned DataLength;
	unsigned DataOffset;
};


typedef TLMDSysEventLogRecord *PLMDSysEventLogRecord;

enum DECLSPEC_DENUM TLMDSysEventType : unsigned char { setError, setWarning, setInformation, setAuditSuccess, setAuditFailure, setUnknown };

typedef System::StaticArray<System::UnicodeString, 6> Lmdsyseventlog__1;

struct DECLSPEC_DRECORD TLMDSysEventInfo
{
public:
	System::UnicodeString Source;
	System::UnicodeString Category;
	System::UnicodeString ComputerName;
	System::TDateTime DateTime;
	TLMDSysEventType EventType;
	unsigned EventID;
	unsigned RecordNumber;
	void *UserSID;
	System::UnicodeString UserName;
	System::UnicodeString UserNameLong;
	System::UnicodeString MessageText;
};


typedef TLMDSysEventInfo *PLMDSysEventInfo;

enum DECLSPEC_DENUM TLMDSysLogType : unsigned char { sltApplication, sltSecurity, sltSystem, sltCustom };

typedef void __fastcall (__closure *TLMDSysEventOnReadItem)(System::TObject* Sender, PLMDSysEventInfo ItemData, bool &Continue);

typedef void __fastcall (__closure *TLMDSysEventDlgChange)(System::TObject* Sender, int Position);

enum DECLSPEC_DENUM Lmdsyseventlog__2 : unsigned char { sdoCenterDialog, sdoCenterOwnerForm, sdoListShowDialog, sdoListUpdatePosition };

typedef System::Set<Lmdsyseventlog__2, Lmdsyseventlog__2::sdoCenterDialog, Lmdsyseventlog__2::sdoListUpdatePosition> TLMDSysEventDlgOptions;

class PASCALIMPLEMENTATION TLMDSysEventLog : public Lmdsysbase::TLMDSysComponent
{
	typedef Lmdsysbase::TLMDSysComponent inherited;
	
private:
	System::UnicodeString FServer;
	System::UnicodeString FCustom;
	bool FAuto;
	bool FInternal;
	HWND FLogHandle;
	TLMDSysLogType FLogType;
	TLMDSysEventDlgOptions FDlgOptions;
	TLMDSysEventOnReadItem FOnReadItem;
	Lmdsysbase::TLMDSysDirection FDirection;
	TLMDSysEventDlgChange FOnDlgChange;
	System::Classes::TNotifyEvent FOnEnd;
	System::Classes::TNotifyEvent FOnStart;
	System::Classes::TNotifyEvent FOnClick;
	System::Classes::TNotifyEvent FOnDlgCustomize;
	Lmdsyseventlistview::TLMDSysEventListView* FControl;
	void __fastcall SetCustom(const System::UnicodeString Value);
	void __fastcall SetControl(Lmdsyseventlistview::TLMDSysEventListView* const Value);
	void __fastcall SetServer(const System::UnicodeString Value);
	void __fastcall SetLogType(const TLMDSysLogType Value);
	bool __fastcall CheckFlags(void);
	void __fastcall GetBtnClick(System::TObject* Sender);
	System::UnicodeString __fastcall GetLogName(void);
	int __fastcall GetCount(void);
	bool __fastcall GetOpenState(void);
	
protected:
	void __fastcall DoReadItem(PLMDSysEventInfo ItemData, bool &Continue);
	void __fastcall ExtractInfo(PLMDSysEventLogRecord indata, PLMDSysEventInfo outData, bool ExInfo = false);
	void __fastcall FillControl(void);
	virtual void __fastcall Loaded(void);
	virtual void __fastcall Notification(System::Classes::TComponent* AComponent, System::Classes::TOperation Operation);
	
public:
	__fastcall virtual TLMDSysEventLog(System::Classes::TComponent* aOwner);
	__fastcall virtual ~TLMDSysEventLog(void);
	void __fastcall Open(void);
	void __fastcall Close(void);
	System::UnicodeString __fastcall CategoryToString(System::Word EventCategory);
	int __fastcall FirstRecordNr(void);
	int __fastcall LastRecordNr(void);
	bool __fastcall Read(int nr, PLMDSysEventInfo ItemData, bool ExInfo = false);
	bool __fastcall ReadAll(bool ExInfo = false);
	bool __fastcall ShowEventDialog(int nr = 0x0, Vcl::Forms::TCustomForm* aOwner = (Vcl::Forms::TCustomForm*)(0x0), int X = 0xffffffff, int Y = 0xffffffff);
	__property bool Opened = {read=GetOpenState, nodefault};
	__property int Count = {read=GetCount, nodefault};
	__property System::UnicodeString LogName = {read=GetLogName};
	
__published:
	__property System::UnicodeString Server = {read=FServer, write=SetServer};
	__property TLMDSysLogType LogType = {read=FLogType, write=SetLogType, default=0};
	__property System::UnicodeString CustomLog = {read=FCustom, write=SetCustom};
	__property Lmdsysbase::TLMDSysDirection ReadDirection = {read=FDirection, write=FDirection, default=1};
	__property TLMDSysEventDlgOptions DlgOptions = {read=FDlgOptions, write=FDlgOptions, default=13};
	__property System::Classes::TNotifyEvent OnReadAllStart = {read=FOnStart, write=FOnStart};
	__property System::Classes::TNotifyEvent OnReadAllEnd = {read=FOnEnd, write=FOnEnd};
	__property TLMDSysEventOnReadItem OnReadEvent = {read=FOnReadItem, write=FOnReadItem};
	__property bool AutoRetrieve = {read=FAuto, write=FAuto, default=1};
	__property Lmdsyseventlistview::TLMDSysEventListView* DisplayControl = {read=FControl, write=SetControl};
	__property System::Classes::TNotifyEvent OnDetailsDlgCustomize = {read=FOnDlgCustomize, write=FOnDlgCustomize};
	__property TLMDSysEventDlgChange OnDetailsDlgChange = {read=FOnDlgChange, write=FOnDlgChange};
	__property System::Classes::TNotifyEvent OnDetailsDlgBtnClick = {read=FOnClick, write=FOnClick};
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE Lmdsyseventlog__1 LMDSysEventTypeString;
#define def_DlgOptions (System::Set<Lmdsyseventlog__2, Lmdsyseventlog__2::sdoCenterDialog, Lmdsyseventlog__2::sdoListUpdatePosition>() << Lmdsyseventlog__2::sdoCenterDialog << Lmdsyseventlog__2::sdoListShowDialog << Lmdsyseventlog__2::sdoListUpdatePosition )
}	/* namespace Lmdsyseventlog */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSEVENTLOG)
using namespace Lmdsyseventlog;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyseventlogHPP
