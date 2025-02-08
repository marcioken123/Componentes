unit LMDErrorProvidersGroup;
{$I LMDCmps.inc}

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

LMDErrorProvidersGroup unit (RS)
--------------------------------

Error providers group class

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses Windows,
  Messages,
  Classes,
  SysUtils,
  LMDVldBase;

type

  TLMDErrorProvidersGroup = class(TLMDCustomErrorProvider)
  protected
    FErrorProviders: TLMDErrorProviders;
    procedure SetErrorProviders(const Value: TLMDErrorProviders);
    procedure Notification(AComponent: TComponent; Operation: TOperation);
      override;
    procedure DoDisplayError(control: ILMDValidatedControl; ErrorMsg: string;
      ErrorLevel: TLMDErrorLevel); override;
  public
    constructor Create(AComponent: TComponent); override;
    destructor Destroy; override;
  published
    property ErrorProviders: TLMDErrorProviders read FErrorProviders write
      SetErrorProviders;
  end;

implementation

{****************** Object TLMDErrorProvidersGroup ****************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDErrorProvidersGroup.SetErrorProviders(
  const Value: TLMDErrorProviders);
begin
  FErrorProviders.Assign(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDErrorProvidersGroup.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i: integer;
  found: boolean;
begin
  inherited;

  if not (Operation = opRemove) then
    Exit;

  if Assigned(FErrorProviders) then
    begin
      i := 0;
      found := false;
      while (i < Self.ErrorProviders.Count) and (not found) do
        begin
          found := Self.ErrorProviders[i].ErrorProvider = AComponent;
          if not found then
            Inc(i);
        end;
      if found then
      begin
        Self.ErrorProviders.Delete(i);
        Exit;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDErrorProvidersGroup.DoDisplayError(
  control: ILMDValidatedControl; ErrorMsg: string;
  ErrorLevel: TLMDErrorLevel);
var
  i: integer;
begin
  if (Self.MaxErrorLevel >= ErrorLevel) and (Self.MinErrorLevel <= ErrorLevel)
    then
    for i := 0 to Self.ErrorProviders.Count - 1 do
      Self.ErrorProviders[i].ErrorProvider.DisplayError(control, ErrorMsg,
        ErrorLevel);
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDErrorProvidersGroup.Create(AComponent: TComponent);
begin
  inherited;
  Self.FErrorProviders := TLMDErrorProviders.Create(Self);
end;

{------------------------------------------------------------------------------}
destructor TLMDErrorProvidersGroup.Destroy;
begin
  inherited; //Notification should be called before FErrorProviders is freed //VB Oct 2009
  Self.FErrorProviders.Free;  
end;

end.

