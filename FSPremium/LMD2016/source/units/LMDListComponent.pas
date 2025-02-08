unit LMDListComponent;
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

LMDListComponent unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDBufferComponent;

type
  TLMDListComponent = class(TLMDBufferComponent)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    function Item : Pointer; //O(1)
    procedure First; //O(1)
    procedure Next; //O(1)
    procedure Last; //O(1)
    procedure Prev; // O(1)
    function isLast : Boolean; //O(1)
    procedure Seek (index : Integer); //O(n) ... n/2

    procedure Delete; //O(1);
    function Extract : Pointer;  //O(1)
    function ExtractByNr (index : Integer) : Pointer; //O(n) ... n/2
    function GetItemByNr (index : Integer) : Pointer; //O(n) ... n/2

    procedure Insert (item : Pointer); //O(1)
    procedure InsertAt (item : Pointer; index : Integer); //O(n) ... n/2
    procedure Add (item : Pointer); //O(1)
    procedure Clear; //O(n)
  published
    { Published declarations }
  end;

implementation

uses
  LMDList
  ;

{ ---------------------------------------------------------------------------- }
constructor TLMDListComponent.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FBuffer := TLMDList.Create;
  FBuffer.OnGetItemSize := DoGetItemSize;
  FBuffer.OnDestroyItem := DoDeleteItem;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDListComponent.Destroy;
begin
  FBuffer.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

function TLMDListComponent.Item : Pointer;

begin
  result := TLMDList(FBuffer).Item;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListComponent.First;
begin
  TLMDList(FBuffer).First;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListComponent.Next;
begin
  TLMDList(FBuffer).Next;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListComponent.Last;
begin
  TLMDList(FBuffer).Last;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListComponent.Prev;
begin
  TLMDList(FBuffer).Prev;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDListComponent.isLast : Boolean;
begin
  result := TLMDList(FBuffer).isLast;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListComponent.Seek (index : Integer);
begin
  TLMDList(FBuffer).Seek (index);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListComponent.Delete;
begin
  TLMDList(FBuffer).Delete;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDListComponent.extract : Pointer;

begin
  result := TLMDList(FBuffer).Extract;
  GetChange(nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDListComponent.extractByNr (index : Integer) : Pointer;

begin
  result := TLMDList(FBuffer).extractByNr (index);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDListComponent.GetItemByNr (index : Integer) : Pointer;

begin
  result := TLMDList(FBuffer).GetItemByNr (index);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDListComponent.insert (item : Pointer);

begin
  TLMDList(FBuffer).insert (item);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDListComponent.insertAt (item : Pointer; index : Integer);

begin
  TLMDList(FBuffer).insertAt (item, index);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDListComponent.Add (item : Pointer);

begin
  TLMDList(FBuffer).Put (item);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDListComponent.Clear;
begin
  TLMDList(FBuffer).Clear;
  GetChange (nil);
end;

end.
