unit LMDRTFLinkDialog;
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

LMDRTFLinkDialog unit ()
-------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  LMDRTFHyperText, StdCtrls, ComCtrls, Classes, Controls,
  Forms;

type
  TLMDRichfrmLinkDialog = class(TForm)
    pcLinkType: TPageControl;
    tabURL: TTabSheet;
    tabLink: TTabSheet;
    URLAddress: TEdit;
    LINKAddress: TComboBox;
    btnOK: TButton;
    btnDelete: TButton;
    btnCancel: TButton;
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LINKAddressChange(Sender: TObject);
  private
    FHyperText: TLMDRichHyperText;
    FOldLink: string;
    procedure CheckButtons;
  public
    constructor CreateExt(aHyperText: TLMDRichHyperText);
    class function  Execute(aHyperText: TLMDRichHyperText): Boolean;
  end;

implementation

uses
  SysUtils,
  LMDRTFConst;

{$R *.DFM}

class function  TLMDRichfrmLinkDialog.Execute(aHyperText: TLMDRichHyperText): Boolean;
var
  Frm: TLMDRichfrmLinkDialog;
begin
  Result := False;

  if  (aHyperText.Editor.SelLength > 0) or aHyperText.ValidLinkSelection  then
    begin
      Frm := TLMDRichfrmLinkDialog.CreateExt(aHyperText);

      try
        Result := (Frm.ShowModal <> mrCancel);
      finally
        Frm.Release;
      end;
    end;
end;

constructor TLMDRichfrmLinkDialog.CreateExt(aHyperText: TLMDRichHyperText);
var
  lAddress: string;
  lType: boolean;
  Frm: TCustomForm;
begin
  inherited Create(nil);

  Caption:= IDRTF_LINK;
  btnDelete.Caption:= IDRTF_DELETE;
  btnOK.Caption:= IDRTF_OK;
  btnCancel.Caption:= IDRTF_CANCEL;
  tabURL.Caption:= IDRTF_URL;
  tabLink.Caption:= IDRTF_LINK;

  FHyperText:= aHyperText;
  if not assigned(FHyperText) then Exit;
  FHyperText.GetBookMarks(LINKAddress.Items);
  btnDelete.Enabled:= FHyperText.GetLinkParams(lType, lAddress);
  FOldLink := lAddress;
  if lType then
    begin
      pcLinkType.ActivePageIndex:= 1;
      LINKAddress.Text:= lAddress;
    end
  else
    begin
      pcLinkType.ActivePageIndex:= 0;
      URLAddress.Text:= lAddress;
    end;

  if  Assigned(FHyperText.Editor) then
    Frm := GetParentForm(FHyperText.Editor)
  else
    Frm := nil;

  if  Assigned(Frm) then
    Frm.InsertComponent(self);
end;

procedure TLMDRichfrmLinkDialog.btnDeleteClick(Sender: TObject);
begin
  if  FHyperText.DeleteLink then
    ModalResult := mrOK;
end;

procedure TLMDRichfrmLinkDialog.btnCancelClick(Sender: TObject);
begin
  Close
end;

procedure TLMDRichfrmLinkDialog.btnOKClick(Sender: TObject);
var
  OK: Boolean;
begin
  if btnDelete.Enabled then
    if pcLinkType.ActivePageIndex = 0 then
      OK := FHyperText.ChangeLink(False, Trim(URLAddress.Text))
    else
      OK := FHyperText.ChangeLink(True, Trim(LINKAddress.Text))
  else
  if pcLinkType.ActivePageIndex = 0 then
    OK := FHyperText.InsertLink(False, Trim(URLAddress.Text))
  else
    OK := FHyperText.InsertLink(True, Trim(LINKAddress.Text));

  if  OK  then
    ModalResult := mrOK;
end;

procedure TLMDRichfrmLinkDialog.FormShow(Sender: TObject);
begin
  if  pcLinkType.ActivePage = tabURL  then
    ActiveControl := URLAddress
  else
  if  pcLinkType.ActivePage = tabLink then
    ActiveControl := LINKAddress;

  CheckButtons;
end;

procedure TLMDRichfrmLinkDialog.CheckButtons;
begin
  btnOK.Enabled := (pcLinkType.ActivePage = tabURL)
      and (Trim(URLAddress.Text) <> '') and (Trim(URLAddress.Text) <> FOldLink)
    or (pcLinkType.ActivePage = tabLink)
      and (Trim(LINKAddress.Text) <> '')and (Trim(LINKAddress.Text) <> FOldLink);
end;

procedure TLMDRichfrmLinkDialog.LINKAddressChange(Sender: TObject);
begin
  CheckButtons;
end;

end.
