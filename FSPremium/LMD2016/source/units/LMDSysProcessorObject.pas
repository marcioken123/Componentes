{$W+}
unit LMDSysProcessorObject;
{$I LMDCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDSysProcessorObject unit (JH)
-------------------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, LMDSysObject, LMDSysBase, LMDSysConst;

type
  TLMDSysProcessorDisplayInfoDotNet=(cpiAddressWidth, cpiArchitecture, cpiAvailability,
                               cpiCpuStatus, cpiCurrentClockSpeed, cpiCurrentVoltage,
                               cpiDataWidth, cpiDescription, cpiDeviceID, cpiExtClock,
                               cpiCPUFamily, cpiL2CacheSize, cpiL2CacheSpeed, cpiLastErrorCode,
                               cpiLevel, cpiLoadPercentage, cpiManufacturer, cpiMaxClockSpeed,
                               cpiName, cpiOtherFamilyDescription, cpiProcessorId, cpiProcessorType,
                               cpiRevision, cpiRole, cpiSocketDesignation, cpiStatus,
                               cpiStatusInfo, cpiCPUStepping,  cpiUniqueId,
                               cpiUpgradeMethod, cpiVoltageCaps);

  TLMDSysProcessorDisplayInfo=(cpiCPUName, cpiIDString, cpiMHz, cpiCount, cpiIdentifier, cpiVendorIdentifier,
                               cpiMMX, cpiAMD3DNow, cpiProcessorUsage, cpiFamily,
                               cpiStepping, cpiModel, cpiFPU, cpiVirtualModeExtensions,
                               cpiDebuggingExtensions, cpiPageSizeExtensions, cpiTimeStampCounter,
                               cpiK86_ModelSpecificRegisters, cpiMachineCheckException, cpiCMP_XCHG_8B,
                               cpiAPIC, cpiMemoryTypeRangeRegisters, cpiGlobalPaging,
                               cpiCond_MOVE_Instruct,  cpiSYSCALLandSYSRET, cpiFPCond_MOVE_Instruct);

  TLMDSysProcessorDisplayInfos = set of TLMDSysProcessorDisplayInfo;
  TLMDSysProcessorDisplayInfosDotNet = set of TLMDSysProcessorDisplayInfoDotNet;

const
  def_TLMDSysProcessorDisplayInfosDotNet = [cpiAddressWidth, cpiArchitecture, cpiAvailability,
                                    cpiCpuStatus, cpiCurrentClockSpeed, cpiCurrentVoltage,
                                    cpiDataWidth, cpiDescription, cpiDeviceID, cpiExtClock,
                                    cpiCPUFamily, cpiL2CacheSize, cpiL2CacheSpeed, cpiLastErrorCode,
                                    cpiLevel, cpiLoadPercentage, cpiManufacturer, cpiMaxClockSpeed,
                                    cpiName, cpiOtherFamilyDescription, cpiProcessorId, cpiProcessorType,
                                    cpiRevision, cpiRole, cpiSocketDesignation, cpiStatus,
                                    cpiStatusInfo, cpiCPUStepping,  cpiUniqueId,
                                    cpiUpgradeMethod, cpiVoltageCaps
                                    ];

  def_TLMDSysProcessorDisplayInfos = [cpiCPUName, cpiIDString, cpiMHz, cpiCount, cpiIdentifier, cpiVendorIdentifier,
                                    cpiMMX, cpiAMD3DNow, cpiFamily,
                                    cpiStepping, cpiModel, cpiFPU, cpiVirtualModeExtensions,
                                    cpiDebuggingExtensions, cpiPageSizeExtensions, cpiTimeStampCounter,
                                    cpiK86_ModelSpecificRegisters, cpiMachineCheckException, cpiCMP_XCHG_8B,
                                    cpiAPIC, cpiMemoryTypeRangeRegisters, cpiGlobalPaging,
                                    cpiCond_MOVE_Instruct,  cpiSYSCALLandSYSRET, cpiFPCond_MOVE_Instruct
                                    ];

  LMDSysProcessorProps:array[TLMDSysProcessorDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysProcessorPropTitleCPUName; Description: sLMDSysProcessorPropDescCPUName),
    (Name: sLMDSysProcessorPropTitleIDString; Description: sLMDSysProcessorPropDescIDString),
    (Name: sLMDSysProcessorPropTitleMHz; Description: sLMDSysProcessorPropDescMHz),
    (Name: sLMDSysProcessorPropTitleCount; Description: sLMDSysProcessorPropDescCount),
    (Name: sLMDSysProcessorPropTitleIdentifier; Description: sLMDSysProcessorPropDescIdentifier),
    (Name: sLMDSysProcessorPropTitleVendorIdentifier; Description: sLMDSysProcessorPropDescVendorIdentifier),
    (Name: sLMDSysProcessorPropTitleMMX; Description: sLMDSysProcessorPropDescMMX),
    (Name: sLMDSysProcessorPropTitleAMD3DNow; Description: sLMDSysProcessorPropDescAMD3DNow),
    (Name: sLMDSysProcessorPropTitleProcessorUsage; Description: sLMDSysProcessorPropDescProcessorUsage),
    (Name: sLMDSysProcessorPropTitleFamily; Description: sLMDSysProcessorPropDescFamily),
    (Name: sLMDSysProcessorPropTitleStepping; Description: sLMDSysProcessorPropDescStepping),
    (Name: sLMDSysProcessorPropTitleModel; Description: sLMDSysProcessorPropDescModel),
    (Name: sLMDSysProcessorPropTitleFPU; Description: sLMDSysProcessorPropDescFPU),
    (Name: sLMDSysProcessorPropTitleVirtualModeExtensions; Description: sLMDSysProcessorPropDescVirtualModeExtensions),
    (Name: sLMDSysProcessorPropTitleDebuggingExtensions; Description: sLMDSysProcessorPropDescDebuggingExtensions),
    (Name: sLMDSysProcessorPropTitlePageSizeExtensions; Description: sLMDSysProcessorPropDescPageSizeExtensions),
    (Name: sLMDSysProcessorPropTitleTimeStampCounter; Description: sLMDSysProcessorPropDescTimeStampCounter),
    (Name: sLMDSysProcessorPropTitleK86_ModelSpecificRegisters; Description: sLMDSysProcessorPropDescK86_ModelSpecificRegisters),
    (Name: sLMDSysProcessorPropTitleMachineCheckException; Description: sLMDSysProcessorPropDescMachineCheckException),
    (Name: sLMDSysProcessorPropTitleCMP_XCHG_8B; Description: sLMDSysProcessorPropDescCMP_XCHG_8B),
    (Name: sLMDSysProcessorPropTitleAPIC; Description: sLMDSysProcessorPropDescAPIC),
    (Name: sLMDSysProcessorPropTitleMemoryTypeRangeRegisters; Description: sLMDSysProcessorPropDescMemoryTypeRangeRegisters),
    (Name: sLMDSysProcessorPropTitleGlobalPaging; Description: sLMDSysProcessorPropDescGlobalPaging),
    (Name: sLMDSysProcessorPropTitleCond_MOVE_Instruct; Description: sLMDSysProcessorPropDescCond_MOVE_Instruct),
    (Name: sLMDSysProcessorPropTitleSYSCALLandSYSRET; Description: sLMDSysProcessorPropDescSYSCALLandSYSRET),
    (Name: sLMDSysProcessorPropTitleFPCond_MOVE_Instruct; Description: sLMDSysProcessorPropDescFPCond_MOVE_Instruct));

