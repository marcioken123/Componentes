unit ElSBHook;
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

ElSBHook unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

{
todo:
 Exchange8Bytes:
    Function for recording of two words by one atomic operation is needed.
    This is critical for WinNT.
}

{-$B-,R-}
{-$D-,L-}

(*

Version History

01/07/2003

 Added support of Win9X

22/02/2003

 Original version created.

*)

(*
  {$UNDEF DEBUG_TEMPLATE}
  {.$DEFINE DEBUG_TEMPLATE} // only for pattern debug (not mapped code), and only for NT
                            // (under Win9X debug only once, then - Reset)
  {$UNDEF LMD_DEBUGMESSAGES}
  {.$DEFINE LMD_DEBUGMESSAGES}  // debug message LMD_DEBUG
  {$IFDEF DEBUG_TEMPLATE}
    {$O-,D+,L+}
  {$ENDIF}
*)

interface

uses
  SysUtils,
  Windows, LMDDebugUnit, LMDTypes, LMDObjectList, ElProcessUtils, ElVCLUtils
  ,LMDInprocHookAPI;

var
  WM_ELSCROLLBAR: DWORD; {Returns non zero if succeeded}

const
  // WPARAM CODES for WM_ELSCROLLBAR:
  ELSB_BASE          = 0;
  ELSB_GETCONTROLLER = ELSB_BASE + 1; // check of window to override system scrollbar paint
  ELSB_PAINT         = ELSB_BASE + 2; // Paint SCROLLBAR. LPARAM in (SB_HORZ, SB_VERT)
  ELSB_SYNCSI        = ELSB_BASE + 3; // Synchronize TScrollInfo Data and bRedraw Flag

type
   {$EXTERNALSYM PScrollInfo}
   PScrollInfo = ^TScrollInfo;
   TELSBSyncScrollInfo = packed record
     BarFlag: Integer;
     pSI: PScrollInfo;
     bRedraw: BOOL;
   end;
   PELSBSyncScrollInfo = ^TELSBSyncScrollInfo;

function SystemScrollBarHooked:Boolean;
function IsHookImpExp:Boolean;

(*
{$IFDEF DEBUG_TEMPLATE}
var
  hDebugWindow: THandle; // for convenience when setting breakpoint for a selected window
{$ENDIF IFDEF DEBUG_TEMPLATE}
*)

implementation

{$ifdef LMDX86}
const
  cID_WM_ELSCROLLBAR = '{7DDF4ADB-4A01-4F4B-83AA-8D91C21E99D2}';
  ID_WM_ELSCROLLBAR: String = cID_WM_ELSCROLLBAR;

var
  bHookImpExp: Boolean;
  GlobalNewSetScrollInfo: Pointer;

function IsHookImpExp:Boolean;
begin
  Result := bHookImpExp;
end;

// Logical code Логический код (only as logic sample)
(*
function NewSetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo;
  Redraw: BOOL): Integer; stdcall;
type
  TLocalData = packed record
    C: Pointer;
    nBar: Integer; // = PELSBSyncScrollInfo
    pSI: PScrollInfo;
    vRedraw: BOOL;
  end;
var
  LocalData:TLocalData;
begin
  with LocalData do
  begin
    C := nil;
    if (Pointer(SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_GETCONTROLLER, DWord(@C) ))=nil) then
      C := nil;
    if Assigned(C) then
      vRedraw := False
    else
      vRedraw := Redraw;
    // begin lock ...
    // restore old handler code ...
    // call old handler
    Result := Windows.SetScrollInfo(hWnd, BarFlag, ScrollInfo, vRedraw);
    // reset new handler ...
    // end lock ...
    if Assigned(C) then
    begin
      nBar := BarFlag;
      pSI := @ScrollInfo;
      vRedraw := Redraw;
      SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_SYNCSI,  DWord(@nBar));
    end;
  end;
end;

function NewSetScrollRange(hWnd: HWND; nBar, nMinPos, nMaxPos: Integer;
  bRedraw: BOOL): BOOL; stdcall;
type
  TSetScrollInfo_Vars = packed record
    C: Pointer;
    wBar: Integer; // = PELSBSyncScrollInfo
    pSI: PScrollInfo;
    vRedraw: BOOL;
    SI: TScrollInfo;
  end;
var
  LocalData:TSetScrollInfo_Vars;
begin
  with LocalData do
  begin
    C := nil;
    if (Pointer(SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_GETCONTROLLER, DWord(@C) ))=nil) then
      C := nil;
    if Assigned(C) then
      vRedraw := False
    else
      vRedraw := bRedraw;
    // begin lock ...
    // restore old handler code ...
    // call old handler
    Result := Windows.SetScrollRange(hWnd, nBar, nMinPos, nMaxPos, vRedraw);
    // reset new handler ...
    // end lock ...
    if Assigned(C) then
    begin
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_RANGE;
      SI.nMin := nMinPos;
      SI.nMax := nMaxPos;
      wBar := nBar;
      pSI := @SI;
      vRedraw := bRedraw;
      SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_SYNCSI,  DWord(@wBar));
    end;
  end;
end;

function NewSetScrollPos(hWnd: HWND; nBar, nPos: Integer; bRedraw: BOOL): Integer; stdcall;
type
  TSetScrollPos_Vars = packed record
    C: Pointer;
    wBar: Integer; // = PELSBSyncScrollInfo
    pSI: PScrollInfo;
    vRedraw: BOOL;
    SI: TScrollInfo;
  end;
var
  LocalData:TSetScrollPos_Vars;
begin
  with LocalData do
  begin
    C := nil;
    if (Pointer(SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_GETCONTROLLER, DWord(@C) ))=nil) then
      C := nil;
    if Assigned(C) then
      vRedraw := False
    else
      vRedraw := bRedraw;
    // begin lock ...
    // restore old handler code ...
    // call old handler
    Result := Windows.SetScrollPos(hWnd, nBar, nPos, vRedraw);
    // reset new handler ...
    // end lock ...
    if Assigned(C) then
    begin
      SI.cbSize := SizeOf(TScrollInfo);
      SI.fMask := SIF_POS;
      SI.nPos := nPos;
      wBar := nBar;
      pSI := @SI;
      vRedraw := bRedraw;
      SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_SYNCSI,  DWord(@wBar));
    end;
  end;
end;
*)

type
  PJumpInstruction = ^TJumpInstruction;
  TJumpInstruction = packed record
    case byte of
    1:(
    Code:    Byte;  // jump instruction ($FF)
    _Offset: DWORD; // jump offset
    NU:      array[0..2]of byte;
    );
    2:(
    DW1: DWORD;
    DW2: DWORD;
    );
  end;

procedure _JumpFromCode( MSrc, MDest:Pointer; SaveJump :PJumpInstruction );
var
  mCache: TJumpInstruction;
begin
  SaveJump^ := PJumpInstruction(MSrc)^;
  with mCache do
  begin
    DW2 :=              $0;
    Code :=             $E9;
    TLMDPtrInt(_Offset) := TLMDPtrInt(MDest) - TLMDPtrInt(MSrc) - 5;
  end;
  // -----
  //PJumpInstruction(MSrc)^ := mCache; {??? it'd better to replace by one atomic operation}
  asm
    push    ecx
    mov     eax, MSrc
    mov     edx, mCache.DW1
    mov     ecx, mCache.DW2
    xchg    [eax].TJumpInstruction.DW1, edx
    xchg    [eax].TJumpInstruction.DW2, ecx
    pop     ecx
  end;
  // -----
  FlushInstructionCache(GetCurrentProcess, MSrc, SizeOf(TJumpInstruction));
end;

const
  cLockID = 'HookApi:{7DDF4ADB-4A01-4F4B-83AA-8D91C21E99D2}:123456789012345:Lock';

type
 TCodeData = {$ifndef lmdcomp12}packed{$endif} record
   // cache of winapi addresses:
   SendMessage: Pointer;            // user32 'SendMessageA'
   GetCurrentProcess: Pointer;      // kernel32 'GetCurrentProcess'
   FlushInstructionCache: Pointer;  // kernel32 'FlushInstructionCache'
   CreateMutex: Pointer;            // kernel32 'CreateMutexA'
   WaitForSingleObject: Pointer;    // kernel32 'WaitForSingleObject'
   CloseHandle: Pointer;            // kernel32 'CloseHandle'
   Sleep: Pointer;                  // kernel32 'Sleep'

   (*{$IFDEF LMD_DEBUGMESSAGES}
   LMD_DEBUG: Pointer;      // kernel32 'LMDDebugA'
   b1: array[0..8] of char;
   b2: array[0..8] of char;
   b3: array[0..8] of char;
   e1: array[0..8] of char;
   e2: array[0..8] of char;
   e3: array[0..8] of char;
   {$ENDIF}*)

   // cache of addresses:
   SetScrollInfo: Pointer;          // user32 'SetScrollInfo'
   NewSetScrollInfo: Pointer;
   SetScrollRange: Pointer;         // user32 'SetScrollRange'
   NewSetScrollRange: Pointer;
   SetScrollPos: Pointer;           // user32 'SetScrollPos'
   NewSetScrollPos: Pointer;
   // cache of dynamic constants:
   WM_ELSCROLLBAR: DWORD;    // = RegisterWindowMessage(ID_WM_ELSCROLLBAR)
   IsWin9X: DWORD; // 1 = TRUE
   IsHookImpExp: DWORD; // 1 = TRUE
   // cache of old code first instructions:
   jiSetScrollInfo: TJumpInstruction;
   jiSetScrollRange: TJumpInstruction;
   jiSetScrollPos: TJumpInstruction;
   // lock data
   LockID: array[0..Length(cLockID)] of char;
   // IsInstalled Flag:
   Installed: DWORD;         // 1 - True else False
 end;
 PCodeData = ^TCodeData;     // Debug view of Code Data: PCodeData(ebx)^

const
  ci_NewSetScrollRange_offset = ci_code_data_offset+1;
  ci_NewSetScrollPos_offset =   ci_code_data_offset+2;

procedure SBHandlersTemplates;
// code references:
label
 LB_CODE_START, LB_CODE_END, LB_CODE_DATA,
 LB_NewSetScrollInfo, LB_NewSetScrollRange, LB_NewSetScrollPos;
//
// define functions types for access to params, result and local variables:
//
type
  TCommon_Vars = packed record
    C: Pointer;
    hLock: THandle;
    SSI: TELSBSyncScrollInfo;
  end;
  PCommon_Vars = ^TCommon_Vars;
//function _NewSetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo;
//  Redraw: BOOL): Integer; stdcall;
type
  TSetScrollInfo_Vars = packed record
    C: Pointer;
    hLock: THandle;
    nBar: Integer; // = PELSBSyncScrollInfo
    pSI: PScrollInfo;
    vRedraw: BOOL;
    // return value
    fResult: BOOL;
  end;
  TSetScrollInfo_Params = packed record
    LV: TSetScrollInfo_Vars;
    NU: array [0..1] of dword;
    hWnd: THandle;
    BarFlag: Integer;
    ScrollInfo: PScrollInfo;
    Redraw: BOOL;
  end;
  PSetScrollInfo_Params = ^TSetScrollInfo_Params; // Debug view of Params, Result, Local Variables: PSetScrollInfo_Params(ebp)^
const
  cSetScrollInfo_VarsAndResultSize = (SizeOf(TSetScrollInfo_Vars)+SizeOf(DWord)-1) div SizeOf(DWord) * SizeOf(DWord);
//
//function NewSetScrollRange(hWnd: HWND; nBar, nMinPos, nMaxPos: Integer;
//  bRedraw: BOOL): BOOL; stdcall;
type
  TSetScrollRange_Vars = packed record
    C: Pointer;
    hLock: THandle;
    wBar: Integer; // = PELSBSyncScrollInfo
    pSI: PScrollInfo;
    vRedraw: BOOL;
    case byte of
    0: (SI: TScrollInfo;
        // return value
        fResult: BOOL;
    );
    1: (SIPtr: DWORD);
  end;
  TSetScrollRange_Params = packed record
    LV: TSetScrollRange_Vars;
    NU: array [0..1] of dword;
    hWnd: THandle;
    nBar: Integer;
    nMinPos: Integer;
    nMaxPos: Integer;
    bRedraw: BOOL;
  end;
  PSetScrollRange_Params = ^TSetScrollRange_Params;
const
  cSetScrollRange_VarsAndResultSz = (SizeOf(TSetScrollRange_Vars)+SizeOf(DWord)-1) div SizeOf(DWord) * SizeOf(DWord);
  cSizeOfTScrollInfo = SizeOf(TScrollInfo);
//
//function NewSetScrollPos(hWnd: HWND; nBar: Integer; nPos: Integer; bRedraw: BOOL): Integer; stdcall;
type
  TSetScrollPos_Vars = packed record
    C: Pointer;
    hLock: THandle;
    wBar: Integer; // = PELSBSyncScrollInfo
    pSI: PScrollInfo;
    vRedraw: BOOL;
    case byte of
    0: (SI: TScrollInfo;
        // return value
        fResult: Integer;
    );
    1: (SIPtr: DWORD);
  end;
  TSetScrollPos_Params = packed record
    LV: TSetScrollPos_Vars;
    NU: array [0..1] of dword;
    hWnd: THandle;
    nBar: Integer;
    nPos: Integer;
    bRedraw: BOOL;
  end;
  PSetScrollPos_Params = ^TSetScrollPos_Params;
