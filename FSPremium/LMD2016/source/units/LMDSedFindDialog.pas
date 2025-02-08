unit LMDSedFindDialog;
{$I LMDCmps.inc}

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

LMDSedFindDialog unit (VT)
--------------------------
This unit contains implementation of the Find/Replace dialog.

Changes
-------
Release 8.0 (May 2007)
 - Initial Release                    

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LMDSedDocument, LMDSedView, LMDTypes;

type
  {********************************** Types ***********************************}

  TLMDEditSearchDlgOptions = record
    Searches: array of TLMDString;
    Replaces: array of TLMDString;

    ReplaceAllBounds: TLMDEditViewReplaceAllBounds;

    Options: TLMDEditSearchOptions;
    Direction: TLMDEditSearchDirection;
    Start: TLMDEditViewSearchStart;

    LastNumberOfReplacements: Integer;
    WasReplaceAllChosen: Boolean;
  end;

  {****************************** TLMDSedFindDlg ******************************}

  TLMDSedFindDlg = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnOpts1: TPanel;
    grOptions: TGroupBox;
    cbCaseSensitive: TCheckBox;
    cbWholeWords: TCheckBox;
    cbRegexps: TCheckBox;
    cbConfirmReplace: TCheckBox;
    grDirection: TGroupBox;
    cbBackward: TRadioButton;
    cbForward: TRadioButton;
    pnOpts2: TPanel;
    grStartFrom: TGroupBox;
    cbFromCursor: TRadioButton;
    cbFromTextStart: TRadioButton;
    grBounds: TGroupBox;
    cbAllText: TRadioButton;
    cbSelection: TRadioButton;
    pnReplaceBtns: TPanel;
    btnReplace: TButton;
    btnReplaceCancel: TButton;
    btnReplaceAll: TButton;
    pnReplaceText: TPanel;
    lblTextToReplace: TLabel;
    edReplaceText: TComboBox;
    pnSearch: TPanel;
    lblTextToSearch: TLabel;
    edTextToSearch: TComboBox;
    pnSearchBtns: TPanel;
    btnFind: TButton;
    btnFindCancel: TButton;
    Panel4: TPanel;
    pnReplacePadding: TPanel;
    Panel6: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnFindClick(Sender: TObject);
    procedure edTextToSearchCloseUp(Sender: TObject);
    procedure btnReplaceAllClick(Sender: TObject);
  private
    IsReplace:   Boolean;
    View:        TLMDCustomEditView;
    NumOfReplacements: Integer;
    WasReplaceAllChosen: Boolean;

    procedure RememberSearch;
    procedure SetReplace(AIsReplace: Boolean);
  public
    function GetSearchOptions(AForSave: Boolean): TLMDEditSearchDlgOptions;
    procedure SetSearchOptions(const AOps: TLMDEditSearchDlgOptions);
  end;

  TLMDEditSearchResult = (srFound, srNotFound, srCancel);

  function LMDEditExecFindDialog(const ACaption: TLMDString;
                                 AView: TLMDCustomEditView;
                                 var Options: TLMDEditSearchDlgOptions): TLMDEditSearchResult;

  function LMDEditExecReplaceDialog(const ACaption: TLMDString;
                                    AView: TLMDCustomEditView;
                                    var Options: TLMDEditSearchDlgOptions): TLMDEditSearchResult;

implementation

uses
  LMDSedUtils, LMDSedConst, LMDUtils, LMDRegExpr, LMDProcs;

{$R *.dfm}

{****************************** TLMDSedFindDlg ********************************}
{------------------------------------------------------------------------------}

function TLMDSedFindDlg.GetSearchOptions(AForSave: Boolean): TLMDEditSearchDlgOptions;
var
  i: Integer;
begin
  if AForSave then
  begin
    SetLength(Result.Searches, edTextToSearch.Items.Count);
    for i := 0 to edTextToSearch.Items.Count-1 do
      Result.Searches[i] := edTextToSearch.Items[i];
  end
  else
  begin
    SetLength(Result.Searches, 1);
    Result.Searches[0] := edTextToSearch.Text;
  end;

  if AForSave then
  begin
    SetLength(Result.Replaces, edReplaceText.Items.Count);
    for i := 0 to edReplaceText.Items.Count-1 do
      Result.Replaces[i] := edReplaceText.Items[i];
  end
  else
  begin
    SetLength(Result.Replaces, 1);
    Result.Replaces[0] := edReplaceText.Text;
  end;

  Result.Options := [];
  if cbCaseSensitive.Checked then
    Include(Result.Options, soCaseSensitive);
  if cbWholeWords.Checked then
    Include(Result.Options, soWholeWords);
  if cbRegexps.Checked then
    Include(Result.Options, soRegexp);
  if cbConfirmReplace.Checked then
    Include(Result.Options, soConfirmReplace);

  if cbBackward.Checked then
    Result.Direction := sdBackward
  else
    Result.Direction := sdForward;

  if cbFromCursor.Checked then
    Result.Start := ssCursor
  else
    Result.Start := ssTextStartEnd;

  if cbSelection.Checked then
    Result.ReplaceAllBounds := rbSelection
  else
    Result.ReplaceAllBounds := rbAllText;

  Result.LastNumberOfReplacements := NumOfReplacements;
  Result.WasReplaceAllChosen := WasReplaceAllChosen;

  if soRegexp in Result.Options then
    Include(Result.Options, soRegexpSubstitute);
end;

{------------------------------------------------------------------------------}

procedure TLMDSedFindDlg.SetSearchOptions(const AOps: TLMDEditSearchDlgOptions);
var
  i: Integer;
begin
  edReplaceText.Items.Clear;
  edReplaceText.Text := '';

  if Length(AOps.Replaces)>0 then
  begin
    for i := 0 to Length(AOps.Replaces) - 1 do
      edReplaceText.Items.Add(AOps.Replaces[i]);

    edReplaceText.Text := AOps.Replaces[0];
  end;

  edTextToSearch.Items.Clear;
  edTextToSearch.Text := '';

  if Length(AOps.Searches)>0 then
  begin
    for i := 0 to Length(AOps.Searches) - 1 do
      edTextToSearch.Items.Add(AOps.Searches[i]);

    edTextToSearch.Text := AOps.Searches[0];
  end;

  cbCaseSensitive.Checked := soCaseSensitive in AOps.Options;
  cbRegexps.Checked := soRegexp in AOps.Options;
  cbWholeWords.Checked := soWholeWords in AOps.Options;
  cbConfirmReplace.Checked := soConfirmReplace in AOps.Options;

  if AOps.Direction = sdForward then
    cbForward.Checked := True
  else
    cbBackward.Checked := True;

  if AOps.ReplaceAllBounds = rbAllText then
    cbAllText.Checked := True
  else
    cbSelection.Checked := True;

  if AOps.Start = ssCursor then
    cbFromCursor.Checked := True
  else
    cbFromTextStart.Checked := True;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedFindDlg.RememberSearch;
var OldIdx: Integer;
begin
  if edTextToSearch.Text<>'' then
  begin
    OldIdx := edTextToSearch.Items.IndexOf(edTextToSearch.Text);
    edTextToSearch.Items.Insert(0, edTextToSearch.Text);
    if OldIdx<>-1 then
      edTextToSearch.Items.Delete(OldIdx+1);
  end;

  OldIdx := edReplaceText.Items.IndexOf(edReplaceText.Text);
  edReplaceText.Items.Insert(0, edReplaceText.Text);
  if OldIdx<>-1 then
    edReplaceText.Items.Delete(OldIdx+1);
end;

{------------------------------------------------------------------------------}

procedure TLMDSedFindDlg.SetReplace(AIsReplace: Boolean);
begin
  IsReplace := AIsReplace;

  pnSearchBtns.Visible := not IsReplace;
  pnReplaceBtns.Visible := IsReplace;
  pnReplaceText.Visible := IsReplace;
  cbConfirmReplace.Visible := IsReplace;
  grBounds.Visible := IsReplace;
  pnReplacePadding.Visible := IsReplace;

  if IsReplace then
    Constraints.MaxHeight := Height - pnSearchBtns.Height
  else
    Constraints.MaxHeight := Height - pnReplaceBtns.Height - pnReplaceText.Height;

  Constraints.MinHeight := Height;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedFindDlg.edTextToSearchCloseUp(Sender: TObject);
var
  Cb: TComboBox;
  i:  Integer;
begin
  Cb := Sender as TComboBox;

  i := Cb.ItemIndex;

  Cb.Items.BeginUpdate;
  Cb.Items.Insert(0, Cb.Items[i]);
  Cb.Items.Delete(i+1);
  Cb.Items.EndUpdate;

  Cb.ItemIndex := 0;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedFindDlg.btnFindClick(Sender: TObject);
var
  Opts: TLMDEditSearchArguments;
  MyOpts: TLMDEditSearchDlgOptions;
  Ok: Boolean;
begin
  MyOpts := GetSearchOptions(false);

  Opts.Search := MyOpts.Searches[0];
  Opts.Options := MyOpts.Options;
  Opts.Direction := MyOpts.Direction;
  Opts.Start := MyOpts.Start;

  if IsReplace then
    Opts.Replace := MyOpts.Replaces[0]
  else
    Opts.Replace := '';

  Hide;

  try
    if IsReplace then
      Ok := View.ReplaceFirst(Opts)
    else
      Ok := View.SearchFirst(Opts);

    if Ok then
    begin
      NumOfReplacements := View.SearchLastNumReplacements;
      ModalResult := mrYes;
    end
    else
      ModalResult := mrNo;
  except
    on E: ELMDRegExprError do
    begin
      ModalResult := mrCancel;

      MessageDlg(Format(SLMDSedDlgSearchBadRegex, [E.Message]),
                 mtError, [mbOK], -1);
    end;
  end;

  RememberSearch;
end;

{------------------------------------------------------------------------------}

procedure TLMDSedFindDlg.btnReplaceAllClick(Sender: TObject);
var
  Opts: TLMDEditSearchArguments;
  MyOpts: TLMDEditSearchDlgOptions;
begin
  WasReplaceAllChosen := true;
  MyOpts := GetSearchOptions(false);

  Opts.Search := MyOpts.Searches[0];
  Opts.Replace := MyOpts.Replaces[0];
  Opts.Options := MyOpts.Options;
  Opts.Direction := MyOpts.Direction;
  Opts.Start := MyOpts.Start;

  try
    Visible := false;
    try
      if View.ReplaceAll(Opts, MyOpts.ReplaceAllBounds) then
      begin
        ModalResult := mrYes;
        NumOfReplacements := View.SearchLastNumReplacements;
      end
      else
        ModalResult := mrNo;
    except
      on E: ELMDRegExprError do
      begin
        ModalResult := mrCancel;

        MessageDlg(Format(SLMDSedDlgSearchBadRegex, [E.Message]),
                   mtError, [mbOK], -1);
      end;
    end;
  finally
    Visible := true;
  end;

  RememberSearch;
end;

{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}

procedure TLMDSedFindDlg.FormCreate(Sender: TObject);
begin
  LMDGetDialogFont(Font);

  lblTextToSearch.Caption := SLMDSedDlgSearchText;
  lblTextToReplace.Caption := SLMDSedDlgReplaceText;
  grOptions.Caption :=  SLMDSedDlgSearchOptions;
  grDirection.Caption := SLMDSedDlgSearchDirection;
  grBounds.Caption := SLMDSedDlgSearchBounds;
  grStartFrom.Caption := SLMDSedDlgSearchStartFrom;
  cbRegexps.Caption := SLMDSedDlgSearchRegexps;
  cbWholeWords.Caption := SLMDSedDlgSearchWholeWords;
  cbConfirmReplace.Caption := SLMDSedDlgSearchConfirmReplace;
  cbCaseSensitive.Caption := SLMDSedDlgSearchCaseSensitive;
  cbBackward.Caption := SLMDSedDlgSearchBackward;
  cbForward.Caption := SLMDSedDlgSearchForward;
  cbAllText.Caption := SLMDSedDlgSearchAllText;
  cbSelection.Caption := SLMDSedDlgSearchSelection;
  cbFromCursor.Caption := SLMDSedDlgSearchFromCursor;
  cbFromTextStart.Caption := SLMDSedDlgSearchFromTextStart;
  btnFind.Caption := SLMDSedDlgSearchOk;
  btnFindCancel.Caption := SLMDSedDlgSearchCancel;
  btnReplace.Caption := SLMDSedDlgSearchOk;
  btnReplaceCancel.Caption := SLMDSedDlgSearchCancel;
  btnReplaceAll.Caption := SLMDSedDlgReplaceAll;

  NumOfReplacements := 0;
  WasReplaceAllChosen := false;
end;

{------------------------------------------------------------------------------}

function LMDSedExecFindReplDialog(const ACaption: TLMDString;
  AView: TLMDCustomEditView; AIsReplace: Boolean;
  var Options: TLMDEditSearchDlgOptions): TLMDEditSearchResult;
var
  dlg: TLMDSedFindDlg;
begin
  Result := srCancel;

  if AView=nil then
  begin
    Beep;
    Exit;
  end;

  dlg := TLMDSedFindDlg.Create(nil);
  try
    dlg.Caption := ACaption;
    dlg.View := AView;
    dlg.SetSearchOptions(Options);
    dlg.SetReplace(AIsReplace);

    if not AIsReplace then
    begin
      dlg.Height := dlg.Height - dlg.pnReplaceBtns.Height;
      dlg.Height := dlg.Height - dlg.pnReplaceText.Height;
    end
    else
      dlg.Height := dlg.Height - dlg.pnSearchBtns.Height;

    if AView.SelectedText<>'' then
      dlg.edTextToSearch.Text := AView.SelectedText
    else if AView.GetWordUnderCursor<>'' then
      dlg.edTextToSearch.Text := AView.GetWordUnderCursor;

    dlg.ShowModal;

    case dlg.ModalResult of
      mrYes: Result := srFound;
      mrNo: Result := srNotFound;
      mrCancel: Result := srCancel;
    else
      Assert(false);
    end;

    Options := dlg.GetSearchOptions(true);
    Options.LastNumberOfReplacements := dlg.NumOfReplacements;
  finally
    dlg.Free;
  end;
end;

{------------------------------------------------------------------------------}

function LMDEditExecReplaceDialog(const ACaption: TLMDString;
  AView: TLMDCustomEditView; var Options:
  TLMDEditSearchDlgOptions): TLMDEditSearchResult;
begin
  Result := LMDSedExecFindReplDialog(ACaption, AView, True, Options);
end;

{------------------------------------------------------------------------------}

function LMDEditExecFindDialog(const ACaption: TLMDString;
  AView: TLMDCustomEditView; var Options:
  TLMDEditSearchDlgOptions): TLMDEditSearchResult;
begin
  Result := LMDSedExecFindReplDialog(ACaption, AView, False, Options);
end;

{------------------------------------------------------------------------------}

end.
