unit pLMDElDBTreeGridDsgn;
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

pLMDElDBTreeGridDsgn unit
-------------------------


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
  Forms,
  Dialogs,
  pLMDElGridColProp,
  ElDbTreeGrids,
  ElDBtree,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  LMDElDBConst;

type
  TElDBTreeGridEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

implementation

procedure TElDBTreeGridEditor.ExecuteVerb(Index : Integer);
var Form : TCustomForm;
begin
  if Index = 0 then
    with TColumnDefs.Create(Application) do
    begin
      try
        AComp := Component;
        DStylesDefs := TCustomElDBTree(AComp).StylesDefs;
        if TCustomElDBTree(AComp).StylesDefs.Count > 0 then
          begin
            ShowModal;
            Form := GetParentForm(Component as TControl);
            if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;
          end
        else ShowMessage (SNoSetInstall);
      finally
        Free;
      end;
    end;
end;

function TElDBTreeGridEditor.GetVerb(Index : Integer) : string;
begin
  if Index = 0 then
    Result := 'Columns...'
  else
end;

function TElDBTreeGridEditor.GetVerbCount : Integer;
begin
  Result := 1;
end;

end.