const
  cSetScrollPos_VarsAndResultSize = (SizeOf(TSetScrollPos_Vars)+SizeOf(DWord)-1) div SizeOf(DWord) * SizeOf(DWord);
//
  cTJumpInstructionSize = SizeOf(TJumpInstruction);
begin
asm
  // input: eax
  // output: eax
              cmp     eax, ci_code_ptr
              jz      @@ci_code_ptr
              cmp     eax, ci_code_size
              jz      @@ci_code_size
              cmp     eax, ci_code_data_offset
              jz      @@ci_code_data_offset
              cmp     eax, ci_NewSetScrollRange_offset
              jz      @@ci_NewSetScrollRange_offset
              cmp     eax, ci_NewSetScrollPos_offset
              jz      @@ci_NewSetScrollPos_offset
              xor     eax, eax
              jmp     @@exit
@@ci_code_ptr:
              mov     eax, offset LB_CODE_START
              jmp     @@exit
@@ci_code_size:
              mov     eax, offset LB_CODE_END
              sub     eax, offset LB_CODE_START
              jmp     @@exit
@@ci_code_data_offset:
              mov     eax, offset LB_CODE_DATA
              sub     eax, offset LB_CODE_START
              jmp     @@exit
@@ci_NewSetScrollRange_offset:
              mov     eax, offset LB_NewSetScrollRange
              sub     eax, offset LB_CODE_START
              jmp     @@exit
@@ci_NewSetScrollPos_offset:
              mov     eax, offset LB_NewSetScrollPos
              sub     eax, offset LB_CODE_START
@@exit:
end;
exit;
asm
LB_CODE_START:
LB_NewSetScrollInfo:
{--------------------------------------------------------------------------------------------------}
//function _NewSetScrollInfo(hWnd: HWND; BarFlag: Integer; const ScrollInfo: TScrollInfo;
//  Redraw: BOOL): Integer; stdcall;
              push    ebp
              mov     ebp, esp
              add     esp, -cSetScrollInfo_VarsAndResultSize
              add     ebp, -cSetScrollInfo_VarsAndResultSize
              push    edx

              push    ebx
             {load to ebx address of LB_CODE_DATA in dynamic} // (mov ebx, offset LB_CODE_DATA)
             {-------------------------------------------------------------------------------}
              push    ebp
              @@code_start1:
              call    @@delta1
              @@delta1:
              // load to ebx address of @@code_start:
              pop     ebx
              // sub ebx, (offset @@delta) - (offset @@code_start):
              mov     eax, offset @@delta1
              sub     eax, offset @@code_start1
              sub     ebx, eax
              // load to ebx address of LB_CODE_DATA
              // lea ebx,[ebx+ ( (offset LB_CODE_DATA)-(offset @@code_start) ) ]:
              mov     eax, offset LB_CODE_DATA
              sub     eax, offset @@code_start1
              lea     ebx, [ebx+eax]
              pop     ebp
             {-------------------------------------------------------------------------------}
             {/load to ebx address of LB_CODE_DATA in dynamic}

  // C := nil;
              xor     eax, eax
              mov     [ebp].TSetScrollInfo_Vars.C, eax
  // check installed of hooks
              cmp     dword ptr [ebx].TCodeData.Installed, $01
              jne     @@NSSI_2
  // check ScrollInfo = nil
              cmp     [ebp].TSetScrollInfo_Params.ScrollInfo, $00
              jz      @@NSSI_2

  // C := Pointer(SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_GETCONTROLLER, @C));

              lea     eax, [ebp].TSetScrollInfo_Vars.C
              push    eax
              push    ELSB_GETCONTROLLER
              push    [ebx].TCodeData.WM_ELSCROLLBAR
              push    [ebp].TSetScrollInfo_Params.hWnd
              call    dword ptr [ebx].TCodeData.SendMessage

  // check result and:
  //  if Assigned(C) then vRedraw := False else vRedraw := Redraw;

              cmp     eax, +$00
              jz      @@NSSI_1
              cmp     [ebp].TSetScrollInfo_Vars.C, eax
              jne     @@NSSI_1
              xor     eax, eax
              jmp     @@NSSI_3
  @@NSSI_1:   xor     eax, eax
              mov     [ebp].TSetScrollInfo_Vars.C, eax
  @@NSSI_2:   mov     eax, [ebp].TSetScrollInfo_Params.Redraw
  @@NSSI_3:   mov     [ebp].TSetScrollInfo_Vars.vRedraw, eax

  // Result := Windows.SetScrollInfo(hWnd, BarFlag, ScrollInfo, vRedraw);

        (*
              {$IFDEF LMD_DEBUGMESSAGES}
              mov     eax, 1
              call    @@PrintDebug
              {$ENDIF IFDEF LMD_DEBUGMESSAGES}
        *)

              cmp     [ebx].TCodeData.IsHookImpExp, 1
              je      @@NSSI_SKIPLOCK_1

              call    @@BeginLock
              // restore old code:
              mov     eax, [ebx].TCodeData.SetScrollInfo
              lea     edx, [ebx].TCodeData.jiSetScrollInfo
              call    @@RestoreSavedCode // eax = MSrc = @SetScrollInfo, edx = PJumpInstruction

  @@NSSI_SKIPLOCK_1:

              // call old handler:
              push    [ebp].TSetScrollInfo_Vars.vRedraw
              push    [ebp].TSetScrollInfo_Params.ScrollInfo
              push    [ebp].TSetScrollInfo_Params.BarFlag
              push    [ebp].TSetScrollInfo_Params.hWnd
              call    dword ptr [ebx].TCodeData.SetScrollInfo
              mov     [ebp].TSetScrollInfo_Vars.fResult, eax

              cmp     [ebx].TCodeData.IsHookImpExp, 1
              je      @@NSSI_SKIPLOCK_2

              // reset new code:
              mov     eax, [ebx].TCodeData.SetScrollInfo
              mov     edx, [ebx].TCodeData.NewSetScrollInfo
              call    @@ShortJumpFromCode // eax = MSrc = @SetScrollInfo, edx = Dest = @NewSetScrollInfo

              call    @@EndLock

  @@NSSI_SKIPLOCK_2:

  //  if Assigned(C) then
              cmp     [ebp].TSetScrollInfo_Vars.C, +$00
              jz      @@NSSI_4
  //    nBar := BarFlag;
  //    pSI := @ScrollInfo;
  //    vRedraw := Redraw;
  //    SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_SYNCSI,  DWord(@nBar));

              mov     eax, [ebp].TSetScrollInfo_Params.BarFlag
              mov     [ebp].TSetScrollInfo_Vars.nBar, eax
              mov     eax, [ebp].TSetScrollInfo_Params.ScrollInfo
              mov     [ebp].TSetScrollInfo_Vars.pSI, eax
              mov     eax, [ebp].TSetScrollInfo_Params.Redraw
              mov     [ebp].TSetScrollInfo_Vars.vRedraw, eax
              lea     eax, [ebp].TSetScrollInfo_Vars.nBar
              push    eax
              push    ELSB_SYNCSI
              push    [ebx].TCodeData.WM_ELSCROLLBAR
              push    [ebp].TSetScrollInfo_Params.hWnd
              call    dword ptr [ebx].TCodeData.SendMessage

  @@NSSI_4:

        (*
              {$IFDEF LMD_DEBUGMESSAGES}
              mov     eax, 4
              call    @@PrintDebug
              {$ENDIF IFDEF LMD_DEBUGMESSAGES}
        *)

              mov     eax, [ebp].TSetScrollInfo_Vars.fResult
              add     ebp, cSetScrollInfo_VarsAndResultSize
              pop     ebx
              pop     edx
              mov     esp, ebp
              pop     ebp
              ret     $10

