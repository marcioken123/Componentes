unit LMDRTFBookMarkDialog;
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

LMDRTFBookMarkDialog unit (RM)
------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  StdCtrls, Classes, Controls, Forms,
  LMDRTFHyperText;

{ **************************** TfrmBookMarks ********************************* }
type
  TLMDRichfrmBookMarks = class(TForm)
    FNameEditor: TEdit;
    FBookMarkList: TListBox;
    btnNew: TButton;
    btnDelete: TButton;
    btnSelect: TButton;
    btnClose: TButton;
    procedure FNameEditorChange(Sender: TObject);
    procedure FBookMarkListClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSelectClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FBookMarkListDblClick(Sender: TObject);
  private
    FHyperText: TLMDRichHyperText;
    function IsValidName(const aName: string): boolean;
  public
    constructor CreateExt(aHyperText: TLMDRichHyperText);
    class procedure Execute(aHyperText: TLMDRichHyperText);
  end;

implementation

uses
  SysUtils,
  LMDRTFConst;

{$R *.DFM}

{ **************************** TfrmBookMarks ********************************* }

class procedure TLMDRichfrmBookMarks.Execute(aHyperText: TLMDRichHyperText);
var
  Dlg: TLMDRichfrmBookMarks;
begin
  Dlg:= TLMDRichfrmBookMarks.CreateExt(aHyperText);
  try
    Dlg.ShowModal;
  finally
    Dlg.Release;
  end;
end;

{ ---------------------------- Private --------------------------------------- }
function TLMDRichfrmBookMarks.IsValidName(const aName: string): boolean;
//var
//  I: integer;
begin
  Result := (Trim(aName) <> '')
    and (FBookMarkList.Items.IndexOf(Trim(aName)) < 0);
{
  result:= false;
  if length(aName) = 0 then Exit;
  if FBookMarkList.items.count > 0 then
    for I:= 0 to FBookMarkList.items.Count - 1 do
      if FBookMarkList.Items[I] = aName then Exit;
  result:= True;
}
end;

{ ---------------------------------------------------------------------------- }

constructor TLMDRichfrmBookMarks.CreateExt(aHyperText: TLMDRichHyperText);
var
  Frm: TCustomForm;
begin
  inherited Create(nil);

  // Localization
  Caption:= IDRTF_BOOKMARKS;
  btnNew.Caption:= IDRTF_NEW;
  btnDelete.Caption:= IDRTF_DELETE;
  btnSelect.Caption:= IDRTF_SELECT;
  btnClose.Caption:= IDRTF_CLOSE;

  FHyperText:= aHyperText;

  if Assigned(aHyperText) then
    begin
      aHyperText.GetBookMarks(FBookMarkList.Items);

      if  Assigned(FHyperText.Editor) then
        Frm := GetParentForm(FHyperText.Editor)
      else
        Frm := nil;

      if  Assigned(Frm) then
      Frm.InsertComponent(self);
    end;
end;

{ ---------------------------- Public ---------------------------------------- }

procedure TLMDRichfrmBookMarks.FNameEditorChange(Sender: TObject);
begin
  if IsValidName(FNameEditor.Text) then
    btnNew.Enabled:= True
  else
    btnNew.Enabled:= False;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRichfrmBookMarks.FBookMarkListClick(Sender: TObject);
begin
  if FBookMarkList.ItemIndex <> -1 then
    begin
      FNameEditor.Text:= FBookMarkList.Items[FBookMarkList.ItemIndex];
      btnDelete.Enabled:= True;
      btnSelect.Enabled:= True;
    end
  else
    begin
      btnDelete.Enabled:= False;
      btnSelect.Enabled:= False;
    end;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRichfrmBookMarks.btnCloseClick(Sender: TObject);
begin
  Close;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDRichfrmBookMarks.btnNewClick(Sender: TObject);
begin
  FHyperText.InsertBookMark(FNameEditor.Text);
  Close;
end;

procedure TLMDRichfrmBookMarks.btnSelectClick(Sender: TObject);
begin
  FHyperText.GoToBookMark(FBookMarkList.Items[FBookMarkList.itemIndex]);
  Close;
end;

procedure TLMDRichfrmBookMarks.btnDeleteClick(Sender: TObject);
begin
  FHyperText.DeleteBookMark(FBookMarkList.Items[FBookMarkList.itemIndex]);
  Close;
end;

procedure TLMDRichfrmBookMarks.FBookMarkListDblClick(Sender: TObject);
begin
  if  FBookMarkList.ItemIndex >= 0  then
    btnSelect.Click;
end;

end.
