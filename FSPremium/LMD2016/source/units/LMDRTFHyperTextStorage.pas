unit LMDRTFHyperTextStorage;
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

LMDRTFHyperTextStorage unit (RM)
--------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDRTFBase, LMDRTFStorage, LMDRTFHyperText, Windows, Classes, Controls;

type
  {************************* TLMDRichHyperTextStorageItem  ********************}
  TLMDRichHyperTextStorageItem = class(TLMDRichStorageItem)
  public
    procedure DoLinkClick(aSender: TObject; const aURLText: string; aButton: TMouseButton); override;
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  end;

  {************************* TLMDRichHyperTextStorageItems ********************}
  TLMDRichHyperTextStorage = class;
  TLMDRichHyperTextStorageItems = class(TLMDRichStorageItems)
  private
    function GetItemByName(const index:String):Integer;
  protected
    function GetItem(Index: Integer): TLMDRichHyperTextStorageItem;
    procedure SetItem(Index: Integer; const Value: TLMDRichHyperTextStorageItem);
    function GetStorage: TLMDRichHyperTextStorage;
    class function GetItemClass: TCollectionItemClass; override;
  public
    function Add: TLMDRichHyperTextStorageItem;
    property Items[Index: Integer]: TLMDRichHyperTextStorageItem read GetItem write SetItem; default;
    property ItemByName[const index:String]:Integer read GetItemByName;
    property Storage: TLMDRichHyperTextStorage read GetStorage;
  end;

  {***************************** TLMDRichHyperTextStorage  **********************}
  TLMDRichHyperTextStorage = class(TLMDRichStorage)
  private
    FHyperText: TLMDRichHyperText;
    function GetItems: TLMDRichHyperTextStorageItems;
    procedure SetItems(const Value: TLMDRichHyperTextStorageItems);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function GetNamedIndex(const aValue:String):Integer;
    property HyperText: TLMDRichHyperText read FHyperText;
  published
    property Items: TLMDRichHyperTextStorageItems read GetItems write SetItems;
  end;

implementation

uses
  SysUtils;

{ TLMDRichHyperTextStorageItem }
{------------------------------------------------------------------------------}
constructor TLMDRichHyperTextStorageItem.Create;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
destructor TLMDRichHyperTextStorageItem.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichHyperTextStorageItem.DoLinkClick(aSender: TObject;
  const aURLText: string; aButton: TMouseButton);
var
  B: Boolean;
  S: string;
begin
  if TLMDRichHyperTextStorageItems(Collection).Storage.HyperText.GetLinkParams(B, S) then
    if b then
      TLMDRichHyperTextStorageItems(Collection).Storage.HyperText.GoToBookMark(S);
//    else ;
  inherited;
end;

{ TLMDRichHyperTextStorage }
{------------------------------------------------------------------------------}
constructor TLMDRichHyperTextStorage.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FHyperText:= TLMDRichHyperText.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRichHyperTextStorage.Destroy;
begin
  if Assigned(FHyperText) then
    FHyperText.Free;
  if Assigned(FItems) then
    begin
      FItems.Clear;
      FreeAndNil(FItems);
    end;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDRichHyperTextStorage.GetNamedIndex(const aValue:String):Integer;
begin
  result := Items.ItemByName[aValue];
end;

{------------------------------------------------------------------------------}
function TLMDRichHyperTextStorage.GetItems: TLMDRichHyperTextStorageItems;
begin
  if not Assigned(FItems) then
    FItems:= TLMDRichHyperTextStorageItems.Create(self, TLMDRichHyperTextStorageItem);
  Result:= TLMDRichHyperTextStorageItems(FItems);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichHyperTextStorage.SetItems(const Value: TLMDRichHyperTextStorageItems);
begin
  inherited Items:= Value
end;

{ TLMDRichHyperTextStorageItems }
{------------------------------------------------------------------------------}
function TLMDRichHyperTextStorageItems.Add: TLMDRichHyperTextStorageItem;
begin
  Result:= TLMDRichHyperTextStorageItem(inherited Add)
end;

{------------------------------------------------------------------------------}
function TLMDRichHyperTextStorageItems.GetItem(Index: Integer): TLMDRichHyperTextStorageItem;
begin
  Result:= TLMDRichHyperTextStorageItem(inherited GetItem(Index))
end;

{------------------------------------------------------------------------------}
class function TLMDRichHyperTextStorageItems.GetItemClass: TCollectionItemClass;
begin
  Result:= TLMDRichHyperTextStorageItem
end;

{------------------------------------------------------------------------------}
function TLMDRichHyperTextStorageItems.GetStorage: TLMDRichHyperTextStorage;
begin
  Result:= TLMDRichHyperTextStorage(inherited Storage);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichHyperTextStorageItems.SetItem(Index: Integer; const Value: TLMDRichHyperTextStorageItem);
begin
  inherited SetItem(Index, Value)
end;

{------------------------------------------------------------------------------}
function TLMDRichHyperTextStorageItems.GetItemByName(const index:String):Integer;
var
  i:Integer;
begin
  result:=-1;
  for i:=0 to Count-1 do
    begin
       if Items[i].name=index then
         begin
           result:=i;
           break;
         end
    end;
end;

end.