LB_NewSetScrollRange:
{--------------------------------------------------------------------------------------------------}
//function NewSetScrollRange(hWnd: HWND; nBar, nMinPos, nMaxPos: Integer;
//  bRedraw: BOOL): BOOL; stdcall;
              push    ebp
              mov     ebp, esp
              add     esp, -cSetScrollRange_VarsAndResultSz
              add     ebp, -cSetScrollRange_VarsAndResultSz
              push    edx

              push    ebx
             {load to ebx address of LB_CODE_DATA in dynamic} // (mov ebx, offset LB_CODE_DATA)
             {-------------------------------------------------------------------------------}
              push    ebp
              @@code_start2:
              call    @@delta2
              @@delta2:
              // load to ebx address of @@code_start:
              pop     ebx
              // sub ebx, (offset @@delta) - (offset @@code_start):
              mov     eax, offset @@delta2
              sub     eax, offset @@code_start2
              sub     ebx, eax
              // load to ebx address of LB_CODE_DATA
              // lea ebx,[ebx+ ( (offset LB_CODE_DATA)-(offset @@code_start) ) ]:
              mov     eax, offset LB_CODE_DATA
              sub     eax, offset @@code_start2
              lea     ebx, [ebx+eax]
              pop     ebp
             {-------------------------------------------------------------------------------}
             {/load to ebx address of LB_CODE_DATA in dynamic}

  // C := nil;
              xor     eax, eax
              mov     [ebp].TSetScrollRange_Vars.C, eax
  // check installed of hooks
              cmp     dword ptr [ebx].TCodeData.Installed, $01
              jne     @@NSSR_2

  // C := Pointer(SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_GETCONTROLLER, @C));

              lea     eax, [ebp].TSetScrollRange_Vars.C
              push    eax
              push    ELSB_GETCONTROLLER
              push    [ebx].TCodeData.WM_ELSCROLLBAR
              push    [ebp].TSetScrollRange_Params.hWnd
              call    dword ptr [ebx].TCodeData.SendMessage

  // check result and:
  // if Assigned(C) then vRedraw := False else vRedraw := bRedraw;

              cmp     eax, +$00
              jz      @@NSSR_1
              cmp     [ebp].TSetScrollRange_Vars.C, eax
              jne     @@NSSR_1
              xor     eax, eax
              jmp     @@NSSR_3
  @@NSSR_1:   xor     eax, eax
              mov     [ebp].TSetScrollRange_Vars.C, eax
  @@NSSR_2:   mov     eax, [ebp].TSetScrollRange_Params.bRedraw
  @@NSSR_3:   mov     [ebp].TSetScrollRange_Vars.vRedraw, eax

  // Result := Windows.SetScrollRange(hWnd, nBar, nMinPos, nMaxPos, vRedraw);

        (*
              {$IFDEF LMD_DEBUGMESSAGES}
              mov     eax, 2
              call    @@PrintDebug
              {$ENDIF IFDEF LMD_DEBUGMESSAGES}
        *)

              cmp     [ebx].TCodeData.IsHookImpExp, 1
              je      @@NSSR_SKIPLOCK_1

              call    @@BeginLock

              // restore old code:
              mov     eax, [ebx].TCodeData.SetScrollRange
              lea     edx, [ebx].TCodeData.jiSetScrollRange
              call    @@RestoreSavedCode // eax = MSrc = @SetScrollRange, edx = PJumpInstruction

  @@NSSR_SKIPLOCK_1:
              // call old handler:
              mov     eax, [ebp].TSetScrollRange_Vars.vRedraw
              push    eax
              push    [ebp].TSetScrollRange_Params.nMaxPos
              push    [ebp].TSetScrollRange_Params.nMinPos
              push    [ebp].TSetScrollRange_Params.nBar
              push    [ebp].TSetScrollRange_Params.hWnd
              call    dword ptr [ebx].TCodeData.SetScrollRange
              mov     [ebp].TSetScrollRange_Vars.fResult, eax

              cmp     [ebx].TCodeData.IsHookImpExp, 1
              je      @@NSSR_SKIPLOCK_2

              // reset new code:
              mov     eax, [ebx].TCodeData.SetScrollRange
              mov     edx, [ebx].TCodeData.NewSetScrollRange
              call    @@ShortJumpFromCode // eax = MSrc = @SetScrollRange, edx = Dest = @NewSetScrollRange

              call    @@EndLock

  @@NSSR_SKIPLOCK_2:

  // if Assigned(C) then

              cmp     [ebp].TSetScrollRange_Vars.C, +$00
              jz      @@NSSR_4

  // SI.cbSize := SizeOf(TScrollInfo);
              mov     [ebp].TSetScrollRange_Vars.SIPtr.TScrollInfo.cbSize, cSizeOfTScrollInfo
  // SI.fMask := SIF_RANGE;
              mov     [ebp].TSetScrollRange_Vars.SIPtr.TScrollInfo.fMask, SIF_RANGE
  // SI.nMin := nMinPos;
              mov     eax, [ebp].TSetScrollRange_Params.nMinPos
              mov     [ebp].TSetScrollRange_Vars.SIPtr.TScrollInfo.nMin, eax
  // SI.nMax := nMaxPos;
              mov     eax, [ebp].TSetScrollRange_Params.nMaxPos
              mov     [ebp].TSetScrollRange_Vars.SIPtr.TScrollInfo.nMax, eax

  //    wBar := nBar;
  //    pSI := @SI;
  //    vRedraw := bRedraw;
  //    SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_SYNCSI,  DWord(@wBar));

              mov     eax, [ebp].TSetScrollRange_Params.nBar
              mov     [ebp].TSetScrollRange_Vars.wBar, eax
              lea     eax, [ebp].TSetScrollRange_Vars.SIPtr
              mov     [ebp].TSetScrollRange_Vars.pSI, eax
              mov     eax, [ebp].TSetScrollRange_Params.bRedraw
              mov     [ebp].TSetScrollRange_Vars.vRedraw, eax
              lea     eax, [ebp].TSetScrollRange_Vars.wBar
              push    eax
              push    ELSB_SYNCSI
              push    [ebx].TCodeData.WM_ELSCROLLBAR
              push    [ebp].TSetScrollRange_Params.hWnd
              call    dword ptr [ebx].TCodeData.SendMessage

  @@NSSR_4:

        (*
              {$IFDEF LMD_DEBUGMESSAGES}
              mov     eax, 5
              call    @@PrintDebug
              {$ENDIF IFDEF LMD_DEBUGMESSAGES}
        *)

              mov     eax, [ebp].TSetScrollRange_Vars.fResult
              add     ebp, cSetScrollRange_VarsAndResultSz
              pop     ebx
              pop     edx
              mov     esp, ebp
              pop     ebp
              ret     $14
