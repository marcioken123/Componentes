unit LMDBand;
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

LMDBand unit (VO)
-----------------

TLMDExtParser uses TLMDTokenBand for the storing parsed tokens 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes,
  LMDLex;

type

  { ******************************* TLMDTokenBand **************************** }
  TLMDTokenBand = class
  private
    FList       : TList;
    FCursor     : LongInt;
    function GetCurrent : TLMDToken;
    function GetItem(Index : LongInt) : TLMDToken;
  public
    constructor Create;
    destructor Destroy; override;
    function Eof : boolean;
    function Bof : boolean;
    procedure Clear;
    procedure Add(aToken : TLMDToken);
    procedure Insert(aToken : TLMDToken);
    procedure Remove;
    procedure Next;
    procedure Prev;
    procedure First;
    procedure Last;
    property Current : TLMDToken read GetCurrent;
    property Pos : LongInt read FCursor write FCursor;
    property Item[Index : LongInt] : TLMDToken read GetItem; default;
  end;

implementation

{ ********************************* TLMDTokenBand **************************** }
{------------------------------------------------------------------------------}

function TLMDTokenBand.GetCurrent : TLMDToken;
begin
  result := nil;
  if FCursor < 0 then Exit;
  result := TLMDToken(FList[FCursor]);
end;

{ ********************************* PUBLIC *********************************** }

constructor TLMDTokenBand.Create;
begin
  inherited;
  FList := TList.create;
  FCursor := -1;
end;

{------------------------------------------------------------------------------}

destructor TLMDTokenBand.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDTokenBand.Eof : boolean;
begin result := (FCursor = -2) end;

{------------------------------------------------------------------------------}

function TLMDTokenBand.Bof : boolean;
begin result := (FCursor = -1) end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.Clear;
var
  I : LongInt;
begin
  for I := 0 to FList.count-1 do
    if assigned(FList[I]) then
      TLMDToken(FList[I]).Free;
  FList.Clear;
  FCursor := -1;
end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.Add(aToken : TLMDToken);
begin if assigned(aToken) then FList.Add(aToken) end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.Insert(aToken : TLMDToken);
begin
  if assigned(aToken) then
    begin
      if FCursor = -1 then FList.Insert(0, aToken)
      else if FCursor = -2 then
        begin
          FList.Add(aToken);
          FCursor := FList.Count - 1;
        end
      else FList.Insert(FCursor, aToken);
    end;
end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.Remove;
begin
  if (FCursor >= 0) and (FCursor < FList.count) then
    FCursor := FList.Remove(FList[FCursor])
  else
    FCursor := -2;
  if (FCursor >= FList.count) then
      FCursor := -2;
end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.Next;
begin
  if FList.count = 0 then Exit;
  if FCursor = -2 then Exit;
  if FCursor < FList.count-1 then inc(FCursor)
  else FCursor := -2;
end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.Prev;
begin
  if FList.count = 0 then Exit;
  if FCursor = -1 then Exit;
  if FCursor = -2 then FCursor := FList.count-1
  else Dec(FCursor);
end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.First;
begin
  if FList.count = 0 then Exit;
  FCursor := 0
end;

{------------------------------------------------------------------------------}

procedure TLMDTokenBand.Last;
begin
  if FList.count = 0 then Exit;
  FCursor := FList.count-1
end;

{------------------------------------------------------------------------------}

function TLMDTokenBand.GetItem(Index : LongInt) : TLMDToken;
begin
  result := nil;
  if (Index >= 0) and (Index < FList.Count) then
    Result := TLMDToken(FList[Index]);
end;

end.
