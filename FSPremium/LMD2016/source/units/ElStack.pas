unit ElStack;

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

ElStack unit
------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
   Classes, SysUtils, LMDTypes, LMDProcs;

type
  EElStackError = class(exception)
  end;

type
  TElStack = class(TObject)
  private
    FList: PPointerList;
    FCount : Integer;
    FCapacity : Integer;
    function Get(index : integer) : TxListItem;
    procedure Put(index : integer; value : TxListItem);
    procedure Grow;
    procedure SetCapacity(NewCapacity : Integer);
    protected
    function GetLast: TxListItem;
  public
    destructor Destroy; override;
    procedure Clear;
    procedure ShiftUp(ACount: integer);
    procedure Push(value : TxListItem);
    function Pop : TxListItem;
    function Empty : boolean;
    property Capacity : integer read FCapacity write SetCapacity;
    property Items[Index : Integer] : TxListItem read Get write Put; default;
    property Count : integer read FCount;
    property Last: TxListItem read GetLast;
  end;

implementation

function TElStack.Empty : boolean;
begin
  result := Count = 0;
end;

function TElStack.Get(index : integer) : TxListItem;
begin
 result := FList^[index];
 end;

procedure TElStack.Put(index : integer; value : TxListItem);
begin
 FList^[index] := value;
 end;

destructor TElStack.Destroy;
begin
  //FreeMem(FList, FCapacity);
   FreeMem(FList); //???
  inherited Destroy;
end;

procedure TElStack.Grow;
var
  Delta : Integer;
begin
  if FCapacity > 64 then
    Delta := FCapacity div 4
  else if FCapacity > 8 then
    Delta := 16
  else
    Delta := 4;
  SetCapacity(FCapacity + Delta);
end;

procedure TElStack.SetCapacity(NewCapacity : Integer);
begin
  if (NewCapacity < FCount)
     or (NewCapacity > MaxListSize)
     then
    raise EElStackError.Create('Invalid ElStack capacity.');
  if NewCapacity <> FCapacity then
  begin
    ReallocMem(FList, NewCapacity * SizeOf(TxListItem));
    FCapacity := NewCapacity;
  end;
end;

procedure TElStack.Push(value : TxListItem);
begin
  if FCount = FCapacity then Grow;
  FList^[FCount] := value;
  Inc(FCount);
end;

function TElStack.Pop: TxListItem;
begin
  if FCount = 0 then raise EElStackError.Create('ElStack is empty.');
  result := FList^[FCount - 1];
  dec(FCount);
  if FCount < (FCapacity div 2) then SetCapacity(FCapacity div 2);
end;

procedure TElStack.Clear;
begin
  FCount := 0;
  SetCapacity(0);
end;

function TElStack.GetLast: TxListItem;
begin
  if FCount = 0 then raise EElStackError.Create('ElStack is empty.');
  Result := FList^[FCount - 1];
  end;

procedure TElStack.ShiftUp(ACount: integer);
begin
  if ACount > FCount then raise EElStackError.Create('Cannot shift ElStack');
  if FCount = 0 then raise EElStackError.Create('ElStack is empty.');
  Move(FList^[ACount], FList^, (FCount - ACount) * SizeOf(TxListItem));
  FCount := FCount - ACount;
  SetCapacity(FCount);
end;

end.
