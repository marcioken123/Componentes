unit pLMDSctPE;
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

pLMDSctPE unit (YB)
-------------------
Unit contains property editors needed in LMD-ScriptPack.

Changes
-------

###############################################################################}

interface

uses
  Classes, SysUtils, TypInfo, DesignIntf, DesignEditors, VCLEditors, LMDSctCst,
  LMDSctClass, LMDSctScripter;

type
  { ******************* class TLMDScriptDebugNameProperty ****************** }

  TLMDScriptDebugNameProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

{ ******************* class TLMDScriptDebugNameProperty ********************** }
{ ------------------------------ public -------------------------------------- }

function TLMDScriptDebugNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paRevertable];
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDScriptDebugNameProperty.GetValues(Proc: TGetStrProc);
var
  dbg: TLMDScriptDebugger;
  i: Integer;
begin
  if GetComponent(0) is TLMDScriptControl then
  begin
    dbg := TLMDScriptControl(GetComponent(0)).Debugger;
    if dbg <> nil then
    begin
      for i := 0 to dbg.Modules.Count - 1 do
        if dbg.Modules[i].Name <> '' then
          Proc(dbg.Modules[i].Name);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }

end.
