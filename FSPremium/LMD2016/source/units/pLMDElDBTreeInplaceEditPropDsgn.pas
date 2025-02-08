unit pLMDElDBTreeInplaceEditPropDsgn;
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

pLMDElDBTreeInplaceEditPropDsgn unit
------------------------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Db,
  DBCtrls,
  TypInfo,
  Dialogs,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ElDBTree,
  ElDBXTree;

type

  TELDBTreeProperty = class(TComponentProperty)
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

implementation
{ TELDBTreeProperty }

function TELDBTreeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList];
end;

procedure TELDBTreeProperty.GetValues(Proc: TGetStrProc);
begin
  Designer.GetComponentNames(GetTypeData(TCustomElDBTree.ClassInfo), Proc);
  Designer.GetComponentNames(GetTypeData(TCustomElDBXTree.ClassInfo), Proc);
end;

procedure TELDBTreeProperty.SetValue(const Value: string);
begin
  inherited SetValue(Value);
end;

end.