type
  { ************************************************************************** }

  PLMDSysCPUInfo = ^TLMDSysCPUInfo;
  TLMDSysCPUInfo = packed record
    IDString: array[0..11] of AnsiChar;
    Stepping: Integer;
    Model: Integer;
    Family: Integer;
    FPU,
    VirtualModeExtensions,
    DebuggingExtensions,
    PageSizeExtensions,
    TimeStampCounter,
    K86ModelSpecificRegisters,
    MachineCheckException,
    CMPXCHG8B,
    APIC,
    MemoryTypeRangeRegisters,
    GlobalPagingExtension,
    ConditionalMoveInstruction,
    MMX: Boolean;
    SYSCALLandSYSRET,
    FPConditionalMoveInstruction,
    AMD3DNow: Boolean;
    CPUName: array[0..48] of AnsiChar; // 49 chars = 48 for name + #0.
    Dummy: array[0..1024] of Byte;     // For sure, may be it will prevent AVs.
  end;

  { ************************************************************************** }
  TLMDProcessorItem = class(TCollectionItem)
  private
    FMHz: LongInt;
    FIdentifier: string;
    FVendorIdentifier: string;
    procedure SetIdentifier(const Value: string);
    procedure SetMhz(const Value: LongInt);
    procedure SetVendorIdentifier(const Value: string);
  public
    property Identifier: string read FIdentifier write SetIdentifier stored false;
    property VendorIdentifier: string read FVendorIdentifier write SetVendorIdentifier stored false;
    property MHz: LongInt read FMHz write SetMhz;
  end;

  { ************************************************************************** }
  TLMDProcessorsInfo = class(TCollection)
  private
    FOwner: TLMDSysObject;
    FMhzDisplayString,
    FIdentDisplayString,
    FVendorDisplayString:String;
    function GetItem(Index: Integer): TLMDProcessorItem;
    procedure SetItem(Index: Integer; Value: TLMDProcessorItem);
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TLMDProcessorItem;
    constructor Create(aOwner: TLMDSysObject);
    destructor Destroy; override;

    procedure Refresh;
    property Items[Index: Integer]: TLMDProcessorItem read GetItem write SetItem; default;
  end;

  { ************************************************************************** }
  TLMDSysProcessorObject = class(TLMDSysObject)
  private
    FCount: Byte;
    FProcessorsInfo: TLMDProcessorsInfo;
    FInfo: TLMDSysCPUInfo;
    FDisplayInfo:TLMDSysProcessorDisplayInfos;
    FDisplayInfoDotNet:TLMDSysProcessorDisplayInfosDotNet;
    procedure SetProcessorUsage(const Value: Byte);
    procedure SetCount(const Value: Byte);

    function GetString(Index: Integer): string;
    function GetInteger(Index: Integer): Integer;
    function GetBoolean(Index: Integer): Boolean;

    function GetProcessorUsage:Byte;
    procedure SetDummyBool(Index: Integer; b: Boolean);
    procedure SetDummyString(Index: Integer; s: string);
    procedure SetDummyInt(Index: Integer; b: Integer);
    procedure SetDisplayInfo(const Value: TLMDSysProcessorDisplayInfos);
    protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    destructor Destroy; override;

    //    procedure GetValues(aText: TStrings); override;
    procedure Init;override;
    procedure Refresh; override;
    procedure Apply; override;

    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;

    property ProcessorUsage: Byte read GetProcessorUsage write SetProcessorUsage stored false;
    property ProcessorsInfo: TLMDProcessorsInfo read FProcessorsInfo;

  published
    property Count: Byte read FCount write SetCount stored false;

    property IDString: string index 0 read GetString write SetDummyString stored false;
    property CPUName: string index 1 read GetString write SetDummyString stored false;
    property Stepping: Integer index 0 read GetInteger write SetDummyInt stored false;
    property Model: Integer index 1 read GetInteger write SetDummyInt stored false;
    property Family: Integer index 2 read GetInteger write SetDummyInt stored false;
    property FPU: Boolean index 0 read GetBoolean write SetDummyBool stored false;
    property VirtualModeExtensions: Boolean index 1 read GetBoolean write SetDummyBool stored false;
    property DebuggingExtensions: Boolean index 2 read GetBoolean write SetDummyBool stored false;
    property PageSizeExtensions: Boolean index 3 read GetBoolean write SetDummyBool stored false;
    property TimeStampCounter: Boolean index 4 read GetBoolean write SetDummyBool stored false;
    property K86_ModelSpecificRegisters: Boolean index 5 read GetBoolean write SetDummyBool stored false;
    property MachineCheckException: Boolean index 6 read GetBoolean write SetDummyBool stored false;
    property CMP_XCHG_8B: Boolean index 7 read GetBoolean write SetDummyBool stored false;
    property APIC: Boolean index 8 read GetBoolean write SetDummyBool stored false;
    property MemoryTypeRangeRegisters: Boolean index 9 read GetBoolean write SetDummyBool stored false;
    property GlobalPaging: Boolean index 10 read GetBoolean write SetDummyBool stored false;
    property Cond_MOVE_Instruct: Boolean index 11 read GetBoolean write SetDummyBool stored false;
    property MMX: Boolean index 12 read GetBoolean write SetDummyBool stored false;
    property SYSCALLandSYSRET: Boolean index 13 read GetBoolean write SetDummyBool stored false;
    property FPCond_MOVE_Instruct: Boolean index 14 read GetBoolean write SetDummyBool stored false;
    property AMD3DNow: Boolean index 15 read GetBoolean write SetDummyBool stored false;
    property ExistCPUInfo: Boolean index 16 read GetBoolean write SetDummyBool stored false;
    // Allows programmer to select which information is shown
    property DisplayInfo: TLMDSysProcessorDisplayInfos read FDisplayInfo  write SetDisplayInfo default def_TLMDSysProcessorDisplayInfos;
    property DisplayInfoDotNet: TLMDSysProcessorDisplayInfosDotNet read FDisplayInfoDotNet  write FDisplayInfoDotNet stored false;
  end;

