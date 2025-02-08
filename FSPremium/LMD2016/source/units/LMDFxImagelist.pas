unit LMDFxImageList;
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

LMDFxEffect unit (RM, AH)
------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  SysUtils, Classes, LMDFxEffect, LMDFxAnimation, LMDFxBase;

type

  TLMDFxImageList = class;

  {************************ TLMDFxChangeLink  *********************************}
  TLMDFxChangeLink = class
  private
    FSender:TLMDFxImageList;
    FOnChange:TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TLMDFxImageList read FSender write FSender;
  end;

  { ************************ class TLMDFxImageItem *************************** }
  TLMDFxImageItem = class(TCollectionItem)
  private
    FPicture: TPicture;
    FTag: integer;
    procedure SetPicture(Value: TPicture);
  protected
    function GetDisplayName: string; override;
    procedure OnChange(Sender: TObject);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Picture: TPicture read FPicture write SetPicture;
    property Index;
    property Tag: integer read FTag write FTag;
  end;

  { ************************ class TLMDFxImageCollection ********************* }
  TLMDFxImageCollection = class(TCollection)
  private
    FImageList: TLMDFxImageList;
    function GetItem(Index: Integer): TLMDFxImageItem;
    procedure SetItem(Index: Integer; Value: TLMDFxImageItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(ImageList: TLMDFxImageList);
    function Add: TLMDFxImageItem;
    property Items[Index: Integer]: TLMDFxImageItem read GetItem write SetItem; default;
  end;

  { ************************ class TLMDFxImageList *************************** }
  TLMDFxImageList = class(TLMDFxComponent)
  private
    FImages: TLMDFxImageCollection;
    FClients:TList;
  protected
    procedure Change; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IsValidItem(index:Integer):Boolean;
    procedure RegisterChanges(aValue: TLMDFxChangeLink);
    procedure UnRegisterChanges(aValue: TLMDFxChangeLink);

  published
    property Images: TLMDFxImageCollection read FImages write FImages;
    //property OnChange;
  end;

implementation

{*********************** TLMDChangeLink ***************************************}
{------------------------------------------------------------------------------}
destructor TLMDFxChangeLink.Destroy;
begin
  if Sender <> nil then
    Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFxChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender)
end;

{ ************************ class TLMDFxImageItem ***************************** }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxImageItem.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDFxImageItem.GetDisplayName: string;
begin
  Result := inherited GetDisplayName;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImageItem.OnChange(Sender: TObject);
begin
  TLMDFxImageCollection(Collection).FImageList.Change;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxImageItem.Create(Collection: TCollection);
begin
  FPicture := TPicture.Create;
  FPicture.OnChange := OnChange;
  inherited;
  end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFxImageItem.Destroy;
begin
  OnChange(Self);
  FPicture.OnChange := nil;
  FPicture.Free;
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImageItem.Assign(Source: TPersistent);
begin
   if (Source is TLMDFxImageItem) then
     FPicture.Assign(TLMDFxImageItem(Source).FPicture);
  inherited Assign(Source);
end;

{ ************************ class TLMDFxImageCollection *********************** }
{ ------------------------------ private ------------------------------------- }
function TLMDFxImageCollection.GetItem(Index: Integer): TLMDFxImageItem;
begin
  Result := TLMDFxImageItem(inherited GetItem(Index));
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxImageCollection.SetItem(Index: Integer; Value: TLMDFxImageItem);
begin
  inherited SetItem(Index, Value);
end;

{ ------------------------------ protected ----------------------------------- }
function TLMDFxImageCollection.GetOwner: TPersistent;
begin
  Result := FImageList;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxImageCollection.Update(Item: TCollectionItem);
begin
  inherited Update(Item);
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxImageCollection.Create(ImageList: TLMDFxImageList);
begin
  inherited Create(TLMDFxImageItem);
  FImageList := ImageList;
end;

{ -----------------------------------------------------------------------------}
function TLMDFxImageCollection.Add: TLMDFxImageItem;
begin
  Result := TLMDFxImageItem(inherited Add);
end;

{ ************************ class TLMDFxImageList ***************************** }
{ ------------------------------ protected ----------------------------------- }
procedure TLMDFxImageList.Change;
var
  i:Integer;
begin
  if ([csLoading, csDestroying]*ComponentState<>[]) then Exit;
  for i:=0 to FClients.Count-1 do
    TLMDFxChangeLink(FClients[i]).Change;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxImageList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FImages := TLMDFxImageCollection.Create(Self);
  FClients:= TList.Create;
end;

{ -----------------------------------------------------------------------------}
destructor TLMDFxImageList.Destroy;
begin
  while FClients.Count > 0 do
    UnRegisterChanges(TLMDFxChangeLink(FClients.Last));
  FreeAndNil(FClients);
  FImages.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDFxImageList.IsValidItem(index: Integer): Boolean;
begin
  result:=(Index>-1) and (index<FImages.Count);
end;

{------------------------------------------------------------------------------}
procedure TLMDFxImageList.RegisterChanges(aValue: TLMDFxChangeLink);
begin
  if not Assigned(aValue) then exit;
  aValue.Sender:= Self;
  FClients.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFxImageList.UnRegisterChanges(aValue: TLMDFxChangeLink);
var
  i: Integer;
begin
  if FClients<>nil then
    for i:= 0 to FClients.Count - 1 do
      if FClients[I] = aValue then
        begin
          aValue.Sender:= nil;
          FClients.Delete(I);
          Break;
        end;
end;
end.
