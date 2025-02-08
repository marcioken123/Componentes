// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDSysProcessorObject.pas' rev: 31.00 (Windows)

#ifndef LmdsysprocessorobjectHPP
#define LmdsysprocessorobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <System.Classes.hpp>
#include <Winapi.Windows.hpp>
#include <LMDSysObject.hpp>
#include <LMDSysBase.hpp>
#include <LMDSysConst.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdsysprocessorobject
{
//-- forward type declarations -----------------------------------------------
struct TLMDSysCPUInfo;
class DELPHICLASS TLMDProcessorItem;
class DELPHICLASS TLMDProcessorsInfo;
class DELPHICLASS TLMDSysProcessorObject;
//-- type declarations -------------------------------------------------------
enum DECLSPEC_DENUM TLMDSysProcessorDisplayInfoDotNet : unsigned char { cpiAddressWidth, cpiArchitecture, cpiAvailability, cpiCpuStatus, cpiCurrentClockSpeed, cpiCurrentVoltage, cpiDataWidth, cpiDescription, cpiDeviceID, cpiExtClock, cpiCPUFamily, cpiL2CacheSize, cpiL2CacheSpeed, cpiLastErrorCode, cpiLevel, cpiLoadPercentage, cpiManufacturer, cpiMaxClockSpeed, cpiName, cpiOtherFamilyDescription, cpiProcessorId, cpiProcessorType, cpiRevision, cpiRole, cpiSocketDesignation, cpiStatus, cpiStatusInfo, cpiCPUStepping, cpiUniqueId, cpiUpgradeMethod, cpiVoltageCaps };

enum DECLSPEC_DENUM TLMDSysProcessorDisplayInfo : unsigned char { cpiCPUName, cpiIDString, cpiMHz, cpiCount, cpiIdentifier, cpiVendorIdentifier, cpiMMX, cpiAMD3DNow, cpiProcessorUsage, cpiFamily, cpiStepping, cpiModel, cpiFPU, cpiVirtualModeExtensions, cpiDebuggingExtensions, cpiPageSizeExtensions, cpiTimeStampCounter, cpiK86_ModelSpecificRegisters, cpiMachineCheckException, cpiCMP_XCHG_8B, cpiAPIC, cpiMemoryTypeRangeRegisters, cpiGlobalPaging, cpiCond_MOVE_Instruct, cpiSYSCALLandSYSRET, cpiFPCond_MOVE_Instruct };

typedef System::Set<TLMDSysProcessorDisplayInfo, TLMDSysProcessorDisplayInfo::cpiCPUName, TLMDSysProcessorDisplayInfo::cpiFPCond_MOVE_Instruct> TLMDSysProcessorDisplayInfos;

typedef System::Set<TLMDSysProcessorDisplayInfoDotNet, TLMDSysProcessorDisplayInfoDotNet::cpiAddressWidth, TLMDSysProcessorDisplayInfoDotNet::cpiVoltageCaps> TLMDSysProcessorDisplayInfosDotNet;

typedef System::StaticArray<Lmdsysbase::TLMDSysProperty, 26> Lmdsysprocessorobject__1;

typedef TLMDSysCPUInfo *PLMDSysCPUInfo;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TLMDSysCPUInfo
{
public:
	System::StaticArray<char, 12> IDString;
	int Stepping;
	int Model;
	int Family;
	bool FPU;
	bool VirtualModeExtensions;
	bool DebuggingExtensions;
	bool PageSizeExtensions;
	bool TimeStampCounter;
	bool K86ModelSpecificRegisters;
	bool MachineCheckException;
	bool CMPXCHG8B;
	bool APIC;
	bool MemoryTypeRangeRegisters;
	bool GlobalPagingExtension;
	bool ConditionalMoveInstruction;
	bool MMX;
	bool SYSCALLandSYSRET;
	bool FPConditionalMoveInstruction;
	bool AMD3DNow;
	System::StaticArray<char, 49> CPUName;
	System::StaticArray<System::Byte, 1025> Dummy;
};
#pragma pack(pop)


#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProcessorItem : public System::Classes::TCollectionItem
{
	typedef System::Classes::TCollectionItem inherited;
	
private:
	int FMHz;
	System::UnicodeString FIdentifier;
	System::UnicodeString FVendorIdentifier;
	void __fastcall SetIdentifier(const System::UnicodeString Value);
	void __fastcall SetMhz(const int Value);
	void __fastcall SetVendorIdentifier(const System::UnicodeString Value);
	
public:
	__property System::UnicodeString Identifier = {read=FIdentifier, write=SetIdentifier, stored=false};
	__property System::UnicodeString VendorIdentifier = {read=FVendorIdentifier, write=SetVendorIdentifier, stored=false};
	__property int MHz = {read=FMHz, write=SetMhz, nodefault};
public:
	/* TCollectionItem.Create */ inline __fastcall virtual TLMDProcessorItem(System::Classes::TCollection* Collection) : System::Classes::TCollectionItem(Collection) { }
	/* TCollectionItem.Destroy */ inline __fastcall virtual ~TLMDProcessorItem(void) { }
	
};

#pragma pack(pop)

#pragma pack(push,4)
class PASCALIMPLEMENTATION TLMDProcessorsInfo : public System::Classes::TCollection
{
	typedef System::Classes::TCollection inherited;
	
public:
	TLMDProcessorItem* operator[](int Index) { return this->Items[Index]; }
	
private:
	Lmdsysobject::TLMDSysObject* FOwner;
	System::UnicodeString FMhzDisplayString;
	System::UnicodeString FIdentDisplayString;
	System::UnicodeString FVendorDisplayString;
	HIDESBASE TLMDProcessorItem* __fastcall GetItem(int Index);
	HIDESBASE void __fastcall SetItem(int Index, TLMDProcessorItem* Value);
	
protected:
	DYNAMIC System::Classes::TPersistent* __fastcall GetOwner(void);
	
public:
	HIDESBASE TLMDProcessorItem* __fastcall Add(void);
	__fastcall TLMDProcessorsInfo(Lmdsysobject::TLMDSysObject* aOwner);
	__fastcall virtual ~TLMDProcessorsInfo(void);
	void __fastcall Refresh(void);
	__property TLMDProcessorItem* Items[int Index] = {read=GetItem, write=SetItem/*, default*/};
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TLMDSysProcessorObject : public Lmdsysobject::TLMDSysObject
{
	typedef Lmdsysobject::TLMDSysObject inherited;
	
private:
	System::Byte FCount;
	TLMDProcessorsInfo* FProcessorsInfo;
	TLMDSysCPUInfo FInfo;
	TLMDSysProcessorDisplayInfos FDisplayInfo;
	TLMDSysProcessorDisplayInfosDotNet FDisplayInfoDotNet;
	void __fastcall SetProcessorUsage(const System::Byte Value);
	void __fastcall SetCount(const System::Byte Value);
	System::UnicodeString __fastcall GetString(int Index);
	int __fastcall GetInteger(int Index);
	bool __fastcall GetBoolean(int Index);
	System::Byte __fastcall GetProcessorUsage(void);
	void __fastcall SetDummyBool(int Index, bool b);
	void __fastcall SetDummyString(int Index, System::UnicodeString s);
	void __fastcall SetDummyInt(int Index, int b);
	void __fastcall SetDisplayInfo(const TLMDSysProcessorDisplayInfos Value);
	
protected:
	virtual void __fastcall RegisterProperties(void);
	
public:
	__fastcall virtual TLMDSysProcessorObject(void);
	__fastcall virtual ~TLMDSysProcessorObject(void);
	virtual void __fastcall Init(void);
	virtual void __fastcall Refresh(void);
	virtual void __fastcall Apply(void);
	virtual System::UnicodeString __fastcall GetElementTitle(void);
	virtual System::UnicodeString __fastcall GetElementDescription(void);
	virtual Lmdsysbase::TLMDSysInfoType __fastcall GetElementType(void);
	__property System::Byte ProcessorUsage = {read=GetProcessorUsage, write=SetProcessorUsage, stored=false, nodefault};
	__property TLMDProcessorsInfo* ProcessorsInfo = {read=FProcessorsInfo};
	
__published:
	__property System::Byte Count = {read=FCount, write=SetCount, stored=false, nodefault};
	__property System::UnicodeString IDString = {read=GetString, write=SetDummyString, stored=false, index=0};
	__property System::UnicodeString CPUName = {read=GetString, write=SetDummyString, stored=false, index=1};
	__property int Stepping = {read=GetInteger, write=SetDummyInt, stored=false, index=0, nodefault};
	__property int Model = {read=GetInteger, write=SetDummyInt, stored=false, index=1, nodefault};
	__property int Family = {read=GetInteger, write=SetDummyInt, stored=false, index=2, nodefault};
	__property bool FPU = {read=GetBoolean, write=SetDummyBool, stored=false, index=0, nodefault};
	__property bool VirtualModeExtensions = {read=GetBoolean, write=SetDummyBool, stored=false, index=1, nodefault};
	__property bool DebuggingExtensions = {read=GetBoolean, write=SetDummyBool, stored=false, index=2, nodefault};
	__property bool PageSizeExtensions = {read=GetBoolean, write=SetDummyBool, stored=false, index=3, nodefault};
	__property bool TimeStampCounter = {read=GetBoolean, write=SetDummyBool, stored=false, index=4, nodefault};
	__property bool K86_ModelSpecificRegisters = {read=GetBoolean, write=SetDummyBool, stored=false, index=5, nodefault};
	__property bool MachineCheckException = {read=GetBoolean, write=SetDummyBool, stored=false, index=6, nodefault};
	__property bool CMP_XCHG_8B = {read=GetBoolean, write=SetDummyBool, stored=false, index=7, nodefault};
	__property bool APIC = {read=GetBoolean, write=SetDummyBool, stored=false, index=8, nodefault};
	__property bool MemoryTypeRangeRegisters = {read=GetBoolean, write=SetDummyBool, stored=false, index=9, nodefault};
	__property bool GlobalPaging = {read=GetBoolean, write=SetDummyBool, stored=false, index=10, nodefault};
	__property bool Cond_MOVE_Instruct = {read=GetBoolean, write=SetDummyBool, stored=false, index=11, nodefault};
	__property bool MMX = {read=GetBoolean, write=SetDummyBool, stored=false, index=12, nodefault};
	__property bool SYSCALLandSYSRET = {read=GetBoolean, write=SetDummyBool, stored=false, index=13, nodefault};
	__property bool FPCond_MOVE_Instruct = {read=GetBoolean, write=SetDummyBool, stored=false, index=14, nodefault};
	__property bool AMD3DNow = {read=GetBoolean, write=SetDummyBool, stored=false, index=15, nodefault};
	__property bool ExistCPUInfo = {read=GetBoolean, write=SetDummyBool, stored=false, index=16, nodefault};
	__property TLMDSysProcessorDisplayInfos DisplayInfo = {read=FDisplayInfo, write=SetDisplayInfo, default=67108607};
	__property TLMDSysProcessorDisplayInfosDotNet DisplayInfoDotNet = {read=FDisplayInfoDotNet, write=FDisplayInfoDotNet, stored=false, nodefault};
};


//-- var, const, procedure ---------------------------------------------------
#define def_TLMDSysProcessorDisplayInfosDotNet (System::Set<TLMDSysProcessorDisplayInfoDotNet, TLMDSysProcessorDisplayInfoDotNet::cpiAddressWidth, TLMDSysProcessorDisplayInfoDotNet::cpiVoltageCaps>() << TLMDSysProcessorDisplayInfoDotNet::cpiAddressWidth << TLMDSysProcessorDisplayInfoDotNet::cpiArchitecture << TLMDSysProcessorDisplayInfoDotNet::cpiAvailability << TLMDSysProcessorDisplayInfoDotNet::cpiCpuStatus << TLMDSysProcessorDisplayInfoDotNet::cpiCurrentClockSpeed << TLMDSysProcessorDisplayInfoDotNet::cpiCurrentVoltage << TLMDSysProcessorDisplayInfoDotNet::cpiDataWidth << TLMDSysProcessorDisplayInfoDotNet::cpiDescription << TLMDSysProcessorDisplayInfoDotNet::cpiDeviceID << TLMDSysProcessorDisplayInfoDotNet::cpiExtClock << TLMDSysProcessorDisplayInfoDotNet::cpiCPUFamily \
	<< TLMDSysProcessorDisplayInfoDotNet::cpiL2CacheSize << TLMDSysProcessorDisplayInfoDotNet::cpiL2CacheSpeed << TLMDSysProcessorDisplayInfoDotNet::cpiLastErrorCode << TLMDSysProcessorDisplayInfoDotNet::cpiLevel << TLMDSysProcessorDisplayInfoDotNet::cpiLoadPercentage << TLMDSysProcessorDisplayInfoDotNet::cpiManufacturer << TLMDSysProcessorDisplayInfoDotNet::cpiMaxClockSpeed << TLMDSysProcessorDisplayInfoDotNet::cpiName << TLMDSysProcessorDisplayInfoDotNet::cpiOtherFamilyDescription << TLMDSysProcessorDisplayInfoDotNet::cpiProcessorId << TLMDSysProcessorDisplayInfoDotNet::cpiProcessorType << TLMDSysProcessorDisplayInfoDotNet::cpiRevision << TLMDSysProcessorDisplayInfoDotNet::cpiRole << TLMDSysProcessorDisplayInfoDotNet::cpiSocketDesignation << TLMDSysProcessorDisplayInfoDotNet::cpiStatus \
	<< TLMDSysProcessorDisplayInfoDotNet::cpiStatusInfo << TLMDSysProcessorDisplayInfoDotNet::cpiCPUStepping << TLMDSysProcessorDisplayInfoDotNet::cpiUniqueId << TLMDSysProcessorDisplayInfoDotNet::cpiUpgradeMethod << TLMDSysProcessorDisplayInfoDotNet::cpiVoltageCaps )
#define def_TLMDSysProcessorDisplayInfos (System::Set<TLMDSysProcessorDisplayInfo, TLMDSysProcessorDisplayInfo::cpiCPUName, TLMDSysProcessorDisplayInfo::cpiFPCond_MOVE_Instruct>() << TLMDSysProcessorDisplayInfo::cpiCPUName << TLMDSysProcessorDisplayInfo::cpiIDString << TLMDSysProcessorDisplayInfo::cpiMHz << TLMDSysProcessorDisplayInfo::cpiCount << TLMDSysProcessorDisplayInfo::cpiIdentifier << TLMDSysProcessorDisplayInfo::cpiVendorIdentifier << TLMDSysProcessorDisplayInfo::cpiMMX << TLMDSysProcessorDisplayInfo::cpiAMD3DNow << TLMDSysProcessorDisplayInfo::cpiFamily << TLMDSysProcessorDisplayInfo::cpiStepping << TLMDSysProcessorDisplayInfo::cpiModel << TLMDSysProcessorDisplayInfo::cpiFPU << TLMDSysProcessorDisplayInfo::cpiVirtualModeExtensions << TLMDSysProcessorDisplayInfo::cpiDebuggingExtensions \
	<< TLMDSysProcessorDisplayInfo::cpiPageSizeExtensions << TLMDSysProcessorDisplayInfo::cpiTimeStampCounter << TLMDSysProcessorDisplayInfo::cpiK86_ModelSpecificRegisters << TLMDSysProcessorDisplayInfo::cpiMachineCheckException << TLMDSysProcessorDisplayInfo::cpiCMP_XCHG_8B << TLMDSysProcessorDisplayInfo::cpiAPIC << TLMDSysProcessorDisplayInfo::cpiMemoryTypeRangeRegisters << TLMDSysProcessorDisplayInfo::cpiGlobalPaging << TLMDSysProcessorDisplayInfo::cpiCond_MOVE_Instruct << TLMDSysProcessorDisplayInfo::cpiSYSCALLandSYSRET << TLMDSysProcessorDisplayInfo::cpiFPCond_MOVE_Instruct )
extern DELPHI_PACKAGE Lmdsysprocessorobject__1 LMDSysProcessorProps;
extern DELPHI_PACKAGE bool __fastcall LMDSysExistCPUInfo(void);
extern DELPHI_PACKAGE bool __fastcall LMDSysGetCPUInfo(TLMDSysCPUInfo &ainfo);
extern DELPHI_PACKAGE bool __fastcall LMDSysExistMMX(void);
extern DELPHI_PACKAGE bool __fastcall LMDSysExist3DNow(void);
}	/* namespace Lmdsysprocessorobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDSYSPROCESSOROBJECT)
using namespace Lmdsysprocessorobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdsysprocessorobjectHPP
