unit ElStrPool;
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

ElStrPool unit
--------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  ElComponent,
  {$ifdef LMD_UNICODE}
  LMDUnicodeStrings;
 {$else}
  ElStrArray;
 {$endif}

type

{$ifdef LMD_UNICODE}
  TLMDStringArray = TLMDWideStringArray;
{$else}
  TLMDStringArray = TElStringArray;
{$endif}

  TElStringPool = class(TElComponent)
  private
    FItems : TLMDStringArray;
    procedure SetItems(newValue : TLMDStringArray);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Assign(Source : TPersistent); override;
  published
    property Items : TLMDStringArray read FItems write SetItems;
  end;

implementation

constructor TElStringPool.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FItems := TLMDStringArray.Create;
end;

destructor TElStringPool.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TElStringPool.Assign(Source : TPersistent);
begin
  if Source is TStrings then
    FItems.Assign(Source)
  else
    inherited;
end;

procedure TElStringPool.SetItems(newValue : TLMDStringArray);
begin
  FItems.Assign(newValue);
end;

end.
