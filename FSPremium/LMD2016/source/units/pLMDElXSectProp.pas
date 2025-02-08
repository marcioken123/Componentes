unit pLMDElXSectProp;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author:             LMD Innovative ()
  # Created:
  # Description:
  # State:              release
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

uses
  Math, Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DesignEditors, DesignWindows, DsnConst, DesignIntf,
  LMDTypes,
  ElXHeader, ElXTreeCell, StdCtrls, pLMDElXSectEdit, ExtCtrls, ElXPThemedControl,
  ElHeader, ElPanel, ElGroupBox, ElCLabel, ElLabel, ElSpin, ElEdits, ElVCLUtils,
  ElBtnEdit, ElCombos, LMDGraphUtils, LMDUtils, ElBtnCtl, ElPopBtn,
  ElCGControl;

type
  TElXSectionsPropDlg = class(TForm)
    OpenDlg : TOpenDialog;
    SaveDlg : TSaveDialog;
    Panel3: TPanel;
    ScrollBox1: TScrollBox;
    GroupBox1: TElGroupBox;
    Panel1: TPanel;
    SecList: TListBox;
    Panel2: TPanel;
    GroupBox2: TElGroupBox;
    TestHeader: TElXHeader;
    ElPanel1: TElPanel;
    ElGroupBox1: TElGroupBox;
    ElPanel2: TElPanel;
    ElGroupBox2: TElGroupBox;
    CellEdit: TElEdit;
    RowCountSE: TElSpinEdit;
    RowHeightSE: TElSpinEdit;
    ElLabel1: TElLabel;
    ElLabel2: TElLabel;
    ElLabel3: TElLabel;
    ElPanel3: TElPanel;
    AlCB: TElComboBox;
    ElLabel4: TElLabel;
    Button1: TElPopupButton;
    Button2: TElPopupButton;
    Button3: TElPopupButton;
    MergeBtn: TElPopupButton;
    SplitBtn: TElPopupButton;
    AddBtn: TElPopupButton;
    DeleteBtn: TElPopupButton;
    EditBtn: TElPopupButton;
    UpBtn: TElPopupButton;
    DownBtn: TElPopupButton;
    LoadBtn: TElPopupButton;
    SaveBtn: TElPopupButton;
    DuplicateBtn: TElPopupButton;
    ReindexBtn: TElPopupButton;
    FontBtn: TElGraphicButton;
    FontDialog1: TFontDialog;
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
    procedure TestHeaderSectionCreate(Sender: TElXCustomHeader;
      Section: TElXHeaderSection);
    procedure TestHeaderSectionDelete(Sender: TElXCustomHeader;
      Section: TElXHeaderSection);
    procedure RowHeightSEChange(Sender: TObject);
    procedure RowCountSEChange(Sender: TObject);
    procedure CellEditChange(Sender: TObject);
    procedure TestHeaderSectionCellClick(Sender: TElXCustomHeader;
      Section: TElXHeaderSection; Cell: TElXHeaderCell);
    procedure TestHeaderSectionCellPostDraw(Sender: TElXCustomHeader;
      Canvas: TCanvas; Section: TElXHeaderSection; Cell: TElXHeaderCell;
      R: TRect; Pressed: Boolean);
    procedure TestHeaderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SplitBtnClick(Sender: TObject);
    procedure MergeBtnClick(Sender: TObject);
    procedure AlCBChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CellEditPasteClipboardText(Sender: TObject;
      var AClipboardText: TLMDString);
    procedure FontBtnClick(Sender: TObject);
  protected
    procedure ScrollCheck;
    //Designer : TFormDesigner;
  public
    ARow, ACol : integer;
//    ARowStart, AColStart : integer;
//    ARowEnd, AColEnd : integer;
//    ARowCount, AColCount : integer;
    ACellRange: TElXTreeCustomCellRange;
    ASect : TElXHeaderSections;
    FCtrlPressed: Boolean;
    FShiftPressed: Boolean;
    procedure FillSecList;
    procedure SetData;
    procedure GetData;
  end;

implementation

uses
  Types ;

{$R *.DFM}

