unit LMDBuffer;
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

LMDBuffer unit (JH)
-------------------

Base class for data structures

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, LMDObject;

const
  buffer_type = '@LMDBufferStream-V0.1@';

type
  TLMDDestroyItemEvent = procedure (Sender : TObject; item : Pointer) of object;
  TLMDGetItemSizeEvent = procedure (Sender : TObject; item : Pointer; var size : Integer) of object;
  PLMDDynNode = ^TLMDDynNode;
  TLMDDynNode = record
    item : Pointer;
    next : PLMDDynNode;
  end;

  TLMDBuffer = class(TLMDObject)
  protected
    FUpdateCount,
    FMaxEntries,
    FCount         : Integer;
    FOnDestroyItem : TLMDDestroyItemEvent;
    FOnGetItemSize : TLMDGetItemSizeEvent;

    procedure FirstNode (var node : Pointer); virtual; abstract;
    procedure NextNode (var node : Pointer); virtual; abstract;
    function GetItem(node : Pointer): Pointer; virtual; abstract;
    function GetItemSize(node : Pointer): Integer;
    function EOFBuffer(node: Pointer): Boolean; virtual; abstract;

  public
    constructor Create(Owner: TPersistent = nil); override;
    destructor Destroy; override;

    function IsEmpty : Boolean; virtual; abstract;
    function IsFull : Boolean; virtual; abstract;
    procedure Put(item: Pointer); virtual; abstract;
    function Get: Pointer; virtual; abstract;
    procedure Clear; virtual; abstract;

    procedure BeginUpdate;
    procedure EndUpdate;
    function Updating : Boolean;

    procedure LoadFromStream (Stream : TStream); virtual;
    procedure SaveToStream (Stream : TStream); virtual;
    procedure LoadFromFile (const Filename : String);
    procedure SaveToFile (const Filename : String);

    property Count : Integer read FCount;
    property MaxEntries : Integer read FMaxEntries write FMaxEntries default -1;

    property OnDestroyItem : TLMDDestroyItemEvent read FOnDestroyItem write FOnDestroyItem;
    property OnGetItemSize : TLMDGetItemSizeEvent read FOnGetItemSize write FOnGetItemSize;
  end;

implementation

{ ---------------------------------------------------------------------------- }

function TLMDBuffer.GetItemSize(node : Pointer) : Integer;

begin
  Result := 0;
  if Assigned (FOnGetItemSize) then
    FOnGetItemSize(Self, GetItem (node), result);
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDBuffer.Create(Owner: TPersistent = nil);
begin
  inherited Create(Owner);
  FCount := 0;
  FUpdateCount := 0;
  FMaxEntries := -1;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDBuffer.Destroy;
begin
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBuffer.BeginUpdate;
begin
  inc (FUpdateCount);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBuffer.EndUpdate;
begin
  if FUpdateCount > 0 then
    dec (FUpdateCount);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBuffer.Updating : Boolean;
begin
  result := FUpdateCount > 0;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBuffer.LoadFromStream (Stream : TStream);
var
  s : String;
  bl : Integer;
  data : Pointer;
begin
  Stream.Read (bl, SizeOf(Integer));
  {$IFDEF LMDCOMP12}
  SetLength(s, bl);
  Stream.Read(Pointer(s)^, bl * SizeOf(Char));
  {$ELSE}
  GetMem(data, bl);
  Stream.ReadBuffer (data^, bl);
  s := StrPas (data);
  FreeMem(data);
  {$ENDIF}

  if s <> buffer_type then exit; //version conflict or not buffer stream
  Clear;
  while Stream.Position < Stream.Size do
    begin
      Stream.ReadBuffer (bl, 4);
      GetMem (data, bl);
      Stream.ReadBuffer (data^, bl);
      Put (data);
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBuffer.SaveToStream (Stream : TStream);
var
  bl        : Integer;
  saveNode  : Pointer;
  data      : Pointer;
begin
  bl := Length (buffer_type) + 1;
  Stream.Write (bl, 4);
  GetMem (data, bl);
  StrPCopy (data, buffer_type);
  Stream.Write (data^, BL);
  FreeMem (data);

  FirstNode(saveNode);

  while not EOFBuffer(saveNode) do
    begin
      bl := GetItemSize(saveNode);
      Stream.Write (bl, 4);
      data := GetItem(saveNode);
      Stream.Write (data^, bl);
      NextNode (saveNode);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBuffer.LoadFromFile (const Filename : String);
var
  f : TFileStream;
begin
  f := TFileStream.Create (Filename, fmOpenRead);
  try
    LoadFromStream (f);
  finally
    f.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBuffer.SaveToFile (const Filename : String);
var
  f : TFileStream;
begin
  f := TFileStream.Create (Filename, fmCreate);
  try
    SaveToStream (f);
  finally
    f.Free;
  end;
end;

end.