LB_NewSetScrollPos:
{--------------------------------------------------------------------------------------------------}
//function NewSetScrollPos(hWnd: HWND; nBar: Integer; nPos: Integer; bRedraw: BOOL): Integer; stdcall;
              push    ebp
              mov     ebp, esp
              add     esp, -cSetScrollPos_VarsAndResultSize
              add     ebp, -cSetScrollPos_VarsAndResultSize
              push    edx

              push    ebx
             {load to ebx address of LB_CODE_DATA in dynamic} // (mov ebx, offset LB_CODE_DATA)
             {-------------------------------------------------------------------------------}
              push    ebp
              @@code_start4:
              call    @@delta4
              @@delta4:
              // load to ebx address of @@code_start:
              pop     ebx
              // sub ebx, (offset @@delta) - (offset @@code_start):
              mov     eax, offset @@delta4
              sub     eax, offset @@code_start4
              sub     ebx, eax
              // load to ebx address of LB_CODE_DATA
              // lea ebx,[ebx+ ( (offset LB_CODE_DATA)-(offset @@code_start) ) ]:
              mov     eax, offset LB_CODE_DATA
              sub     eax, offset @@code_start4
              lea     ebx, [ebx+eax]
              pop     ebp
             {-------------------------------------------------------------------------------}
             {/load to ebx address of LB_CODE_DATA in dynamic}

  // C := nil;
              xor     eax, eax
              mov     [ebp].TSetScrollPos_Vars.C, eax
  // check installed of hooks
              cmp     dword ptr [ebx].TCodeData.Installed, $01
              jne     @@NSSP_2

  // C := Pointer(SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_GETCONTROLLER, @C));

              lea     eax, [ebp].TSetScrollPos_Vars.C
              push    eax
              push    ELSB_GETCONTROLLER
              push    [ebx].TCodeData.WM_ELSCROLLBAR
              push    [ebp].TSetScrollPos_Params.hWnd
              call    dword ptr [ebx].TCodeData.SendMessage

  // check result and:
  // if Assigned(C) then vRedraw := False else vRedraw := bRedraw;
              cmp     eax, +$00
              jz      @@NSSP_1
              cmp     [ebp].TSetScrollPos_Vars.C, eax
              jne     @@NSSP_1
              xor     eax, eax
              jmp     @@NSSP_3
  @@NSSP_1:   xor     eax, eax
              mov     [ebp].TSetScrollPos_Vars.C, eax
  @@NSSP_2:   mov     eax, [ebp].TSetScrollPos_Params.bRedraw
  @@NSSP_3:   mov     [ebp].TSetScrollPos_Vars.vRedraw, eax

  // Result := Windows.SetScrollPos(hWnd, nBar, nPos, vRedraw);

              (*
              {$IFDEF LMD_DEBUGMESSAGES}
              mov     eax, 3
              call    @@PrintDebug
              {$ENDIF IFDEF LMD_DEBUGMESSAGES}
        *)

              cmp     [ebx].TCodeData.IsHookImpExp, 1
              je      @@NSSP_SKIPLOCK_1

              call    @@BeginLock

              // restore old code:
              mov     eax, [ebx].TCodeData.SetScrollPos
              lea     edx, [ebx].TCodeData.jiSetScrollPos
              call    @@RestoreSavedCode // eax = MSrc = @SetScrollPos, edx = PJumpInstruction

  @@NSSP_SKIPLOCK_1:
              // call old handler:
              push    [ebp].TSetScrollPos_Vars.vRedraw
              push    [ebp].TSetScrollPos_Params.nPos
              push    [ebp].TSetScrollPos_Params.nBar
              push    [ebp].TSetScrollPos_Params.hWnd
              call    dword ptr [ebx].TCodeData.SetScrollPos
              mov     [ebp].TSetScrollPos_Vars.fResult, eax

              cmp     [ebx].TCodeData.IsHookImpExp, 1
              je      @@NSSP_SKIPLOCK_2

              // reset new code:
              mov     eax, [ebx].TCodeData.SetScrollPos
              mov     edx, [ebx].TCodeData.NewSetScrollPos
              call    @@ShortJumpFromCode // eax = MSrc = @SetScrollPos, edx = Dest = @NewSetScrollPos

              call    @@EndLock

  @@NSSP_SKIPLOCK_2:

  // if Assigned(C) then

              cmp     [ebp].TSetScrollPos_Vars.C, +$00
              jz      @@NSSP_4

  // SI.cbSize := SizeOf(TScrollInfo);
              mov     [ebp].TSetScrollPos_Vars.SIPtr.TScrollInfo.cbSize, cSizeOfTScrollInfo
  // SI.fMask := SIF_POS;
              mov     [ebp].TSetScrollPos_Vars.SIPtr.TScrollInfo.fMask, SIF_POS
  // SI.nPos := nPos;
              mov     eax, [ebp].TSetScrollPos_Params.nPos
              mov     [ebp].TSetScrollPos_Vars.SIPtr.TScrollInfo.nPos, eax

  //    wBar := nBar;
  //    pSI := @SI;
  //    vRedraw := bRedraw;
  //    SendMessage( hWnd, WM_ELSCROLLBAR, ELSB_SYNCSI,  DWord(@wBar));

              mov     eax, [ebp].TSetScrollPos_Params.nBar
              mov     [ebp].TSetScrollPos_Vars.wBar, eax
              lea     eax, [ebp].TSetScrollPos_Vars.SIPtr
              mov     [ebp].TSetScrollPos_Vars.pSI, eax
              mov     eax, [ebp].TSetScrollPos_Params.bRedraw
              mov     [ebp].TSetScrollPos_Vars.vRedraw, eax
              lea     eax, [ebp].TSetScrollPos_Vars.wBar
              push    eax
              push    ELSB_SYNCSI
              push    [ebx].TCodeData.WM_ELSCROLLBAR
              push    [ebp].TSetScrollPos_Params.hWnd
              call    dword ptr [ebx].TCodeData.SendMessage

  @@NSSP_4:

        (*
              {$IFDEF LMD_DEBUGMESSAGES}
              mov     eax, 6
              call    @@PrintDebug
              {$ENDIF IFDEF LMD_DEBUGMESSAGES}
        *)

              mov     eax, [ebp].TSetScrollPos_Vars.fResult
              add     ebp, cSetScrollPos_VarsAndResultSize
              pop     ebx
              pop     edx
              mov     esp, ebp
              pop     ebp
              ret     $0010
