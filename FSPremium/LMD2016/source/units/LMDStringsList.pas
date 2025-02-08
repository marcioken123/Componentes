unit LMDStringsList;
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

LMDStringsList unit (VO)
------------------------

Collection of TStringList 

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes;

type

  { ************************** TLMDStringsItem  ****************************** }
  TLMDStringsItem = class (TCollectionItem)
  private
    FStringList : TStringList;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Replace(const aSrc, aDect : string);
    property Strings : TStringList read FStringList;
  end;

  { ************************** TLMDStringsList ******************************* }
  TLMDStringsList = class (TCollection)
  private
    function GetItem(index : LongInt) : TLMDStringsItem;
  public
    constructor Create;
    function Add : TLMDStringsItem;
    function GetMaxSubItemsCount : LongInt;
    function GetMaxSubItemLength(aCol : LongInt) : LongInt;
    procedure Replace(const aSrc, aDect : string);
    property Item[index : LongInt] : TLMDStringsItem read GetItem;default;
  end;

implementation
uses
  SysUtils;

{ ************************** TLMDStringsItem ********************************* }
{------------------------------------------------------------------------------}
constructor TLMDStringsItem.Create(Collection: TCollection);
begin
  inherited;
  FStringList := TStringList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDStringsItem.Destroy;
begin
  FStringList.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsItem.Replace(const aSrc, aDect : string);
var
  I : LongInt;
begin
  for I := 0 to FStringList.Count-1 do
    FStringList[I] := StringReplace(FStringList[I], aSrc, aDect,[rfReplaceAll, rfIgnoreCase]);
end;

{ ************************** TLMDStringsList ********************************* }
{------------------------------------------------------------------------------}

function TLMDStringsList.GetItem(index : LongInt) : TLMDStringsItem;
begin
  result := TLMDStringsItem(inherited GetItem(index));
end;

{---------------------------- PUBLIC ------------------------------------------}
constructor TLMDStringsList.Create;
begin
  inherited Create(TLMDStringsItem);
end;

{------------------------------------------------------------------------------}
function TLMDStringsList.Add : TLMDStringsItem;
begin
  result := TLMDStringsItem(inherited Add);
end;

{------------------------------------------------------------------------------}
function TLMDStringsList.GetMaxSubItemsCount : LongInt;
var
  I : LongInt;
begin
  result := 0;
  for I := 0 to count-1 do
    if Item[I].Strings.Count > result then
      result := Item[I].Strings.Count;
end;

{------------------------------------------------------------------------------}
function TLMDStringsList.GetMaxSubItemLength(aCol : LongInt) : LongInt;
var
  I : LongInt;
begin
  result := 0;
  for I := 0 to Count-1 do
    if Item[I].Strings.Count > aCol then
      if Length(Item[I].Strings[aCol]) > result then
        result := Length(Item[I].Strings[aCol]);
end;

{------------------------------------------------------------------------------}
procedure TLMDStringsList.Replace(const aSrc, aDect : string);
var
  I : LongInt;
begin
  for I := 0 to Count-1 do
    Item[I].Replace(aSrc, aDect);
end;

end.
