unit pLMDControlFaceEditorDlg;
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

pLMDControlFaceEditorDlg unit (JH)
----------------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, StdCtrls,
  Dialogs, ComCtrls, ImgList,
  LMDCFCStateObject, LMDCustomListBox, LMDCustomImageListBox, LMDCustomCheckListBox,
  LMDCheckListBox, Menus, LMDBaseController, LMDCustomContainer, LMDCustomImageList,
  LMDImageListConnector, LMDCustomComponent, LMDFaceController, LMDCustomParentPanel,
  LMDCustomPanelFill, LMDBaseGraphicButton, LMDCustomSpeedButton, LMDSpeedButton,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtCombo, 
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDSimpleLabel, LMDCustomScrollBox, LMDScrollBox, LMDSplt, LMDCustomButton,
  LMDButton, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel, LMDSimplePanel,
  LMDImageList, LMDCustomBrowseEdit, LMDBrowseEdit, LMDIniCtrl,
  LMDBaseControl, LMDControl;

type
  TfrmLMDControlFaceComponentEditor = class(TForm)
    dialogPanel: TLMDSimplePanel;
    EditFaceController: TLMDFaceController;
    ImgCon: TLMDImageListConnector;
    settingObjectsPics: TImageList;
    PopupMenu1: TPopupMenu;
    mnuAddState: TMenuItem;
    SplitterPanel: TLMDSplitterPanel;
    LMDSplitterPane5: TLMDSplitterPane;
    LMDSplitterPane6: TLMDSplitterPane;
    LMDSimplePanel2: TLMDSimplePanel;
    statesHeaderPanel: TLMDSimplePanel;
    LMDSimplePanel3: TLMDSimplePanel;
    controllerStateList: TLMDCheckListBox;
    LMDSplitterPane1: TLMDSplitterPane;
    stateObjectInfoPanel: TLMDSimplePanel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    stateObjectList: TListView;
    LMDImageList1: TLMDImageList;
    btnLoad: TLMDSpeedButton;
    btnSave: TLMDSpeedButton;
    btnAddState: TLMDSpeedButton;
    remove: TLMDSpeedButton;
    LMDSimpleLabel1: TLMDSimpleLabel;
    clear: TLMDSpeedButton;
    objectsEditPanel: TLMDSimplePanel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSpeedButton1: TLMDSpeedButton;
    LMDSpeedButton2: TLMDSpeedButton;
    LMDSpeedButton3: TLMDSpeedButton;
    LMDSpeedButton4: TLMDSpeedButton;
    btnProp: TLMDSpeedButton;
    LMDSpeedButton5: TLMDSpeedButton;
    LMDSpeedButton6: TLMDSpeedButton;
    LMDSpeedButton7: TLMDSpeedButton;
    LMDSpeedButton8: TLMDSpeedButton;
    LMDSpeedButton9: TLMDSpeedButton;
    LMDSpeedButton10: TLMDSpeedButton;
    controllerObjectsList: TListView;
    mnuProperties: TMenuItem;
    popMnuStateObjects: TPopupMenu;
    Edit1: TMenuItem;
    mnuRemove: TMenuItem;
    LMDButton3: TButton;
    LMDButton4: TButton;
    ini: TLMDIniCtrl;
    FEdit: TLMDBrowseEdit;
    Label1: TLabel;
    odlg: TOpenDialog;
    sdlg: TSaveDialog;
    LMDSpeedButton11: TLMDSpeedButton;
    LMDSpeedButton13: TLMDSpeedButton;
    procedure controllerStateListClick(Sender: TObject);
    procedure stateObjectListDragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure stateObjectListDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnAddObject(Sender: TObject);
    procedure btnStateClick(Sender: TObject);
    procedure mnuAddStateClick(Sender: TObject);
    procedure btnObjectClick(Sender: TObject);
    procedure controllerObjectsListKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure controllerObjectsListEdited(Sender: TObject; Item: TListItem;var S: String);
    procedure stateObjectListDblClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FUsedStates: TStringList;

    procedure getAddInfo (l: TListItem);
    procedure updateControllerObjectList;
    procedure updateStateList;
    procedure updateStateObjectList;

    procedure BuildStateList(bs: TLMDStateKind; s: String; sl: TStringList);
  public
    procedure Edit (aFaceController: TLMDFaceController); overload;
    procedure Edit (aFaceStatesCollection: TLMDCFCStateObjects); overload;

    function FaceController: TLMDFaceController;
  end;

