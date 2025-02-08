unit LMDThreads;
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

LMDThreads unit (AH)
-------------------

ToDo
----
* VCL.NET port
* Unicode support

Changes
-------

###############################################################################}

interface
uses
  Classes,
  SysUtils,
  Windows,
  intfLMDBase,
  LMDProcs,
  LMDUnicode,
  LMDTypes;

type

  {**************************** ILMDSyncroObject ******************************}
  ILMDSyncroObject = interface(IInterface)
    procedure GraspIt;
    procedure ReleaseIt;
  end;

  {**************************** TLMDHandledObject *****************************}
  TLMDHandledObject = class(TInterfacedObject)
  private
    FLastOSError: integer;
    FHandle: THandle;
  public
    function WaitFor(AWaitTime: Cardinal): TLMDWaitStatus;
    property LastOSError: integer read FLastOSError;
  end;

  {**************************** TLMDCriticalSection ***************************}
  TLMDCriticalSection = class(TInterfacedObject, ILMDSyncroObject)
  private
    FCriticalSection: TRTLCriticalSection;
  public
    constructor Create;
    destructor Destroy; override;
    function TryEnter: boolean;
    procedure GraspIt;
    procedure ReleaseIt;
    procedure Enter;
    procedure Leave;
  end;

  {**************************** TLMDEvent *************************************}
  TLMDEvent = class
  end;

  {**************************** TLMDMutex *************************************}
  TLMDMutex = class(TLMDHandledObject, ILMDSyncroObject)
  public
    constructor Create(ASecAttr: PSecurityAttributes; AInitialOwner: Boolean; AName: PLMDChar); overload;

    constructor Create(AInitialOwner: LongBool; AName: PLMDChar); overload;
    constructor Create(AInitialOwner: LongBool); overload;
    procedure GraspIt;
    procedure ReleaseIt;
  end;

  {**************************** TLMDSemaphore *********************************}
  TLMDSemaphore = class(TLMDHandledObject)
  public
    constructor Create(AInitCount, AMaxCount: integer);
    destructor Destroy; override;
    procedure ReleaseIt(AReleaseCount: integer);
  end;

  {**************************** TLMDThreadBuffer ******************************}
  // todo - replace THandle by TLMDSemaphore and TLMDMutex
  TLMDThreadBuffer = class
  private
    FBufInit: boolean;
    FBufSize: integer;
    FBuffer: PPointerList;
    FReadPoint: integer;
    FWritePoint: integer;
    FEntriesFree, FEntriesUsed: THandle;
    FCriticalMutex: THandle;
    FEntryCountFree, FEntryCountUsed: integer;
  protected
    procedure SetSize(AValue: integer);
    function ControlledWait(Semaphore: THandle): boolean;
    { Returns whether wait returned OK, or an error occurred }
  public
    procedure ResetState;
    destructor Destroy; override;
    function PutItem(AItem: TObject): boolean;
    function GetItem: TObject;
    function GetFreeSlots(var AFree: integer): boolean;
    function GetUsedSlots(var AUsed: integer): boolean;
    property Size: integer read FBufSize write SetSize;
  end;

implementation

const
  DefaultWaitTime = 1000;

{**************************** TLMDHandledObject *******************************}
{------------------------------ public ----------------------------------------}
function TLMDHandledObject.WaitFor(AWaitTime: Cardinal): TLMDWaitStatus;
begin
  Result := wsFailed;
  case WaitForSingleObject(FHandle, AWaitTime) of
  WAIT_ABANDONED:
    Result := wsAbandoned;
  WAIT_OBJECT_0:
    Result := wsSignaled;
  WAIT_TIMEOUT:
    Result := wsTimeout;
  WAIT_FAILED:
    begin
      FLastOSError := GetLastError();
      Result := wsFailed;
    end;
  end;
end;

{**************************** TLMDCriticalSection *****************************}
{------------------------------ public ----------------------------------------}
constructor TLMDCriticalSection.Create;
begin
  inherited;
  InitializeCriticalSection(FCriticalSection);
end;

{------------------------------------------------------------------------------}
destructor TLMDCriticalSection.Destroy;
begin
  DeleteCriticalSection(FCriticalSection);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCriticalSection.Enter;
