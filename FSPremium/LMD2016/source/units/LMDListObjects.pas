unit LMDListObjects;
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

LMDListObjects unit (VO)
------------------------

TLMDDTD used for description of HTLM elements 

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
  { ******************************* TLMDListObjects  ************************** }
  TLMDListObjects = class(TObject)
  private
  protected
    FItems: TList;
    procedure SetItems(Ind: integer; Value: TObject); virtual;
    function  GetItems(Ind: integer): TObject; virtual;
    procedure Utilize(Obj: TObject); virtual;
  public
    constructor Create;
    destructor  Destroy; override;
    procedure Clear;
    procedure Remove(Obj: TObject);
    function  Count: integer;
    function  Add(Obj: TObject): integer;
    function  RemoveLast: TObject;
    property  Items[Ind: integer]: TObject read GetItems write SetItems; default;
  end;

implementation

constructor TLMDListObjects.Create;
begin
  inherited Create;
  FItems := nil;
end;

destructor  TLMDListObjects.Destroy;
begin
  Clear;
  inherited ;
end;

procedure TLMDListObjects.Clear;
var
  i: integer;
  Obj: TObject;
begin
  if  Assigned(FItems)  then
    begin
      for i := FItems.Count - 1 downto 0 do
        begin
          Obj := FItems[i];

          if Assigned(Obj)  then
            begin
              FItems[i] := nil;
              Utilize(Obj);
            end;
        end;

      FItems.Free;
      FItems := nil;
    end;
end;

function  TLMDListObjects.Count: integer;
begin
  if  Assigned(FItems)  then
    Result := FItems.Count
  else
    Result := 0;
end;

function  TLMDListObjects.Add(Obj: TObject): integer;
begin
  if  not Assigned(FItems) then
    FItems := TList.Create;

  Result := FItems.Add(Obj);
end;

procedure TLMDListObjects.SetItems(Ind: integer; Value: TObject);
var
  Obj: TObject;
begin
  Obj := FItems[Ind];

  if  Assigned(Obj) then
    Utilize(Obj);

  FItems[Ind] := Value;
end;

function  TLMDListObjects.GetItems(Ind: integer): TObject;
begin
  Result := FItems[Ind];
end;

procedure TLMDListObjects.Utilize(Obj: TObject);
begin
  Obj.Free;
end;

procedure TLMDListObjects.Remove(Obj: TObject);
begin
  if  Assigned(FItems)  then
    FItems.Remove(Obj);
end;

function  TLMDListObjects.RemoveLast: TObject;
var
  i: integer;
begin
  Result := nil;
  i := Count - 1;

  if  i >= 0 then
    begin
      Result := FItems[i];
      FItems.Delete(i);
    end;
end;

end.
