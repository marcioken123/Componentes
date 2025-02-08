unit LMDDynLIFOBuffer;
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

LMDDynLIFOBuffer unit ()
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
  TLMDDynLIFOBuffer = class(TLMDBuffer)
  private
    FCircleMode : Boolean;
    FCurrent,
    FTop        : PLMDDynNode;

  protected
    procedure FirstNode (var node : Pointer); override;
    procedure NextNode (var node : Pointer); override;
    function GetItem(node : Pointer) : Pointer; override;
//    function GetItemSize (node : PLMDDynNode) : Integer; override;
    function EOFBuffer(node : Pointer):Boolean; override;
    procedure clearItem (item : Pointer);
    public
    function IsEmpty: Boolean; override;
    function IsFull: Boolean; override;
    procedure Put (item : Pointer); override;
    //get will extract the last inserted node, delete the node and returns a pointer to the item => the item has to be destroyed manually if it has to be destroyed!!
    function Get : Pointer; override;
    procedure Clear; override;

    constructor Create(AOwner: TPersistent = nil); override;
    destructor Destroy; override;
  end;

implementation

{ ---------------------------- protected ------------------------------------- }

procedure TLMDDynLIFOBuffer.FirstNode (var node : Pointer);

var
  step : PLMDDynNode;
begin
  //FCurrent := FTop;
  step := FTop;
  while (step <> nil) and (step.next <> nil) do
    step := step.next;
  node := step; //FCurrent = oldest item
  end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDynLIFOBuffer.NextNode (var node : Pointer);

var
  step : PLMDDynNode;
begin
  //FCurrent := FCurrent^.next;
  step := FTop;
  while (step <> nil) and (step.next <> PLMDDynNode(node)) do
    step := step.next;
  node := step;
  end;

{ ---------------------------------------------------------------------------- }

function TLMDDynLIFOBuffer.GetItem(node : Pointer) : Pointer;

begin
  result := PLMDDynNode(node).item;
end;
(*
{ ---------------------------------------------------------------------------- }
function TLMDDynLIFOBuffer.GetItemSize : Integer;
begin
  result := 0;
  if Assigned (OnGetItemSize) then OnGetItemSize (self, FCurrent^.item, result);
end;*)

{ ---------------------------------------------------------------------------- }

function TLMDDynLIFOBuffer.EOFBuffer(node : Pointer):Boolean;

begin
  result := (node = nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDynLIFOBuffer.clearItem (item : Pointer);

begin
  if Assigned (FOnDestroyItem) then
    FOnDestroyItem (self, item)
  else
  if item <> nil then

    FreeMem (Pointer(item));

end;

{ ----------------------------- public --------------------------------------- }
function TLMDDynLIFOBuffer.IsEmpty: Boolean;
begin
  result := (FTop = nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDynLIFOBuffer.IsFull: Boolean;
begin
  result := false;
  if (FMaxEntries <> -1) and (FCount >= FMaxEntries) then
    result := true;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDDynLIFOBuffer.Put (item : Pointer);

var
  prevNode,
  newNode : PLMDDynNode;
begin
  if (FMaxEntries <> -1) and (FCount >= FMaxEntries) then
    if not FCircleMode then //buffer is full, oldest element shall be kept
      exit
    else //we can delete the oldest element for being able to insert the new one
      begin
        if MaxEntries = 1 then Clear
        else
          begin
            prevNode := nil; //calm down compiler
            newNode := FTop;
            //newNode = newest (last inserted) element
            while newNode.next <> nil do
              begin
                prevNode := newNode;
                newNode := newNode.next;
              end;
            //prevNode = previous of last Node
            prevNode.next := nil; //new last element
            //newNode = last Node (oldest one)
            if Assigned (OnDestroyItem) then
              OnDestroyItem (self, newNode.item)
            else
            if newNode.item <> nil then

              FreeMem (newNode.item);
            Dispose (newNode);

            dec (FCount);
          end;
      end;

  New (newNode);

  newNode.next := FTop;
  newNode.item := item;
  FTop := newNode;
  inc (FCount);
end;

{ ---------------------------------------------------------------------------- }

function TLMDDynLIFOBuffer.Get : Pointer;

var
  helpNode : PLMDDynNode;
begin
  if IsEmpty then
    begin
      result := nil;
      exit;
    end;
  result := FTop.item;
  helpNode := FTop.next;
{  if Assigned (FOnDestroyItem) then
    FOnDestroyItem (self, FTop^.item)
  else
    if FTop^.item <> nil then FreeMem (FTop^.item);}

  Dispose(FTop);

  FTop := helpNode;
  dec (FCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDynLIFOBuffer.Clear;
var
  helpNode : PLMDDynNode;
begin
  while FTop <> nil do
    begin
      helpNode := FTop.next;
      if Assigned (FOnDestroyItem) then
        FOnDestroyItem (self, FTop.item)
      else
      if FTop.item <> nil then

        FreeMem (FTop.item);
      Dispose (FTop);

      FTop := helpNode;
    end;
  FCount := 0;
  FCurrent := nil;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDDynLIFOBuffer.Create;
begin
  inherited Create;
  FTop := nil;
  FCurrent := nil;
  FCircleMode := true; //only of some interest if MaxEntries <> -1
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDynLIFOBuffer.Destroy;
begin
  Clear;
  FCurrent := nil;
  FTop := nil;
  inherited Destroy;
end;

end.