begin
  GraspIt;
end;

{------------------------------------------------------------------------------}
procedure TLMDCriticalSection.GraspIt;
begin
  EnterCriticalSection(FCriticalSection);
end;

{------------------------------------------------------------------------------}
procedure TLMDCriticalSection.Leave;
begin
  ReleaseIt;
end;

{------------------------------------------------------------------------------}
procedure TLMDCriticalSection.ReleaseIt;
begin
  LeaveCriticalSection(FCriticalSection);
end;

{------------------------------------------------------------------------------}
function TLMDCriticalSection.TryEnter: boolean;
begin
  Result := TryEnterCriticalSection(FCriticalSection);
end;

{**************************** TLMDMutex ***************************************}
{------------------------------ public ----------------------------------------}

constructor TLMDMutex.Create(ASecAttr: PSecurityAttributes; AInitialOwner: Boolean; AName: PLMDChar);

begin
  inherited Create;
  {$ifdef LMD_UNICODE}
  FHandle := CreateMutexW(ASecAttr, AInitialOwner, int_RefW(AName));
  {$else}
  FHandle := CreateMutexA(ASecAttr, AInitialOwner, int_Ref(AName));
  {$endif LMD_UNICODE}
end;

{------------------------------------------------------------------------------}
constructor TLMDMutex.Create(AInitialOwner: LongBool; AName: PLMDChar);
begin
  Create(nil, AInitialOwner, AName);
end;

{------------------------------------------------------------------------------}
constructor TLMDMutex.Create(AInitialOwner: LongBool);
begin
  Create(AInitialOwner, nil);
end;

{$warnings off}
{------------------------------------------------------------------------------}
procedure TLMDMutex.GraspIt;
begin
  if WaitFor(INFINITE) = wsFailed then
    RaiseLastWin32Error;
end;

{------------------------------------------------------------------------------}
procedure TLMDMutex.ReleaseIt;
begin
  if not ReleaseMutex(FHandle) then
    RaiseLastWin32Error;
end;
{$warnings on}

{**************************** TLMDSemaphore ***********************************}
{------------------------------ protected -------------------------------------}
constructor TLMDSemaphore.Create(AInitCount, AMaxCount: integer);
begin
  inherited Create;
  FHandle := CreateSemaphore(nil, AInitCount, AMaxCount, int_Ref(''));
end;

{------------------------------------------------------------------------------}
destructor TLMDSemaphore.Destroy;
begin
  WaitFor(INFINITE);
  ReleaseIt(0);
  CloseHandle(FHandle);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSemaphore.ReleaseIt;
begin
  ReleaseSemaphore(FHandle, AReleaseCount, nil);
end;

{**************************** TLMDThreadBuffer ********************************}
{------------------------------ protected -------------------------------------}
procedure TLMDThreadBuffer.SetSize(AValue: integer);
begin
  if FBufInit then
    ResetState;

  if AValue < 2 then
    AValue := 2;

  FBufSize := AValue;
  GetMem(FBuffer, AValue * Sizeof(Pointer));
  FillMemory(FBuffer, Sizeof(Pointer) * AValue, 0);
  FCriticalMutex := CreateMutex(nil, false, int_Ref('')); { note lack of name }
  WaitForSingleObject(FCriticalMutex, INFINITE);
  FBufInit := true;
  { The initial count on the semaphores requires some thought,
    The maximum count requires more thought.
    Again, all synchronisation objects are anonymous }
  FEntriesFree := CreateSemaphore(nil, FBufSize - 1, FBufSize, int_Ref(''));
  FEntriesUsed := CreateSemaphore(nil, 0, FBufSize, int_Ref(''));

  FEntryCountFree := FBufSize - 1;
  FEntryCountUsed := 0;

  ReleaseMutex(FCriticalMutex);

  if (FCriticalMutex = 0) or (FEntriesFree = 0) or (FEntriesUsed = 0) then
    ResetState;
end;

{------------------------------------------------------------------------------}
function TLMDThreadBuffer.ControlledWait(Semaphore: THandle): boolean;
var
  ErrCode: integer;