//check whether there is valid CPU info or not
function LMDSysExistCPUInfo: Boolean;

//get the info about the CPU
function LMDSysGetCPUInfo(var ainfo: TLMDSysCPUInfo): Boolean;

//fast info functions
function LMDSysExistMMX: Boolean;
function LMDSysExist3DNow: Boolean;

implementation

uses
  SysUtils, LMDSysIn;

// Important: In "register" calling convention the following registers
// should be preserved:
//   EBX, EDI, ESI, ESP, EBP.
// Look:
//   http://docwiki.embarcadero.com/RADStudio/Seattle/en/Using_Inline_Assembly_Code
//   http://docwiki.embarcadero.com/RADStudio/Seattle/en/Program_Control

{ ---------------------------------------------------------------------------- }
{$IFDEF LMDX64}
function LMDSysExistCPUInfo: Boolean;
asm
  .noframe
  pushfq
  pop rax
  mov ebx, eax
  xor eax, 00200000h
  push rax
  popfq
  pushfq
  pop rcx
  mov eax,0
  cmp ecx, ebx
  jz @NO_CPUID
  inc eax
@NO_CPUID:
end;
{$ELSE}
function LMDSysExistCPUInfo: Boolean;
asm
  push ebx // EB-2016
  pushfd
  pop eax
  mov ebx, eax
  xor eax, 00200000h
  push eax
  popfd
  pushfd
  pop ecx
  mov eax,0
  cmp ecx, ebx
  jz @NO_CPUID
  inc eax
