unit ElInspectorEditors;
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

ElInspectorEditors unit
-----------------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  Graphics,
  Controls,
  TypInfo,
  Classes,
  SysUtils,
  Forms,
  Dialogs,
  LMDTypes,
  LMDUtils,
  ElTree,
  ElEdits,
  ElInspector,
  ElSpin,
  ElTreeInplaceEditors,
  ElTreeStdEditors,
  ElTreeColorCombo,
  ElTreeDTPickEdit,
  ElTreeComboBox,
  ElTreeCurrEdit,
  ElTreeMaskEdit,
  ElTreeMemoComboEdit,
  ElTreeMemoEdit,
  ElTreeModalEdit,
  ElTreeSpinEdit,
  ElTreeBtnEdit,
  ElClrCmb,
  ElCapPropDlg,
  ElPictPropDlg,
  LMDUnicodeStrings,
  LMDObjectList;

type
  TElInspectorProxy = class(TCustomElInspector)
  end;

  TElInspectorInplaceManager = class(TElTreeInplaceManager)
  public
    function GetSuitableEditor(AEditorClass: TClass): TElTreeInplaceEditor;
  end;

  TElHelperEditor = class(TObject)
  private
    FOwner: TElTreeInplaceEditor;
    FRebuild: boolean;
    Editor: TCustomElEdit;
    OldEditorProc: TWndMethod;
    procedure EditorWndProc(var Message : TMessage);
  protected
    procedure DoAfterOperation;
    procedure DoBeforeOpeation;
    procedure AssignValue;
  public
    constructor Create(AOwner: TElTreeInplaceEditor; const AEditor: TCustomElEdit);
    destructor Destroy; override;
  end;

  // Inplace Editors for inspector
  TElInspectorInplaceColorCombo = class(TElTreeInplaceColorCombo)
  private
    FElHelper: TElHelperEditor;
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
    procedure TriggerChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TElInspectorInplaceComboBox = class(TElTreeInplaceComboBox)
  private
    FElHelper: TElHelperEditor;
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
    procedure TriggerChange(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TriggerValidateResult(var InputValid : boolean); override;
  end;

  TElInspectorInplaceSpinEdit = class(TElTreeInplaceSpinEdit)
  private
    FElHelper: TElHelperEditor;
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TriggerValidateResult(var InputValid : boolean); override;
  end;

  TElInspectorInplaceFloatSpinEdit = class(TElTreeInplaceFloatSpinEdit)
  private
    FElHelper: TElHelperEditor;
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TriggerValidateResult(var InputValid : boolean); override;
  end;

  TElInspectorInplaceEdit = class(TElTreeInplaceEdit)
  private
    FElHelper: TElHelperEditor;
  protected
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TElInspectorInplaceButtonEdit = class(TElTreeInplaceButtonEdit)
  private
    FElHelper: TElHelperEditor;
  protected
    procedure BtnClick(Sender: TObject); virtual;
    procedure TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean); override;
    procedure TriggerBeforeOperation(var DefaultConversion: boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure TriggerValidateResult(var InputValid : boolean); override;
  end;

  TElInspectorInplaceStringsEdit = class(TElTreeInplaceButtonEdit)
  protected
    procedure BtnClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TElInspectorInplaceFontEdit = class(TElTreeInplaceButtonEdit)
  protected
    procedure BtnClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TElInspectorInplacePictureEdit = class(TElTreeInplaceButtonEdit)
  protected
    procedure BtnClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  ElRegisteredEditors: TElInspectorClassesList;

implementation

uses
  ElXPThemedControl;

type
  TElHackCustomEdit = class(TCustomElEdit)
    property AutoSize;
    property BorderStyle;
    property Flat;
  end;

{-**********************************************************************
   Class:    TElInspectorInplaceManager
***********************************************************************-}
function TElInspectorInplaceManager.GetSuitableEditor(AEditorClass: TClass): TElTreeInplaceEditor;
var
  i: Integer;
  Editor: TElTreeInplaceEditor;
  LName: string;
begin
  Result := nil;
  if Assigned(AEditorClass) then
  begin

    for i := 0 to FEditorsList.Count - 1 do
    begin
      Editor := TElTreeInplaceEditor(FEditorsList[i]);
      if (Editor.ClassType = AEditorClass) or (Editor.ClassNameIs(AEditorClass.ClassName)) then
      begin
        Result := Editor;
        exit;
      end;
    end;

    if not Assigned(Result) then
    begin
      Result := TElClassInplaceEditor(AEditorClass).Create(Owner);
      Result.Tree := TElTree(Owner);
      LName := AEditorClass.ClassName;
      Delete(LName, 1, 1);
      Result.Name := LName;
      RegisterEditor(Result);
    end;
  end;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceColorCombo
***********************************************************************-}
constructor TElInspectorInplaceColorCombo.Create(AOwner: TComponent);
begin
  inherited;
  FElHelper := TElHelperEditor.Create(Self, Editor);
  Editor.OnChange := TriggerChange;
