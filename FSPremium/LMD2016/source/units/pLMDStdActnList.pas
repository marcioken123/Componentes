unit pLMDStdActnList;
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

pLMDStdActnList(AH)
------------------------------

Changes
-------
Release 9.0 (September 2008)
 - Initial Release

###############################################################################}
interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmStdActionList = class(TForm)
    TreeView1: TTreeView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AddStdAction(const ACategory: String; const AName: String; AActionClass: TBasicActionClass);
  end;

var
  frmStdActionList: TfrmStdActionList;

implementation

{$R *.dfm}

{ TfrmStdActionList }

procedure TfrmStdActionList.AddStdAction(const ACategory: String;
  const AName: String; AActionClass: TBasicActionClass);
var
  i: Integer;
  LTreeNode: TTreeNode;
  LCat: String;
begin
  LCat := ACategory;
  if LCat = '' then
    LCat := '(No Category)';
  LTreeNode := nil;
  for i := 0 to TreeView1.Items.Count - 1 do
    if (TreeView1.Items[i].Level = 0) and (TreeView1.Items[i].Text = LCat) then
       LTreeNode := TreeView1.Items[i];
  if LTreeNode = nil then
    LTreeNode := TreeView1.Items.Add(nil, LCat);
  TreeView1.Items.AddChildObject(LTreeNode, AName, AActionClass);
  LTreeNode.Expand(True);
end;

end.
