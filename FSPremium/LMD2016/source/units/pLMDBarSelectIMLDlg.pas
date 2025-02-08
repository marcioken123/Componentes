unit pLMDBarSelectIMLDlg;
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

pLMDBarSelectIMLDlg unit (DD, RM, AH)
-------------------------------------
Implements imagelist selection dialog.


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ImgList, pLMDImageBox;

type
  TLMDfrmBarSelectIMLDlg = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    ln: TComboBox;
    btnClear: TButton;
    lb: TLMDImageLBox;
    procedure lnChange(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    FDesigner: IDesigner;
    function GetImageList:TCustomImageList;
    procedure GetLists(const S:String);
    procedure SetImageList(aValue:TCustomImageList);
  public
    procedure AddImageLists;

    property Design: IDesigner read FDesigner write FDesigner;
    property ImageList:TCustomImageList read GetImageList write SetImageList;
  end;

var
  LMDfrmBarSelectIMLDlg: TLMDfrmBarSelectIMLDlg;

implementation
uses
  typInfo;
{$R *.DFM}

{------------------------------------------------------------------------------}
procedure TLMDfrmBarSelectIMLDlg.SetImageList(aValue:TCustomImageList);
begin
  lb.ImageList:=aValue;
end;

{------------------------------------------------------------------------------}
function TLMDfrmBarSelectIMLDlg.GetImageList:TCustomImageList;
begin
  result:=lb.ImageList;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmBarSelectIMLDlg.GetLists(const S:String);
var
  tmp:TComponent;
begin
 tmp:=FDesigner.GetComponent(s);
 ln.Items.AddObject(tmp.Name, tmp);
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmBarSelectIMLDlg.AddImageLists;
var
  TD : PTypeData;
begin
  ln.Clear;

  if FDesigner<>nil then
    begin
      TD := GetTypeData(TCustomImageList.ClassInfo);
      FDesigner.GetComponentNames(TD, GetLists);
    end;

  ln.ItemIndex:=ln.Items.IndexofObject(lb.ImageList);
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmBarSelectIMLDlg.lnChange(Sender: TObject);
begin
  if ln.ItemIndex<>-1 then
    lb.ImageList:=TCustomImageList(ln.Items.Objects[ln.ItemIndex])
  else
    lb.ImageList:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDfrmBarSelectIMLDlg.btnClearClick(Sender: TObject);
begin
  lb.ImageList:=nil;
  ln.ItemIndex:=-1;
end;

end.
