unit ElFormContainer;
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

ElFormContainer unit
--------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  ElComponent,

  SysUtils,
  Types,
  Forms,
  ElHTMLContainer;

type

  TElFormContainer = class;

  {*************************** TElFormContainerChangeLink  ********************}
  TElFormContainerChangeLink = class
  private
    FSender:TElFormContainer;
    FOnChange:TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TElFormContainer read FSender write FSender;
  end;

  {*************************** TElFormListItem  *******************************}
  TElFormListItem = class(TCollectionItem)
  private
    FFormName: string;
    FHTMLContainerIndex: integer;
    FFormClassName: string;
    FFormClass: TFormClass;
    FForm: TCustomForm;
    FTag: integer;
    FWidth:  integer;
    FHeight: integer;
    procedure SetFormExt(const Value: TCustomForm);
    procedure SetFormClassName(const Value: string);
  protected
    function GetDisplayName: string; override;
  public
    procedure Assign(Source : TPersistent); override;
    constructor Create(Collection : TCollection); override;
    destructor Destroy; override;
    procedure LoadFromStream(Stream : TStream);
    procedure SaveToStream(Stream : TStream);
    property Form : TCustomForm read FForm write SetFormExt;
    //these are used to restore form size when position switches from
    //fdpClient to anything else
    property Width: integer read FWidth write FWidth;
    property Height: integer read FHeight write FHeight;
  published
    property Tag: Integer read FTag write FTag;
    property FormName: string read FFormName write FFormName;
    property FormClassName : string read FFormClassName write SetFormClassName;
    property HTMLContainerIndex: integer read FHTMLContainerIndex write
      FHTMLContainerIndex;
    property Index;
  end;

  {*************************** TElFormList  ***********************************}
  TElFormList = class(TCollection)
  private
    FOwner : TPersistent;
    function GetItems(Index : integer) : TElFormListItem;
    procedure SetItems(Index : integer; newValue : TElFormListItem);
  protected
    function GetOwner : TPersistent; override;
  public
    constructor Create(AOwner : TComponent);
    function Add : TElFormListItem;
    procedure SaveToStream(Stream : TStream);
    procedure LoadFromStream(Stream : TStream);
    function IndexOf(Form: TCustomForm):integer; overload;
    function IndexOf(FormClass: TFormClass):integer; overload;
    function IndexOf(FormName: string):integer; overload;
    property Items[Index : integer] : TElFormListItem read GetItems write SetItems; default;
  end;

  {*************************** TElFormContainer *******************************}
  TElFormContainer = class(TElComponent)
  private
    // HTML Container support
    FHTMLContainer:TElHTMLContainer;
    FHTMLChangeLink:TElHTMLChangeLink;
    FCheckHTMLContainer:Boolean;
    // ---

    FClients: TList;
    FFormList : TElFormList;
    procedure SetFormList(newValue : TElFormList);
    procedure SetHTMLContainer(const aValue: TElHTMLContainer);
    procedure DoChange(Sender: TObject);
  protected
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    public
    procedure Assign(Source : TPersistent); override;
    procedure AddForm(aValue: TCustomForm);//deprecated: name conflict with '#define AddForm AddFormA' in winspool.h
    procedure Add(aValue: TCustomForm);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Change; override;
    procedure RegisterChanges(aValue: TElFormContainerChangeLink);
    procedure UnRegisterChanges(aValue: TElFormContainerChangeLink);
  published
    property CheckHTMLContainer:Boolean read FCheckHTMLContainer write FCheckHTMLContainer;
    property FormList : TElFormList read FFormList write SetFormList;
    property HTMLContainer: TElHTMLContainer read FHTMLContainer write SetHTMLContainer;
  end;

implementation

{ ---------------------------------------------------------------------------- }
constructor TElFormContainer.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FFormList := TElFormList.Create(self);
  FClients:= TList.Create;
  FHTMLChangeLink := TELHTMLChangeLink.Create;
  FHTMLChangeLink.OnChange:=DoChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TElFormContainer.Destroy;
begin
  FFormList.Clear;
  FFormList.Free;
  while FClients.Count > 0 do
    UnRegisterChanges(TElFormContainerChangeLink(FClients.Last));
  FreeAndNil(FClients);
  FreeAndNil(FHTMLChangeLink);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TElFormContainer.RegisterChanges(aValue: TElFormContainerChangeLink);
begin
  aValue.Sender:= Self;
  FClients.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TElFormContainer.UnRegisterChanges(aValue: TElFormContainerChangeLink);
var
  i: Integer;
begin
  if FClients<>nil then
    for i:= 0 to FClients.Count - 1 do
      if FClients[i] = aValue then
        begin
          aValue.Sender:= nil;
          FClients.Delete(i);
          Break;
        end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormContainer.Assign(Source : TPersistent);
begin
  if Source is TElFormList then
    FFormList.Assign(Source)
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormContainer.SetFormList(newValue : TElFormList);
begin
  FFormList.Assign(newValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormContainer.Change;
var
  i:Integer;
begin
  if csLoading in ComponentState then Exit;
  inherited Change;
  for i:=0 to FClients.Count-1 do
    TElFormContainerChangeLink(FClients[i]).Change;
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormContainer.Notification(AComponent : TComponent;
  operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
    begin
      if (AComponent = FHTMLContainer) then
        FHTMLContainer := nil;
    end;  { if }
end;  { Notification }

{ ---------------------------------------------------------------------------- }
procedure TElFormListItem.Assign(Source : TPersistent);
begin
  if Source is TElFormListItem then
  begin
    with Source as TElFormListItem do
    begin
      Self.FFormName := FFormName;
      Self.FHTMLContainerIndex := FHTMLContainerIndex;
      Self.FFormClassName := FFormClassName;
      Self.FFormClass :=FFormClass;
      Self.FWidth := FWidth;
      Self.FHeight := FHeight;
      Self.FForm := FForm;
    end;
  end
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
function TElFormListItem.GetDisplayName: string;
begin
  if FFormName = '' then
    Result:= inherited GetDisplayName
  else
    Result:= FFormName;
end;

{ ---------------------------------------------------------------------------- }
constructor TElFormListItem.Create;
begin
  inherited;
  FHTMLContainerIndex := -1;
  FForm := nil;
  FFormClass := nil;
  FTag := 0;
  FWidth :=0;
  FHeight :=0;
end;

{ ---------------------------------------------------------------------------- }
destructor TElFormListItem.Destroy;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormListItem.SaveToStream(Stream : TStream);
begin
//  Stream.WriteBuffer(F, SizeOf(F));
//  WriteStringToStream(Stream, FName);
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormListItem.LoadFromStream(Stream : TStream);
begin
//  ReadStringFromStream(Stream, FName);
//  Stream.ReadBuffer(F, SizeOf(F));
end;

{ ---------------------------------------------------------------------------- }
function TElFormList.GetItems(Index : integer) : TElFormListItem;
begin
  Result := TElFormListItem(inherited GetItem(Index));
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormList.SetItems(Index : integer; newValue : TElFormListItem);
begin
  inherited SetItem(Index, newValue);
end;

{ ---------------------------------------------------------------------------- }
function TElFormList.GetOwner : TPersistent;
begin
  Result := FOwner;
end;

{ ---------------------------------------------------------------------------- }
function TElFormList.Add : TElFormListItem;
begin
  Result := TElFormListItem(inherited Add);
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormList.SaveToStream(Stream : TStream);
var
  i : integer;
begin
  i := Count;
  Stream.WriteBuffer(i, SizeOf(integer));
  for i := 0 to Count - 1 do // Iterate
  begin
    Items[i].SaveToStream(Stream);
  end; // for
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormList.LoadFromStream(Stream : TStream);
var
  i, j : integer;
  item : TElFormListItem;
begin
  Clear;
  Stream.ReadBuffer(i, SizeOf(integer));
  for j := 0 to i - 1 do // Iterate
  begin
    item := Add;
    item.LoadFromStream(Stream);
  end; // for
end;

{ ---------------------------------------------------------------------------- }
constructor TElFormList.Create(AOwner : TComponent);
begin
  FOwner := AOwner;
  inherited Create(TElFormListItem);
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormListItem.SetFormExt(const Value: TCustomForm);
begin
  if FForm <> Value then
    FForm := Value;
end;

{ ---------------------------------------------------------------------------- }
function TElFormList.IndexOf(Form: TCustomForm): integer;
var i:integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
    if Items[i].Form = Form then
    begin
      result := i;
      break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TElFormList.IndexOf(FormClass: TFormClass): integer;
var i:integer;
begin
  result := -1;
  for i := 0 to Count - 1 do
  //  if Items[i].Form <> nil then
    if Items[i].FormClassName = FormClass.ClassName then
    begin
      result := i;
      break;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TElFormList.IndexOf(FormName: string): integer;
var i:integer;
    s:string;
begin
  result := -1;
  s := lowercase(FormName);
  for i := 0 to Count - 1 do
    //if Items[i].Form <> nil then
      if lowercase(Items[i].FormName) = s then
      begin
        result := i;
        break;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormContainer.AddForm(aValue: TCustomForm); //deprecated
 var f: TElFormListItem;
begin
  f := FormList.Add;
  f.FForm := aValue;
end;

procedure TElFormContainer.Add(aValue: TCustomForm);
 var f: TElFormListItem;
begin
  f := FormList.Add;
  f.FForm := aValue;
end;

procedure TElFormListItem.SetFormClassName(const Value: string);
begin
  if FFormClassName <> Value then
    FFormClassName := Value;
end;

{************************* TElHTMLChangeLink *********************************}

{------------------------------------------------------------------------------}
destructor TElFormContainerChangeLink.Destroy;
begin
  if Sender <> nil then Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TElFormContainerChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender)
end;

procedure TElFormContainer.SetHTMLContainer(const aValue: TElHTMLContainer);
begin
  if FHTMLContainer<>nil then
    FHTMLContainer.UnRegisterChanges(FHTMLChangeLink);
  FHTMLContainer := aValue;
  if FHTMLContainer = nil then
    FCheckHTMLContainer := false
  else
    FCheckHTMLContainer := true;
  if FHTMLContainer<>nil then
    begin
      FHTMLContainer.RegisterChanges(FHTMLChangeLink);
      FHTMLContainer.FreeNotification(Self);
    end;
  DoChange(nil);
end;

procedure TElFormContainer.DoChange(Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  Change;
end;

end.