end;

destructor TElInspectorInplaceColorCombo.Destroy;
begin
  FElHelper.Free;
  inherited;
end;

procedure TElInspectorInplaceColorCombo.TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean);
begin
  FElHelper.DoAfterOperation;
  inherited;
end;

procedure TElInspectorInplaceColorCombo.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  FElHelper.DoBeforeOpeation;
  Editor.Text := TElInspectorItem(Item).InspectorData.Value;
  inherited;
end;

procedure TElInspectorInplaceColorCombo.TriggerChange(Sender: TObject);
var
  LAccepted: Boolean;
begin
  LAccepted := False;
  try
    if Editor.Text = s_Custom then
    begin
      (TElInspectorItem(Item).TreeView as TCustomElInspector).TriggerValidateResult(Self, TElInspectorItem(Item).InspectorData, LAccepted);
      if LAccepted then
        TElInspectorItem(Item).InspectorData.Value := '$' + IntToHex(Editor.SelectedColor, 8)
    end
    else
    begin
      (TElInspectorItem(Item).TreeView as TCustomElInspector).TriggerValidateResult(Self, TElInspectorItem(Item).InspectorData, LAccepted);
      if LAccepted then
        TElInspectorItem(Item).InspectorData.Value := Editor.Text;
    end;
  except
    Exit;
  end;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceComboBox
***********************************************************************-}
constructor TElInspectorInplaceComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FElHelper := TElHelperEditor.Create(Self, Editor);
  Editor.OnDropDown := TriggerChange;
// TODO: addIgnorekillfocus
//  FIgnoreKillFocus := True;
end;

destructor TElInspectorInplaceComboBox.Destroy;
begin
  FElHelper.Free;
  inherited;
end;

procedure TElInspectorInplaceComboBox.TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean);
begin
  FElHelper.DoAfterOperation;
  inherited;
end;

procedure TElInspectorInplaceComboBox.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  inherited;
  FElHelper.DoBeforeOpeation;
  Editor.ItemIndex := TElInspectorItem(Item).InspectorData.GetValuesList(Editor.Items);
  TElInspectorProxy(Tree).TriggerGetValuesList(TElInspectorItem(Item), Editor.Items);
  end;

procedure TElInspectorInplaceComboBox.TriggerChange(Sender: TObject);
begin
  if not Editor.DroppedDown then
    FElHelper.AssignValue;
end;

procedure TElInspectorInplaceComboBox.TriggerValidateResult(var InputValid : boolean);
begin
  inherited;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceSpinEdit
***********************************************************************-}
constructor TElInspectorInplaceSpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FElHelper := TElHelperEditor.Create(Self, Editor);
end;

destructor TElInspectorInplaceSpinEdit.Destroy;
begin
  FElHelper.Free;
  inherited;
end;

procedure TElInspectorInplaceSpinEdit.TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean);
begin
  FElHelper.AssignValue;
  inherited;
end;

procedure TElInspectorInplaceSpinEdit.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  FElHelper.DoBeforeOpeation;
  Editor.MinValue := TElInspectorItem(Item).InspectorData.MinValue;
  Editor.MaxValue := TElInspectorItem(Item).InspectorData.MaxValue;
  Editor.Value := TElInspectorItem(Item).InspectorData.AsInteger;
  Editor.ButtonThinFrame := true;
  Editor.Height := Editor.Height - 2;
  inherited;
