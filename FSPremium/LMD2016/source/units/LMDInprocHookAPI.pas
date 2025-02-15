unit LMDInprocHookAPI;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
� by LMD Innovative
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

LMDInprocHookAPI unit ()
--------------------------

ToDo
----

Changes
-------
Release 8.0 (Mart 2007)
 - Initial Release

###############################################################################}

{$B-}

interface

{$ifdef LMDX86}
uses
 TlHelp32, Windows, SysUtils, LMDTypes, LMDSysIn;

type
  {$EXTERNALSYM PPPointer}
  PPPointer = ^PPointer;

  PJumpInstruction = ^TJumpInstruction;
  TJumpInstruction = packed record
    case byte of
      1:(
        Code   :Byte;  // jump instruction ($FF)
        Offset :DWORD; // jump offset
      );
      2:(
        DW1: DWORD;
        DW2: DWORD;
      );
  end;

// Calculation of a native address when importing of functions from packages and dll.
// (returns address found in table of import 0r current address if fucntion is not imported)
function GetNativeAddr( Ptr: Pointer ):Pointer;
// insert jump to the code of interceptor
function JumpFromCode( MSrc, MDest: Pointer; SaveJump: PJumpInstruction ): Boolean;
// restore intercepted code
function RestoreSavedCode( MSrc: Pointer; var SaveJump: TJumpInstruction ): Boolean;

function IsJumpFromCode( MSrc, MDest: Pointer ): Boolean;

// winnt.h

type
  {$EXTERNALSYM PImageImportByName}
  PImageImportByName    = ^TImageImportByName;
  {$EXTERNALSYM _IMAGE_IMPORT_BY_NAME}
  _IMAGE_IMPORT_BY_NAME = packed record
    Hint  :WORD;
    Name  :BYTE;
  end;
  {$EXTERNALSYM IMAGE_IMPORT_BY_NAME}
  IMAGE_IMPORT_BY_NAME  = _IMAGE_IMPORT_BY_NAME;
  {$EXTERNALSYM PIMAGE_IMPORT_BY_NAME}
  PIMAGE_IMPORT_BY_NAME = ^IMAGE_IMPORT_BY_NAME;
  {$EXTERNALSYM TImageImportByName}
  TImageImportByName    = _IMAGE_IMPORT_BY_NAME;

  PImageThunkData   = ^TImageThunkData;
  {.$EXTERNALSYM IMAGE_THUNK_DATA}
  _IMAGE_THUNK_DATA = packed record
     case byte of
       0: (ForwarderString  :PBYTE);
       1: (FFunction        :PDWORD);
       2: (Ordinal          :DWORD);
       3: (AddressOfData    :PIMAGE_IMPORT_BY_NAME)
  end;
  {.$EXTERNALSYM IMAGE_THUNK_DATA}
  IMAGE_THUNK_DATA  = _IMAGE_THUNK_DATA;
  {.$EXTERNALSYM IMAGE_THUNK_DATA}
  PIMAGE_THUNK_DATA = ^IMAGE_THUNK_DATA;
  {.$EXTERNALSYM TImageThunkData}
  TImageThunkData   = _IMAGE_THUNK_DATA;
  {.$EXTERNALSYM PImageImportDescriptor}
  {.$ENDIF}
  PImageImportDescriptor   = ^TImageImportDescriptor;
  {.$EXTERNALSYM _IMAGE_IMPORT_DESCRIPTOR}
  _IMAGE_IMPORT_DESCRIPTOR = packed record
    OriginalFirstThunk  :PIMAGE_THUNK_DATA; // = DWORD
    TimeDateStamp       :DWORD;
    ForwarderChain      :DWORD;
    Name                :DWORD;
    FirstThunk          :PIMAGE_THUNK_DATA;
  end;
  {$EXTERNALSYM IMAGE_IMPORT_DESCRIPTOR}
  IMAGE_IMPORT_DESCRIPTOR  = _IMAGE_IMPORT_DESCRIPTOR;
  {$EXTERNALSYM PIMAGE_IMPORT_DESCRIPTOR}
  PIMAGE_IMPORT_DESCRIPTOR = ^IMAGE_IMPORT_DESCRIPTOR;
  {.$EXTERNALSYM TImageImportDescriptor}
  TImageImportDescriptor   = _IMAGE_IMPORT_DESCRIPTOR;

function GetModuleFromAddress( AAddr: Pointer ): HMODULE;
function GetModuleNtHeaders( Module: THandle ): PImageNTHeaders;
function GetModuleExportDirectory( Module: THandle ): PImageExportDirectory;
function GetModuleImportDirectory( Module: THandle ): PImageImportDescriptor;
function SetProcAddressETA( Module: THandle; const ProcName: String; NewAddr: Pointer ): Boolean;
function GetProcAddressETAOrd( Module: THandle; AOrd: DWORD ): Pointer;
function GetProcAddressETA( Module: THandle; const ProcName: String ): Pointer;
function UnprotectMemory( AAddr: Pointer; MemSize: DWORD; MemProtection: DWORD ): Boolean;
// Patch of import table for chosen module.
function HookImportTableApiFunction( hFromModule: hModule; const FunctionModule,
                                     FunctionName: String; NewProc: Pointer): Pointer;

const
 // HookApi_GetCodeTemplateInfo
  ci_code_ptr  = 1;
  ci_code_size = 2;
  ci_code_data_offset = 3;

procedure HookApi_GetCodeTemplateInfo(
  pTemplate: Pointer; DataAllocSize: DWORD;
  var pCode: Pointer; var DataOffset, CodeSize: DWORD );
function HookApi_GetBuffer( BuffSize: DWORD; const sBuffID: String;
  var hSharedMem: THandle;var bFirstAllocate: Boolean ): Pointer;
function HookApi_CreateCodeTemplate( pCodeTemplate: Pointer; DataAllocSize: DWORD;
  const sCodeID: String; var hSharedMem: THandle; var bFirstAllocate: Boolean;
  var CodeData: Pointer; var CodeSize: DWORD ): Pointer;
function HookApi_LockCodeTemplate( var hSharedMem: THandle; bFirstAllocate: Boolean ): Boolean;

function BeginLock( const LockName: String; var hLock: THandle ): Boolean;
procedure EndLock( var hLock: THandle );

function IsBadWritePtrSize( Ptr: Pointer; Size: DWORD): Boolean;
function IsBadWritePtrPtr( Ptr: Pointer ): Boolean;
function IsBadReadPtrSize( Ptr: Pointer; Size: DWORD): Boolean;
function IsBadReadPtrPtr( Ptr: Pointer ): Boolean;
{$endif}

implementation

{$ifdef LMDX86}
{ InProcess Hook Hack API }

function MakePtr( AAddr: Pointer; Shift: Integer ): Pointer;
begin
  Result := Pointer( TLMDPtrInt(AAddr)+Shift );
end;

function IsBadWritePtrSize( Ptr: Pointer; Size: DWORD): Boolean;
var
  mbi: TMemoryBasicInformation;
const
  PAGE_WRITABLE = PAGE_EXECUTE_WRITECOPY or PAGE_EXECUTE_READWRITE or
                  PAGE_READWRITE or PAGE_WRITECOPY;
begin
  Result := VirtualQuery(Ptr, mbi, SizeOf(mbi)) <> 0;
  if Result then
  begin
    Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_WRITABLE)= 0);
    if Result then
      exit;
    if Ptr<>mbi.BaseAddress then
      Inc(Size, DWORD(Ptr) - DWORD(mbi.BaseAddress) );
    if (Size<= mbi.RegionSize) then
      exit;
    while True do // search bad write block
    begin
      Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_WRITABLE)= 0);
      if Result or (Size<= mbi.RegionSize) then
        break;
      Dec(Size, mbi.RegionSize);
      // Seek Ptr to next region:
      Ptr := Pointer(TLMDPtrInt(mbi.BaseAddress) + TLMDPtrInt(mbi.RegionSize) + 1);
      if VirtualQuery(Ptr, mbi, SizeOf(mbi)) = 0 then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function IsBadWritePtrPtr( Ptr: Pointer ): Boolean;
begin
 Result := IsBadWritePtrSize( Ptr, SizeOf(Pointer));
end;

function IsBadReadPtrSize( Ptr: Pointer; Size: DWORD): Boolean;
var
  mbi: TMemoryBasicInformation;
const
  PAGE_READABLE = PAGE_READONLY or PAGE_EXECUTE_READWRITE or
                  PAGE_READWRITE or PAGE_EXECUTE_READ;
begin
  Result := VirtualQuery(Ptr, mbi, SizeOf(mbi)) <> 0;
  if Result then
  begin
    Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_READABLE) = 0);
    if Result then
      exit;
    if Ptr<>mbi.BaseAddress then
      Inc(Size, DWORD(Ptr) - DWORD(mbi.BaseAddress) );
    if (Size<= mbi.RegionSize) then
      exit;
    while True do // search bad read block
    begin
      Result := (mbi.Protect = PAGE_NOACCESS) or ((mbi.Protect and PAGE_READABLE) = 0);
      if Result or (Size<= mbi.RegionSize) then
        break;
      Dec(Size, mbi.RegionSize);
      // Seek Ptr to next region:
      Ptr := Pointer(DWORD(mbi.BaseAddress) + mbi.RegionSize + 1);
      if VirtualQuery(Ptr, mbi, SizeOf(mbi)) = 0 then
      begin
        Result := True;
        break;
      end;
    end;
  end;
end;

function IsBadReadPtrPtr( Ptr: Pointer): Boolean;
begin
 Result := IsBadReadPtrSize(Ptr, SizeOf(Pointer));
end;

function GetModuleFromAddress( AAddr: Pointer ): HMODULE;
  var
    mbi: TMemoryBasicInformation;
begin
   if (VirtualQuery(AAddr, mbi, SizeOf(mbi)) <> 0) then
     Result := DWORD(mbi.AllocationBase)
   else
     Result := 0;
end;

function GetModuleNtHeaders( Module: THandle ): PImageNTHeaders;
var
  pDosHeader: PImageDosHeader absolute Module;
  pNTHeader: PImageNTHeaders;
begin
  Result := nil;
  if (Module=0) then
    exit;
  try
    if IsBadReadPtrSize( pDosHeader, SizeOf(TImageDosHeader) ) or
       (pDosHeader.e_magic <> IMAGE_DOS_SIGNATURE ) then
      exit;
    Pointer(pNTHeader) := MakePtr(pDosHeader, pDosHeader._lfanew);
    if IsBadReadPtrSize( pNTHeader, SizeOf(TImageNTHeaders) ) or
       (pNTHeader.Signature <> IMAGE_NT_SIGNATURE) then
       exit;
    Result := pNTHeader;
  except
  end;
end;

function GetModuleExportDirectory( Module: THandle ): PImageExportDirectory;
var
  pNTHeader: PImageNTHeaders;
begin
  Result:=nil;
  if (Module=0) then
    exit;
  try
    pNTHeader := GetModuleNtHeaders(Module);
    if (pNTHeader = nil) or
       (pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress = 0 )
    then
      exit;
    Pointer(Result) :=
      MakePtr( Pointer(Module),
       pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXPORT].VirtualAddress );
  except
  end;
end;

function GetModuleImportDirectory( Module: THandle ): PImageImportDescriptor;
var
  pNTHeader: PImageNTHeaders;
begin
  Result:=nil;
  if (Module=0) then
    exit;
  try
    pNTHeader := GetModuleNtHeaders(Module);
    if (pNTHeader = nil) or
       (pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress = 0 )
    then
      exit;
    Pointer(Result) :=
      MakePtr( Pointer(Module),
       pNTHeader.OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT].VirtualAddress );
  except
  end;
end;

{$R-} // !!!
type
  TArrayOfDWord = array [0..0] of DWORD;
  PArrayOfDWord = ^TArrayOfDWord;
  TArrayOfWord = array [0..0] of WORD;
  PArrayOfWord = ^TArrayOfWord;

function GetProcAddressETAOrd( Module: THandle; AOrd: DWORD ): Pointer;
var
  ETA : PImageExportDirectory;