type
  THackElXHeaderSections = class(TElXHeaderSections);

procedure TElXSectionsPropDlg.FillSecList;
var j : integer;
    S : string;
    Section : TElXHeaderSection;
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

procedure TElXSectionsPropDlg.SetData;

begin
  ARow := -1;
  ACol := -1;

  if THackElXHeaderSections(ASect).Owner <> nil then
  begin
    TestHeader.MultiSort := TElXHeader(THackElXHeaderSections(ASect).Owner).Multisort;
    TestHeader.RowCount := TElXHeader(THackElXHeaderSections(ASect).Owner).RowCount;
    TestHeader.RowHeight := TElXHeader(THackElXHeaderSections(ASect).Owner).RowHeight;
    RowCountSE.Value := TElXHeader(THackElXHeaderSections(ASect).Owner).RowCount;
    RowHeightSE.Value := TElXHeader(THackElXHeaderSections(ASect).Owner).RowHeight;
  end;
  TestHeader.Sections.Assign(ASect);

  if (TestHeader.RowCount > 0) and (TestHeader.Sections.Count > 0) then
  begin
    ARow := 0;
    ACol := 0;
  end;
  FillSecList;
  ScrollCheck;

  if THackElXHeaderSections(ASect).Owner <> nil then
    TestHeader.RightAlignedOrder := TElXHeader(THackElXHeaderSections(ASect).Owner).RightAlignedOrder;
  if ARow < 0 then
    ElGroupBox2.Enabled := false;
end;

procedure TElXSectionsPropDlg.GetData;

begin
  if THackElXHeaderSections(ASect).Owner <> nil then
  begin
    TElXHeader(THackElXHeaderSections(ASect).Owner).RowCount := TestHeader.RowCount;
    TElXHeader(THackElXHeaderSections(ASect).Owner).RowHeight := TestHeader.RowHeight;
  end;
  ASect.Assign(TestHeader.Sections);
end;

procedure TElXSectionsPropDlg.LoadBtnClick(Sender : TObject);
var
  j : integer;
  Form : TCustomForm;
  S: string;
  Section : TElXHeaderSection;
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

procedure TElXSectionsPropDlg.SaveBtnClick(Sender : TObject);
begin
  if not SaveDlg.Execute then exit;
  TestHeader.Sections.SaveToFile(SaveDlg.FileName);
end;

procedure TElXSectionsPropDlg.EditBtnClick(Sender : TObject);
var
  SectDlg : TXSectEdit;
  THS : TElXHeaderSection;
  S: string;
begin
  SectDlg := nil;
  if SecList.ItemIndex = -1 then exit;
  try
    SectDlg := TXSectEdit.Create(self);
    THS := TElXHeaderSection(SecList.Items.Objects[SecList.ItemIndex]);
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
  TestHeader.Repaint;
  SecList.SetFocus;
end;

procedure TElXSectionsPropDlg.AddBtnClick(Sender : TObject);
var
  THS : TElHeaderSection;
begin
  THS := TestHeader.Sections.AddSection;
  THS.Text := '';
  SecList.ItemIndex := SecList.Items.AddObject(IntToStr(THS.Index) + ' - (Untitled)', THS);
  SecList.SetFocus;
  SecListClick(Sender);
end;

procedure TElXSectionsPropDlg.DeleteBtnClick(Sender : TObject);
var
  THS : TElXHeaderSection;
  j : integer;
  i : integer;
  S: string;
  Section : TElXHeaderSection;
begin
  if SecList.ItemIndex = -1 then exit;
  i := SecList.ItemIndex;
  THS := TElXHeaderSection(SecList.Items.Objects[SecList.ItemIndex]);
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

procedure TElXSectionsPropDlg.UpBtnClick(Sender : TObject);
var
  i : integer;
  THS : TElXHeaderSection;
begin
  if SecList.ItemIndex = -1 then exit;
  i := SecList.ItemIndex;
  THS := TElXHeaderSection(SecList.Items.Objects[i]);
  SecList.Items.Exchange(i, i - 1);
  TestHeader.Sections.MoveSection(THS, i - 1);
  SecList.ItemIndex := i - 1;
  SecListClick(Self);