end;

procedure TElInspectorInplaceSpinEdit.TriggerValidateResult(var InputValid : boolean);
begin
  inherited;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceButtonEdit
***********************************************************************-}
constructor TElInspectorInplaceButtonEdit.Create(AOwner: TComponent);
begin
  inherited;
  Editor.ButtonCaption := '---';
  Editor.UseDisabledColors := True;
  Editor.OnButtonClick := BtnClick;
  FIgnoreKillFocus := True;

  FElHelper := TElHelperEditor.Create(Self, Editor);
end;

destructor TElInspectorInplaceButtonEdit.Destroy;
begin
  FElHelper.Free;
  inherited;
end;

procedure TElInspectorInplaceButtonEdit.BtnClick(Sender: TObject);
begin
  with TElCapPropDialog.Create(Self) do
  try
    Value := TElInspectorItem(Item).InspectorData.AsString;
    if ShowModal = mrOk then
    begin
      TElInspectorItem(Item).InspectorData.AsString := Value;
      Editor.Text := Value;
    end;
  finally
    Free;
  end;
end;

procedure TElInspectorInplaceButtonEdit.TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean);
begin
  FElHelper.AssignValue;
  inherited;
end;

procedure TElInspectorInplaceButtonEdit.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  FElHelper.DoBeforeOpeation;
  Editor.MaxLength := TElInspectorItem(Item).InspectorData.MaxValue;
  Editor.Text := TElInspectorItem(Item).InspectorData.Value;
  inherited;
end;

procedure TElInspectorInplaceButtonEdit.TriggerValidateResult(var InputValid : boolean);
begin
  inherited;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceFontEdit
***********************************************************************-}
constructor TElInspectorInplaceFontEdit.Create(AOwner: TComponent);
begin
  inherited;
  Editor.OnButtonClick := BtnClick;
  Editor.ButtonCaption := '---';
  Editor.ReadOnly := True;
  if Owner <> nil then
  begin
    if Assigned(TElInspector(Owner).InspectorStyle) then
    begin
      Editor.Color := TElInspector(Owner).InspectorStyle.Background;
      Editor.Font.Color := TElInspector(Owner).InspectorStyle.PropertyValue.Color;
    end
    else
    begin
      Editor.Color := TElInspectorProxy(Owner).BkColor;
      Editor.Font.Color := TElInspectorProxy(Owner).Font.Color;
    end;
  end;
  FIgnoreKillFocus := True;
end;

procedure TElInspectorInplaceFontEdit.BtnClick(Sender: TObject);
begin
  with TFontDialog.Create(Self) do
  try
    Font := (TElInspectorItem(Item).InspectorData.AsObject as TFont);
    Options := Options + [fdForceFontExist];
    if Execute then
    begin
      TElInspectorItem(Item).InspectorData.AsObject := Font;
      TCustomElInspector(Tree).Rebuild(TElInspectorItem(Item));
    end;
  finally
    Free;
  end;
end;

{-**********************************************************************
   Class:    TElInspectorInplacePictureEdit
***********************************************************************-}
constructor TElInspectorInplacePictureEdit.Create(AOwner: TComponent);
begin
  inherited;
  Editor.OnButtonClick := BtnClick;
  Editor.ButtonCaption := '---';
  Editor.ReadOnly := True;
  if Owner <> nil then
  begin
    if Assigned(TElInspector(Owner).InspectorStyle) then
    begin
      Editor.Color := TElInspector(Owner).InspectorStyle.Background;
      Editor.Font.Color := TElInspector(Owner).InspectorStyle.PropertyValue.Color;
    end
    else
    begin
      Editor.Color := TElInspectorProxy(Owner).BkColor;
      Editor.Font.Color := TElInspectorProxy(Owner).Font.Color;
    end;
  end;
  FIgnoreKillFocus := True;
end;

procedure TElInspectorInplacePictureEdit.BtnClick(Sender: TObject);
begin
  with TElPicturePropDialog.Create(Self) do
  try
    if (TElInspectorItem(Item).InspectorData.AsObject is TIcon) then
    begin
      Value.Icon := (TElInspectorItem(Item).InspectorData.AsObject as TIcon);
      IsIcon := true;
    end
    else
      if (TElInspectorItem(Item).InspectorData.AsObject is TBitmap) then
        Value.Graphic := TElInspectorItem(Item).InspectorData.AsObject as TBitmap
      else
        Value := (TElInspectorItem(Item).InspectorData.AsObject as TPicture);
    if ShowModal = mrOk then
    begin
      if (TElInspectorItem(Item).InspectorData.AsObject is TIcon) then
        TElInspectorItem(Item).InspectorData.AsObject := Value.Icon
      else
        if (TElInspectorItem(Item).InspectorData.AsObject is TBitmap) then
          TBitmap(TElInspectorItem(Item).InspectorData.AsObject).Assign(Value.Graphic)
        else
          TElInspectorItem(Item).InspectorData.AsObject := Value;
    end;
  finally
    Free;
  end;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceEdit
***********************************************************************-}
constructor TElInspectorInplaceEdit.Create(AOwner: TComponent);
begin
  inherited;
  FElHelper := TElHelperEditor.Create(Self, Editor);
end;

destructor TElInspectorInplaceEdit.Destroy;
begin
  FElHelper.Free;
  inherited;
end;

procedure TElInspectorInplaceEdit.TriggerAfterOperation(var Accepted: boolean; var DefaultConversion: boolean);
begin
  FElHelper.AssignValue;
  inherited;
end;

procedure TElInspectorInplaceEdit.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  FElHelper.DoBeforeOpeation;

  Editor.MaxLength := TElInspectorItem(Item).InspectorData.MaxValue;
  Editor.Text := TElInspectorItem(Item).InspectorData.Value;
  inherited;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceStringsEdit
***********************************************************************-}
constructor TElInspectorInplaceStringsEdit.Create(AOwner: TComponent);
begin
  inherited;
  Editor.ReadOnly := True;
  Editor.OnButtonClick := BtnClick;
  Editor.ButtonCaption := '---';
  FIgnoreKillFocus := True;
end;

procedure TElInspectorInplaceStringsEdit.BtnClick(Sender: TObject);
begin
  with TElCapPropDialog.Create(Self) do
  begin
    try
      {$ifdef LMD_UNICODE}
      if (TElInspectorItem(Item).InspectorData.AsObject is TLMDWideStrings) then
        Value := TLMDWideStrings(TElInspectorItem(Item).InspectorData.AsObject).Text
      else
      {$endif}
      Value := TStrings(TElInspectorItem(Item).InspectorData.AsObject).Text;
      if ShowModal = mrOk then
      begin
        {$ifdef LMD_UNICODE}
        if (TElInspectorItem(Item).InspectorData.AsObject is TLMDWideStrings) then
          TLMDWideStrings(TElInspectorItem(Item).InspectorData.AsObject).Text := Value
        else
        {$endif}
          TStrings(TElInspectorItem(Item).InspectorData.AsObject).Text := Value;
      end;
    finally
      Free;
    end;
  end;
end;

{-**********************************************************************
   Class:    TElInspectorInplaceFloatSpinEdit
***********************************************************************-}
constructor TElInspectorInplaceFloatSpinEdit.Create(AOwner: TComponent);
begin
  inherited;
  FElHelper := TElHelperEditor.Create(Self, Editor);
end;

destructor TElInspectorInplaceFloatSpinEdit.Destroy;
begin
  FElHelper.Free;
  inherited;
end;

procedure TElInspectorInplaceFloatSpinEdit.TriggerAfterOperation(var Accepted, DefaultConversion: boolean);
begin
  FElHelper.DoAfterOperation;
  inherited;
end;

procedure TElInspectorInplaceFloatSpinEdit.TriggerBeforeOperation(var DefaultConversion: boolean);
begin
  FElHelper.DoBeforeOpeation;

  Editor.MinValue := TElInspectorItem(Item).InspectorData.MinValue;
  Editor.MaxValue := TElInspectorItem(Item).InspectorData.MaxValue;

  Editor.Value := TElInspectorItem(Item).InspectorData.AsFloat;
  inherited;