begin
  dec(AOrd);
  Result:=nil;
  try
    ETA:=GetModuleExportDirectory(Module);
    if (ETA<>nil)and(AOrd<ETA.NumberOfFunctions) then
      Result:=Pointer(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfFunctions))^[AOrd]);
  except
  end;
end;

function UnprotectMemoryWin9X( AAddr: Pointer; MemSize: DWORD ): Boolean;
var
  IntAddr: DWORD absolute AAddr;
  FirstPage: DWORD;
  PageCount: DWORD;
  VxDCall0 : Pointer;
const
 // PageCommit Flags:
  PC_WRITEABLE = $00020000;  // make the pages writeable
  PC_USER      = $00040000;  // make the pages ring 3 accessible
  PC_STATIC    = $20000000;  // allow commit in PR_STATIC object
  {CH PC_FIXED     = $00000008; }  // pages are permanently locked
  {CH PC_LOCKED    = $00000080; }  // pages are made present and locked
 // Page Permisions Flags:
  c_PageModifyPermissions = $1000D;
begin
  Result := False;
  if (MemSize=0)or(AAddr=nil) then
    exit;
  FirstPage:=IntAddr div 4096;
  PageCount := (IntAddr+MemSize-FirstPage*4096+4095) div 4096;
  dec(IntAddr, IntAddr mod 4096 );
  MemSize := PageCount*4096;
  if  not IsBadWritePtrSize(AAddr, MemSize) then
    Result := True
  else
  try
    VxDCall0:=GetProcAddressETAOrd(GetModuleHandle(kernel32), 1);
    if @VxDCall0=nil then
      exit;
    asm
      push    PC_WRITEABLE or PC_USER or PC_STATIC
      push    $0FFFFFFFF
      push    PageCount
      push    dword ptr [FirstPage]
      push    c_PageModifyPermissions
      call    dword ptr [VxDCall0]
    end;
    Result := not IsBadWritePtrSize(AAddr, MemSize);
  except
  end;
end;

function IsExecutePage( AAddr: Pointer ): Boolean;
var
  mbi: TMemoryBasicInformation;
const
  PAGE_EXECUTABLE = PAGE_EXECUTE_READWRITE or PAGE_EXECUTE_READ or
    PAGE_EXECUTE or PAGE_EXECUTE_WRITECOPY;
begin
 Result := Assigned(AAddr) and ( VirtualQuery(AAddr, mbi, SizeOf(mbi)) <> 0 );
 if Result then
   Result := (mbi.Protect and PAGE_EXECUTABLE) <> 0;
end;

function UnprotectMemory( AAddr: Pointer; MemSize: DWORD; MemProtection: DWORD ): Boolean;
var
  SaveFlag: DWORD;
begin
  if (Win32Platform = VER_PLATFORM_WIN32_NT) then
  begin
    if (MemSize=0)or(AAddr=nil) then
    begin
      Result := False;
      exit;
    end;
    Result := IsBadWritePtrSize(AAddr, MemSize);
    if Result then
    begin
      if MemProtection <>0 then
        Result := VirtualProtect( AAddr,  MemSize, MemProtection, @SaveFlag )
      else
      if IsExecutePage(AAddr) then
        Result := VirtualProtect( AAddr,  MemSize, PAGE_EXECUTE_READWRITE, @SaveFlag )
      else
        Result := VirtualProtect( AAddr,  MemSize, PAGE_READWRITE, @SaveFlag );
    end;
    if not Result then
      Result := not IsBadWritePtrSize(AAddr, MemSize);
  end
  else
    Result := UnprotectMemoryWin9X(AAddr, MemSize);
end;

function SetProcAddressETA( Module: THandle; const ProcName: String; NewAddr: Pointer ): Boolean;
var
  ETA: PImageExportDirectory;
  i: integer;
  pAddr: PInteger;
begin
  Result := False;
  if (Module=0) or (ProcName='') or (NewAddr=nil) or
     (GetProcAddressETA(Module, ProcName) = NewAddr) then
    exit;
  try
    ETA:=GetModuleExportDirectory(module);
    if ETA<>nil then
      for i:=0 to ETA.NumberOfNames-1 do
        if CompareText(PChar(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfNames))^[i]), ProcName)=0 then
        begin
          pAddr := @(PArrayOfDWord(Module+DWORD(ETA.AddressOfFunctions))^[
            PArrayOfWord(Module+DWORD(ETA.AddressOfNameOrdinals))^[i]]);

          if not UnprotectMemory(pAddr,  SizeOf(DWORD), PAGE_EXECUTE_READWRITE) then
            exit;

          TLMDPtrInt(Module) := TLMDPtrInt(NewAddr)-TLMDPtrInt(Module);

          asm // pAddr^ := Integer(Module);
            mov     eax, pAddr
            mov     edx, Module
            xchg    [eax], edx
          end;

          Result:=True;
          break;
        end;
  except
  end;
end;

function GetProcAddressETA( Module: THandle; const ProcName: String ): Pointer;
var
  ETA: PImageExportDirectory;
  i: integer;
begin
  Result := nil;
  if (Module=0) or (ProcName='') then
    exit;
  try
    ETA:=GetModuleExportDirectory(Module);
    if ETA<>nil then
      for i:=0 to ETA.NumberOfNames-1 do
        if CompareText(
            PChar(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfNames))^[i]),
            ProcName
           )=0 then
        begin
          Result := Pointer(Module+PArrayOfDWord(Module+DWORD(ETA.AddressOfFunctions))^[
            PArrayOfWord(Module+DWORD(ETA.AddressOfNameOrdinals))^[i]]);
          break;
        end;
  except
  end;
  if (Result=nil) and (Win32Platform = VER_PLATFORM_WIN32_NT) then
    Result := Windows.GetProcAddress(Module, PChar(ProcName));
end;

function HookImportTableApiFunction( hFromModule: hModule; const FunctionModule,
                                     FunctionName: String; NewProc: Pointer): Pointer;
 var
  pDosHeader        :PImageDosHeader absolute hFromModule;
  pfnOriginalProc   :Pointer;
  pImportDesc       :PImageImportDescriptor;
  pThunk            :PImageThunkData;
  pszModName        :PChar;
const
  cPushOpCode: byte = $68;   // The PUSH opcode on x86 platforms
var
  ppfn: ppointer;
  lpNumberOfBytesWritten: TLMDSize_t;
  // Win9X:
  si: TSystemInfo; // The highest private memory address (used for Windows 9X only).