begin
  repeat
    ErrCode := WaitForSingleObject(Semaphore, DefaultWaitTime);
    if (ErrCode = WAIT_OBJECT_0) or (ErrCode = WAIT_ABANDONED) then
    begin
      { If wait abandoned, return failure. Buffer not properly cleaned up }
      result := ErrCode = WAIT_OBJECT_0;
      exit;
    end;
    { Wait timed out. Check whether buffer state initialised }
    if WaitForSingleObject(FCriticalMutex, DefaultWaitTime) <> WAIT_OBJECT_0 then
    begin
      result := false;
      exit;
    end
    else
    begin
      Result := FBufInit;
      ReleaseMutex(FCriticalMutex);
    end;
  until not Result;
end;

{------------------------------ public ----------------------------------------}
destructor TLMDThreadBuffer.Destroy;
begin
  ResetState;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDThreadBuffer.GetItem: TObject;
begin
  result := nil;
  { WAIT(EntriesUsed) }
  if not ControlledWait(FEntriesUsed) then
    exit;

  if (WaitForSingleObject(FCriticalMutex, DefaultWaitTime) <> WAIT_OBJECT_0)
    or not FBufInit then { NB.This condition depends on L -> R lazy evaluation }
    exit;

  Result := FBuffer[FReadPoint];
  FReadPoint := (FReadPoint + 1) mod FBufSize;

  Inc(FEntryCountFree);
  Dec(FEntryCountUsed);
  ReleaseMutex(FCriticalMutex);
  { SIGNAL(EntriesFree) }
  ReleaseSemaphore(FEntriesFree, 1, nil);
end;

{------------------------------------------------------------------------------}
function TLMDThreadBuffer.GetFreeSlots(var AFree: integer): boolean;
begin
  Result := false;
  if (WaitForSingleObject(FCriticalMutex, DefaultWaitTime) <> WAIT_OBJECT_0) or not FBufInit then
    exit;
  AFree := FEntryCountFree;
  Result := true;
  ReleaseMutex(FCriticalMutex);
end;

{------------------------------------------------------------------------------}
function TLMDThreadBuffer.GetUsedSlots(var AUsed: integer): boolean;
begin
  result := false;
  if (WaitForSingleObject(FCriticalMutex, DefaultWaitTime) <> WAIT_OBJECT_0)
    or not FBufInit then
    exit;
  AUsed := FEntryCountUsed;
  result := true;
  ReleaseMutex(FCriticalMutex);
end;

{------------------------------------------------------------------------------}
function TLMDThreadBuffer.PutItem(AItem: TObject): boolean;
begin
  Result := false;
  { WAIT(EntriesFree) }
  if not ControlledWait(FEntriesFree) then
    exit;

  { NB.This condition depends on L -> R lazy evaluation }
  if (WaitForSingleObject(FCriticalMutex, DefaultWaitTime) <> WAIT_OBJECT_0) or not FBufInit then
    exit;

  FBuffer[FWritePoint] := AItem;

  FWritePoint := (FWritePoint + 1) mod FBufSize;
  Inc(FEntryCountUsed);
  Dec(FEntryCountFree);

  ReleaseMutex(FCriticalMutex);

  { SIGNAL(EntriesUsed) }
  ReleaseSemaphore(FEntriesUsed, 1, nil);
  result := true;
end;

{------------------------------------------------------------------------------}
procedure TLMDThreadBuffer.ResetState;
{ Closes handles and deallocates memory.
  Note that this must unblock threads in such a manner that they quit cleanly }
begin
  if FBufInit then
  begin
    WaitForSingleObject(FCriticalMutex, DefaultWaitTime);
    FBufInit := false;
    FBufSize := 0;

    FWritePoint := 0;
    FReadPoint := 0;

    FreeMem(FBuffer);
    ReleaseSemaphore(FEntriesUsed, 1, nil);
    ReleaseSemaphore(FEntriesFree, 1, nil);
    CloseHandle(FEntriesFree);
    CloseHandle(FEntriesUsed);
    ReleaseMutex(FCriticalMutex);
    CloseHandle(FCriticalMutex);
  end;
end;

end.
