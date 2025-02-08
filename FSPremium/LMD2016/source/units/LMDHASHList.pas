unit LMDHASHList;
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

LMDHASHList unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows
  ;

const
  {$IFDEF BIG_HASH}
  HASHTABLE_SIZE = $FFFF;
  {$ELSE}
  HASHTABLE_SIZE = $7FF;
  {$ENDIF}
type

  TLMDHashItem = packed record
    Name: string;
    pObj: TObject;
  end;

  TLMDHashItems = array of TLMDHashItem;

  TLMDHashArray = array[0..HASHTABLE_SIZE] of TLMDHashItems;

  PHashArray = ^TLMDHashArray;

  TLMDHashStringList = class
  private

    FHashHandle: THandle;
    FHashTable: PHashArray;

    function GetCount: Integer;
    function InternalIndexOf(const Str: string; const Items: TLMDHashItems): Integer;
    function InternalIndexOfObject(pObj: TObject; const Items: TLMDHashItems):
      Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddObject(const Str: string; Obj: TObject);
    function FindObject(const Str: string; var Obj: TObject): Integer;
    function GetObject(const Str: string): TObject;
    function IndexOf(const Str: string): Integer;
    function IndexOfObject(const Obj: TObject; var Hash: Word): Integer;
    procedure Delete(const Hash: Word; Index: Integer);
    class function GetHash(const Str: string): Word;

    property HashTable: PHashArray read FHashTable;
    property Count: Integer read GetCount;
  end;

implementation

function GetHashCode(const Buffer: PChar; Count: Integer): Word; assembler; overload;
asm
        MOV     ECX,EDX
        MOV     EDX,EAX
        XOR     EAX,EAX
@@1:    ROL     AX,5
        XOR     AL,[EDX]
        INC     EDX
        DEC     ECX
        JNE     @@1
        MOV     CX,HASHTABLE_SIZE
        AND     AX,CX
end;

function GetHashCode(const Str: string): Word; overload;
begin
  Result := GetHashCode(PChar(Str), Length(Str));
end;

{ TLMDHashStringList }

procedure TLMDHashStringList.AddObject(const Str: string; Obj: TObject);
var
  Hash: Word;
  iCount: DWORD;
begin
  Hash:= GetHash(Str);
  {$IFDEF THREADSAFE}
  Synchronizer.BeginWrite;
  try
    {$ENDIF}
    iCount:= Length(FHashTable[Hash]);
    SetLength(FHashTable[Hash], iCount + 1);
    with FHashTable[Hash][iCount] do
      begin
        Name:= Str;
        pObj:= Obj;
      end;
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndWrite;
  end;
  {$ENDIF}
end;

constructor TLMDHashStringList.Create;
begin
  inherited;

  FHashHandle:= GlobalAlloc(GPTR, sizeof(TLMDHashArray));
  FHashTable:= GlobalLock(FHashHandle);

end;

procedure TLMDHashStringList.Delete(const Hash: Word; Index: Integer);
var
  iMove, iCount: Integer;
begin
  {$IFDEF THREADSAFE}
  Synchronizer.BeginWrite;
  try
    {$ENDIF}
    if FHashTable[Hash] <> nil then
      begin
        iCount:= Length(FHashTable[Hash]);
        if (Index >= 0) and (Index < iCount) then
          begin
            iMove:= Index;
            while iMove < (iCount - 1) do
              begin
                FHashTable[Hash][iMove].Name:= FHashTable[Hash][iMove + 1].Name;
                FHashTable[Hash][iMove].pObj:= FHashTable[Hash][iMove + 1].pObj;
                Inc(iMove);
              end;
            FHashTable[Hash][iMove].Name:= '';
            SetLength(FHashTable[Hash], iCount - 1);
          end;
      end;
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndWrite;
  end;
  {$ENDIF}
end;

destructor TLMDHashStringList.Destroy;
var
  i: Integer;
begin
  for i:= 0 to HASHTABLE_SIZE do
    SetLength(FHashTable[i], 0);

  GlobalUnlock(FHashHandle);
  GlobalFree(FHashHandle);

  inherited;
end;

function TLMDHashStringList.FindObject(const Str: string;
  var Obj: TObject): Integer;
var
  Hash: Word;
begin
  Obj:= nil;
  Hash:= GetHash(Str);
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
    {$ENDIF}
    Result:= InternalIndexOf(Str, FHashTable[Hash]);
    if Result >= 0 then
      Obj:= FHashTable[Hash][Result].pObj;
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

function TLMDHashStringList.GetCount: Integer;
var
  i: Integer;
begin
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
    {$ENDIF}
    Result:= 0;
    for i:= 0 to HASHTABLE_SIZE do
      if Assigned(FHashTable[i])  then
        Result:= Result + Length(FHashTable[i]);
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

class function TLMDHashStringList.GetHash(const Str: string): Word;
begin
  Result:= LMDHASHList .GetHashCode(Str);
end;

function TLMDHashStringList.GetObject(const Str: string): TObject;
var
  Hash: Word;
  i: Integer;
begin
  Result:= nil;
  Hash:= GetHash(Str);
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
    {$ENDIF}
    i:= InternalIndexOf(Str, FHashTable[Hash]);
    if i >= 0 then
      Result:= FHashTable[Hash][i].pObj;
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

function TLMDHashStringList.IndexOf(const Str: string): Integer;
var
  Hash: Word;
begin
  Hash:= GetHash(Str);
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
    {$ENDIF}
//    if FHashTable[Hash] = nil then
//      Result:= -1
//    else
    Result:= InternalIndexOf(Str, FHashTable[Hash]);
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

function TLMDHashStringList.IndexOfObject(const Obj: TObject;
  var Hash: Word): Integer;
var
  i: Integer;
begin
//  Result:= -1;
  {$IFDEF THREADSAFE}
  Synchronizer.BeginRead;
  try
    {$ENDIF}
    Hash:= 0;
    for i:= 0 to HASHTABLE_SIZE do
//      if Assigned(FHashTable[i])  then
        begin
          Result:= InternalIndexOfObject(Obj, FHashTable[i]);
          if Result >= 0 then
            begin
              Hash:= i;
              break;
            end;
        end;
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndRead;
  end;
  {$ENDIF}
end;

function TLMDHashStringList.InternalIndexOf(const Str: string;
  const Items: TLMDHashItems): Integer;
var
  i: Integer;
begin
  Result:= -1;

  if  Assigned(Items) then
    for i:= Low(Items) to High(Items) do
      if Items[i].Name = Str then
        begin
          Result:= i;
          break;
        end;
end;

function TLMDHashStringList.InternalIndexOfObject(pObj: TObject;
  const Items: TLMDHashItems): Integer;
var
  i: Integer;
begin
  Result:= -1;

  if  Assigned(Items) then
    for i:= Low(Items) to High(Items) do
      if Items[i].pObj = pObj then
        begin
          Result:= i;
          break;
        end;
end;

end.