begin
  Result := nil;
  // Verify that a valid pfn was passed
  if (hFromModule=0) or (NewProc=nil) or (FunctionModule='') or (FunctionName='') or
     IsBadCodePtr(NewProc) then
    exit;
  pImportDesc := GetModuleImportDirectory(hFromModule);
  if pImportDesc=nil then
    exit;
  // First, verify the the module and function names passed to use are valid
  pfnOriginalProc := GetProcAddressETA(GetModuleHandle({$IFDEF LMDCOMP12}PChar{$ELSE}PAnsiChar{$ENDIF}(FunctionModule)),
    FunctionName);
  if pfnOriginalProc=nil then
    exit;

  // Functions with address above lpMaximumApplicationAddress require
  // special processing (Windows 9X only)
  GetSystemInfo(si);

  if (DWORD(pfnOriginalProc) > DWORD(si.lpMaximumApplicationAddress)) then
  begin
    // The address is in a shared DLL; the address needs fixing up
    if Byte(PChar(pfnOriginalProc)[0]) = cPushOpCode then
    begin
       // Skip over the PUSH op code and grab the real address
       pfnOriginalProc := PPointer((DWORD(pfnOriginalProc)+SizeOf(Byte)))^;
    end;
  end;
  // Iterate through the array of imported module descriptors, looking
  // for the module whose name matches the pszFunctionModule parameter
  while pImportDesc.Name <> 0 do
  begin
    Pointer(pszModName) := MakePtr(pDosHeader, pImportDesc.Name);
    if StrIComp(pszModName, PChar(FunctionModule)) = 0 then
    begin
      // Get a pointer to the found module's import address table (IAT)
      Pointer(pThunk) := MakePtr(pDosHeader, TLMDPtrInt(pImportDesc.FirstThunk) );
      // Blast through the table of import addresses, looking for the one
      // that matches the address we got back from GetProcAddress above.
      while Assigned(pThunk.FFunction) do
      begin
        ppfn := @(pThunk.FFunction);
        if (PDWORD(ppfn^) <> PDWORD(pfnOriginalProc)) and
           (DWORD(ppfn^) > DWORD(si.lpMaximumApplicationAddress)) then
        begin
          // If this is not the function and the address is in a shared DLL,
          // then maybe we're running under a debugger on Windows 9X. In this
          // case, this address points to an instruction that may have the
          // correct address.
          if (Byte(PChar(ppfn^)[0]) = cPushOpCode) then
          begin
            // We see the PUSH instruction, the real function address follows
            ppfn := @PPointer((DWORD(ppfn^)+SizeOf(Byte)))^;
          end;
        end;
        if PDWORD(ppfn^) = PDWORD(pfnOriginalProc) then
        begin
          if ppfn^ = PDWORD(NewProc) then
            exit;
          // Get the current protection attributes
          try
            if not UnprotectMemory(ppfn, SizeOf(Pointer), PAGE_EXECUTE_READWRITE) then
              exit;
            if not UnprotectMemory(@NewProc, SizeOf(Pointer), PAGE_EXECUTE_READWRITE) then
              exit;
            if not WriteProcessMemory( GetCurrentProcess(), ppfn, @NewProc, SizeOf(Pointer), lpNumberOfBytesWritten) then
            asm // ppfn^ := PDWORD(NewProc);
              mov     eax, ppfn
              mov     edx, NewProc
              xchg    [eax], edx
            end;
          except
            exit;
          end;
          Result := pfnOriginalProc;
          exit;
        end;
        // Advance to next imported function address
        Inc(pThunk);
      end;
    end;
    // Advance to next imported module descriptor
    Inc(pImportDesc);
  end;
end; { HookImportTableApiFunction }

procedure HookApi_GetCodeTemplateInfo(
  pTemplate: Pointer; DataAllocSize: DWORD;
  var pCode: Pointer; var DataOffset, CodeSize: DWORD );
begin
  asm
    // 1
    mov   eax, ci_code_ptr
    call  dword ptr [pTemplate]

    mov   edx, pCode
    mov   [edx], eax // - address of first entry point of code

    // 2
    mov   eax, ci_code_data_offset
    call  dword ptr [pTemplate]

    mov   edx, DataOffset
    mov   [edx], eax // - offset data from code_start

    // 3
    mov   eax, ci_code_size
    call  dword ptr [pTemplate]

    add   eax, DataAllocSize
    mov   edx, CodeSize
    mov   [edx], eax // - code and data size
  end;
end;

function HookApi_GetBuffer( BuffSize: DWORD; const sBuffID: String;
  var hSharedMem: THandle; var bFirstAllocate: Boolean): Pointer;
const
  FILE_MAP_EXECUTE = $20;
begin
  hSharedMem := 0;
  bFirstAllocate := False;
  Result := nil;
  if Length(sBuffID)=0 then
    exit;
//  if IsWinXPSP2 or IsWinXPUp then
  if LMDSIWindowsXPSP2Up then
    hSharedMem := CreateFileMapping(INVALID_HANDLE_VALUE, nil,
      PAGE_EXECUTE_READWRITE or SEC_NOCACHE or SEC_COMMIT, 0, BuffSize, PChar(sBuffID))
  else
    hSharedMem := CreateFileMapping(INVALID_HANDLE_VALUE, nil,
      PAGE_READWRITE or SEC_NOCACHE or SEC_COMMIT, 0, BuffSize, PChar(sBuffID));
  bFirstAllocate := not (GetLastError = ERROR_ALREADY_EXISTS);
  if (not bFirstAllocate) and ((hSharedMem=ERROR_INVALID_HANDLE)or(hSharedMem=0)) then
    hSharedMem := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(sBuffID) );
  if (hSharedMem=ERROR_INVALID_HANDLE)or(hSharedMem=0) then
  begin
    hSharedMem := 0;
    bFirstAllocate := False;
    exit;
  end;
  if LMDSIWindowsXPSP2Up then
    Result := MapViewOfFile(hSharedMem, FILE_MAP_EXECUTE or FILE_MAP_WRITE, 0, 0, 0)
  else
    Result := MapViewOfFile(hSharedMem, FILE_MAP_ALL_ACCESS, 0, 0, 0);
  if Result=nil then
  begin
    CloseHandle(hSharedMem);
    hSharedMem := 0;
    bFirstAllocate := False;
  end
  else
  if bFirstAllocate then
    FillChar(Result^, BuffSize, 0);