end;

procedure TElInspectorInplaceFloatSpinEdit.TriggerValidateResult(var InputValid: boolean);
begin
  InputValid := True;
  try
    TElInspectorItem(Item).InspectorData.AsFloat := Editor.Value;
  except
    InputValid := False;
  end;
  inherited;
end;

{-**********************************************************************
   Class:    TElHelperEditor
***********************************************************************-}

constructor TElHelperEditor.Create(AOwner: TElTreeInplaceEditor; const AEditor: TCustomElEdit);
begin
  FOwner := AOwner;
  FRebuild := True;
  Editor := AEditor;
  with FOwner do
  begin
    OldEditorProc := Editor.WindowProc;
    Editor.WindowProc := EditorWndProc;
  end;
end;

procedure TElHelperEditor.DoAfterOperation;
begin
  FRebuild := False;
  AssignValue;
  FRebuild := True;
end;

procedure TElHelperEditor.DoBeforeOpeation;
begin
  (FOwner.Tree as TCustomElTree).IsUpdating := True;
  TElHackCustomEdit(Editor).AutoSize := False;
  TElHackCustomEdit(Editor).BorderStyle := bsNone;
  TElHackCustomEdit(Editor).Flat := True;
  Editor.Top := Editor.Top + 1;
  Editor.Height := (FOwner.Tree as TCustomElTree).Selected.Height - 2;
  // TODO: category widths
  if TElInspector(FOwner.Tree).VertScrollBarVisible and ((TElInspector(FOwner.Tree).HeaderSections[1].Width + TElInspector(FOwner.Tree).HeaderSections[0].Width) > (FOwner.Tree.Width - TElInspector(FOwner.Tree).VertScrollBarStyles.Width)) then
    Editor.Width := TElInspector(FOwner.Tree).HeaderSections[1].Width - TElInspector(FOwner.Tree).VertScrollBarStyles.Width;
  (FOwner.Tree as TCustomElTree).IsUpdating := false;
end;

procedure TElHelperEditor.AssignValue;
var
  LAccepted: Boolean;
begin
  (FOwner.Tree as TCustomElInspector).TriggerValidateResult(FOwner, TElInspectorItem(FOwner.Item).InspectorData, LAccepted);
  (FOwner.Tree as TCustomElTree).IsUpdating := True;
  if (TElInspectorItem(FOwner.Item).InspectorData.Value <> Editor.Text) and (LAccepted) then
  begin
    TElInspectorItem(FOwner.Item).InspectorData.Value := Editor.Text;
    TElInspectorItem(FOwner.Item).InspectorData.InspectorItem.ColumnText.Strings[0] := Editor.Text;
    if Assigned((FOwner.Item as TElTreeItem).Parent) and (not TElInspectorItem((FOwner.Item as TElTreeItem).Parent).IsCategory)  then
      (FOwner.Item as TElTreeItem).Parent.ColumnText.Strings[0] := TElInspectorItem((FOwner.Item as TElTreeItem).Parent).InspectorData.Value;
    if TElInspectorItem(FOwner.Item).InspectorData.IsComplex then
    begin
      if FRebuild then
        TCustomElInspector(FOwner.Tree).Rebuild(TElInspectorItem(FOwner.Item))
      else
        TCustomElInspector(FOwner.Tree).RebuildedItem := TElInspectorItem(FOwner.Item);
    end;
    Editor.SelectAll;
  end;
  if not (LAccepted) then
    Editor.Text := TElInspectorItem(FOwner.Item).InspectorData.Value;
  (FOwner.Tree as TCustomElTree).IsUpdating := false;
end;

procedure TElHelperEditor.EditorWndProc(var Message: TMessage);
begin
  if Message.Msg = WM_KEYDOWN then
  begin
    if (TWMKey(Message).CharCode = VK_RETURN) then
    AssignValue
    else
      OldEditorProc(Message);
  end
  else
    OldEditorProc(Message);
end;

destructor TElHelperEditor.Destroy;
begin
  Editor.WindowProc := OldEditorProc;
  inherited;
end;

end.
