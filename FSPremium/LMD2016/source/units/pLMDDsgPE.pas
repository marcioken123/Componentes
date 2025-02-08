unit pLMDDsgPE;
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

pLMDDsgPE unit (YB)
------------------------
Unit contains property editors needed in  LMD Design Pack

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, TypInfo, DesignIntf, DesignEditors, VCLEditors, LMDDsgCst,
  LMDDsgClass, LMDDsgDiagram, pLMDCommon;

type
  { ********************* class TLMDDiagramItemRefProperty ******************* }

  TLMDDiagramItemRefProperty = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

implementation

uses
  Controls, LMDProcs, pLMDCst;

type
  TLMDCustomDiagramAccess = class(TLMDCustomDiagram);

{ ******************* class TLMDDiagramItemRefProperty *********************** }
{ ------------------------------ public -------------------------------------- }
function TLMDDiagramItemRefProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paRevertable];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemRefProperty.GetValues(Proc: TGetStrProc);
var
  LDiagram: TLMDCustomDiagram;
  LItems:   TLMDDiagramItems;
  LI:       Integer;
begin
  LDiagram := ((GetComponent(0) as TLMDDiagramLink).Collection as
    TLMDDiagramLinks).Diagram;

  LItems := TLMDCustomDiagramAccess(LDiagram).Items;
  for LI := 0 to LItems.Count - 1 do
    Proc(LItems[LI].Name);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDiagramItemRefProperty.SetValue(const Value: string);
var
  LDiagram: TLMDCustomDiagram;
  LItems:   TLMDDiagramItems;
begin
  LDiagram := ((GetComponent(0) as TLMDDiagramLink).Collection as
    TLMDDiagramLinks).Diagram;

  LItems := TLMDCustomDiagramAccess(LDiagram).Items;
  if (Value <> '') and (LItems.Find(Value) = nil) then
    raise EPropertyError.CreateFmt(SLMDNamedItemNotFound, [Value]);
    
  inherited SetValue(Value);
end;

{ ---------------------------------------------------------------------------- }

end.
