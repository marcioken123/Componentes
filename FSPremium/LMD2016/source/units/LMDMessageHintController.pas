unit LMDMessageHintController;
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

LMDMessageHintController unit (VB)
----------------------------------

Changes
-------
Release 9.0 (XXXXX 2008)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Controls, CommCtrl, Messages, Graphics,
  LMDTypes, LMDClass, LMDCustomComponent, LMDCustomShapeHint, LMDMessageHint;

type
  TLMDMessageSetItem =  class(TCollectionItem)
  private
    FTitle: TLMDString;
    FMsgString: TLMDString;
    FControl: TControl;
    FColor: TColor;
    FDisplayOrder: integer;
    FIcon: TLMDHintIconType;

    procedure SetMsgString(const Value: TLMDString);
    procedure SetControl(const Value: TControl);
    procedure SetDisplayOrder(const Value: integer);
    procedure SetTitle(const Value: TLMDString);
    procedure SetColor(const Value: TColor);
    procedure SetIcon(const Value: TLMDHintIconType);
  protected
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Control: TControl read FControl write SetControl;
    property Color: TColor read FColor write SetColor default clNone;
    property DisplayOrder: integer read FDisplayOrder write SetDisplayOrder;
    property Icon: TLMDHintIconType read FIcon write SetIcon;
    property MessageString: TLMDString read FMsgString write SetMsgString;
    property Title: TLMDString read FTitle write SetTitle;

  end;

  TLMDMessageHintController = class;

  TLMDMessageSet = class (TCollection)
  private
    FOwner  : TLMDMessageHintController;
    function GetItem(Index: Integer): TLMDMessageSetItem;
    procedure SetItem(Index: Integer; Value: TLMDMessageSetItem);
  protected
    function GetOwner: TPersistent; override;
    procedure Notify(Item: TCollectionItem; Action: TCollectionNotification); override;
    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner : TLMDMessageHintController);
    destructor Destroy; override;
    function Add: TLMDMessageSetItem;
    procedure Delete(Index: Integer);
    property Items[Index: Integer]: TLMDMessageSetItem read GetItem write SetItem; default;
  end;

  { *************************** TLMDMessageHintController *********************}
  TLMDMessageHintController = class(TLMDCustomComponent)
  private
    FMessageHintControl: TLMDMessageHint;
    FMessages: TLMDMessageSet;
    procedure SetItems(const Value: TLMDMessageSet);
    procedure SetMessageHintControl(const Value: TLMDMessageHint);
  protected
    procedure Notification(AComponent: TComponent;Operation:TOperation);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure HideMessages(DisplayOrder: integer = -1);
    procedure ShowMessages(DisplayOrder: integer = -1);
  published
    property About;
    property Items: TLMDMessageSet read FMessages write SetItems;
    property MessageHintControl: TLMDMessageHint read FMessageHintControl write SetMessageHintControl;
  end;

implementation

{--------------------------- Public -------------------------------------------}
constructor TLMDMessageHintController.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FMessages := TLMDMessageSet.Create(Self)
end;

{------------------------------------------------------------------------------}
destructor TLMDMessageHintController.Destroy;
begin
  FMessages.Clear;
  FMessages.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHintController.HideMessages(DisplayOrder: integer = -1);
begin
  if not Assigned(MessageHintControl) then
    exit;
  MessageHintControl.HideMessages(DisplayOrder);
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHintController.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: integer;
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
    begin
      for i := 0 to Items.Count - 1 do
        if Assigned(Items[i].Control) and (Items[i].Control = AComponent) then
          Items[i].FControl := nil;
      if (AComponent = FMessageHintControl) then
        self.SetMessageHintControl(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHintController.SetItems(const Value: TLMDMessageSet);
begin
  FMessages.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHintController.SetMessageHintControl(
  const Value: TLMDMessageHint);
begin
  FMessageHintControl := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageHintController.ShowMessages(DisplayOrder: integer = -1);
var
  i: integer;
begin
  if not Assigned(MessageHintControl) then
    exit;
  MessageHintControl.AllowMultipleHints := true;
  for i := 0 to Items.Count - 1 do
    if (DisplayOrder = -1) or (DisplayOrder = Items[i].DisplayOrder) then
      MessageHintControl.ShowControlMessage(Items[i].MessageString, Items[i].Control, Items[i].Title, Items[i].Color, Items[i].Icon, DisplayOrder);
end;

{--------------------------- TLMDMessageSetItem -------------------------------}
procedure TLMDMessageSetItem.Assign(Source: TPersistent);
var
  S: TLMDMessageSetItem;
begin
  if Source is TLMDMessageSetItem then
    begin
      S := TLMDMessageSetItem(Source);
      FDisplayOrder := S.DisplayOrder;
      FMsgString := S.MessageString;
      FControl := S.Control;
      Changed(false);
    end
  else
    inherited Assign (Source);
end;

{------------------------------------------------------------------------------}
constructor TLMDMessageSetItem.Create(Collection: TCollection);
begin
  inherited Create (Collection);
  FMsgString := '';
  FControl := nil;
  FTitle := '';
  FColor := clNone;
  FDisplayOrder := 0;
end;

{------------------------------------------------------------------------------}
destructor TLMDMessageSetItem.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSetItem.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSetItem.SetControl(const Value: TControl);
begin
  FControl := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSetItem.SetDisplayOrder(const Value: integer);
begin
  if (Value >= 0) and (Value < Collection.Count) then
    FDisplayOrder := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSetItem.SetIcon(const Value: TLMDHintIconType);
begin
  FIcon := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSetItem.SetMsgString(const Value: TLMDString);
begin
  FMsgString := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSetItem.SetTitle(const Value: TLMDString);
begin
  FTitle := Value;
end;

{--------------------------- TLMDMessageSet -----------------------------------}

function TLMDMessageSet.Add: TLMDMessageSetItem;
begin
  result := TLMDMessageSetItem(inherited Add);
end;

{------------------------------------------------------------------------------}
constructor TLMDMessageSet.Create(Owner: TLMDMessageHintController);
begin
  inherited Create(TLMDMessageSetItem);
  FOwner := Owner;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSet.Delete(Index: Integer);
begin
  inherited Delete (index);
end;

{------------------------------------------------------------------------------}
destructor TLMDMessageSet.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDMessageSet.GetItem(Index: Integer): TLMDMessageSetItem;
begin
  result := TLMDMessageSetItem(inherited GetItem(Index));
end;

{------------------------------------------------------------------------------}
function TLMDMessageSet.GetOwner: TPersistent;
begin
  result := FOwner;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSet.Notify(Item: TCollectionItem;
  Action: TCollectionNotification);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSet.SetItem(Index: Integer; Value: TLMDMessageSetItem);
begin
  inherited SetItem(Index, Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDMessageSet.Update(Item: TCollectionItem);
begin
  inherited;
end;

end.
