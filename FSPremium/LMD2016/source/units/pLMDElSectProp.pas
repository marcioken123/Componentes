unit pLMDElSectProp;
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

pLMDElSectProp unit
-------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Math, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  ElHeader, StdCtrls, pLMDElSectEdit, ExtCtrls, ElXPThemedControl, LMDUtils,
  ElBtnCtl, ElPopBtn, ElListBox;

type
  TElSectionsPropDlg = class(TForm)
    OpenDlg : TOpenDialog;
    SaveDlg : TSaveDialog;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    TestHeader: TElHeader;
    Button2: TElPopupButton;
    Button3: TElPopupButton;
    AddBtn: TElPopupButton;
    DeleteBtn: TElPopupButton;
    EditBtn: TElPopupButton;
    UpBtn: TElPopupButton;
    DownBtn: TElPopupButton;
    LoadBtn: TElPopupButton;
    SaveBtn: TElPopupButton;
    DuplicateBtn: TElPopupButton;
    ReindexBtn: TElPopupButton;
    SecList: TElListBox;
    Button1: TElPopupButton;
    procedure LoadBtnClick(Sender : TObject);
    procedure SaveBtnClick(Sender : TObject);
    procedure EditBtnClick(Sender : TObject);
    procedure AddBtnClick(Sender : TObject);
    procedure DeleteBtnClick(Sender : TObject);
    procedure UpBtnClick(Sender : TObject);
    procedure DownBtnClick(Sender : TObject);
    procedure SecListClick(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure SecListKeyPress(Sender : TObject; var Key : Char);
    procedure SecListDblClick(Sender: TObject);
    procedure DuplicateBtnClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ReindexBtnClick(Sender: TObject);
  protected
    //Designer : TFormDesigner;
  public
    ASect : TElHeaderSections;
    procedure FillSecList;
    procedure SetData;
    procedure GetData;
  end;

implementation

{$R *.DFM}

type
  THackElHeaderSections = class(TElHeaderSections);

procedure TElSectionsPropDlg.FillSecList;
var j : integer;
    S : string;
    Section : TElHeaderSection;
begin
  for j := 0 to TestHeader.Sections.Count - 1 do
  begin
    Section := TestHeader.Sections.ItemByPos[j];
    S := IntToStr(Section.Index) + ' - ';
    if Section.Text = '' then
      S := S + '(Untitled)'
    else
      S := S + Section.Text;
    SecList.Items.AddObject(S, Section);
  end;
end;

procedure TElSectionsPropDlg.SetData;
begin
  TestHeader.Sections.Assign(ASect);

  if THackElHeaderSections(ASect).Owner <> nil then
    TestHeader.MultiSort := TElHeader(THackElHeaderSections(ASect).Owner).Multisort;
  FillSecList;
end;

procedure TElSectionsPropDlg.GetData;
begin
  ASect.Assign(TestHeader.Sections);
end;

procedure TElSectionsPropDlg.LoadBtnClick(Sender : TObject);
var
  j : integer;
  Form : TCustomForm;
  S: string;
  Section : TElHeaderSection;
begin
  if not OpenDlg.Execute then exit;
  TestHeader.Sections.LoadFromFile(OpenDlg.FileName);
  SecList.Items.Clear;
  for j := 0 to TestHeader.Sections.Count - 1 do // Iterate
  begin
    Section := TestHeader.Sections.ItemByPos[j];
    S := IntToStr(Section.Index) + ' - ';
    if Section.Text = '' then
      S := S + '(Untitled)'
    else
      S := S + Section.Text;
    SecList.Items.AddObject(S, Section);
  end;
  Form := GetParentForm(ASect.Owner);
  if (Form <> nil) and (Form.Designer <> nil) then
    Form.Designer.Modified;
end;

procedure TElSectionsPropDlg.SaveBtnClick(Sender : TObject);
begin
  if not SaveDlg.Execute then exit;
  TestHeader.Sections.SaveToFile(SaveDlg.FileName);
end;

procedure TElSectionsPropDlg.EditBtnClick(Sender : TObject);
var
  SectDlg : TSectEdit;
  THS : TElHeaderSection;
  S: string;
begin
  SectDlg := nil;
  if SecList.ItemIndex = -1 then exit;
  try
    SectDlg := TSectEdit.Create(self);
    THS := TElHeaderSection(SecList.Items.Objects[SecList.ItemIndex]);
    SectDlg.Item := THS;
    SectDlg.Items := TestHeader.Sections;
    SectDlg.Form := GetParentForm(ASect.Owner);
    SectDlg.SetData;
    if SectDlg.ShowModal = mrOk then
    begin
      SectDlg.GetData;
      S := IntToStr(THS.Index) + ' - ';
      if THS.Text = '' then
        S := S + '(Untitled)'
      else
        S := S + THS.Text;
      SecList.Items[SecList.ItemIndex] := S;
    end;
  finally
    SectDlg.Free;
  end;
  SecList.SetFocus;
end;

procedure TElSectionsPropDlg.AddBtnClick(Sender : TObject);
var
  THS : TElHeaderSection;
begin
  THS := TestHeader.Sections.AddSection;
  THS.Text := '';
  SecList.ItemIndex := SecList.Items.AddObject(IntToStr(THS.Index) + ' - (Untitled)', THS);
  SecList.SetFocus;
  SecListClick(Sender);
end;

procedure TElSectionsPropDlg.DeleteBtnClick(Sender : TObject);
var
  THS : TElHeaderSection;
  j : integer;
  i : integer;
  S: string;
  Section : TElHeaderSection;
begin
  if SecList.ItemIndex = -1 then exit;
  i := SecList.ItemIndex;
  THS := TElHeaderSection(SecList.Items.Objects[SecList.ItemIndex]);
  TestHeader.Sections.DeleteSection(THS);
  SecList.Items.Clear;
  for j := 0 to TestHeader.Sections.Count - 1 do // Iterate
  begin
    Section := TestHeader.Sections.ItemByPos[j];
    S := IntToStr(Section.Index) + ' - ';
    if Section.Text = '' then
      S := S + '(Untitled)'
    else
      S := S + Section.Text;
    SecList.Items.AddObject(S, Section);
  end;
  SecList.ItemIndex := Min(i, SecList.Items.Count - 1);
  SecList.SetFocus;
  SecListClick(Sender);
end;

procedure TElSectionsPropDlg.UpBtnClick(Sender : TObject);
var
  i : integer;
  THS : TElHeaderSection;
begin
  if SecList.ItemIndex = -1 then exit;
  i := SecList.ItemIndex;
  THS := TElHeaderSection(SecList.Items.Objects[i]);
  SecList.Items.Exchange(i, i - 1);
  TestHeader.Sections.MoveSection(THS, i - 1);
  SecList.ItemIndex := i - 1;
  SecListClick(Self);
end;

procedure TElSectionsPropDlg.DownBtnClick(Sender : TObject);
var
  i : integer;
  THS : TElHeaderSection;
begin
  if SecList.ItemIndex = -1 then exit;
  i := SecList.ItemIndex;
  THS := TElHeaderSection(SecList.Items.Objects[i]);
  SecList.Items.Exchange(i, i + 1);
  TestHeader.Sections.MoveSection(THS, i + 1);
  SecList.ItemIndex := i + 1;
  SecListClick(Self);
end;

procedure TElSectionsPropDlg.SecListClick(Sender : TObject);
var
  b : boolean;
begin
  if (SecList.ItemIndex = 0) or (SecList.ItemIndex = -1) then
    UpBtn.Enabled := false
  else
    UpBtn.Enabled := true;
  b := SecList.ItemIndex <> -1;
  if SecList.ItemIndex = SecList.Items.Count - 1 then
    DownBtn.Enabled := false
  else
    DownBtn.Enabled := true;
  DeleteBtn.Enabled := b;
  EditBtn.Enabled := b;
  DuplicateBtn.Enabled := b;
end;

procedure TElSectionsPropDlg.FormCreate(Sender : TObject);
begin
  SecListClick(sender);
end;

procedure TElSectionsPropDlg.SecListKeyPress(Sender : TObject;
  var Key : Char);
begin
  SecListClick(sender);
end;

procedure TElSectionsPropDlg.SecListDblClick(Sender: TObject);
begin
  EditBtnClick(Self);
end;

procedure TElSectionsPropDlg.DuplicateBtnClick(Sender: TObject);
var
  THS : TElHeaderSection;
  S    : string;
begin
  THS := TestHeader.Sections.AddSection;
  THS.Assign(TPersistent(SecList.Items.Objects[SecList.ItemIndex]));
  S := THS.Text;
  if S = '' then S := '(Untitled)';
  SecList.ItemIndex := SecList.Items.AddObject(IntToStr(THS.Index) + ' - ' + S, THS);
  SecList.SetFocus;
  SecListClick(Sender);
end;

procedure TElSectionsPropDlg.Button3Click(Sender: TObject);
var
  Form: TCustomForm;
begin
  ASect.Assign(TestHeader.Sections);
  Form := GetParentForm(ASect.Owner);
  if (Form <> nil) and (Form.Designer <> nil) then
    Form.Designer.Modified;
end;

procedure TElSectionsPropDlg.ReindexBtnClick(Sender: TObject);
begin
  TestHeader.Sections.Reindex;
  SecList.Items.Clear;
  FillSecList;
end;

end.
