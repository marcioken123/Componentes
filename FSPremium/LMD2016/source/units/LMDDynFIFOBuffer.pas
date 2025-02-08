unit LMDDynFIFOBuffer;
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

LMDDynFIFOBuffer unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, LMDBuffer;

type
  TLMDDynFIFOBuffer = class(TLMDBuffer)
  private
    FRoot,
    FTop   : PLMDDynNode;
    procedure FreeNode(Node: PLMDDynNode);
    function  CreateNode: PLMDDynNode;
  protected
    procedure FirstNode (var node : Pointer); override;
    procedure NextNode (var node : Pointer); override;
    function EOFBuffer(node : Pointer):Boolean; override;
    function GetItem (node : Pointer) : Pointer; override;
    public
    function IsEmpty : Boolean; override;
    function IsFull : Boolean; override;
    procedure Put (item : Pointer); override;
    function Get : Pointer; override;
    function Front : Pointer;
    procedure Clear; override;

    constructor Create(AOwner: TPersistent = nil); override;
    destructor Destroy; override;
  end;

implementation

{ ---------------------------- protected ------------------------------------- }

procedure TLMDDynFIFOBuffer.FirstNode (var node : Pointer);

begin
  node := FRoot;
  end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDynFIFOBuffer.NextNode (var node : Pointer);

begin
  node := PLMDDynNode(node).next;
  end;

{ ---------------------------------------------------------------------------- }

function TLMDDynFIFOBuffer.EOFBuffer(node : Pointer): Boolean;

begin
  result := (node = nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDDynFIFOBuffer.GetItem (node : Pointer) : Pointer;

begin
  result := nil;
  if node = nil then exit;
  result := PLMDDynNode (node).item;
end;

{ ------------------------------- public ------------------------------------- }
function TLMDDynFIFOBuffer.IsEmpty : Boolean;
begin
  result := (FRoot = nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDynFIFOBuffer.IsFull : Boolean;
begin
  if MaxEntries = -1 then
    result := false
  else
    result := (MaxEntries <= Count);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDynFIFOBuffer.Put (item : Pointer);

var
  newNode : PLMDDynNode;
begin
  if (MaxEntries <> -1) and (MaxEntries >= FCount) then exit;

  newNode := CreateNode;
  inc(FCount);
  newNode.item := item;
  newNode.next := nil;
  if FRoot = nil then
    begin //isEmpty = true
      FTop := newNode;
      FRoot := newNode;
      Exit;
    end;
  //isEmtpy = false
  FTop.next := newNode;
  FTop := newNode;
end;

{ ---------------------------------------------------------------------------- }

function TLMDDynFIFOBuffer.Get : Pointer;

var
  helpNode : PLMDDynNode;
begin
  if isEmpty then
    begin
      result := nil;
      exit;
    end;
  result := FRoot.item;
  helpNode := FRoot.next;
  if FRoot = FTop then //last item
    FTop := nil;

  FreeNode(FRoot);
  FRoot := helpNode;
  dec (FCount);
end;

{ ---------------------------------------------------------------------------- }

function TLMDDynFIFOBuffer.Front : Pointer;

begin
  if FRoot <> nil then
    result := FRoot.item
  else
    result := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDynFIFOBuffer.Clear;
var
  helpNode : PLMDDynNode;
begin
  while FRoot <> nil do
    begin
      helpNode := FRoot.next;
      if Assigned (FOnDestroyItem) then FOnDestroyItem (self, FRoot.item);
      FreeNode(FRoot);
      FRoot := helpNode;
    end;
  FCount := 0;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDynFIFOBuffer.Create;
begin
  inherited Create;
  FTop := nil;
  FRoot := nil;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDynFIFOBuffer.Destroy;
begin
  Clear;
  FRoot := nil;
  FTop := nil;
  inherited Destroy;
end;

procedure TLMDDynFIFOBuffer.FreeNode(Node: PLMDDynNode);
begin
  if  Assigned(Node)  then

    Dispose (Node);

end;

function  TLMDDynFIFOBuffer.CreateNode: PLMDDynNode;
begin

  New(Result);

end;

end.
