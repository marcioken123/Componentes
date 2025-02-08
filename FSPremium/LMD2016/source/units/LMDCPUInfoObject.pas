unit LMDCPUInfoObject;
{$I lmdcmps.inc}

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

LMDCPUInfoObject unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDObject, Classes;

type
  { -------------------------------------------------------------------------- }
  TLMDCPUInfo = record
    IDString                     : array [0..11] of AnsiChar;
    Stepping                     : Integer;
    Model                        : Integer;
    Family                       : Integer;
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
    MMX                          : Boolean;
    SYSCALLandSYSRET,
    FPConditionalMoveInstruction,
    AMD3DNow                     : Boolean;
    CPUName                      : AnsiString;
  end;
  { -------------------------------------------------------------------------- }
  TLMDCPUInfoObject = class (TLMDObject)
  private
    FInfo : TLMDCPUInfo;

    function GetString (Index : Integer) : String;
    function GetInteger (Index : Integer) : Integer;
    function GetBoolean (Index : Integer) : Boolean;
    procedure SetDummyBool (Index : Integer; b : Boolean);
    procedure SetDummyString (Index : Integer; s : String);
  public
    constructor Create(Owner:TPersistent=nil); override;
    procedure GetInfo;
  published
    property IDString : String index 0 read GetString;
    property Stepping : Integer index 0 read GetInteger;
    property Model    : Integer index 1 read GetInteger;
    property Family   : Integer index 2 read GetInteger;
    property FPU : Boolean index 0 read GetBoolean;
    property VirtualModeExtensions : Boolean index 1 read GetBoolean write SetDummyBool;
    property DebuggingExtensions : Boolean index 2 read GetBoolean write SetDummyBool;
    property PageSizeExtensions : Boolean index 3 read GetBoolean write SetDummyBool;
    property TimeStampCoutner : Boolean index 4 read GetBoolean write SetDummyBool;
    property K86_ModelSpecificRegisters : Boolean index 5 read GetBoolean write SetDummyBool;
    property MachineCheckException : Boolean index 6 read GetBoolean write SetDummyBool;
    property CMP_XCHG_8B : Boolean index 7 read GetBoolean write SetDummyBool;
    property APIC  : Boolean index 8 read GetBoolean write SetDummyBool;
    property MemoryTypeRangeRegisters  : Boolean index 9 read GetBoolean write SetDummyBool;
    property GlobalPaging : Boolean index 10 read GetBoolean write SetDummyBool;
    property Cond_MOVE_Instruct : Boolean index 11 read GetBoolean write SetDummyBool;
    property MMX : Boolean index 12 read GetBoolean write SetDummyBool;
    property SysCallAndSysRet : Boolean index 13 read GetBoolean write SetDummyBool;
    property FPCond_MOVE_Instruct : Boolean index 14 read GetBoolean write SetDummyBool;
    property AMD3DNow : Boolean index 15 read GetBoolean write SetDummyBool;
    property CPUName : String index 0 read GetString write SetDummyString;
    property ExistCPUInfo : Boolean index 16 read GetBoolean write SetDummyBool;
    end;

  //check whether there is valid CPU info or not
  function LMDExistCPUInfo : Boolean;
  //get the info about the CPU
  function LMDGetCPUInfo(out info: TLMDCPUInfo) : Boolean;
  //fast info functions
  function LMDExistMMX : Boolean;
  function LMDExist3DNow : Boolean;

implementation
uses
  LMDUtils, SysUtils
  ;

{ ---------------------------------------------------------------------------- }
function LMDExistCPUInfo : Boolean;
{$ifdef LMDX64}
begin
  Result := false;
end;
{$else}
asm
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
end;
{$endif}

{ ---------------------------------------------------------------------------- }
function LMDGetCPUInfo(out info: TLMDCPUInfo) : Boolean;

  function ExistExtendedCPUIDFunctions : Boolean;
  {$ifdef LMDX64}
  begin
    Result := false;
  end;
  {$else}
  asm
    mov eax,080000000h
    db $0F,$A2
  end;
  {$endif}

 {$ifdef LMDX86}
 var
  name : array [0..47] of AnsiChar;
  p    : Pointer;
{$ENDIF} 