//
@@RestoreSavedCode:
//procedure RestoreSavedCode // eax = MSrc, edx = PJumpInstruction
              push    ebp
              mov     ebp, esp
              add     esp, -cTJumpInstructionSize
              add     ebp, -cTJumpInstructionSize // ebp = PJumpInstruction
              push    ecx

              //  load old instruction into cache
              mov     ecx, [edx].TJumpInstruction.DW1
              mov     [ebp].TJumpInstruction.DW1, ecx
              mov     ecx, [edx].TJumpInstruction.DW2
              mov     [ebp].TJumpInstruction.DW2, ecx

              // copy instruction {it'd be better to replace it by one operation}
              // ---
//              push    eax
//              push    $00
//              call    dword ptr [ebx].TCodeData.Sleep
//              pop     eax
              mov     ecx, [ebp].TJumpInstruction.DW1     // save 2*dword
              mov     edx, [ebp].TJumpInstruction.DW2
              xchg    [eax].TJumpInstruction.DW1, ecx
              xchg    [eax].TJumpInstruction.DW2, edx
              // ---

              push    cTJumpInstructionSize
              push    eax // = MSrc
              call    dword ptr [ebx].TCodeData.GetCurrentProcess
              push    eax
              call    dword ptr [ebx].TCodeData.FlushInstructionCache

              pop     ecx
              add     ebp, cTJumpInstructionSize
              mov     esp, ebp
              pop     ebp
              ret     $00
//
@@ShortJumpFromCode:
//procedure ShortJumpFromCode; // eax = MSrc = @SetScrollInfo, edx = Dest = @NewSetScrollInfo
              push    ebp
              mov     ebp, esp
              add     esp, -cTJumpInstructionSize
              add     ebp, -cTJumpInstructionSize // ebp = PJumpInstruction
              push    ecx

              //  build absolute jump instruction into cache
              mov     [ebp].TJumpInstruction.DW2, 0
              mov     byte ptr [ebp].TJumpInstruction.Code, $E9
              sub     edx, eax
              sub     edx, +$05
              mov     dword ptr [ebp].TJumpInstruction._Offset, edx

              // copy instruction {it'd be better to replace it by one operation}
//              {
              // ---
//              push    eax
//              push    $00
//              call    dword ptr [ebx].TCodeData.Sleep
//              pop     eax
              mov     ecx, [ebp].TJumpInstruction.DW1      // save 2*dword
              mov     edx, [ebp].TJumpInstruction.DW2
              xchg    [eax].TJumpInstruction.DW1, ecx
              xchg    [eax].TJumpInstruction.DW2, edx
              // ---

              push    cTJumpInstructionSize
              push    eax // = MSrc
              call    dword ptr [ebx].TCodeData.GetCurrentProcess
              push    eax
              call    dword ptr [ebx].TCodeData.FlushInstructionCache

              pop     ecx
              add     ebp, cTJumpInstructionSize
              mov     esp, ebp
              pop     ebp
              ret     $00
//
@@BeginLock:
              cmp     [ebx].TCodeData.IsWin9X, 1
              je      @@CLI
//              push    $00
//              call    dword ptr [ebx].TCodeData.Sleep
              // hLock := CreateMutex(nil, TRUE, LockID);
              lea     eax, [ebx].TCodeData.LockID
              push    eax
              push    1 // = TRUE
              push    0 // = nil = PSecurityAttributes
              call    dword ptr [ebx].TCodeData.CreateMutex
              mov     [ebp].TCommon_Vars.hLock, eax
              test    eax, eax
              jz      @@BLR
              // WaitForSingleObject( hLock, INFINITE )
              push    INFINITE
              push    eax
              call    dword ptr [ebx].TCodeData.WaitForSingleObject
              jmp     @@BLR
  @@CLI:      cli
  @@BLR:      ret     $00
//
@@EndLock:
              cmp     [ebx].TCodeData.IsWin9X, 1
              je      @@STI
              // if hLock<>0 then CloseHandle(hLock)
              mov     eax, [ebp].TCommon_Vars.hLock
              test    eax, eax
              jz      @@ELR
              push    eax
              call    dword ptr [ebx].TCodeData.CloseHandle
              jmp     @@ELR
  @@STI:      sti
  @@ELR:      ret     $00
//

(*
{$IFDEF LMD_DEBUGMESSAGES}
//
@@PrintDebug:
              cmp     [ebp].TCommon_Vars.C, 0
              je      @@PDR

    @@PD1:    cmp     eax, 1
              jne     @@PD2
              lea     eax, [ebx].TCodeData.b1
              jmp     @@PDC
    @@PD2:    cmp     eax, 2
              jne     @@PD3
              lea     eax, [ebx].TCodeData.b2
              jmp     @@PDC
    @@PD3:    cmp     eax, 3
              jne     @@PD4
              lea     eax, [ebx].TCodeData.b3
              jmp     @@PDC
    @@PD4:    cmp     eax, 4
              jne     @@PD5
              lea     eax, [ebx].TCodeData.e1
              jmp     @@PDC
    @@PD5:    cmp     eax, 5
              jne     @@PD6
              lea     eax, [ebx].TCodeData.e2
              jmp     @@PDC
    @@PD6:    cmp     eax, 6
              jne     @@PDR
              lea     eax, [ebx].TCodeData.e3

    @@PDC:    push    eax
              call    dword ptr [ebx].TCodeData.OutputDebugString
    @@PDR:    ret     $00
{$ENDIF IFDEF LMD_DEBUGMESSAGES}
*)

