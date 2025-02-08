// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysMemoryObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysmemoryobjectHPP
#define LmdsysmemoryobjectHPP

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

namespace Lmdsysmemoryobject
{
//-- forward type declarations -----------------------------------------------
class DELPHICLASS TLMDSysMemoryObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysMemoryDisplayInfo : unsigned char { mlpidTotalPhysicalMemory, mlpidAvailablePhysicalMemory, mlpidMemoryLoad, mlpidTotalPageFile, mlpidAvailablePageFile, mlpidTotalVirtual, mlpidAvailableVirtual, mlpidAvailableExtendedVirtual, mlpidPageSize, mlpidAllocationGranularity, mlpidMinAppAddress, mlpidMaxAppAddress };

typedef System::Set<TLMDSysMemoryDisplayInfo, TLMDSysMemoryDisplayInfo::mlpidTotalPhysicalMemory, TLMDSysMemoryDisplayInfo::mlpidMaxAppAddress> TLMDSysMemoryDisplayInfos;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 12> Lmdsysmemoryobject__1;

enum DECLSPEC_DENUM TLMDSysMemoryDisplayFormat : unsigned char { mdfByte, mdfKB, mdfMB };

typedef System::StaticArray<System::UnicodeString, 3> Lmdsysmemoryobject__2;

class PASCALIMPLEMENTATION TLMDSysMemoryObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	__int64 FMemoryLoad;
	__int64 FTotalPhys;
	__int64 FAvailPhys;
	__int64 FTotalPageFile;
	__int64 FAvailPageFile;
	__int64 FTotalVirtual;
	__int64 FAvailVirtual;
	__int64 FPageSize;
	__int64 FMinAppAddress;
	__int64 FMaxAppAddress;
	__int64 FAvailExtendedVirtual;
	__int64 FAllocGranularity;
	TLMDSysMemoryDisplayInfos FDisplayInfo;
	TLMDSysMemoryDisplayFormat FDisplayFormat;
	void __fastcall SetDummyCardinal(int index, __int64 aValue);
	void __fastcall SetDisplayInfo(const TLMDSysMemoryDisplayInfos Value);
	void __fastcall SetDisplayFormat(const TLMDSysMemoryDisplayFormat Value);
	__int64 __fastcall GetValue(int index);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysMemoryObject(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	
__published:
	__property __int64 MemoryLoad = {read=GetValue, write=SetDummyCardinal, stored=false, index=0};
	__property __int64 TotalPhysicalMemory = {read=GetValue, write=SetDummyCardinal, stored=false, index=1};
	__property __int64 AvailablePhysicalMemory = {read=GetValue, write=SetDummyCardinal, stored=false, index=2};
	__property __int64 TotalPageFile = {read=GetValue, write=SetDummyCardinal, stored=false, index=3};
	__property __int64 AvailablePageFile = {read=GetValue, write=SetDummyCardinal, stored=false, index=4};
	__property __int64 TotalVirtual = {read=GetValue, write=SetDummyCardinal, stored=false, index=5};
	__property __int64 AvailableVirtual = {read=GetValue, write=SetDummyCardinal, stored=false, index=6};
	__property __int64 PageSize = {read=GetValue, write=SetDummyCardinal, stored=false, index=7};
	__property __int64 AllocationGranularity = {read=GetValue, write=SetDummyCardinal, stored=false, index=8};
	__property __int64 MinAppAddress = {read=GetValue, write=SetDummyCardinal, stored=false, index=9};
	__property __int64 MaxAppAddress = {read=GetValue, write=SetDummyCardinal, stored=false, index=10};
	__property __int64 AvailExtendedVirtual = {read=GetValue, write=SetDummyCardinal, stored=false, index=11};
	__property TLMDSysMemoryDisplayFormat MemoryFormat = {read=FDisplayFormat, write=SetDisplayFormat, default=0};
	__property TLMDSysMemoryDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=4095};
public:
	/* TLMDSysObject.Destroy */ inline __fastcall virtual ~TLMDSysMemoryObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysMemoryDisplayInfos (System::Set<TLMDSysMemoryDisplayInfo, TLMDSysMemoryDisplayInfo::mlpidTotalPhysicalMemory, TLMDSysMemoryDisplayInfo::mlpidMaxAppAddress>() << TLMDSysMemoryDisplayInfo::mlpidTotalPhysicalMemory << TLMDSysMemoryDisplayInfo::mlpidAvailablePhysicalMemory << TLMDSysMemoryDisplayInfo::mlpidMemoryLoad << TLMDSysMemoryDisplayInfo::mlpidTotalPageFile << TLMDSysMemoryDisplayInfo::mlpidAvailablePageFile << TLMDSysMemoryDisplayInfo::mlpidTotalVirtual << TLMDSysMemoryDisplayInfo::mlpidAvailableVirtual << TLMDSysMemoryDisplayInfo::mlpidAvailableExtendedVirtual << TLMDSysMemoryDisplayInfo::mlpidPageSize << TLMDSysMemoryDisplayInfo::mlpidAllocationGranularity << TLMDSysMemoryDisplayInfo::mlpidMinAppAddress << TLMDSysMemoryDisplayInfo::mlpidMaxAppAddress )
extern DELPHI_PACKAGE Lmdsysmemoryobject__1 LMDSysMemoryProps;
extern DELPHI_PACKAGE Lmdsysmemoryobject__2 sLMDSysMemory;
}	/* namespace Lmdsysmemoryobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSMEMORYOBJECT)
using namespace Lmdsysmemoryobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysmemoryobjectHPP
