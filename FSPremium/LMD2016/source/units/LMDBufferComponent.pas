unit LMDBufferComponent;
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

LMDBufferComponent unit ()
--------------------------

Base comnponent for data storages.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  LMDCustomComponent,
  LMDBuffer;

type
  TLMDBufferComponent = class(TLMDCustomComponent)
  private
    FMaxEntries      : Integer;

    FOnGetItemSize   : TLMDGetItemSizeEvent;
    FOnDeleteItem    : TLMDDestroyItemEvent;

    procedure SetInteger (aValue : Integer);

  protected
    FBuffer : TLMDBuffer;

    procedure DoDeleteItem (Sender : TObject; Item : Pointer);
    procedure DoGetItemSize (Sender : TObject; Item : Pointer; var size : Integer);
    function GetCount : Integer;
  public
    constructor Create (aOwner : TComponent); override;
    procedure SaveToFile (const Filename : String);
    procedure LoadFromFile (const Filename : String);

    procedure SaveToStream (Stream : TStream);
    procedure LoadFromStream (Stream : TStream);

    function isEmtpy : Boolean;
    function isFull : Boolean;

    property Count : Integer read GetCount;
  published
    property About;
    property MaxEntries : Integer read FMaxEntries write SetInteger default -1;

    property OnGetItemSize : TLMDGetItemSizeEvent read FOnGetItemSize write FOnGetItemSize;
    property OnDeleteItem : TLMDDestroyItemEvent read FOnDeleteItem write FOnDeleteItem;
    property OnChange;

  end;

implementation

{ -------------------------- private ----------------------------------------- }
procedure TLMDBufferComponent.SetInteger (aValue : Integer);
begin
  FMaxEntries := aValue;
  FBuffer.MaxEntries := aValue;
end;

{ -------------------------- protected --------------------------------------- }

procedure TLMDBufferComponent.DoDeleteItem (Sender : TObject; Item : Pointer);

begin
  if Assigned (FOnDeleteItem) then
    FOnDeleteItem (self, Item)
  else

    FreeMem (Pointer(Item));

end;

{ ---------------------------------------------------------------------------- }

procedure TLMDBufferComponent.DoGetItemSize (Sender : TObject; Item : Pointer; var size : Integer);

begin
  if Assigned (FOnGetItemSize) then FOnGetItemSize (self, Item, size);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBufferComponent.GetCount : Integer;
begin
  result := FBuffer.Count;
end;

{ -------------------------- public ------------------------------------------ }
constructor TLMDBufferComponent.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FMaxEntries := -1;
  FBuffer := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBufferComponent.SaveToFile (const Filename : String);
begin
  FBuffer.SaveToFile (Filename);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBufferComponent.LoadFromFile (const Filename : String);
begin
  FBuffer.LoadFromFile (Filename);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBufferComponent.SaveToStream (Stream : TStream);
begin
  FBuffer.SaveToStream (Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBufferComponent.LoadFromStream (Stream : TStream);
begin
  FBuffer.LoadFromStream (Stream);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
function TLMDBufferComponent.isEmtpy : Boolean;
begin
  result := FBuffer.isEmpty;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBufferComponent.isFull : Boolean;
begin
  result := FBuffer.isFull;
end;

end.