@NO_CPUID:
  pop ebx // EB-2016
end;
{$ENDIF}


function ExistExtendedCPUIDFunctions: Boolean;
asm
  {$IFDEF LMDX64}
  .noframe
  {$ENDIF}
  mov eax,080000000h
  cpuid
end;

{$IFDEF LMDX64}
procedure FillCPUInfo(var info: TLMDSysCPUInfo);
asm
  .noframe
  jmp @Start

@BitLoop:
  mov al,dl
  and al,1
  mov [rdi],al
  shr edx,1
  inc rdi
  loop @BitLoop
  ret

@Start:
  push rdi
  mov rdi, rcx
  mov eax,0
  cpuid
  mov [rdi],ebx
  mov [rdi+4],edx
  mov [rdi+8],ecx
  mov eax,1
  cpuid
  mov ebx,eax
  and eax,0fh;
  mov [rdi+12],eax;
  shr ebx,4
  mov eax,ebx
  and eax,0fh
  mov [rdi+12+4],eax
  shr ebx,4
  mov eax,ebx
  and eax,0fh
  mov [rdi+12+8],eax
  add rdi,24
  mov ecx,6
  call @BitLoop
  shr edx,1
  mov ecx,3
  call @BitLoop
  shr edx,2
  mov ecx,2
  call @BitLoop
  shr edx,1
  mov ecx,1
  call @BitLoop
  shr edx,7
  mov ecx,1
  call @BitLoop
  pop rdi
end;
{$ELSE}
procedure FillCPUInfo(var info: TLMDSysCPUInfo);
asm
  jmp @Start

@BitLoop:
  mov al,dl
  and al,1
  mov [edi],al
  shr edx,1
  inc edi
  loop @BitLoop
  ret

@Start:
  push edi
  push ebx       // EB-2016

  mov edi, info  // info = eax
  mov eax,0
  cpuid
  mov [edi],ebx
  mov [edi+4],edx
  mov [edi+8],ecx
  mov eax,1
  cpuid
  mov ebx,eax
  and eax,0fh;
  mov [edi+12],eax;
  shr ebx,4
  mov eax,ebx
  and eax,0fh
  mov [edi+12+4],eax
  shr ebx,4
  mov eax,ebx
  and eax,0fh
  mov [edi+12+8],eax
  add edi,24
  mov ecx,6
  call @BitLoop
  shr edx,1
  mov ecx,3
  call @BitLoop
  shr edx,2
  mov ecx,2
  call @BitLoop
  shr edx,1
  mov ecx,1
  call @BitLoop
  shr edx,7
  mov ecx,1
  call @BitLoop

  pop ebx // EB-2016
  pop edi
end;
{$ENDIF}

{$IFDEF LMDX64}
procedure FillCPUName(var info: TLMDSysCPUInfo; name: PAnsiChar);
asm
  .noframe
  push rdi
  push rdx
  mov rdi,rcx
  mov eax,080000001h
  cpuid
  mov eax,edx
  shr eax,11
  and al,1
  mov [rdi + 12 + 12 + 12],al
  mov eax,edx
  shr eax,16
  and al,1
  mov [rdi + 12 + 12 + 13],al
  pop rdx
  lea rdi, [rdx]
  shr eax,31
  and al,1
  mov [rdi+2],al
  mov rdi, rdx
  mov eax,0
  mov [rdi],eax
  mov eax,080000000h
  cpuid
  cmp eax,080000004h
  jl @NoString
  mov eax,080000002h
  cpuid
  mov [rdi],eax
  mov [rdi+4],ebx
  mov [rdi+8],ecx
  mov [rdi+12],edx
  add rdi,16
  mov eax,080000003h
  cpuid
  mov [rdi],eax
  mov [rdi+4],ebx
  mov [rdi+8],ecx
  mov [rdi+12],edx
  add rdi,16
  mov eax,080000004h
  cpuid
  mov [rdi],eax
  mov [rdi+4],ebx
  mov [rdi+8],ecx
  mov [rdi+12],edx
@NoString:
  pop rdi
