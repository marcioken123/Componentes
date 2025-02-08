unit pLMDFxAniDesigner;
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

pLMDFxAniDesigner unit (RM, AH)
-------------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors, DesignWindows,
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls,
  LMDFxAnimation;

type
  { ----------------------- TLMDFxAnimationPropertyEditor -------------------- }
  TLMDFxAnimationPropertyEditor = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: String; override;
  end;

implementation {===============================================================}

uses
  LMDFxAniDesignerForm;

{ TLMDFxAnimationPropertyEditor ==================================================}
procedure TLMDFxAnimationPropertyEditor.Edit;
begin
  if PropCount <> 1 then Exit;

  LMDFxShowDesignerForm(TLMDFxAnimation(GetComponent(0)));
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxAnimationPropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog, paReadOnly];
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxAnimationPropertyEditor.GetValue: String;
var
  AniComp: TLMDFxAnimation;
begin
  AniComp := TLMDFxAnimation(GetComponent(0));

  if AniComp <> nil then
    Result := AniComp.Effect
  else
    Result := '(none)';
end;

end.
