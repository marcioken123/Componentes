unit LMDQueueComponent;
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

LMDQueueComponent unit ()
-------------------------

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
  TLMDQueueComponent = class(TLMDBufferComponent)
  private
  protected
    { Protected declarations }
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure EnQueue (item : Pointer);
    procedure DeQueue;
    function Front : Pointer;
    function ExtractFront : Pointer;
    procedure Clear;
  published
    { Published declarations }
  end;

implementation

uses
  LMDQueue;

{ -------------------------- public ------------------------------------------ }
constructor TLMDQueueComponent.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FBuffer := TLMDQueue.Create;
  FBuffer.OnGetItemSize := DoGetItemSize;
  FBuffer.OnDestroyItem := DoDeleteItem;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDQueueComponent.Destroy;
begin
  FBuffer.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDQueueComponent.enQueue (item : Pointer);

begin
  TLMDQueue(FBuffer).enQueue (item);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDQueueComponent.deQueue;
begin
  TLMDQueue(FBuffer).deQueue;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDQueueComponent.Front : Pointer;

begin
  result := TLMDQueue(FBuffer).front;
end;

{ ---------------------------------------------------------------------------- }

function TLMDQueueComponent.extractFront : Pointer;

begin
  result := TLMDQueue(FBuffer).extractFront;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDQueueComponent.Clear;
begin
  TLMDQueue(FBuffer).Clear;
  GetChange (nil);
end;

end.
