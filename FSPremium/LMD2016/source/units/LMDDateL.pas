unit LMDDateL;
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

LMDDateL unit ()
----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses classes;

  {****************************************************************************}
  {----------------------TLMDDateListRecord------------------------------------}
type
  TLMDDateListRecord = record
    Datefg     : TDateTime;
    Date       : TDateTime;
    DateString : String[40];
    Active,
    Calculated : Boolean;
  End;

  PLMDDateListRecord = ^TLMDDateListRecord;

  TLMDDateList=class(TList)
  private
    function GetDate(Index: integer):TLMDDateListRecord;
  protected
    function Comp (Item1, Item2: TObject): Integer;
  public
    destructor Destroy; override;
    procedure DeleteDate (Index: Integer);
    procedure PutDate(Index: integer; const aValue: TLMDDateListRecord);
    procedure AddDate(const aValue: TLMDDateListRecord);
    procedure EditDate(Index: Integer; aValue : TLMDDateListRecord);
    procedure SortDates;

    procedure SaveToFile (const Filename : String);
    procedure LoadFromFile (const Filename : String);

    procedure SaveToStream (Stream : TStream);
    procedure LoadFromStream (Stream : TStream);

    property Dates[Index: integer]:TLMDDateListRecord read GetDate write PutDate;
  end;

implementation

uses

  LMDProcs,
  sysutils;

{************************ Object TLMDDateList *********************************}
{-------------------------- Private -------------------------------------------}
function TLMDDateList.GetDate(Index: integer): TLMDDateListRecord;
var
  temp : PLMDDateListRecord;

begin
  if Index > Count-1 then
    exit;
  temp := PLMDDateListRecord(Items[Index]);
  result.Date := temp.Date;
  result.DateString := temp.DateString;
  result.Calculated := temp.calculated;
  result.active := temp.active;
end;

{ ------------------------ protected ----------------------------------------- }
function TLMDDateList.Comp (Item1, Item2: TObject): Integer;
begin
  if PLMDDateListRecord(Item1).Date < PLMDDateListRecord(Item2).Date then
    result := -1
  else
    if PLMDDateListRecord(Item1).Date > PLMDDateListRecord(Item2).Date then
      result := 1
    else
      result := 0;
end;

{ ------------------------ public -------------------------------------------- }
procedure TLMDDateList.PutDate(Index: integer; const aValue: TLMDDateListRecord);
var
  temp : PLMDDateListRecord;
begin
  if Index>Count-1 then exit;

  temp := Items[Index];

  if  not Assigned(temp)  then
    New(temp);

  temp^ := aValue;
  Items[Index]:=temp;

end;

{------------------------------------------------------------------------------}

procedure TLMDDateList.AddDate(const aValue: TLMDDateListRecord);
var
  temp : PLMDDateListRecord;
begin
  New (temp);
  temp^ := aValue;
  Add(temp);
{  PutDate(Count-1,aValue);}
end;

{------------------------------------------------------------------------------}
procedure TLMDDateList.EditDate(Index: Integer; aValue : TLMDDateListRecord);
begin
//  Items[index]^ := aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDDateList.DeleteDate(index : Integer);
begin
  if (index >= Count) or (index < 0) then exit;

  Dispose (PLMDDateListRecord(Items[index]));

  Delete (index);
end;

{------------------------------------------------------------------------------}
procedure TLMDDateList.SortDates;
begin
//  Sort (Comp);
end;

{------------------------------------------------------------------------------}
procedure TLMDDateList.SaveToFile (const Filename : String);
var
  f : TFileStream;
begin
  f := TFileStream.Create (Filename, fmCreate);
  try
    SaveToStream (f);
  finally
    f.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDateList.LoadFromFile (const Filename : String);
var
  f : TFileStream;
begin
  f := TFileStream.Create (Filename, fmOpenRead);
  try
    LoadFromStream (f);
  finally
    f.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDateList.SaveToStream (Stream : TStream);
var
  i : Integer;
  vers : Byte;
begin
  vers := 1;
  Stream.Write (vers, 1);
  for i := 0 to Count-1 do

    Stream.WriteBuffer (PLMDDateListRecord(Items[I])^, SizeOf (TLMDDateListRecord));

end;

{------------------------------------------------------------------------------}
procedure TLMDDateList.LoadFromStream (Stream : TStream);
var
  td : TLMDDateListRecord;
  vers : Byte;
begin
  Stream.Read (vers, 1);
  while Stream.Position < Stream.Size do
    begin

      Stream.ReadBuffer (td, SizeOf (TLMDDateListRecord));

      AddDate (td);
    end;
end;

{------------------------------------------------------------------------------}
destructor TLMDDateList.Destroy;
var
  i : Integer;
begin
  for i := 0 to Count-1 do

    Dispose(PLMDDateListRecord(Items[I]));

  inherited Destroy;
end;

end.
