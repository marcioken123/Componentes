unit LMDVariants;
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

LMDCustomPluginManager unit (AIH)
---------------------------------
Description
LMDVariants - list of variants

ToDo
----

Changes
-------

Release 0.1 (July 2008)
* Initial Release

###############################################################################}
interface

uses
  Classes;

type
  {******************************* LMDVariant *********************************}
  TLMDVariant = class(TObject)
  private
    FVariant: Variant;
  public
    constructor Create(AVariant: Variant);
    property VarData: Variant read FVariant write FVariant;
  end;

  {*************************** TLMDVariantLIst ********************************}
  TLMDVariantList = class(TObject)
  private
    FList: TList;
    function GetItem(Index: Integer): Variant;
    procedure SetItem(Index: Integer; AVariant: Variant);
    function GetCount: integer;
  public
    constructor Create();
    destructor Destroy(); override;
    procedure Add(AVariant: Variant);
    procedure Delete(Index: Integer);
    property Variants[Index: Integer]: Variant read GetItem write SetItem;
    property Count: integer read GetCount;
  end;

implementation

{********************************* LMDVariant *********************************}
{------------------------------------------------------------------------------}
constructor TLMDVariant.Create(AVariant: Variant);
begin
  FVariant := AVariant;
end;

{------------------------------------------------------------------------------}
function TLMDVariantList.GetItem(Index: Integer): Variant;
begin
  Result := TLMDVariant(FList.Items[Index]).VarData;
end;

{------------------------------------------------------------------------------}
procedure TLMDVariantList.SetItem(Index: Integer; AVariant: Variant);
begin
  TLMDVariant(FList.Items[Index]).VarData := AVariant;
end;

{------------------------------------------------------------------------------}
constructor TLMDVariantList.Create();
begin
  FList := TList.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDVariantList.Add(AVariant: Variant);
begin
  FList.Add(TLMDVariant.Create(AVariant))
end;

{------------------------------------------------------------------------------}
procedure TLMDVariantList.Delete(Index: Integer);
begin
  TLMDVariant(FList.Items[Index]).Free;
  FList.Delete(Index);
end;

{------------------------------------------------------------------------------}
destructor TLMDVariantList.Destroy();
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    TLMDVariant(FList.Items[i]).Free;
  FList.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDVariantList.GetCount: integer;
begin
  Result := FList.Count;
end;

end.
