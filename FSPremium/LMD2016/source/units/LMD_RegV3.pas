unit LMD_RegV3;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description:
  # State: release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses Classes, DesignIntf, DesignEditors, VCLEditors,  TypInfo,
     {Standard Components}
     pLMDCECore, LMDSpltA, LMDShapeLabel, LMDTeethShape, LMDTeethShapeLabel,
     LMD3DShapeButton, LMD3DShapeLabelButton, LMDShapeLabelButton, LMD3DCaptionButton,
     LMDOfficeButton, LMDDockOfficeButton, LMDExplorerButton,
     {$IFNDEF LMDCOMP21}{$IFDEF LMDCOMP16}Bde.DBTables,{$ELSE}DBTables,{$ENDIF}{$ENDIF}
     DB, LMDDBFilter, LMDDBShapeLabel, LMDDBAliasNamesComboBox, LMDDBDriverComboBox,
     LMDDBTablesComboBox;


type
    {----------------------------------------------------------------------------}
    TLMDSplitterComponentEditor = class(TComponentEditor)
    public
      procedure ExecuteVerb(Index: Integer); override;
      function GetVerb(Index: Integer): string; override;
      function GetVerbCount: Integer; override;
    end;

    TLMDDBStringProperty = class(TStringProperty)
    public
      function GetAttributes: TPropertyAttributes; override;
      procedure GetValueList(List: TStrings); virtual;
      procedure GetValues(Proc: TGetStrProc); override;
    end;

    {$IFNDEF LMDCOMP21}
    TLMDDBDatabaseNameProperty = class (TLMDDBStringProperty)
    public
      procedure GetValueList(List: TStrings); override;
    end;

    TLMDDataFieldProperty = class(TLMDDBStringProperty)
    public
      function GetDataSourcePropName: string; virtual;
      procedure GetValueList(List: TStrings); override;
    end;
    {$ENDIF}
procedure Register;

implementation
{ ---------------------------------------------------------------------------- }
function TLMDDBStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBStringProperty.GetValueList(List: TStrings);
begin
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBStringProperty.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;


{$IFNDEF LMDCOMP21}
{ ---------------------------------------------------------------------------- }
procedure TLMDDBDatabaseNameProperty.GetValueList(List: TStrings);
begin
  Session.GetDatabaseNames (List);
end;

{ ---------------------------------------------------------------------------- }
function TLMDDataFieldProperty.GetDataSourcePropName: string;
begin
  Result := 'DataSource';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDataFieldProperty.GetValueList(List: TStrings);
var
  DataSource: TDataSource;
begin
  DataSource := GetObjectProp(GetComponent(0), GetDataSourcePropName) as TDataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil) then
    DataSource.DataSet.GetFieldNames(List);
end;
{$ENDIF}
{********************* Class TLMDSplitterComponentEditor **********************}
{------------------------------------------------------------------------------}
procedure TLMDSplitterComponentEditor.ExecuteVerb(Index: Integer);
begin
  with TLMDCustomSplitControl(Component) do
    case Index of
      0:RotatePanes;
    end;
  Designer.Modified;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterComponentEditor.GetVerb(Index: Integer): string;
begin
  case index of
    0: result:='Rotate Panes';
  end;
end;

{------------------------------------------------------------------------------}
function TLMDSplitterComponentEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

procedure Register;
begin

  {Obsolete controls of version 3.X}
  {****************************************************************************}
  RegisterComponents('LMD Old' ,    [TLMDOfficeButton,
                                      TLMDDockOfficeButton,
                                      TLMDExplorerButton,
                                      TLMD3DCaptionButton,
                                      TLMD3DShapeButton,
                                      TLMD3DShapeLabelButton,
                                      TLMD2PaneSplitCtrl,
                                      TLMD3PaneSplitCtrl,
                                      TLMD4Pane3SplitCtrl,
                                      TLMD4PaneSplitCtrl,
                                      TLMDShapeLabel,
                                      TLMDTeethShape,
                                      TLMDTeethShapeLabel,
                                      TLMDShapeLabelButton,
                                      TLMDDBFilter,
                                      TLMDDBShapeLabel,
                                      TLMDDBAliasNamesComboBox,
                                      TLMDDBTablesComboBox,
                                      TLMDDBDriverComboBox
                                    ]);

  {TLMDSplitCtrls}
  RegisterComponentEditor(TLMDCustomSplitControl, TLMDSplitterComponentEditor);

  {$IFNDEF LMDCOMP21}
  RegisterPropertyEditor (TypeInfo (String), TLMDDBTablesComboBox, 'DatabaseName', TLMDDBDatabaseNameProperty);
  {$ENDIF}
end;

end.