begin
  if LMDExistCPUInfo then
  {$ifdef LMDX86}
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
      mov edi,info
      mov eax,0
      db $0F,$A2
      mov [edi],ebx
      mov [edi+4],edx
      mov [edi+8],ecx
      mov eax,1
      db $0F,$A2
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
      mov p,edi
    end;
  {$else}
    ;
  {$endif}
  if (info.IDString = 'AuthenticAMD') and ExistExtendedCPUIDFunctions then
  {$ifdef LMDX86}
    begin
      asm
        mov edi,p
        mov eax,080000001h
        db $0F,$A2
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
        lea edi,name
        mov eax,0
        mov [edi],eax
        mov eax,080000000h
        db $0F,$A2
        cmp eax,080000004h
        jl @NoString
        mov eax,080000002h
        db $0F,$A2
        mov [edi],eax
        mov [edi+4],ebx
        mov [edi+8],ecx
        mov [edi+12],edx
        add edi,16
        mov eax,080000003h
        db $0F,$A2
        mov [edi],eax
        mov [edi+4],ebx
        mov [edi+8],ecx
        mov [edi+12],edx
        add edi,16
        mov eax,080000004h
        db $0F,$A2
        mov [edi],eax
        mov [edi+4],ebx
        mov [edi+8],ecx
        mov [edi+12],edx
       @NoString:
      end; //end of ASM block
      info.CPUName := name;
    end
  {$else}

  {$endif}
  else
    with info do
      begin
        SYSCALLandSYSRET := false;
        FPConditionalMoveInstruction := false;
        AMD3DNow := false;
        CPUName := '';
      end;
  result := LMDExistCPUInfo;
end;

{ ---------------------------------------------------------------------------- }
function LMDExistMMX : Boolean;

var
  info: TLMDCPUInfo;

begin
  if LMDGetCPUInfo(info) then
    Result:= info.MMX
  else
    Result:= false;
  end;

{ ---------------------------------------------------------------------------- }
function LMDExist3DNow : Boolean;

var
  info: TLMDCPUInfo;

begin
  if LMDGetCPUInfo(info) then
    Result:= info.AMD3DNow
  else
    Result:= false;
  end;

{ ********************** class TLMDCPUInfoObject ************************** }
{ ---------------------------------------------------------------------------- }
function TLMDCPUInfoObject.GetString (Index : Integer) : String;
begin
  case Index of
    0: Result:= string(FInfo.IDString);
    1: Result:= string(FInfo.CPUName);
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCPUInfoObject.GetInteger (Index : Integer) : Integer;
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
function TLMDCPUInfoObject.GetBoolean (Index : Integer) : Boolean;
begin
  case Index of
    0: Result:= FInfo.FPU;
    1: Result:= FInfo.VirtualModeExtensions;
    2: Result:= FInfo.DebuggingExtensions;
    3: Result:= FInfo.PageSizeExtensions;
    4: Result:= FInfo.TimeStampCounter;
    5: Result:= FInfo.K86ModelSpecificRegisters;
    6: Result:= FInfo.MachineCheckException;
    7: Result:= FInfo.CMPXCHG8B;
    8: Result:= FInfo.APIC;
    9: Result:= FInfo.MemoryTypeRangeRegisters;
    10: Result:= FInfo.GlobalPagingExtension;
    11: Result:= FInfo.ConditionalMoveInstruction;
    12: Result:= FInfo.MMX;
    13: Result:= FInfo.SYSCALLandSYSRET;
    14: Result:= FInfo.FPConditionalMoveInstruction;
    15: Result:= FInfo.AMD3DNow;
    16: Result:= LMDExistCPUInfo;
  else
    Result:= false;
  end;
  end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCPUInfoObject.SetDummyBool (Index : Integer; b : Boolean);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCPUInfoObject.SetDummyString (Index : Integer; s : String);
begin
end;

{ ----------------------------- public --------------------------------------- }
constructor TLMDCPUInfoObject.Create;
begin
  inherited Create;
  GetInfo;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCPUInfoObject.GetInfo;
begin
  LMDGetCPUInfo (FInfo);
end;

end.