LB_CODE_DATA:
{--------------------------------------------------------------------------------------------------}
(*
{$IFDEF DEBUG_TEMPLATE}
  // cache of winapi addresses:
@@SendMessage:
              dw      0,0
@@GetCurrentProcess:
              dw      0,0
@@FlushInstructionCache:
              dw      0,0
@@CreateMutex:
              dw      0,0
@@WaitForSingleObject:
              dw      0,0
@@CloseHandle:
              dw      0,0
@@Sleep:
              dw      0,0
{$IFDEF LMD_DEBUGMESSAGES}
@@OutputDebugString:
              dw      0,0
@@b1:
              db      'hook:b-1',0
@@b2:
              db      'hook:b-2',0
@@b3:
              db      'hook:b-3',0
@@e1:
              db      'hook:e-1',0
@@e2:
              db      'hook:e-2',0
@@e3:
              db      'hook:e-3',0
{$ENDIF IFDEF LMD_DEBUGMESSAGES}

  // cache of addresses:
@@SetScrollRange:
              dw      0,0
@@NewSetScrollRange:
              dw      0,0
@@SetScrollPos:
              dw      0,0
@@NewSetScrollPos:
              dw      0,0
@@SetScrollInfo:
              dw      0,0
@@NewSetScrollInfo:
              dw      0,0
  // cache of dynamic constants:
@@WM_ELSCROLLBAR:
              dw      0,0
@@IsWin9X:
              dw      0,0
@@IsHookImpExp:
              dw      0,0
  // cache first instructions
@@jiSetScrollInfo:
              dw      0,0
              dw      0,0
@@jiSetScrollRange:
              dw      0,0
              dw      0,0
@@jiSetScrollPos:
              dw      0,0
              dw      0,0
  // lock data:
@@LockID:
              db      'HookApi:{7DDF4ADB-4A01-4F4B-83AA-8D91C21E99D2}:123456789012345:Lock',$0 //= 'HookApi:'+ID_WM_ELSCROLLBAR+':'+DWordToStr(GetCurrentProcessID()):Lock
  // is installed flag
@@Installed:
              dw      0,0
{$ENDIF IFDEF DEBUG_TEMPLATE}
*)

LB_CODE_END:
end;
end;

var
  bSystemScrollBarHooked: Boolean = False;

(*
type
  TByteArray = array[0..10000]of Byte;
  PByteArray = ^TByteArray;
  TCharArray = array[0..10000]of Char;
  PCharArray = ^TCharArray;
  TWordArray = array[0..10000]of Word;
  PWordArray = ^TWordArray;
  Ptr = Pointer;
  TPtrArray = array[0..10000]of Ptr;
  PPtrArray = ^TPtrArray;
*)

function SystemScrollBarHooked:Boolean;
begin
  Result := bSystemScrollBarHooked;
end;

procedure Install;
var
  SharedCodeID: String;
  LockID: String;
  hLock: THandle;
  hSharedMem: THandle;
  bFirstAllocate: Boolean;

  codeData: PCodeData;
  codeSize: DWORD;

  (*
  {$IFDEF DEBUG_TEMPLATE}
  dataOffset: DWORD;
  {$ENDIF}
  *)

  h:THandle;

  NewSetScrollRange: Pointer;
  NewSetScrollInfo: Pointer;
  NewSetScrollPos: Pointer;

  hBufETA :array[0..2]of Pointer;
  hBufNew :array[0..2]of Pointer;
  hBufStr :array[0..2]of String;
  hBufJmp :array[0..2]of PJumpInstruction;
  iB: Integer;

  Ptr: Pointer;
  ModuleList: TLMDObjectList;
  i: Integer;