var
  frmLMDControlFaceComponentEditor: TfrmLMDControlFaceComponentEditor;

implementation

{$R *.dfm}

uses
  Commctrl,
  pLMDCst, pLMDCPGetCore,
  LMDTypes, LMDCFCSettingObject,
  LMD3DCaption,
  LMDFxCaption,
  LMDFillObject,
  LMDBitmapEffectObject,
  LMDBevel,
  LMDObject,
  pLMDControlFaceEditorDlgAddState,
  LMDStyleMan;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.getAddInfo (l: TListItem);
var
  s: String;
  aObject:TPersistent;
begin
  aObject:=TPersistent(l.Data);
  l.SubItems.Add(aobject.ClassName);
  l.Caption:=FaceController.Settings.NameOfObject(aObject);
  // lmd object
  if aObject is TLMDObject then
    begin
      l.SubItems.Add(TLMDObject(aobject).GetSetStr);
    end
  // standard vcl object
  else if aobject is TFont then
    with TFont(aobject) do
      begin
        ColorToIdent(Color, s);
        //l.Caption := l.Caption + #10#13 +
        l.SubItems.Add('{'+ Name+'-'+IntToStr(Size)+'-'+s+'}');
      end;
  l.ImageIndex := Ord(LMDCFCGetSettingsKindObject(aObject));
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.updateControllerObjectList;
var
  i: Integer;
  l: TListItem;
begin
  controllerObjectsList.Items.Clear;
  for i := 0 to EditFaceController.Settings.Count - 1 do
    begin
      l := controllerObjectsList.Items.Add;
      l.Data := EditFaceController.Settings[i]; //.SettingObject;
      getAddInfo (l);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.updateStateList;
var
  i: Integer;
  s: String;

begin
  controllerStateList.Items.Clear;
  for i := 0 to EditFaceController.States.Count - 1 do
    begin
      s := LMDCFCgetStateDescription (EditFaceController.States[i].getKind);
      if s = '' then s := 'unknown state!!!';
      FUsedStates.Add (s);
      controllerStateList.Items.AddObject(s, EditFaceController.States[i]);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.updateStateObjectList;
var
  i: Integer;
  l: TListItem;
  //s: String;
begin
  stateObjectList.Items.Clear;
  if controllerStateList.Value=-1 then exit;

  with controllerStateList do
    for i:=0 to TLMDCFCStateObject(Items.Objects[Value]).Settings.Count-1 do
      begin
        l:=stateObjectList.Items.Add;
        l.Data:=TLMDCFCStateObject(Items.Objects[Value]).Settings.Objects[i];
        getAddInfo (l);
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.Edit (aFaceController: TLMDFaceController);
begin
  EditFaceController.Assign(aFaceController);

  updateControllerObjectList;       // ok
  updateStateList;                  // ??
  updateStateObjectList;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.Edit (aFaceStatesCollection: TLMDCFCStateObjects);
begin
  EditFaceController.States.Assign(aFaceStatesCollection);
  updateControllerObjectList;
  updateStateList;
  updateStateObjectList;
end;

{ ---------------------------------------------------------------------------- }
function TfrmLMDControlFaceComponentEditor.FaceController: TLMDFaceController;
begin
  result := EditFaceController;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.controllerStateListClick(Sender: TObject);