end;
{$ELSE}
procedure FillCPUName(var info: TLMDSysCPUInfo; name: PAnsiChar);
asm
  push edi
  push ebx // EB-2016

  lea edi,info.TLMDSysCPUInfo.SYSCALLandSYSRET // info = EAX
  push name // name = EDX
  mov eax,080000001h
  cpuid
  mov eax,edx
  shr eax,11
  and al,1
  mov [edi],al
  mov eax,edx
  shr eax,16
  and al,1
  mov [edi+1],al
  mov eax,edx
  shr eax,31
  and al,1
  mov [edi+2],al
  pop edi // name
  mov eax,0
  mov [edi],eax
  mov eax,080000000h
  cpuid
  cmp eax,080000004h
  jl @NoString
  mov eax,080000002h
  cpuid
  mov [edi],eax
  mov [edi+4],ebx
  mov [edi+8],ecx
  mov [edi+12],edx
  add edi,16
  mov eax,080000003h
  cpuid
  mov [edi],eax
  mov [edi+4],ebx
  mov [edi+8],ecx
  mov [edi+12],edx
  add edi,16
  mov eax,080000004h
  cpuid
  mov [edi],eax
  mov [edi+4],ebx
  mov [edi+8],ecx
  mov [edi+12],edx
@NoString:

  pop ebx // EB-2016
  pop edi
end;
{$ENDIF}

procedure NoExtendedInfo(var info: TLMDSysCPUInfo);
begin
  with info do
  begin
    SYSCALLandSYSRET:= false;
    FPConditionalMoveInstruction:= false;
    AMD3DNow:= false;
    CPUName:= '';
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDSysGetCPUInfo(var ainfo: TLMDSysCPUInfo): Boolean;
begin
  Result := LMDSysExistCPUInfo;

  if Result then
    FillCPUInfo(ainfo);

  if Result and ExistExtendedCPUIDFunctions then
  begin
    FillChar(ainfo.CPUName, SizeOf(ainfo.CPUName), 0);
    FillCPUName(ainfo, @ainfo.CPUName);
  end
  else
    NoExtendedInfo(ainfo); // String handling, which required temp string
                           // variables to be initialized/uninitialized
                           // has been moved to this function.
end;

{ ---------------------------------------------------------------------------- }
function LMDSysExistMMX: Boolean;
var
  info: TLMDSysCPUInfo;
begin
  if LMDSysGetCPUInfo(info) then
    Result:= info.MMX
  else
    Result:= false;
end;

{ ---------------------------------------------------------------------------- }
function LMDSysExist3DNow: Boolean;
var
  info: TLMDSysCPUInfo;
begin
  if LMDSysGetCPUInfo(info) then
    Result:= info.AMD3DNow
  else
    Result:= false;
end;

const
  SystemBasicInformation = 0;
  SystemPerformanceInformation = 2;
  SystemTimeInformation = 3;

type
  TSYSTEM_BASIC_INFORMATION = record
    dwUnknown1: DWORD;
    uKeMaximumIncrement: ULONG;
    uPageSize: ULONG;
    uMmNumberOfPhysicalPages: ULONG;
    uMmLowestPhysicalPage: ULONG;
    uMmHighestPhysicalPage: ULONG;
    uAllocationGranularity: ULONG;
    pLowestUserAddress: Pointer;
    pMmHighestUserAddress: Pointer;
    uKeActiveProcessors: ULONG;
    bKeNumberProcessors: Byte;
    bUnknown2: Byte;
    wUnknown3: WORD;
  end;

  TSYSTEM_PERFORMANCE_INFORMATION = record
    liIdleTime: LARGE_INTEGER;
    dwSpare: array[0..75] of DWORD;
  end;

  TSYSTEM_TIME_INFORMATION = record
    liKeBootTime: LARGE_INTEGER;
    liKeSystemTime: LARGE_INTEGER;
    liExpTimeZoneBias: LARGE_INTEGER;
    uCurrentTimeZoneId: ULONG;
    dwReserved: DWORD;
  end;

type
  PROCNTQSI = function(
    aSystemInformationClass: UINT;      // information type
    var SystemInformation{: Pointer};    // pointer to buffer
    SystemInformationLength: ULONG;     // buffer size in bytes
    var ReturnLength: ULONG): LongInt;  // pointer to a 32-bit
  stdcall;                              // variable that receives
  // the number of bytes
  // written to the buffer

var
  NtQuerySystemInformation: PROCNTQSI;

{------------------------------------------------------------------------------}
function TLMDSysProcessorObject.GetProcessorUsage: Byte;
var
  hkey: Windows.hkey;
  dwDataSize: DWORD;
  dwType: DWORD;
  dwCpuUsage: DWORD;

  SysPerfInfo: TSYSTEM_PERFORMANCE_INFORMATION;
  SysTimeInfo: TSYSTEM_TIME_INFORMATION;
  SysBaseInfo: TSYSTEM_BASIC_INFORMATION;
  dbIdleTime: double;
  dbSystemTime: double;
  status: LongInt;
  liOldIdleTime: LARGE_INTEGER;         //= {0,0};
  liOldSystemTime: LARGE_INTEGER;       // = {0,0};
  ReturnLength: ULONG;
  I: LongInt;
