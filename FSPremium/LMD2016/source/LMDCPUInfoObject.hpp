// CodeGear C++Builder
// Copyright (c) 1995, 2016 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDCPUInfoObject.pas' rev: 31.00 (Windows)

#ifndef LmdcpuinfoobjectHPP
#define LmdcpuinfoobjectHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <LMDObject.hpp>
#include <System.Classes.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdcpuinfoobject
{
//-- forward type declarations -----------------------------------------------
struct TLMDCPUInfo;
class DELPHICLASS TLMDCPUInfoObject;
//-- type declarations -------------------------------------------------------
struct DECLSPEC_DRECORD TLMDCPUInfo
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
	System::AnsiString CPUName;
};


class PASCALIMPLEMENTATION TLMDCPUInfoObject : public Lmdobject::TLMDObject
{
	typedef Lmdobject::TLMDObject inherited;
	
private:
	TLMDCPUInfo FInfo;
	System::UnicodeString __fastcall GetString(int Index);
	int __fastcall GetInteger(int Index);
	bool __fastcall GetBoolean(int Index);
	void __fastcall SetDummyBool(int Index, bool b);
	void __fastcall SetDummyString(int Index, System::UnicodeString s);
	
public:
	__fastcall virtual TLMDCPUInfoObject(System::Classes::TPersistent* Owner);
	void __fastcall GetInfo(void);
	
__published:
	__property System::UnicodeString IDString = {read=GetString, index=0};
	__property int Stepping = {read=GetInteger, index=0, nodefault};
	__property int Model = {read=GetInteger, index=1, nodefault};
	__property int Family = {read=GetInteger, index=2, nodefault};
	__property bool FPU = {read=GetBoolean, index=0, nodefault};
	__property bool VirtualModeExtensions = {read=GetBoolean, write=SetDummyBool, index=1, nodefault};
	__property bool DebuggingExtensions = {read=GetBoolean, write=SetDummyBool, index=2, nodefault};
	__property bool PageSizeExtensions = {read=GetBoolean, write=SetDummyBool, index=3, nodefault};
	__property bool TimeStampCoutner = {read=GetBoolean, write=SetDummyBool, index=4, nodefault};
	__property bool K86_ModelSpecificRegisters = {read=GetBoolean, write=SetDummyBool, index=5, nodefault};
	__property bool MachineCheckException = {read=GetBoolean, write=SetDummyBool, index=6, nodefault};
	__property bool CMP_XCHG_8B = {read=GetBoolean, write=SetDummyBool, index=7, nodefault};
	__property bool APIC = {read=GetBoolean, write=SetDummyBool, index=8, nodefault};
	__property bool MemoryTypeRangeRegisters = {read=GetBoolean, write=SetDummyBool, index=9, nodefault};
	__property bool GlobalPaging = {read=GetBoolean, write=SetDummyBool, index=10, nodefault};
	__property bool Cond_MOVE_Instruct = {read=GetBoolean, write=SetDummyBool, index=11, nodefault};
	__property bool MMX = {read=GetBoolean, write=SetDummyBool, index=12, nodefault};
	__property bool SysCallAndSysRet = {read=GetBoolean, write=SetDummyBool, index=13, nodefault};
	__property bool FPCond_MOVE_Instruct = {read=GetBoolean, write=SetDummyBool, index=14, nodefault};
	__property bool AMD3DNow = {read=GetBoolean, write=SetDummyBool, index=15, nodefault};
	__property System::UnicodeString CPUName = {read=GetString, write=SetDummyString, index=0};
	__property bool ExistCPUInfo = {read=GetBoolean, write=SetDummyBool, index=16, nodefault};
public:
	/* TPersistent.Destroy */ inline __fastcall virtual ~TLMDCPUInfoObject(void) { }
	
};


//-- var, const, procedure ---------------------------------------------------
extern DELPHI_PACKAGE bool __fastcall LMDExistCPUInfo(void);
extern DELPHI_PACKAGE bool __fastcall LMDGetCPUInfo(/* out */ TLMDCPUInfo &info);
extern DELPHI_PACKAGE bool __fastcall LMDExistMMX(void);
extern DELPHI_PACKAGE bool __fastcall LMDExist3DNow(void);
}	/* namespace Lmdcpuinfoobject */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDCPUINFOOBJECT)
using namespace Lmdcpuinfoobject;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdcpuinfoobjectHPP
