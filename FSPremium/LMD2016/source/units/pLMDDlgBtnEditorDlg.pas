unit pLMDDlgBtnEditorDlg;
{$I lmdcmps.Inc}

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

pLMDDlgBtnEditorDlg unit (RM)
-----------------------------

Component Editor form for TLMDDlgButtonPanel

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Consts, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, Registry, ImgList, 
  LMDCustomControl, LMDCustomGroupBox, LMDCustomColorComboBox, LMDBaseGraphicButton, LMDCustomSpeedButton,
  LMDCustomPanel, LMDCustomBevelPanel, LMDCustomParentPanel, LMDCustomPanelFill, LMDPanelFill,
  LMDDockSpeedButton, LMDGroupBox, LMDColorComboBox, LMDCustomComponent, LMDCustomComboBox, 
  LMDCustomButtonGroup, LMDCustomCheckGroup, LMDCheckGroup, LMDNoteBook, LMDCustomRadioGroup,
  LMDRadioGroup, LMDButtonControl, LMDRadioButton, LMDSimpleLabel, LMDClass,
  LMDBaseGraphicControl, LMDBaseLabel, LMDCustomSimpleLabel,
  LMDCustomDockLabel, LMDDockLabel, LMDBaseEdit, LMDCustomEdit,
  LMDCustomMaskEdit, LMDCustomExtSpinEdit, LMDSpinEdit,
  LMDDlgButtonPanel, LMDButton, LMDCustomCheckBox, LMDCheckBox,
  LMDCustomScrollBox, LMDListBox, LMDCont, LMDSpeedButton, LMDImageList,
  LMDBaseController, LMDCustomContainer, LMDCustomImageList, LMDThemes,
  LMDBaseControl, LMDCustomSheetControl, LMDControl;

const
  regentry:String='LMDDlgButtonEditor';

type
  TLMDDlgButtonEditorDlg = class(TForm)
    ok: TButton;
    Button1: TButton;
    nb: TLMDNoteBook;
    LMDNoteBookPage1: TLMDNoteBookPage;
    chk: TLMDCheckGroup;
    rb1: TLMDRadioButton;
    rb2: TLMDRadioButton;
    list2: TLMDRadioGroup;
    ext1: TLMDSpinEdit;
    ext2: TLMDSpinEdit;
    LMDDockLabel1: TLMDDockLabel;
    LMDDockLabel2: TLMDDockLabel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    LMDNoteBookPage2: TLMDNoteBookPage;
    chkr: TLMDCheckBox;
    up: TLMDSpeedButton;
    Down: TLMDSpeedButton;
    LMDImageList1: TLMDImageList;
    lbl: TLabel;
    lb: TLMDListBox;
    chkr2: TLMDCheckBox;
    rbal: TLMDRadioGroup;
    procedure chkClick(Sender: TObject);
    procedure list2Click(Sender: TObject);
    procedure okClick(Sender: TObject);
    procedure chkChange(Sender: TObject; ButtonIndex: Integer);
    procedure lbClick(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FChecked:TMsgDlgButtons;
    procedure InsertButtons(aValue:TMsgDlgButtons; Extra:Boolean);
  public
    BtnPanel:TLMDDlgButtonPanel;
    FForm:TCustomForm;
    procedure GetIniSettings;
    procedure SetIniSettings;
    procedure LBFill;
  end;

implementation

uses
  Variants, 
  LMDTypes, LMDProcs, pLMDPECst, pLMDCst;

{$R *.DFM}

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.GetIniSettings;
var
  i:Integer;
begin
  FChecked:=[];
  with TRegIniFile.Create(LMDTOOLS_REGISTRYPATH) do
    try
       ext1.Value:=ReadInteger(regentry, 'Width', 75);
       ext2.Value:=ReadInteger(regentry, 'Height', 25);
       chk.Value:=ReadInteger(regentry, 'CheckGroup', 0);
       chkr.Checked:=Boolean(ReadInteger(regentry, 'RemoveButtons', 0));
       chkr2.Checked:=Boolean(ReadInteger(regentry, 'RightBottom', 0));
       list2.ItemIndex:=ReadInteger(regentry, 'RadioGroup', -1);
       rbal.ItemIndex:=ReadInteger(regentry, 'Align', 5);
       for i:=0 to Pred(chk.Items.Count) do
         if chk.Checked[i] then Include(FChecked, TMsgDlgBtn(i));
       if ReadInteger(regentry, 'Checked',0)=0 then
         rb1.Checked:=true
       else
         rb2.Checked:=true;
     finally
       Free;
     end;

end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.SetIniSettings;
begin
  with TRegIniFile.Create(LMDTOOLS_REGISTRYPATH) do
    try
       WriteInteger(regentry, 'Width', ext1.AsInteger);
       WriteInteger(regentry, 'Height', ext2.AsInteger);
       WriteInteger(regentry, 'Checked', Ord(rb2.Checked));
       WriteInteger(regentry, 'CheckGroup',chk.Value);
       WriteInteger(regentry, 'RadioGroup', list2.ItemIndex);
       WriteInteger(regentry, 'RemoveButtons', Ord(chkr.Checked));
       WriteInteger(regentry, 'RightBottom', Ord(chkr2.Checked));
       WriteInteger(regentry, 'Align', rbal.ItemIndex);
     finally
       Free;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.InsertButtons(aValue:TMsgDlgButtons; Extra:Boolean);
var
  i, DefaultButton, CancelButton:TMsgDlgBtn;
  j:Integer;
const
  ButtonCaptions: array[TMsgDlgBtn] of String= (SMsgDlgYes, SMsgDlgNo, SMsgDlgOK, SMsgDlgCancel, SMsgDlgAbort,
                                                SMsgDlgRetry, SMsgDlgIgnore, SMsgDlgAll, SMsgDlgNoToAll,
                                                SMsgDlgYesToAll, SMsgDlgHelp{$ifdef LMDCOMP12}, sMsgDlgClose{$endif});
  ModalResults: array[TMsgDlgBtn] of Integer = (mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore,
                                                mrAll, mrNoToAll, mrYesToAll, 0{$ifdef LMDCOMP12}, 0{$endif});
  ButtonNames: array[TMsgDlgBtn] of string =   ('Yes', 'No', 'OK', 'Cancel', 'Abort',
                                                'Retry', 'Ignore', 'All', 'NoToAll', 'YesToAll', 'Help'{$ifdef LMDCOMP12}, 'Close'{$endif});
begin

  if chkr.Checked then
    try
      BtnPanel.BeginUpdate;
      for j:=Pred(BtnPanel.ControlCount) downto 0 do
        if (BtnPanel.Controls[j] is TButton) then
          TButton(BtnPanel.Controls[j]).Free;
    finally
      BtnPanel.EndUpdate(true);
    end;

  if aValue=[] then exit;
  BtnPanel.BeginUpdate;
  try
    if mbOk in aValue then
      DefaultButton:=mbOk
    else
      if mbYes in aValue then
        DefaultButton := mbYes
      else
        DefaultButton := mbRetry;
      if mbCancel in aValue then
        CancelButton := mbCancel
      else
        if mbNo in aValue then
          CancelButton := mbNo
        else
          CancelButton := mbOk;

    for i:=Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if i in aValue then
        with TLMDButton.Create(FForm) do
          begin
            Name:=FForm.Designer.UniqueName('btn'+ButtonNames[i]);
            Parent:=BtnPanel;
            Caption:=ButtonCaptions[i];
            Width:=ext1.AsInteger;
            Height:=ext2.AsInteger;
            ModalResult:=ModalResults[i];
            if i=DefaultButton then Default:=True;
            if i=CancelButton then Cancel:=True;
            if (i=mbHelp) and Extra then Tag:=Variant(10);
          end;

     if chkr2.Checked then
       BtnPanel.BtnAlign:=baRightBottom;

     if rbAl.ItemIndex<5 then
       BtnPanel.Align:=TAlign(rbAl.ItemIndex);

  finally
    BtnPanel.EndUpdate(True);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.LBFill;
var
  i:Integer;
begin
  for i:=0 to Pred(BtnPanel.ControlCount) do
    if (BtnPanel.Controls[i] is TButton) then
      lb.Items.AddObject(BtnPanel.Controls[i].Name+';'+TButton(BtnPanel.Controls[i]).Caption, BtnPanel.Controls[i]);
  if lb.Items.Count>0 then
    lb.ItemIndex:=0;
  lbClick(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.chkClick(Sender: TObject);
begin
  rb1.Checked:=True;
end;

procedure TLMDDlgButtonEditorDlg.FormCreate(Sender: TObject);
begin
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.list2Click(Sender: TObject);
begin
  rb2.Checked:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.okClick(Sender: TObject);
var
  i:Integer;
begin
  if nb.PageIndex=0 then
    begin
      if rb1.Checked then
        InsertButtons(FChecked, false)
      else
        begin
          Case list2.ItemIndex of
            0: FChecked:=[mbOK, mbCancel, mbHelp];
            1: FChecked:=[mbOK, mbCancel, mbHelp];
            2: FChecked:=[mbOK, mbCancel];
            3: FChecked:=[mbYes, mbNo, mbCancel];
            4: FChecked:=[mbAbort, mbRetry, mbIgnore];
          end;
          InsertButtons(FChecked, list2.ItemIndex=1);
        end;
    end
  else
    with FForm do
      begin
        BtnPanel.BeginUpdate;
        for i:=Pred(lb.Items.count) Downto 0 do
          TButton(lb.Items.Objects[i]).Parent:=nil;
        for i:=0 to Pred(lb.Items.count) do
          TButton(lb.Items.Objects[i]).Parent:=BtnPanel;
        BtnPanel.EndUpdate(True);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.chkChange(Sender: TObject;
  ButtonIndex: Integer);
begin
  if chk.Checked[ButtonIndex] then
    Include(FChecked,TMsgDlgBtn(ButtonIndex))
  else
    Exclude(FChecked,TMsgDlgBtn(ButtonIndex));
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.lbClick(Sender: TObject);
begin
  {Down}
  Down.Enabled:=(lb.Itemindex>-1) and (lb.itemindex<lb.items.count-1);
  {up}
  Up.Enabled:=(lb.Itemindex>0);
end;

{------------------------------------------------------------------------------}
procedure TLMDDlgButtonEditorDlg.btnClick(Sender: TObject);
var
  tmp:Integer;
begin
  tmp:=lb.Itemindex;
  if sender=up then lb.items.ExChange(tmp, tmp-1);
  if sender=down then lb.items.ExChange(tmp, tmp+1);
  lbClick(nil);
end;

end.
