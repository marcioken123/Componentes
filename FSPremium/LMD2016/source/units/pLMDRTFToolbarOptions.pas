unit pLMDRTFToolbarOptions;
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

pLMDRTFToolbarOptions unit (RM)
------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, Windows, StdCtrls, CheckLst, Classes, Controls, ComCtrls,
  ImgList;

type
  TToolbarOptionsForm = class(TForm)
    GroupBox1: TGroupBox;
    CancelButton: TButton;
    ToolBarRadioButton: TRadioButton;
    ActionBarRadioButton: TRadioButton;
    MenuBarCheckBox: TCheckBox;
    OKButton: TButton;
    GroupBox2: TGroupBox;
    CheckListBox: TListView;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ToolBarRadioButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  SysUtils, Graphics,
  LMDRTFActions, pLMDRTFActDescr;

{$R *.dfm}

procedure TToolbarOptionsForm.FormCreate(Sender: TObject);
var
  i, j: integer;
  Ds: TLMDRTFActionDescriptors;
  D: TLMDRTFActionDescriptor;
  S: string;
  Itm: TListItem;
begin
  ActionBarRadioButton.Enabled := True;
  CheckListBox.SmallImages := CreateLMDRTFActionImageList(self);
  Ds := StdLMDRTFActionDescriptors;
  S := '';
  j := 0;

  for i := 0 to Ds.Count - 1 do
    begin
      D := Ds[i];

      if  D.ImageIndex >= 0  then
        begin
          if  D.Category <> S  then
            begin
              j := CheckListBox.Items.Count;
              Itm := CheckListBox.Items.Insert(j);
              inc(j);
              Itm.Caption := '--- Category: ' + D.Category;
              S := D.Category;
              Itm.ImageIndex := -1;
              Itm.Cut := True;
            end;

          Itm := CheckListBox.Items.Insert(j);
          inc(j);
          Itm.ImageIndex := 1;
          Itm.Caption := D.Caption;
          Itm.ImageIndex := D.ImageIndex;
          Itm.Data := D;
          Itm.Indent := 1;
          Itm.Checked := True;
        end;
    end;
//  for i := 0 to CheckListBox.Items.Count - 1 do CheckListBox.Checked[i] := True;
{
New
Load
Save
Print
Preview
Find
Cut
Copy
Paste
Undo
Redo
Attributes
Bold
Italic
Underline
Subscript
Superscript
Left align
Center align
Right align
Numbering 1
Numbering 2
Increase indent
Decrease indent
}
end;

procedure TToolbarOptionsForm.ToolBarRadioButtonClick(Sender: TObject);
begin
  MenuBarCheckBox.Enabled := ActionBarRadioButton.Checked;
//  CheckListBox.Enabled := ActionBarRadioButton.Checked;
end;

procedure TToolbarOptionsForm.FormShow(Sender: TObject);
begin
  CheckListBox.Width := CheckListBox.Parent.ClientWidth - CheckListBox.Left * 2;
  CheckListBox.Columns[0].Width := CheckListBox.ClientWidth - 16;
end;

end.