end;

procedure TElXSectionsPropDlg.DownBtnClick(Sender : TObject);
var
  i : integer;
  THS : TElXHeaderSection;
begin
  if SecList.ItemIndex = -1 then exit;
  i := SecList.ItemIndex;
  THS := TElXHeaderSection(SecList.Items.Objects[i]);
  SecList.Items.Exchange(i, i + 1);
  TestHeader.Sections.MoveSection(THS, i + 1);
  SecList.ItemIndex := i + 1;
  SecListClick(Self);
end;

procedure TElXSectionsPropDlg.SecListClick(Sender : TObject);
var
  b : boolean;
  i, j: integer;
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
  if (SecList.ItemIndex >= 0) then
  begin
    for i := 0 to TestHeader.RowCount - 1 do
    begin
      for j := 0 to TestHeader.Sections.Count - 1 do
      begin
        TestHeader.Rows[i].Cell[j].Tag := 0;
      end;
    end;
    ACellRange.Clear;
    FCtrlPressed := False;
    FShiftPressed := False;
    if Assigned(TestHeader.Sections[SecList.ItemIndex].Cell[0]) then
    begin
      TestHeader.Sections[SecList.ItemIndex].Cell[0].Tag := 1;
      ACellRange.Add(TestHeader.Sections[SecList.ItemIndex].Cell[0]);
      ARow := 0;
      ACol := TestHeader.Sections[SecList.ItemIndex].Position;
      ElGroupBox2.Caption := 'Cell '+IntToStr(ARow)+':'+IntToStr(ACol);
      CellEdit.Text := TestHeader.Sections[SecList.ItemIndex].Cell[0].Text;
      case TestHeader.Sections[SecList.ItemIndex].Cell[0].Alignment of
        hsaCenter: AlCB.ItemIndex := 1;
        hsaRight: AlCB.ItemIndex := 2;
        else AlCB.ItemIndex := 0;
      end;
      ElGroupBox2.Enabled := true;
    end;
    MergeBtn.Enabled := False;
    SplitBtn.Enabled := (TestHeader.Sections[SecList.ItemIndex].Cell[0].JointCellRole = jcrMaster);
    TestHeader.Repaint;
  end;
end;

procedure TElXSectionsPropDlg.FormCreate(Sender : TObject);
begin

  ScrollBox1.BevelInner := bvNone;
  ScrollBox1.BevelOuter := bvNone;

  SecListClick(sender);
  FCtrlPressed := false;
  FShiftPressed := false;
  ACellRange := TElXTreeCustomCellRange.Create;
end;

procedure TElXSectionsPropDlg.SecListKeyPress(Sender : TObject;
  var Key : Char);
begin
  SecListClick(sender);
end;

procedure TElXSectionsPropDlg.SecListDblClick(Sender: TObject);
begin
  EditBtnClick(Self);
end;

procedure TElXSectionsPropDlg.DuplicateBtnClick(Sender: TObject);
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

procedure TElXSectionsPropDlg.Button3Click(Sender: TObject);
var Form : TCustomForm;
begin
//  ASect.Assign(TestHeader.Sections);
  GetData;
  Form := GetParentForm(ASect.Owner);
  if (Form <> nil) and (Form.Designer <> nil) then
    Form.Designer.Modified;
end;

procedure TElXSectionsPropDlg.ReindexBtnClick(Sender: TObject);
begin
  TestHeader.Sections.Reindex;
  SecList.Items.Clear;
  FillSecList;
end;

procedure TElXSectionsPropDlg.TestHeaderSectionCreate(
  Sender: TElXCustomHeader; Section: TElXHeaderSection);
begin
  ScrollCheck;
end;

procedure TElXSectionsPropDlg.ScrollCheck;
begin
  ScrollBox1.HorzScrollBar.Range := TestHeader.SectionsWidth;
  Self.ClientHeight := TestHeader.Height + 23 + ElPanel1.Height + Panel3.Height;;
  if TestHeader.SectionsWidth > Self.Width then
    Self.ClientHeight := Self.ClientHeight + 16;
end;

procedure TElXSectionsPropDlg.TestHeaderSectionDelete(
  Sender: TElXCustomHeader; Section: TElXHeaderSection);
begin
  ScrollCheck;
end;

procedure TElXSectionsPropDlg.RowHeightSEChange(Sender: TObject);
begin
  TestHeader.RowHeight := RowHeightSE.Value;
  ScrollCheck;
end;

procedure TElXSectionsPropDlg.RowCountSEChange(Sender: TObject);
begin
  TestHeader.RowCount := RowCountSE.Value;
  ScrollCheck;
end;

procedure TElXSectionsPropDlg.CellEditChange(Sender: TObject);
var
  s: string;
  Section: TElXHeaderSection;
begin
  TestHeader.Rows[ARow].Cell[ACol].Text := CellEdit.Text;
  TestHeader.Repaint;
  if ARow = 0 then
  begin
    Section := TestHeader.Sections[ACol];
    S := IntToStr(Section.Index) + ' - ';
    if Section.Text = '' then
      S := S + '(Untitled)'
    else
      S := S + CellEdit.Text;
    SecList.Items[Section.Position] := S;
  end;
end;

procedure TElXSectionsPropDlg.TestHeaderSectionCellClick(
  Sender: TElXCustomHeader; Section: TElXHeaderSection;
  Cell: TElXHeaderCell);
var
  i, j{, i1, j1}: integer;
begin
  if Cell.JointCellRole = jcrSlave then
    Cell := Cell.JointCellMaster;
  if Cell.Tag = 0 then
  begin
    Cell.Tag := 1;
    ACellRange.Add(Cell);
    ARow := Cell.RowIndex;
    ACol := Cell.Index;
  end
  else
  begin
    Cell.Tag := 0;
    ACellRange.Remove(Cell);
    ARow := -1;
    ACol := -1;
  end;
  ACellRange.CheckBorderValues;
  if FShiftPressed and ((ARow >= 0) and (ACol >= 0)) then
  begin
    for i := ACellRange.RowStart to ACellRange.RowEnd do
    begin
      for j := ACellRange.ColStart to ACellRange.ColEnd do
      begin
        TestHeader.Rows[i].Cell[j].Tag := 1;
        if ACellRange.IndexOf(TestHeader.Rows[i].Cell[j]) = -1 then
          ACellRange.Add(TestHeader.Rows[i].Cell[j]);
      end;
    end;
  end;
  if ACellRange.Count > 0 then
  begin
    if Cell.Tag = 0 then
      Cell := TelXHeaderCell(ACellRange.Items[0]);
    ARow := Cell.RowIndex;
    ACol := Cell.Index;
    ElGroupBox2.Caption := 'Cell '+IntToStr(ARow)+':'+IntToStr(ACol);
    CellEdit.Text := Cell.Text;
    case Cell.Alignment of
      hsaCenter: AlCB.ItemIndex := 1;
      hsaRight: AlCB.ItemIndex := 2;
      else AlCB.ItemIndex := 0;
    end;
    ElGroupBox2.Enabled := true;
  end
  else
  begin
    ElGroupBox2.Caption := 'Cell ';
    CellEdit.Text := '';
    AlCB.ItemIndex := 0;
    ElGroupBox2.Enabled := false;
  end;
  TestHeader.Repaint;
  SplitBtn.Enabled := ACellRange.CanSplit;
  MergeBtn.Enabled := ACellRange.CanMerge;
  Sender.Refresh;
end;

procedure TElXSectionsPropDlg.TestHeaderSectionCellPostDraw(
  Sender: TElXCustomHeader; Canvas: TCanvas; Section: TElXHeaderSection;
  Cell: TElXHeaderCell; R: TRect; Pressed: Boolean);
begin
  if Cell.Tag = 1 then
    LMDAlphaFillRect(Canvas, R, clHighlight, 100);
end;

procedure TElXSectionsPropDlg.TestHeaderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i, j: integer;
begin
  if not ((ssShift in Shift) or (ssCtrl in Shift)) then
  begin
    for i := 0 to TestHeader.RowCount - 1 do
    begin
      for j := 0 to TestHeader.Sections.Count - 1 do
      begin
        TestHeader.Rows[i].Cell[j].Tag := 0;
      end;
    end;
    ACellRange.Clear;
    FCtrlPressed := False;
    FShiftPressed := False;
    MergeBtn.Enabled := False;
  end
  else
  begin
    FCtrlPressed := False;
    FShiftPressed := False;
    if (ssShift in Shift) then
      FShiftPressed := True;
    if (ssCtrl in Shift) then
      FCtrlPressed := True;
  end;
end;

procedure TElXSectionsPropDlg.SplitBtnClick(Sender: TObject);
var
  i, j, k: integer;
  Lcell: TElXBaseCell;
begin
  for i := 0 to ACellRange.Count - 1 do
  begin
    LCell := TElXBaseCell(ACellRange.Items[i]);
    if LCell.JointCellRole = jcrMaster then
      for j := LCell.RowIndex to LCell.RowIndex + LCell.JointRowCount - 1 do
      begin
        for k := LCell.Index to LCell.Index + LCell.JointColumnCount - 1 do
        begin
          if ACellRange.IndexOf(TestHeader.Rows[j].Cell[k]) = -1 then
            ACellRange.Add(TestHeader.Rows[j].Cell[k]);
          TestHeader.Rows[j].Cell[k].Tag := 1;
        end;
      end;
  end;
  ACellRange.Split;
//  TestHeader.Rows[ARow].Cell[ACol].Split;
end;

procedure TElXSectionsPropDlg.MergeBtnClick(Sender: TObject);
begin
  ACellRange.CheckBorderValues;
  TestHeader.Rows[ACellRange.RowStart].Cell[ACellRange.ColStart].Join(ACellRange.RowEnd - ACellRange.RowStart + 1,ACellRange.ColEnd - ACellRange.ColStart + 1);
  TestHeader.Refresh;
  ARow := ACellRange.RowStart;
  ACol := ACellRange.ColStart;
  ACellRange.Clear;
  ACellRange.Add(TestHeader.Rows[ARow].Cell[ACol]);
  ElGroupBox2.Caption := 'Cell '+IntToStr(ARow)+':'+IntToStr(ACol);
  SplitBtn.Enabled := True;
  CellEdit.Text := TestHeader.Rows[ARow].Cell[ACol].Text;
  case TestHeader.Rows[ARow].Cell[ACol].Alignment of
    hsaCenter: AlCB.ItemIndex := 1;
    hsaRight: AlCB.ItemIndex := 2;
    else AlCB.ItemIndex := 0;
  end;
end;

procedure TElXSectionsPropDlg.AlCBChange(Sender: TObject);
begin
  case AlCB.ItemIndex of
    1: TestHeader.Rows[ARow].Cell[ACol].Alignment := hsaCenter;
    2: TestHeader.Rows[ARow].Cell[ACol].Alignment := hsaRight;
    else TestHeader.Rows[ARow].Cell[ACol].Alignment := hsaLeft;
  end;
  TestHeader.Repaint;
end;

procedure TElXSectionsPropDlg.FormDestroy(Sender: TObject);
begin
  ACellRange.Clear;
  ACellRange.Free;
end;

procedure TElXSectionsPropDlg.CellEditPasteClipboardText(Sender: TObject;
  var AClipboardText: TLMDString);
var
  s: string;
  Section: TElXHeaderSection;
begin
  TestHeader.Rows[ARow].Cell[ACol].Text := AClipboardText;
  TestHeader.Repaint;
  if ARow = 0 then
  begin
    Section := TestHeader.Sections.ItemByPos[ACol];
    S := IntToStr(Section.Index) + ' - ';
    if Section.Text = '' then
      S := S + '(Untitled)'
    else
      S := S + AClipboardText;
    SecList.Items[Section.Position] := S;
  end;
end;

procedure TElXSectionsPropDlg.FontBtnClick(Sender: TObject);
begin
  FontDialog1.Font := CellEdit.Font;
  if FontDialog1.Execute then
  begin
    CellEdit.Font.Assign(FontDialog1.Font);
  end;
end;

end.