begin
  if LMDSIWindowsNT then
  begin
    result:= Byte(-1);
    liOldIdleTime.QuadPart:= 0;
    liOldSystemTime.QuadPart:= 0;

    if not Assigned(NtQuerySystemInformation) then Exit;

    // get number of processors in the system
    status:= NtQuerySystemInformation(SystemBasicInformation,
      SysBaseInfo, SizeOf(SysBaseInfo), ReturnLength);
    if status <> NO_ERROR then Exit;

    FCount:= SysBaseInfo.bKeNumberProcessors;

    for I:= 0 to 1 do
    begin
      // get new system time
      status:= NtQuerySystemInformation(SystemTimeInformation, SysTimeInfo,
                                        SizeOf(SysTimeInfo), ReturnLength);
      if status <> NO_ERROR then
        Exit;

      // get new CPU's idle time
      status:= NtQuerySystemInformation(SystemPerformanceInformation, SysPerfInfo,
                                        SizeOf(SysPerfInfo), ReturnLength);
      if status <> NO_ERROR then
        Exit;

      // if it's a first call - skip it
      if liOldIdleTime.QuadPart <> 0 then
      begin
        // CurrentValue = NewValue - OldValue
        dbIdleTime:= SysPerfInfo.liIdleTime.QuadPart - liOldIdleTime.QuadPart;
        dbSystemTime:= SysTimeInfo.liKeSystemTime.QuadPart - liOldSystemTime.QuadPart;

        // CurrentCpuIdle = IdleTime / SystemTime
        dbIdleTime:= dbIdleTime / dbSystemTime;

        // CurrentCpuUsage% = 100 - (CurrentCpuIdle * 100) / NumberOfProcessors
        dbIdleTime:= 100.0 - dbIdleTime * 100.0 / SysBaseInfo.bKeNumberProcessors + 0.5;

        result:= Round(dbIdleTime);
      end;

      // store new CPU's idle and system time
      liOldIdleTime:= SysPerfInfo.liIdleTime;
      liOldSystemTime:= SysTimeInfo.liKeSystemTime;

      Sleep(500);
    end;
  end
  else
  begin
    result:= Byte(-1);
    FCount:= 1;
    { TODO :
         How determine number of processor on W9x system?
         I Think it impossible.... }
    // starting the counter
    if RegOpenKeyEx(HKEY_DYN_DATA, 'PerfStats\StartStat',
                    0, KEY_ALL_ACCESS, hkey) <> ERROR_SUCCESS then
      Exit;

    dwDataSize:= SizeOf(DWORD);
    RegQueryValueEx(hkey, 'KERNEL\CPUUsage', nil, @dwType,
                    @dwCpuUsage, @dwDataSize);
    RegCloseKey(hkey);

    // geting current counter's value
    if RegOpenKeyEx(HKEY_DYN_DATA, 'PerfStats\StatData',
                    0, KEY_READ, hkey) <> ERROR_SUCCESS then
      Exit;

    dwDataSize:= SizeOf(DWORD);
    RegQueryValueEx(hkey, 'KERNEL\CPUUsage', nil, @dwType,
                    @dwCpuUsage, @dwDataSize);
    result:= dwCpuUsage;
    RegCloseKey(hkey);

    // stoping the counter
    if RegOpenKeyEx(HKEY_DYN_DATA, 'PerfStats\StopStat', 0, KEY_ALL_ACCESS,
                    hkey) <> ERROR_SUCCESS then
      Exit;

    dwDataSize:= SizeOf(DWORD);
    RegQueryValueEx(hkey, 'KERNEL\CPUUsage', nil, @dwType,
                    @dwCpuUsage, @dwDataSize);
    RegCloseKey(hkey);
  end;
end;

{ -------------------------- private ----------------------------------------- }
function TLMDSysProcessorObject.GetString(Index: Integer): string;
begin
  case Index of
    0: Result := string(FInfo.IDString);
    1: Result := string(FInfo.CPUName);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysProcessorObject.GetInteger(Index: Integer): Integer;
begin
  case Index of
    0: Result:= FInfo.Stepping;
    1: Result:= FInfo.Model;
    2: Result:= FInfo.Family;
  else
    Result:= 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysProcessorObject.GetBoolean(Index: Integer): Boolean;
begin
  case Index of
    0:  Result:= FInfo.FPU;
    1:  Result:= FInfo.VirtualModeExtensions;
    2:  Result:= FInfo.DebuggingExtensions;
    3:  Result:= FInfo.PageSizeExtensions;
    4:  Result:= FInfo.TimeStampCounter;
    5:  Result:= FInfo.K86ModelSpecificRegisters;
    6:  Result:= FInfo.MachineCheckException;
    7:  Result:= FInfo.CMPXCHG8B;
    8:  Result:= FInfo.APIC;
    9:  Result:= FInfo.MemoryTypeRangeRegisters;
    10: Result:= FInfo.GlobalPagingExtension;
    11: Result:= FInfo.ConditionalMoveInstruction;
    12: Result:= FInfo.MMX;
    13: Result:= FInfo.SYSCALLandSYSRET;
    14: Result:= FInfo.FPConditionalMoveInstruction;
    15: Result:= FInfo.AMD3DNow;
    16: Result:= LMDSysExistCPUInfo;
  else
    Result := False;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysProcessorObject.SetDummyBool(Index: Integer; b: Boolean);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysProcessorObject.SetDummyString(Index: Integer; s: string);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysProcessorObject.SetDummyInt(Index, b: Integer);
begin
end;

{------------------------------------------------------------------------------}

procedure TLMDSysProcessorObject.SetDisplayInfo(
  const Value: TLMDSysProcessorDisplayInfos);
begin
  if FDisplayInfo<>Value then
  begin
    FDisplayInfo := Value;
    RegisterProperties;
  end;
end;

{ -------------------------- protected --------------------------------------- }
procedure TLMDSysProcessorObject.RegisterProperties;
var
  i: TLMDSysProcessorDisplayInfo;
begin
  FPropertiesDesc.Clear;
  for i:=Low(TLMDSysProcessorDisplayInfo) to High(TLMDSysProcessorDisplayInfo) do
    if i in FDisplayInfo then
  FPropertiesDesc.Add(Ord(i), LMDSysProcessorProps[i].Name,
                      LMDSysProcessorProps[i].Description);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysProcessorObject.Apply;
begin
end;

{ -------------------------- public ------------------------------------------ }
//procedure TLMDSysProcessorObject.GetValues(aText: TStrings);
//begin
//end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysProcessorObject.Refresh;
var
  i: TLMDSysProcessorDisplayInfo;
begin
  DoProgress(sLMDSysProcessorObjectsTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;

  if not FInit then
    Init;

  for i:=Low(TLMDSysProcessorDisplayInfo) to High(TLMDSysProcessorDisplayInfo) do
    if i in FDisplayInfo then
    begin
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
          cpiCPUName: Text:=String(FInfo.CPUName);
          cpiIDString: Text:=String(FInfo.IDString);
          cpiMHz: Text:=FProcessorsInfo.FMhzDisplayString;
          cpiCount:Text:=Inttostr(FCount);
          cpiIdentifier: Text:=FProcessorsInfo.FIdentDisplayString;
          cpiVendorIdentifier: Text:=FProcessorsInfo.FVendorDisplayString;
          cpiMMX: Text:= BoolToStr(FInfo.MMX);
          cpiAMD3DNow: Text:=BoolToStr(FInfo.AMD3DNow);
          cpiProcessorUsage: Text:= IntToStr(GetProcessorUsage);
          cpiFamily: Text:=IntToStr(FInfo.Family);
          cpiStepping: Text:=IntToStr(FInfo.Stepping);
          cpiModel: Text:= IntToStr(FInfo.Model);
          cpiFPU: Text:=BoolToStr(FInfo.FPU);
          cpiVirtualModeExtensions: Text:=BoolToStr(FInfo.VirtualModeExtensions);
          cpiDebuggingExtensions: Text:=BoolToStr(FInfo.DebuggingExtensions);
          cpiPageSizeExtensions: Text:=BoolToStr(FInfo.PageSizeExtensions);
          cpiTimeStampCounter: Text:=BoolToStr(FInfo.TimeStampCounter);
          cpiK86_ModelSpecificRegisters: Text:= BoolToStr(FInfo.K86ModelSpecificRegisters);
          cpiMachineCheckException: Text:= BoolToStr(FInfo.MachineCheckException);
          cpiCMP_XCHG_8B: Text:=BoolToStr(FInfo.CMPXCHG8B);
          cpiAPIC: Text:=BoolToStr(FInfo.APIC);
          cpiMemoryTypeRangeRegisters: Text:= BoolToStr(FInfo.MemoryTypeRangeRegisters);
          cpiGlobalPaging: Text:=BoolToStr(FInfo.GlobalPagingExtension);
          cpiCond_MOVE_Instruct: Text:= BoolToStr(FInfo.ConditionalMoveInstruction);
          cpiSYSCALLandSYSRET: Text:=  BoolToStr(FInfo.SYSCALLandSYSRET);
          cpiFPCond_MOVE_Instruct: Text:=BoolToStr(FInfo.FPConditionalMoveInstruction);
        end;
    end;

  DoProgress(sLMDSysProcessorObjectsTitle, 100, 100);
  DoProgress('', 100, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDSysProcessorObject.Init;
var
  SysBaseInfo: TSYSTEM_BASIC_INFORMATION;
  status: LongInt;
  ReturnLength: ULONG;
begin
  inherited Init;
  LMDSysGetCPUInfo(FInfo);
  FProcessorsInfo.Refresh;
  if LMDSIWindowsNT then
  begin
    FCount:=1;
    if not Assigned(NtQuerySystemInformation) then exit;
    // get number of processors in the system
    status:= NtQuerySystemInformation(SystemBasicInformation,
             SysBaseInfo, SizeOf(SysBaseInfo), ReturnLength);
    if status <> NO_ERROR then Exit;
    FCount:= SysBaseInfo.bKeNumberProcessors;
  end
  else
    FCount:=1;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysProcessorObject.SetProcessorUsage(const Value: Byte);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysProcessorObject.SetCount(const Value: Byte);
begin
end;

{ TLMDProcessorItem }
{ ---------------------------------------------------------------------------- }
procedure TLMDProcessorItem.SetIdentifier(const Value: string);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDProcessorItem.SetMhz(const Value: LongInt);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDProcessorItem.SetVendorIdentifier(const Value: string);
begin
end;

{ TLMDProcessorsInfo }
{ ---------------------------------------------------------------------------- }
function TLMDProcessorsInfo.Add: TLMDProcessorItem;
begin
  Result:= TLMDProcessorItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDProcessorsInfo.Create(aOwner: TLMDSysObject);
begin
  inherited Create(TLMDProcessorItem);
  FOwner:= aOwner;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDProcessorsInfo.Destroy;
begin
  FOwner:= nil;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDProcessorsInfo.GetItem(Index: Integer): TLMDProcessorItem;
begin
  Result:= TLMDProcessorItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
function TLMDProcessorsInfo.GetOwner: TPersistent;
begin
  if FOwner <> nil then
    Result:= (FOwner as TLMDSysObject).Owner
  else
    Result:= nil;
  //  Result:= FOwner;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDProcessorsInfo.Refresh;
var
  I: LongInt;
begin
  FIdentDisplayString:='';
  FVendorDisplayString:='';
  FMhzDisplayString:='';
  Clear;

  with FOwner do
  begin
    OpenRegistry(true);
    SetRegistryRootKey(HKEY_LOCAL_MACHINE);

    //  OpenRegistrySubKey( 'HARDWARE\DESCRIPTION\System\CentralProcessor');
    I:= 0;
    while Registry.KeyExists('HARDWARE\DESCRIPTION\System\CentralProcessor\' + IntToStr(I)) do
      begin
        OpenRegistrySubKey('HARDWARE\DESCRIPTION\System\CentralProcessor\' + IntToStr(I));
        with Add do
        begin
          FIdentifier:= Registry.ReadString('Identifier');
          FVendorIdentifier:= Registry.ReadString('VendorIdentifier');
          if Registry.ValueExists('~MHz') then //does not exist in win98 registry
            FMHz := Registry.ReadInteger('~MHz')
          else
            FMHz := -1; //invalid MHZ value!

          // build up Displaystrings
          if i > 0 then
          begin
            FIdentDisplayString:=FIdentDisplayString+' \ ';
            FVendorDisplayString:=FVendorDisplayString+' \';
            FMhzDisplayString:=FMhzDisplayString+' \ ';
          end;
          FIdentDisplayString:=FIdentDisplayString+FIdentifier;
          FVendorDisplayString:=FVendorDisplayString+FVendorIdentifier;
          FMhzDisplayString:=FMhzDisplayString+inttostr(FMhz);
          Inc(I);
        end;
        CloseRegistrySubKey;
      end;
    CloseRegistry;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDProcessorsInfo.SetItem(Index: Integer; Value: TLMDProcessorItem);
begin
  inherited SetItem(Index, Value);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSysProcessorObject.Create;
begin
  FDisplayInfo:=def_TLMDSysProcessorDisplayInfos;
  FDisplayInfoDotNet := def_TLMDSysProcessorDisplayInfosDotNet;
  inherited;
  FProcessorsInfo:= TLMDProcessorsInfo.Create(Self);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSysProcessorObject.Destroy;
begin
  FProcessorsInfo.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysProcessorObject.GetElementTitle : string;
begin
  result := sLMDSysProcessorObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysProcessorObject.GetElementDescription : string;
begin
  result := sLMDSysProcessorObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysProcessorObject.GetElementType : TLMDSysInfoType;
begin
  result := itProcessor;
end;

initialization
  if LMDSIWindowsNT then
    NtQuerySystemInformation := GetProcAddress(GetModuleHandle('ntdll'),
                                               'NtQuerySystemInformation');

end.

