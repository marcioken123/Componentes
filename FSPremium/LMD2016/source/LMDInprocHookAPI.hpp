// CodeGear C++Builder
// Copyright (c) 1995, 2020 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'LMDInprocHookAPI.pas' rev: 34.00 (Windows)

#ifndef LmdinprochookapiHPP
#define LmdinprochookapiHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.TlHelp32.hpp>
#include <Winapi.Windows.hpp>
#include <System.SysUtils.hpp>
#include <LMDTypes.hpp>
#include <LMDSysIn.hpp>

//-- user supplied -----------------------------------------------------------

namespace Lmdinprochookapi
{
//-- forward type declarations -----------------------------------------------
struct TJumpInstruction;
struct _IMAGE_THUNK_DATA;
struct _IMAGE_IMPORT_DESCRIPTOR;
//-- type declarations -------------------------------------------------------
typedef TJumpInstruction *PJumpInstruction;

#pragma pack(push,1)
struct DECLSPEC_DRECORD TJumpInstruction
{
	
public:
	union
	{
		struct 
		{
			unsigned DW1;
			unsigned DW2;
		};
		struct 
		{
			System::Byte Code;
			unsigned Offset;
		};
		
	};
};
#pragma pack(pop)


typedef _IMAGE_THUNK_DATA *PImageThunkData;

#pragma pack(push,1)
struct DECLSPEC_DRECORD _IMAGE_THUNK_DATA
{
	
public:
	union
	{
		struct 
		{
			_IMAGE_IMPORT_BY_NAME *AddressOfData;
		};
		struct 
		{
			unsigned Ordinal;
		};
		struct 
		{
			unsigned *FFunction;
		};
		struct 
		{
			System::Byte *ForwarderString;
		};
		
	};
};
#pragma pack(pop)


typedef _IMAGE_THUNK_DATA IMAGE_THUNK_DATA;

typedef _IMAGE_THUNK_DATA *PIMAGE_THUNK_DATA;

typedef _IMAGE_THUNK_DATA TImageThunkData;

typedef _IMAGE_IMPORT_DESCRIPTOR *PImageImportDescriptor;

#pragma pack(push,1)
struct DECLSPEC_DRECORD _IMAGE_IMPORT_DESCRIPTOR
{
public:
	_IMAGE_THUNK_DATA *OriginalFirstThunk;
	unsigned TimeDateStamp;
	unsigned ForwarderChain;
	unsigned Name;
	_IMAGE_THUNK_DATA *FirstThunk;
};
#pragma pack(pop)


typedef _IMAGE_IMPORT_DESCRIPTOR TImageImportDescriptor;

//-- var, const, procedure ---------------------------------------------------
static const System::Int8 ci_code_ptr = System::Int8(0x1);
static const System::Int8 ci_code_size = System::Int8(0x2);
static const System::Int8 ci_code_data_offset = System::Int8(0x3);
extern DELPHI_PACKAGE bool __fastcall IsBadWritePtrSize(void * Ptr, unsigned Size);
extern DELPHI_PACKAGE bool __fastcall IsBadWritePtrPtr(void * Ptr);
extern DELPHI_PACKAGE bool __fastcall IsBadReadPtrSize(void * Ptr, unsigned Size);
extern DELPHI_PACKAGE bool __fastcall IsBadReadPtrPtr(void * Ptr);
extern DELPHI_PACKAGE NativeUInt __fastcall GetModuleFromAddress(void * AAddr);
extern DELPHI_PACKAGE Winapi::Windows::PImageNtHeaders32 __fastcall GetModuleNtHeaders(NativeUInt Module);
extern DELPHI_PACKAGE Winapi::Windows::PImageExportDirectory __fastcall GetModuleExportDirectory(NativeUInt Module);
extern DELPHI_PACKAGE PImageImportDescriptor __fastcall GetModuleImportDirectory(NativeUInt Module);
extern DELPHI_PACKAGE void * __fastcall GetProcAddressETAOrd(NativeUInt Module, unsigned AOrd);
extern DELPHI_PACKAGE bool __fastcall UnprotectMemory(void * AAddr, unsigned MemSize, unsigned MemProtection);
extern DELPHI_PACKAGE bool __fastcall SetProcAddressETA(NativeUInt Module, const System::UnicodeString ProcName, void * NewAddr);
extern DELPHI_PACKAGE void * __fastcall GetProcAddressETA(NativeUInt Module, const System::UnicodeString ProcName);
extern DELPHI_PACKAGE void * __fastcall HookImportTableApiFunction(NativeUInt hFromModule, const System::UnicodeString FunctionModule, const System::UnicodeString FunctionName, void * NewProc);
extern DELPHI_PACKAGE void __fastcall HookApi_GetCodeTemplateInfo(void * pTemplate, unsigned DataAllocSize, void * &pCode, unsigned &DataOffset, unsigned &CodeSize);
extern DELPHI_PACKAGE void * __fastcall HookApi_GetBuffer(unsigned BuffSize, const System::UnicodeString sBuffID, NativeUInt &hSharedMem, bool &bFirstAllocate);
extern DELPHI_PACKAGE void * __fastcall HookApi_CreateCodeTemplate(void * pCodeTemplate, unsigned DataAllocSize, const System::UnicodeString sCodeID, NativeUInt &hSharedMem, bool &bFirstAllocate, void * &CodeData, unsigned &CodeSize);
extern DELPHI_PACKAGE bool __fastcall HookApi_LockCodeTemplate(NativeUInt &hSharedMem, bool bFirstAllocate);
extern DELPHI_PACKAGE void * __fastcall GetNativeAddr(void * Ptr);
extern DELPHI_PACKAGE bool __fastcall JumpFromCode(void * MSrc, void * MDest, PJumpInstruction SaveJump);
extern DELPHI_PACKAGE bool __fastcall RestoreSavedCode(void * MSrc, TJumpInstruction &SaveJump);
extern DELPHI_PACKAGE bool __fastcall IsJumpFromCode(void * MSrc, void * MDest);
extern DELPHI_PACKAGE bool __fastcall BeginLock(const System::UnicodeString LockName, NativeUInt &hLock);
extern DELPHI_PACKAGE void __fastcall EndLock(NativeUInt &hLock);
}	/* namespace Lmdinprochookapi */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_LMDINPROCHOOKAPI)
using namespace Lmdinprochookapi;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// LmdinprochookapiHPP
