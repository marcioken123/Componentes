unit pLMDElDBXTreeGridDsgn;
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

pLMDElDBXTreeGridDsgn unit
--------------------------


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
  pLMDElXGridColProp,
  pLMDElXStylesProp,
  ElDBXTreeGrids,
  ElDBXTree,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  LMDElDBConst
  ;

type
  TElDBXTreeGridEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer) : string; override;
    function GetVerbCount : Integer; override;
  end;

implementation

procedure TElDBXTreeGridEditor.ExecuteVerb(Index : Integer);
var Form : TCustomForm;
begin
  case Index of
    0:
      begin
        with TXColumnDefs.Create(Application) do
        begin
          try
            AComp := Component;
            DStylesDefs := TCustomElDBXTree(AComp).StylesDefs;
            if TCustomElDBXTree(AComp).StylesDefs.Count > 0 then
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
    1:
      begin
        with TNewStylesPropDlg.Create(Application) do
        begin
          try
            AComp := Component;
            DStylesDefs := TCustomElDBXTree(AComp).StylesDefs;
            if TCustomElDBXTree(AComp).StylesDefs.Count > 0 then
              begin
                ShowModal;
                Form := GetParentForm(Component as TControl);
                if (Form <> nil) and (Form.Designer <> nil) then
                  Form.Designer.Modified;
              end
            else ShowMessage (SNoSetInstall);
          finally
            Free;
          end;
        end;
      end;
  end;

end;

function TElDBXTreeGridEditor.GetVerb(Index : Integer) : string;
begin
  case Index of
    0 : Result := 'Columns...';
    1 : Result := 'Styles...';
  else ;
  end;
end;

function TElDBXTreeGridEditor.GetVerbCount : Integer;
begin
  Result := 2;
end;

end.
