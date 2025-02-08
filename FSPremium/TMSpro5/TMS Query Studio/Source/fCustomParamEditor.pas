unit fCustomParamEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, StdCtrls, Buttons, ExtCtrls, atVisualQuery, atMetaSQL,
  fCustomEditor;

type
  TfmCustomParamEditor = class(TfmCustomEditor)
    pnCaption: TPanel;
    Label5: TLabel;
    edCaption: TEdit;
    procedure btOkClick(Sender: TObject);
  private
    FParamType : TatParamType;
    procedure Localize;
  protected
    procedure Loaded; override;
    procedure DefaultCaptionFromParamName(AParamName: TComboBox);
    function ValidateParamName( combo: TComboBox ): boolean;
    property ParamType: TatParamType read FParamType write FParamType;
  public
  end;

var
  fmCustomParamEditor: TfmCustomParamEditor;

implementation

uses
  fCompareConditionEditor, qsRes;

{$R *.DFM}

{ TfmCustomParamEditor }

function TfmCustomParamEditor.ValidateParamName(combo: TComboBox): boolean;
begin
  { verifica se o nome do par�metro foi informado }
  ValidationError(
     (combo.Text=''),
     _str(SParamNameNotIndicated),
     [combo.Text],
     combo );

  { verifica se o nome do par�metro � v�lido }
  ValidationError(
     not IsValidIdent(combo.Text),
     _str(SParamNameNotValid),
     [combo.Text],
     combo );

  { se o par�metro ainda n�o existia ent�o permite criar uma condi��o do
    tipo ParamCompare associada a este novo par�metro }
  if MetaSql.Params.FindParam( combo.Text )=nil then
  begin
    { inclui uma condi��o com o assistente de inclus�o }
    with TfmCompareConditionEditor.Create(Application) do
    try
      { tenta ajustar as cordenadas da nova janela de modo a ficar
        lado-a-lado com a janela corrente }
      if Self.Left+Self.Width+Width<Screen.Width then
      begin
        Left := Self.Left + Self.Width - 3;
        Top := Self.Top;
      end
      else
      begin
        Left := Self.Left;
        Top := Self.Top + Self.Height - 3;
      end;
      VisualQuery := Self.VisualQuery;
      MetaSqlDef := Self.MetaSqlDef;
      EditedObject := Self.MetaSql.Conditions;

      { customize the interface to new ParamCondition }
      PreSelectedValue := ':'+combo.Text;
      edValue.Enabled := false;

      if (combo.ItemIndex>-1) and
         (combo.Items.Objects[combo.ItemIndex] is TatSqlField) then
      begin
        PreSelectedField := combo.Text;
        edField.Enabled := false;
      end;

      result := (ShowModal<>mrCancel);
    finally
      { reload param name combo, because addresses may be changed }
      LoadParamNameCombo(combo);
      Release;
    end;
  end
  else
    result := true;
end;

procedure TfmCustomParamEditor.btOkClick(Sender: TObject);
begin
  inherited;
  { verifica se a legenda do campo foi informada }
  ValidationError(
     (edCaption.Text=''),
     _str(SParamCaptionNotSpecified),
     [edCaption.Text],
     edCaption );
end;

procedure TfmCustomParamEditor.DefaultCaptionFromParamName(AParamName: TComboBox);
var cond : TatSqlCondition;
    fld : TatSqlField;
begin
  { se o par�metro se referir a um campo ent�o tr�s o nome do campo como
    descritivo sen�o tras o pr�prio nome do par�metro }
  if (edCaption.Text='') and (AParamName.Text>'') then
  begin
    if AParamName.ItemIndex>-1 then
      with AParamName do
        if Items.Objects[ItemIndex] is TatSqlField then
          { � campo ent�o pega sua legenda }
          edCaption.Text := TatSqlField(Items.Objects[ItemIndex]).DisplayLabel
        else
        begin
          edCaption.Text := AParamName.Text;

          { � par�metro ent�o encontra a condi��o que usou este par�metro,
            se ela for uma compara��o ent�o pega a legenda do campo comparado,
            sen�o deixa o pr�prio nome do par�metro }
          cond := MetaSql.FindConditionByParamName( AParamName.Text );
          if Assigned(cond) then
          begin
            fld := cond.Field;
            if Assigned(fld) then
              edCaption.Text := fld.DisplayLabel
            else
              { estava na condi��o, mas a condi��o n�o era uma compara��o,
                ent�o usa o Text da condi��o como legenda }
              edCaption.Text := cond.Text;
          end;
        end
    else
      edCaption.Text := AParamName.Text;
  end;
end;

procedure TfmCustomParamEditor.Localize;
begin
  Self.Caption := _str('fmCustomParamEditor.Self.Caption');
  Label5.Caption := _str('fmCustomParamEditor.Label5.Caption');
end;

procedure TfmCustomParamEditor.Loaded;
begin
  inherited;
  Localize;
end;

end.

