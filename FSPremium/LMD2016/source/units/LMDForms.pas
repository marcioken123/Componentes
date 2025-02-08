unit LMDForms;
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

LMDForms unit (AH)
------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Windows, Forms, RTLConsts,
  LMDTypes, LMDUnicodeControl;

type
  TLMDWideForm = class(TForm)
  private
    FCaption: TLMDString;
    function GetCaption: TLMDString;
    procedure SetCaption(const Value: TLMDString);
  protected
    procedure CreateWindowHandle(const Params: TCreateParams); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Caption: TLMDString read GetCaption write SetCaption;
  end;

implementation

{******************************* TLMDWideForm *********************************}
{------------------------------------------------------------------------------}
constructor TLMDWideForm.Create(AOwner: TComponent);
begin
  GlobalNameSpace.BeginWrite;
  try
    CreateNew(AOwner);
    if (ClassType <> TLMDWideForm) and not (csDesigning in ComponentState) then
    begin
      Include(FFormState, fsCreating);
      try
        if not InitInheritedComponent(Self, TLMDWideForm) then
          raise EResNotFound.CreateFmt(SResNotFound, [ClassName]);
      finally
        Exclude(FFormState, fsCreating);
      end;
      if OldCreateOrder then DoCreate;
    end;
  finally
    GlobalNameSpace.EndWrite;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDWideForm.CreateWindowHandle(const Params: TCreateParams);
begin
  if (FormStyle = fsMDIChild) and not (csDesigning in ComponentState) then
    LMDCreateMDIWindowHandle(Self, Params, '')
  else
    LMDCreateControlHandle(Self, Params, '');
end;

{------------------------------------------------------------------------------}
procedure TLMDWideForm.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{------------------------------------------------------------------------------}
function TLMDWideForm.GetCaption: TLMDString;
begin
  Result := LMDGetControlText(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDWideForm.SetCaption(const Value: TLMDString);
begin
  FCaption := Value;
  LMDSetControlText(Self, Value);
end;

end.
