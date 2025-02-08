unit LMDStackComponent;
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

LMDStackComponent unit ()
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
  TLMDStackComponent = class(TLMDBufferComponent)
  private
  protected
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure Pop;
    procedure Push (item : Pointer);
    function Top : Pointer;
    function ExtractTop : Pointer;
    procedure Clear;
  published
  end;

implementation

uses
  LMDStack;

{ -------------------------- public ------------------------------------------ }
constructor TLMDStackComponent.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FBuffer := TLMDStack.Create;
  FBuffer.OnGetItemSize := DoGetItemSize;
  FBuffer.OnDestroyItem := DoDeleteItem;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDStackComponent.Destroy;
begin
  FBuffer.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDStackComponent.Pop;
begin
  TLMDStack(FBuffer).Pop;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDStackComponent.Push (item : Pointer);

begin
  TLMDStack(FBuffer).Push (item);
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }

function TLMDStackComponent.Top : Pointer;

begin
  result := TLMDStack(FBuffer).Top;
end;

{ ---------------------------------------------------------------------------- }

function TLMDStackComponent.ExtractTop : Pointer;

begin
  result := TLMDStack(FBuffer).extractTop;
  GetChange (nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDstackComponent.Clear;
begin
  FBuffer.Clear;
  GetChange (nil);
end;

end.
