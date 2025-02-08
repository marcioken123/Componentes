unit pLMDActnList;

interface

uses
  Classes, LMDActnList,
  DesignEditors, DesignWindows, DsnConst, DesignIntf;
 type
  TLMDActionListEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): String; override;
    function GetVerbCount: Integer; override;
  end;

implementation

uses
  pLMDActnListEditor;

procedure TLMDActionListEditor.ExecuteVerb(Index: Integer);
begin
  frmActionListEditor := TfrmActionListEditor.Create(nil);
  try
    frmActionListEditor.FActionList := TLMDActionList(Component);
    frmActionListEditor.FDesigner := Designer;
    frmActionListEditor.UpdateList;
    frmActionListEditor.Show;
    frmActionListEditor.BringToFront;
  finally
//    frmActionListEditor.Free;
  end;
end;

function TLMDActionListEditor.GetVerb(Index: Integer): String;
begin
  Result := 'LMD ActionList Editor...';
end;

function TLMDActionListEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

end.