end;

function HookApi_CreateCodeTemplate( pCodeTemplate: Pointer; DataAllocSize: DWORD;
  const sCodeID: String; var hSharedMem: THandle; var bFirstAllocate: Boolean;
  var CodeData: Pointer; var CodeSize: DWORD): Pointer;
var
  DataOffset: DWORD;
  pCode: Pointer;
begin
  hSharedMem := 0;
  CodeData := nil;
  CodeSize := 0;
  bFirstAllocate := False;
  HookApi_GetCodeTemplateInfo( pCodeTemplate, DataAllocSize, pCode, DataOffset, CodeSize);
  Result := HookApi_GetBuffer( CodeSize, sCodeID, hSharedMem, bFirstAllocate);
  CodeData :=  Pointer( DWORD(Result)+ DataOffset );
  if bFirstAllocate then // copy code:
    Move(pCode^, Result^, CodeSize-DataAllocSize);
end;

function HookApi_LockCodeTemplate( var hSharedMem: THandle; bFirstAllocate: Boolean): Boolean;
var
  PH, CPH :THandle;
 // CreateToolhelp32Snapshot
  hSnapshot: THandle;
  pe: TProcessEntry32;
  bOk: Boolean;
  bIsDuplicated: Boolean;
begin
  Result := False;
  if (hSharedMem=0) then
    exit;
  if not bFirstAllocate then
  begin
    CloseHandle(hSharedMem);
    hSharedMem := 0;
  end
  else
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Result := True;
    CPH := GetCurrentProcess;
    if not DuplicateHandle(CPH, hSharedMem, CPH, nil, 0, False, DUPLICATE_SAME_ACCESS) then
      hSharedMem := 0;
  end
  else
  begin
    hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    if (hSnapshot = INVALID_HANDLE_VALUE) then
      exit;
    CPH := GetCurrentProcess;
    try
      FillChar(pe, SizeOf(pe), 0);
      pe.dwSize := sizeof(pe);
      bOK := Process32First(hSnapshot, pe);
      bIsDuplicated := False;
      while bOk do
      begin
        PH := OpenProcess( PROCESS_DUP_HANDLE, False, pe.th32ProcessID);
        if PH<>0 then
        begin
          if (PH<>CPH)and
            DuplicateHandle(GetCurrentProcess, hSharedMem, PH, nil, 0, False, DUPLICATE_SAME_ACCESS)
          then
            bIsDuplicated := True;
          CloseHandle(PH);
        end;
        bOK := Process32Next(hSnapshot, pe);
      end;//of: while bOK
      Result := bIsDuplicated;
    finally
      CloseHandle(hSnapshot);
    end;
  end;
  if hSharedMem<>0 then
  begin
    CloseHandle(hSharedMem);
    hSharedMem := 0;
  end;
end;

// Variant of calculation of real address, if source address points to import table.
// Algorithm:
// If given address contains jump-instruction and jump-address points to import table signature,
// then we take real address from import table.
// PS:
// This variant is needed for calculation of real address of function contained in a package, since
// we do not know format of naming for package functions, and we do not want to depend on package name.
// This variant is universal - works for EXE, DLL and packages.
function GetNativeAddr( Ptr:Pointer ): Pointer;
begin
  Result := Ptr;
  if  (PJumpInstruction(Result)^.Code=$FF) and                // if instruction == jump to table
      (PJumpInstruction(TLMDPtrInt(Result)+6)^.Code=$8B) and  // if instruction == mov eax, eax
      (PJumpInstruction(TLMDPtrInt(Result)+7)^.Code=$C0)
  then
    Result := PPPointer(TLMDPtrInt(Result) + 2)^^;
