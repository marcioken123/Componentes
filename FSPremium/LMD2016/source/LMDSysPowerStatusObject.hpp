// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysPowerStatusObject.pas' rev: 31.00 (Windows)

#ifndef LmdsyspowerstatusobjectHPP
#define LmdsyspowerstatusobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <System.Classes.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsyspowerstatusobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysPowerStatusObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysPowerStatusDisplayInfo : unsigned char { ppidACLineStatus, ppidBatteryFlags, ppidBatterLifePercent, ppidBatteryLifeTime, ppidBatteryFullLifeTime };

typedef System::Set<TLMDSysPowerStatusDisplayInfo, TLMDSysPowerStatusDisplayInfo::ppidACLineStatus, TLMDSysPowerStatusDisplayInfo::ppidBatteryFullLifeTime> TLMDSysPowerStatusDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 5> Lmdsyspowerstatusobject__1;

enum DECLSPEC_DENUM TLMDACLineStatus : unsigned char { lsOffline, lsOnline, lsUnknown };

enum DECLSPEC_DENUM TLMDBatteryFlag : unsigned char { bfHigh, bfLow, bfCritical, bfCharging, bfNoSystemBat, bfUnknown };

typedef System::Set<TLMDBatteryFlag, TLMDBatteryFlag::bfHigh, TLMDBatteryFlag::bfUnknown> TLMDBatteryFlags;

class PASCALIMPLEMENTATION TLMDSysPowerStatusObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	TLMDACLineStatus FACLineStatus;
	TLMDBatteryFlags FBatteryFlags;
	System::Byte FBatteryLifePercent;
	unsigned FBatteryLifeTime;
	unsigned FBatteryFullLifeTime;
	TLMDSysPowerStatusDisplayInfos FDisplayInfo;
	void __fastcall SetDummyACLS(TLMDACLineStatus aValue);
	void __fastcall SetDummyBatF(TLMDBatteryFlags aValue);
	void __fastcall SetDummyLP(System::Byte aValue);
	void __fastcall SetDummyDW(int index, unsigned aValue);
	System::UnicodeString __fastcall ACLineStatusToStr(TLMDACLineStatus aACLineStatus);
	System::UnicodeString __fastcall BatteryFlagsToStr(TLMDBatteryFlags aBatteryFlags);
	void __fastcall SetDisplayInfo(const TLMDSysPowerStatusDisplayInfos Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysPowerStatusObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property TLMDACLineStatus ACLineStatus = {read=FACLineStatus, write=SetDummyACLS, stored=false, nodefault};
	__property TLMDBatteryFlags BatteryFlags = {read=FBatteryFlags, write=SetDummyBatF, stored=false, nodefault};
	__property System::Byte BatteryLifePercent = {read=FBatteryLifePercent, write=SetDummyLP, stored=false, nodefault};
	__property unsigned BatteryLifeTime = {read=FBatteryLifeTime, write=SetDummyDW, stored=false, index=0, nodefault};
	__property unsigned BatteryFullLifeTime = {read=FBatteryFullLifeTime, write=SetDummyDW, stored=false, index=1, nodefault};
	__property TLMDSysPowerStatusDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=31};
public:
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysPowerStatusObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysPowerStatusDisplayInfos (System::Set<TLMDSysPowerStatusDisplayInfo, TLMDSysPowerStatusDisplayInfo::ppidACLineStatus, TLMDSysPowerStatusDisplayInfo::ppidBatteryFullLifeTime>() << TLMDSysPowerStatusDisplayInfo::ppidACLineStatus << TLMDSysPowerStatusDisplayInfo::ppidBatteryFlags << TLMDSysPowerStatusDisplayInfo::ppidBatterLifePercent << TLMDSysPowerStatusDisplayInfo::ppidBatteryLifeTime << TLMDSysPowerStatusDisplayInfo::ppidBatteryFullLifeTime )
extern DELPHI_PACKAGE Lmdsyspowerstatusobject__1 LMDSysPowerStatusProps;
}	/* namespace Lmdsyspowerstatusobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPOWERSTATUSOBJECT)
using namespace Lmdsyspowerstatusobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsyspowerstatusobjectHPP
