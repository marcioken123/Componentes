unit LMDBaseController;
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

LMDBaseController unit (RM)
---------------------------
Centralized controller components for LMD design properties

ToDo
----
Introduce Optimization routines

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Classes,
  Controls,
  LMDCustomComponent;

type

  TLMDBaseController=class;

  {************************ TLMDChangeLink  ***********************************}
  TLMDChangeLink = class
  private
    FSender:TLMDBaseController;
    FOnChange:TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TLMDBaseController read FSender write FSender;
  end;

  {************************ TLMDBaseController ********************************}
  TLMDBaseController = class(TLMDCustomComponent)
  private
    FClients:TList;
  protected
    procedure Change;override;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    procedure RegisterChanges(aValue: TLMDChangeLink);
    procedure UnRegisterChanges(aValue: TLMDChangeLink);
  published
    property About;
    property OnChange;
  end;

implementation
uses
 sysutils;

{*********************** TLMDChangeLink ***************************************}
{------------------------------------------------------------------------------}
destructor TLMDChangeLink.Destroy;
begin
  if Sender <> nil then
    Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender)
end;

{************************* TLMDBaseController **********************************}
{----------------------------- Private ----------------------------------------}
{--------------------------- protected ----------------------------------------}
procedure TLMDBaseController.Change;
var
  i:Integer;
begin
  if isUpdating or (csLoading in ComponentState) then Exit;
  inherited Change;
  for i:=0 to FClients.Count-1 do
    TLMDChangeLink(FClients[i]).Change;
end;

{---------------------------- public ------------------------------------------}
constructor TLMDBaseController.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FComponentStyle:=FComponentStyle-[csInheritable];
  FClients:= TList.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseController.Destroy;
begin
  while FClients.Count > 0 do
    UnRegisterChanges(TLMDChangeLink(FClients.Last));
  FreeAndNil(FClients);
  FClients:=nil;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseController.RegisterChanges(aValue: TLMDChangeLink);
begin
  if not Assigned(aValue) then exit;
  aValue.Sender:= Self;
  FClients.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseController.UnRegisterChanges(aValue: TLMDChangeLink);
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