end; { GetNativeAddr }

// Insert jump in code to interceptor code
// todo: rework asm block to one atomic operation
function JumpFromCode( MSrc, MDest: Pointer; SaveJump: PJumpInstruction ): Boolean;
var
  mCache: TJumpInstruction;
begin
  Result := False;
  if MSrc=nil then
    exit;
  try
    if Assigned(SaveJump) then
      FillChar(SaveJump^, SizeOf(TJumpInstruction), 0);
    UnprotectMemory( MSrc, SizeOf(TJumpInstruction), PAGE_EXECUTE_READWRITE );
    if Assigned(SaveJump) then
      SaveJump^ := PJumpInstruction(MSrc)^;
    with mCache do
    begin
      DW2             := 0;
      Code            := $E9;
      TLMDPtrInt(Offset) := TLMDPtrInt(MDest) - TLMDPtrInt(MSrc) - 5;
    end;
    asm // PJumpInstruction(MSrc)^ : =mCache;
      push    ecx
      mov     eax, MSrc
      mov     edx, mCache.DW1
      mov     ecx, mCache.DW2
      xchg    [eax].TJumpInstruction.DW1, edx
      xchg    [eax].TJumpInstruction.DW2, ecx
      pop     ecx
    end;
    FlushInstructionCache(GetCurrentProcess, MSrc, SizeOf(TJumpInstruction));
    Result := True;
  except
  end;
end; { JumpFromCode }

// restore intercepted code to old
// todo: rework asm block to one atomic operation.
function RestoreSavedCode( MSrc: Pointer; var SaveJump: TJumpInstruction ): Boolean;
begin
  Result := False;
  if Assigned(MSrc)and(SaveJump.Code<>0) then
  try
    UnprotectMemory( MSrc, SizeOf(TJumpInstruction), PAGE_EXECUTE_READWRITE );
    asm // PJumpInstruction(MSrc)^ := SaveJump;
      push    ecx
      mov     eax, SaveJump
      mov     edx, [eax].TJumpInstruction.DW1
      mov     ecx, [eax].TJumpInstruction.DW2
      mov     eax, MSrc
      xchg    [eax].TJumpInstruction.DW1, edx
      xchg    [eax].TJumpInstruction.DW2, ecx
      pop     ecx
    end;
    FlushInstructionCache(GetCurrentProcess, MSrc, SizeOf(TJumpInstruction));
    // Clear Buffer
    FillChar(SaveJump, SizeOf(TJumpInstruction), 0);
    Result := True;
  except
  end;
end; { RestoreSavedCode }

function IsJumpFromCode( MSrc, MDest: Pointer): Boolean;
begin
  if (MSrc=nil) or (MDest=nil) then
    Result := False
  else
    with PJumpInstruction(MSrc)^ do
      Result := (Code = $E9) and (TLMDPtrInt(Offset) = (TLMDPtrInt(MDest) - TLMDPtrInt(MSrc) - 5));
end; { IsJumpFromCode }

function BeginLock( const LockName: String; var hLock: THandle ): Boolean;
begin
  hLock := CreateMutex(nil, True, PChar(LockName));
//  if (hLock=0) and (GetLastError() = ERROR_ALREADY_EXISTS) then
//    raise Exception.Create('LockName matches the name of an existing event, '+
//                           'semaphore, waitable timer, job, or file-mapping object');
  Result := hLock<>0;
  if Result then
  begin
    Result := WaitForSingleObject( hLock, INFINITE ) = WAIT_OBJECT_0;
    if not Result then
    begin
      CloseHandle(hLock);
      hLock := 0;
    end;
  end;
end;

procedure EndLock( var hLock: THandle );
begin
  if hLock<>0 then
  begin
    CloseHandle(hLock);
    hLock := 0;
  end;
end;
{$endif}

end.