begin
  updateStateObjectList;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.stateObjectListDragOver(Sender,
  Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
  if Source = controllerObjectsList then Accept := true;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.stateObjectListDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  with controllerStateList do
    begin
      if Value=-1 then exit;  // no item selected
      TLMDCFCStateObject(Items.Objects[Value]).Add(TPersistent(controllerObjectsList.Selected.Data), true);
      updateStateObjectList;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.BuildStateList(bs: TLMDStateKind; s: String; sl: TStringList);
var
  sk : TLMDStateKind;
begin
  //sk := Low (TLMDStateKind);
  if bs = High (TLMDStateKind) then
    begin
      sl.Add (s);
      exit;
    end;
  sk := Succ (bs);
  BuildStateList (sk, s + '  '+ TLMDStateKindStr[sk], sl);
  BuildStateList (sk, s + ' !'+TLMDStateKindStr[sk], sl);
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.FormCreate(Sender: TObject);
begin
  ini.RegPath:=LMDTOOLS_REGISTRYPATH+'\TLMDFaceController';
  fedit.Path:=ini.ReadString(IDS_ROOT, 'FilePath','');
  FUsedStates:= TStringList.Create;
  {$IFDEF LMDCOMP11}FEdit.CtlXP:=true;{$ENDIF}  
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.FormDestroy(Sender: TObject);
begin
  ini.Writestring(IDS_ROOT, 'FilePath',fedit.Path);
  FreeAndNil(FUsedStates);
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.btnAddObject(Sender: TObject);
var
  sObjKind: TLMDCFCSettingObjectKind;
  sk: TLMDStateKind;
  i: integer;
begin
  sObjKind := TLMDCFCSettingObjectKind(TLMDSpeedButton(Sender).ImageIndex);
  if sObjKind = cfcStyle then
    for sk := low(TLMDStateKind) to high(TLMDStateKind) do
      begin
        i := editFaceController.AddSettingObject(cfcStyle);
        TLMDStyleObject(editFaceController.Settings.Items[i]).StyleName := StateStyleNames[sk];
        updateControllerObjectList;
      end
  else
    begin
      editFaceController.AddSettingObject(sObjKind);
      updateControllerObjectList;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.btnStateClick(Sender: TObject);
var
  i, tmp: Integer;
begin
  case Integer(TComponent(Sender).Tag) of
    100: with odlg do
           begin
             InitialDir:=FEdit.Path;
             DefaultExt:='fcstates';
             FileName:='*.fcstates';
             Filter:='States and Settings ((*.fcstates))|*.fcstates';
             if Execute then
               begin
                 FUsedStates.Clear;
                 EditFaceController.States.Clear;
                 EditFaceController.Settings.Clear;
                 EditFaceController.LoadFromFile(FileName);
                 updateControllerObjectList;
                 updateStateList;
                 updateStateObjectList;
                 if (ControllerStateList.Items.Count>0) and (ControllerStateList.Value=-1) then
                   begin
                     ControllerStateList.Value:=0;
                     controllerStateListClick(nil);
                   end;
               end;
           end;
    110: with sdlg do
           begin
             InitialDir:=FEdit.Path;
             DefaultExt:='fcstates';
             FileName:='*.fcstates';
             Filter:='States and Settings ((*.fcstates))|*.fcstates';
             if Execute then
               EditFaceController.SaveToFile(FileName);
           end;
    120: with TfrmStateAddingDlg.Create (self) do
          try
            tmp:=controllerStateList.Value;
            init (FUsedStates);
            if ShowModal = mrOk then
              begin
                for i := 0 to notUsedStates.Items.Count - 1 do
                  if notUsedStates.Checked[i] then
                    begin
                      //add this state
                       EditFaceController.States.Add.setKind(LMDCFCgetStateByDescription(notUsedStates.Items[i]));
                    end;
                updateStateList;
                if controllerStateList.Items.Count>0 then
                  if (tmp>-1) and (tmp<controllerStateList.Items.Count) then
                    controllerStateList.Value:=tmp
                  else
                    controllerStateList.Value:=0;
                updateStateObjectList;
              end;
          finally
            Free;
          end;
    130: begin
           tmp:=controllerStateList.Value;
           if tmp=-1 then exit;
           EditFaceController.States.Delete(tmp);
           updateStateList;
           if controllerStateList.Items.Count>0 then
             if (tmp>-1) and (tmp<controllerStateList.Items.Count) then
               controllerStateList.Value:=tmp
             else
               controllerStateList.Value:=0;
           updateStateObjectList;
         end;
    140: if controllerStateList.Items.Count>0 then
           if MessageDlg('Do you really want to delete list of states?', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             begin
               FUsedStates.Clear;
               EditFaceController.States.Clear;
               updateStateList;
               updateStateObjectList;
             end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.mnuAddStateClick(Sender: TObject);
begin
  if controllerStateList.Value=-1 then exit;
  //if not Assigned (controllerStateList.Selected) then exit;
  if not Assigned (controllerObjectsList.Selected) then exit;
  TLMDCFCStateObject (controllerStateList.Items.Objects[controllerStateList.Value]). Add(TPersistent(controllerObjectsList.Selected.Data), true);
  updateStateObjectList;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.btnObjectClick(Sender: TObject);
begin
  case Integer(TComponent(Sender).Tag) of
    200: with odlg do
           begin
             InitialDir:=FEdit.Path;
             DefaultExt:='fcsettings';
             FileName:='*.fcSettings';
             Filter:='FaceController Settings ((*.fcsettings))|*.fcsettings';
             if Execute then
               begin
                 FUsedStates.Clear;
                 EditFaceController.States.Clear;
                 EditFaceController.Settings.Clear;
                 EditFaceController.Settings.LoadFromFile(FileName);
                 updateControllerObjectList;
                 updateStateList;
                 updateStateObjectList;
               end;
           end;
    210: with sdlg do
           begin
             InitialDir:=FEdit.Path;
             DefaultExt:='fcsettings';
             FileName:='*.fcSettings';
             Filter:='FaceController Settings (*.fcsettings)|*.fcsettings';
             if Execute then
               EditFaceController.Settings.SaveToFile(FileName);
           end;
    220: if controllerObjectsList.Items.Count>0 then
           if MessageDlg('Do you really want to delete list of object settings?'#13'Note: All state settings will be cleared as well!', mtConfirmation, [mbYes,mbNo], 0) = mrYes then
             begin
               EditFaceController.Settings.Clear;
               FUsedStates.Clear;
               EditFaceController.States.Clear;
               updateControllerObjectList;
               updateStateList;
               updateStateObjectList;
             end;
    230: if Assigned(controllerObjectsList.Selected) then
           begin
              EditFaceController.RemoveSettingObject(TPersistent(controllerObjectsList.Selected.Data));
              updateControllerObjectList;
              updateStateObjectList;
           end;
    240: If Assigned(controllerObjectsList.Selected) then
             with controllerObjectsList.Selected  do
              if LMDCPGetSettingEditor(TPersistent(Data)) then updateControllerObjectList;
    250: If Assigned(stateObjectList.Selected) and (controllerStateList.Value>-1) then
           begin
             EditFaceController.States[controllerStateList.Value].Settings.Delete(stateObjectList.Selected.Index);
             updateStateObjectList;
           end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.controllerObjectsListKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_F2) and Assigned(controllerObjectsList.Selected) then
    ListView_EditLabel(controllerObjectsList.Handle, controllerObjectsList.Selected.Index);
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.controllerObjectsListEdited(Sender: TObject; Item: TListItem; var S: String);
begin
  if (EditFaceController.Settings.IndexOf(s)<>-1) and (s<>Item.Caption) then
    begin
      MessageDlg('This name exists in object list already!', mtError, [mbOK], 0);
      s:=Item.Caption;
    end
  else
    begin
      EditFaceController.Settings.Names[EditFaceController.Settings.IndexOfObject(TPersistent(Item.Data))]:=s;
      EditFaceController.States.SynchronizeNames;
      updateStateObjectList;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.stateObjectListDblClick(Sender: TObject);
var
  i:Integer;
begin
  if Assigned(stateObjectList.Selected) then
    with controllerObjectsList do
      for i:=0 to Items.Count-1 do
        if Items[i].Data=stateObjectList.Selected.Data then
          begin
            Selected:=Items[i];
            SetFocus;
            btnObjectClick(btnProp);
            exit;
          end;
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.PopupMenu1Popup(Sender: TObject);
begin
  mnuAddState.Enabled:=ControllerStateList.Value<>-1;
  mnuProperties.Enabled:=Assigned(controllerObjectsList.Selected);
end;

{ ---------------------------------------------------------------------------- }
procedure TfrmLMDControlFaceComponentEditor.FormShow(Sender: TObject);
begin
  if (ControllerStateList.Items.Count>0) and (ControllerStateList.Value=-1) then
    begin
      ControllerStateList.Value:=0;
      controllerStateListClick(nil);
    end;
end;

end.
