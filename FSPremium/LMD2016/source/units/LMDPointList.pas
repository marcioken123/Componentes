unit LMDPointList;
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

LMDPointList unit ()
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes;

type
  {----------------------TLMDPointList-----------------------------------------}
  TLMDPointList=class(TList)
    private
      FOnChange : TNotifyEvent;
      FUpdateCount : Integer;
      function GetPoint(Index: integer):TPoint;
    protected
      procedure GetChange (Sender : TObject);
    public
      procedure BeginUpdate;
      procedure EndUpdate (change : boolean);
      procedure PutPoint(Index: integer; const aValue: TPoint);
      procedure AddPoint(const aValue: TPoint); overload;
      procedure AddPoint(X, Y: integer); overload;
      procedure DeletePoint (Index: Integer);
      procedure Clone (aValue : TLMDPointList);
      Property Points[Index: integer]:TPoint read GetPoint write PutPoint;
      property OnChange : TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

{ ------------------------- protected ---------------------------------------- }
procedure TLMDPointList.GetChange (Sender : TObject);
begin
  if FUpdateCount > 0 then exit;
  if assigned (FOnChange) then FOnChange(Sender);
end;

{-------------------------- Private -------------------------------------------}
function TLMDPointList.GetPoint(Index: integer):TPoint;
var
  temp:LongInt;
begin
  Result := Point(0, 0);
  if Index > Count-1 then
    exit;
  temp := LongInt(Items[Index]);
  // RM: MakeLong(wLow, wHigh)!!!!
  result.x := LoWord(temp);
  result.y := HiWord(temp);
end;

{------------------------------------------------------------------------------}
procedure TLMDPointList.PutPoint(Index: integer; const aValue: TPoint);
begin
  if Index>Count-1 then exit;
  Items[Index]:=TObject(MakeLong(aValue.x, aValue.y));
  GetChange (self);
end;

{------------------------------------------------------------------------------}
procedure TLMDPointList.AddPoint(const aValue: TPoint);
begin
  AddPoint(aValue.X, aValue.Y);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPointList.AddPoint(X, Y: integer);
begin
  Add(TObject(MakeLong(x, y)));
  GetChange (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPointList.DeletePoint (index : Integer);
begin
  Delete (index);
  GetChange (self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPointList.Clone (aValue : TLMDPointList);
var
  i : Integer;
begin
  if aValue = nil then exit;
  aValue.Clear;
  for i := 0 to Count - 1 do
    aValue.AddPoint (Points[i]);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPointList.BeginUpdate;
begin
  inc (FUpdateCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPointList.EndUpdate (change : boolean);
begin
  if FUpdateCount = 0 then exit;
  dec (FUpdateCount);
  if change then GetChange (self);
end;

end.
