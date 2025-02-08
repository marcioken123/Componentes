unit LMDRTFTabsProp;
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

LMDRTFTabsProp unit (RM)
------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, StdCtrls, Mask, Controls, ExtCtrls, Classes,

  LMDRTFRichEdit;

type
{***************************  TfrmTabs *******************************}
  TLMDRichfrmTabs = class(TForm)
    ListBox: TListBox;
    labTabPosition: TLabel;
    btnSet: TButton;
    btnDelete: TButton;
    btnDeleteAll: TButton;
    Bevel1: TBevel;
    btnCancel: TButton;
    btnOK: TButton;
    MaskEdit: TMaskEdit;
    procedure btnSetClick(Sender: TObject);
    procedure btnDeleteAllClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure ListBoxClick(Sender: TObject);
    procedure MaskEditChange(Sender: TObject);
    procedure MaskEditKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure InsertSorted(aItem: LongInt);
    procedure CheckButtons;
  public
    { Public declarations }
    class function Execute(aParagraph: TLMDParaAttributes; aRichEdit: TLMDCustomRichEdit): Boolean;
  end;

implementation

uses
  SysUtils, Windows, RichEdit,
  LMDRTFBase, LMDRTFConst, LMDConversion;

{$R *.DFM}

{***********************************  TLMDRichfrmTabs  ***********************}
{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.InsertSorted(aItem: Integer);
var
  I: LongInt;
begin
  if ListBox.Items.Count > 0 then
    for I:= 0 to ListBox.Items.Count - 1 do
      if StrToInt(ListBox.Items[I]) > aItem then
        begin
          ListBox.Items.Insert(I, IntToStr(aItem));
          Exit;
        end;
  ListBox.Items.Add(IntToStr(aItem));
end;

{-----------------------------------------------------------------------------}

class function TLMDRichfrmTabs.Execute(aParagraph: TLMDParaAttributes; aRichEdit: TLMDCustomRichEdit): Boolean;
var
  T: TLMDRichfrmTabs;
  I: LongInt;
  Tabs: array of integer;
begin

  if Assigned(aRichEdit) then
    begin
      T := TLMDRichfrmTabs.Create(aRichEdit);
      aRichEdit.PrepareDialog(t);
      T.labTabPosition.Caption:= Format('%s (%s)', [T.labTabPosition.Caption,
          LMDUnitsToString(aRichEdit.Measurement)]);
    end
  else
    T := TLMDRichfrmTabs.Create(Application);

  try
    for I:= 0 to aParagraph.TabCount - 1 do
      T.InsertSorted(aParagraph.Tab[I]);

    T.CheckButtons;

    if  T.ListBox.Items.Count > 0 then
    begin
      T.ListBox.ItemIndex := 0;
      T.ListBoxClick(T.ListBox);
    end;

    Result:= T.ShowModal = mrOK;
    if Result then
      begin
        SetLength(Tabs, T.ListBox.Items.Count);
        for I:= 0 to T.ListBox.Items.Count - 1 do
          Tabs[i] := StrToInt(T.ListBox.Items[i]);

        aParagraph.SetTabs(Tabs);

//          aParagraph.Tab[I]:= StrToInt(T.ListBox.Items[i])
      end;
  finally
    T.Release;
  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.FormCreate(Sender: TObject);
begin
  btnOK.Caption:= IDRTF_OK;
  btnCancel.Caption:= IDRTF_CANCEL;
  btnSet.Caption:= IDRTF_SET;
  btnDelete.Caption:= IDRTF_DELETE;
  btnDeleteAll.Caption:= IDRTF_DELETEALL;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.btnSetClick(Sender: TObject);
begin
  if ListBox.Items.IndexOf(MaskEdit.Text) = -1 then
    InsertSorted(StrToInt(MaskEdit.Text));

  CheckButtons;
  self.ActiveControl := MaskEdit;
  MaskEdit.SelectAll;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.btnDeleteAllClick(Sender: TObject);
begin
  ListBox.Items.Clear;
  CheckButtons;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.btnDeleteClick(Sender: TObject);
begin
  if ListBox.Items.IndexOf(MaskEdit.Text) <> -1 then
    ListBox.Items.Delete(ListBox.Items.IndexOf(MaskEdit.Text));

  CheckButtons;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.ListBoxClick(Sender: TObject);
begin
  if ListBox.ItemIndex <> -1 then
    MaskEdit.Text:= ListBox.Items[ListBox.ItemIndex];
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.MaskEditChange(Sender: TObject);
begin
  CheckButtons;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.MaskEditKeyPress(Sender: TObject; var Key: Char);
begin
  if (AnsiChar(Key) in ['0'..'9', chr(VK_BACK)]) then
  else
    Key := #0;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.CheckButtons;
begin
  btnSet.Enabled := (ListBox.Items.Count < MAX_TAB_STOPS)
    and (StrToIntDef(MaskEdit.Text, 0) > 0)
    and (ListBox.Items.IndexOf(MaskEdit.Text) < 0);
  btnDeleteAll.Enabled := (ListBox.Items.Count > 0);
  btnDelete.Enabled := (ListBox.ItemIndex >= 0);

  if  ListBox.Items.Count = 0 then
    self.ActiveControl := MaskEdit;
end;

{-----------------------------------------------------------------------------}

procedure TLMDRichfrmTabs.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if  (Key = VK_RETURN)   then
    if  MaskEdit.Focused AND btnSet.Enabled then
    begin
      ModalResult := mrNone;
      Key := 0;
      btnSetClick(btnSet);
    end
    else
      ModalResult := mrOK;
end;

end.