begin
  (*
  {$IFDEF DEBUG_TEMPLATE}
    if Win32Platform <> VER_PLATFORM_WIN32_NT then
      exit;
  {$ENDIF IFDEF DEBUG_TEMPLATE}
  *)

  try
    // create shared code:
    if Win32Platform = VER_PLATFORM_WIN32_NT then
         // process lock:
      SharedCodeID := 'HookApi:'+ID_WM_ELSCROLLBAR+':' + DWordToStr(GetCurrentProcessID())
    else // global system lock:
      SharedCodeID := 'HookApi:'+ID_WM_ELSCROLLBAR;
    ModuleList := nil;
    hSharedMem := 0;
    LockID :=SharedCodeID+':Lock';
    BeginLock(LockID, hLock);
    try
      NewSetScrollInfo := HookApi_CreateCodeTemplate(
        @SBHandlersTemplates,
        SizeOf(TCodeData),(*{$IFDEF DEBUG_TEMPLATE}-SizeOf(TCodeData){$ENDIF}*)
        SharedCodeID,
        hSharedMem,
        bFirstAllocate,
        Pointer(codeData),
        codeSize);

      if hSharedMem=0 then
        exit;

      if (not bFirstAllocate) then
      begin
        if codeData.Installed = 1 then
        begin

          bSystemScrollBarHooked := True;

          // synchronize
          if ((not bHookImpExp) and (codeData.IsHookImpExp=1)) then
            bHookImpExp:=True;

        end;
        UnmapViewOfFile(NewSetScrollInfo);
        exit;
      end;

      // Calculate address of NewSetScrollRange, NewSetScrollPos:
      NewSetScrollRange := NewSetScrollInfo;
      asm
        mov   eax, ci_NewSetScrollRange_offset
        call  SBHandlersTemplates
        add   NewSetScrollRange, eax
      end;
      NewSetScrollPos := NewSetScrollInfo;
      asm
        mov   eax, ci_NewSetScrollPos_offset
        call  SBHandlersTemplates
        add   NewSetScrollPos, eax
      end;

      // INIT CODE DATA:

      if not UnprotectMemory( codeData,  SizeOf(TCodeData), PAGE_EXECUTE_READWRITE ) then
      begin
        UnmapViewOfFile(NewSetScrollInfo);
        exit;
      end;
      codeData.Installed := 0;
      codeData.WM_ELSCROLLBAR := WM_ELSCROLLBAR;

      if (Win32Platform = VER_PLATFORM_WIN32_NT) then
        codeData.IsWin9X := 0
      else
        codeData.IsWin9X := 1;

      if not bHookImpExp then
        codeData.IsHookImpExp := 0
      else
        codeData.IsHookImpExp := 1;

      StrCopy(codeData.LockID, PChar(LockID));

      h := GetModuleHandle(kernel32);
      codeData.GetCurrentProcess := GetProcAddressETA(h, 'GetCurrentProcess' );
      codeData.FlushInstructionCache := GetProcAddressETA(h, 'FlushInstructionCache' );
      {$ifdef LMD_NATIVEUNICODE}
      codeData.CreateMutex := GetProcAddressETA(h, 'CreateMutexW' );
      {$else}
      codeData.CreateMutex := GetProcAddressETA(h, 'CreateMutexA' );
      {$endif}
      codeData.WaitForSingleObject := GetProcAddressETA(h, 'WaitForSingleObject' );
      codeData.CloseHandle := GetProcAddressETA(h, 'CloseHandle' );
      codeData.Sleep := GetProcAddressETA(h, 'Sleep' );

      h := GetModuleHandle(user32);
      codeData.SendMessage := GetProcAddressETA(h, 'SendMessageA' );
      codeData.SetScrollInfo := GetProcAddressETA(h, 'SetScrollInfo' );
      codeData.SetScrollRange := GetProcAddressETA(h, 'SetScrollRange' );
      codeData.SetScrollPos := GetProcAddressETA(h, 'SetScrollPos' );

      codeData.NewSetScrollInfo := NewSetScrollInfo;
      codeData.NewSetScrollRange := NewSetScrollRange;
      codeData.NewSetScrollPos := NewSetScrollPos;

      if // check pointers
         (codeData.WM_ELSCROLLBAR=0)or
         (codeData.SendMessage=nil)or(codeData.GetCurrentProcess=nil)or
         (codeData.FlushInstructionCache=nil)or(codeData.CreateMutex=nil)or
         (codeData.WaitForSingleObject=nil)or(codeData.CloseHandle=nil)or
         (codeData.Sleep=nil)or
         (codeData.SetScrollInfo=nil)or(codeData.SetScrollRange=nil)or(codeData.SetScrollPos=nil)or
         (NewSetScrollInfo=nil)or(NewSetScrollRange=nil)or(NewSetScrollPos=nil)
      then
      begin
        UnmapViewOfFile(NewSetScrollInfo);
        exit;
      end;
      if not HookApi_LockCodeTemplate(hSharedMem, bFirstAllocate) then
      begin
        UnmapViewOfFile(NewSetScrollInfo);
        exit;
      end;

      GlobalNewSetScrollInfo := NewSetScrollInfo;

      // SET HOKs:

      hBufStr[0] := 'SetScrollInfo';
      hBufETA[0] := codeData.SetScrollInfo;
      hBufNew[0] := NewSetScrollInfo;
      hBufJmp[0] := @codeData.jiSetScrollInfo;

      hBufStr[1] := 'SetScrollRange';
      hBufETA[1] := codeData.SetScrollRange;
      hBufNew[1] := NewSetScrollRange;
      hBufJmp[1] := @codeData.jiSetScrollRange;

      hBufStr[2] := 'SetScrollPos';
      hBufETA[2] := codeData.SetScrollPos;
      hBufNew[2] := NewSetScrollPos;
      hBufJmp[2] := @codeData.jiSetScrollPos;

      if not bHookImpExp then
      begin
        // PATCH CODE:

        for iB:=0 to High(hBufNew) do
        begin
          Ptr := GetProcAddressETA(h, hBufStr[iB] );
          if (Ptr = nil) {or (Ptr=hBufNew[iB])}
             or (not UnprotectMemory(Ptr, SizeOf(TJumpInstruction), PAGE_EXECUTE_READWRITE))
          then
            exit;
          _JumpFromCode(Ptr, hBufNew[iB], hBufJmp[iB]);

          //LMDDebug( PChar('Code Hook: @'+user32+':'+hBufStr[iB]) );

        end;

      end
      else
      begin
        // PATH IMPORT EXPORT TABLES:

        ModuleList := TLMDObjectList.Create;
        ModuleList.AutoClearObjects := true;
        FillModuleList(GetCurrentProcessId(), ModuleList);
        for iB:=0 to High(hBufNew) do
          if (hBufETA[iB] <> hBufNew[iB]) then // in Win9X hook is global in system
          begin
          // import tables:
            for i:=0 to ModuleList.Count-1 do
            begin

        (*
              LMDDebug(
                PChar('  begin hook Import: @'+
                TModuleInformation(ModuleList.Items[i]).ModuleName+':'+user32+':'+hBufStr[iB]) );
        *)

              if HookImportTableApiFunction(
                TModuleInformation(ModuleList.Items[i]).hModule,
                user32, hBufStr[iB],
                hBufNew[iB]
                )<> nil then
              begin
                // Import Table hooked for module: TModuleInformation(ModuleList.Items[i]).ModuleName

    (*
                LMDDebug(
                  PChar( 'Hook Import: @'+
                  TModuleInformation(ModuleList.Items[i]).ModuleName+':'+user32+':'+hBufStr[iB]) );
    *)

              end;
            end;
            // export table:

      //LMDDebug( PChar('  begin hook Export: @'+user32+':'+hBufStr[iB]) );

            if not SetProcAddressETA(h, hBufStr[iB], hBufNew[iB]) then
              exit;

            //LMDDebug( PChar('Export Hook: @'+user32+':'+hBufStr[iB]) );

          end;
          //of: for iB:=0 to Low(hBufNew)

      end;//of: if not bHookImpExp

      codeData.Installed := 1;
      bSystemScrollBarHooked := True;

    finally
      if hSharedMem<>0 then
        CloseHandle(hSharedMem);
      if ModuleList <> nil then
        ModuleList.AutoClearObjects := true;
      ModuleList.Free;
      EndLock(hLock);

      //LMDDebug( PChar('SystemScrollBarHooked= '+IntToStr(Byte(bSystemScrollBarHooked))) );

    end;
  except
    on e:exception do
    begin
      LMDDebug( PChar('##1: Install Hook Error (ScrollBars): '+e.Message) );
    end;
  end;
end;

procedure Uninstall;
begin
{$ifdef LMDCOMP10}
{  if GlobalNewSetScrollInfo <> nil then
    UnmapViewOfFile(GlobalNewSetScrollInfo);}
{$endif}
end;

initialization
//  LMDLog.SendString('ParamStr', ParamStr(0));
//  LMDLog.SendInteger('Instance', HInstance);
//  LMDLog.SendInteger('Model bpl handle', GetModuleHandle('lmdelcore7rt_110.bpl'));
//  bHookImpExp := {$IFDEF LMDCOMP12}True;{$ELSE}Win32Platform <> VER_PLATFORM_WIN32_NT;{$ENDIF}
  if (LowerCase(ExtractFileName(ParamStr(0))) = 'bds.exe') then
    bHookImpExp := True
  else
    bHookImpExp := Win32Platform <> VER_PLATFORM_WIN32_NT;

  if (Win32Platform = VER_PLATFORM_WIN32_NT) and isLibrary or ModuleIsLib or ModuleIsPackage then
  begin
    if DisableThreadLibraryCalls(hInstance) then
    //LMDDebug( PChar('DisableThreadLibraryCalls=True') )
    ;
  end;
  WM_ELSCROLLBAR := RegisterWindowMessage(PChar(ID_WM_ELSCROLLBAR));
{$IFNDEF LMD_PROFILING}
  Install;
{$ENDIF}
finalization
{$IFNDEF LMD_PROFILING}
  Uninstall;
{$ENDIF}
{$else}
function SystemScrollBarHooked:Boolean;
begin
  Result := false;
end;

function IsHookImpExp:Boolean;
begin
  Result := false;
end;
{$endif}

end.
