unit pLMDElImgListEditDlg;
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

pLMDElImgListEditDlg unit
-------------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, LMDElConst, ElPanel, ElGroupBox, ElCheckItemGrp, ElXPThemedControl,
  ElBtnCtl, ElPopBtn, StdCtrls, ElCLabel, ElLabel, ElScrollBox;

type

  TImageOperation = ( ioCrop, ioStretch, ioCenter, ioCenterStretch, ioCenterCrop, ioDivideIntoFragment );
  TImageOperations = set of TImageOperation;

  TFormImgListEditDlg = class(TForm)
    ElRadioGroup1: TElRadioGroup;
    pBtns: TElPanel;
    OkButton: TElPopupButton;
    CancelButton: TElPopupButton;
    ElLabel1: TElLabel;
    ScrollBox: TElScrollBox;
    Image: TImage;
    ElPanel2: TElPanel;
    lbDestInfo: TElLabel;
    lbSrcInfo: TElLabel;
    ElPanel1: TElPanel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function GetProccesingImageOperation( const ImageOperations: TImageOperations; Graphic:TGraphic; SrcWidth, SrcHeight, DestWidth, DestHeight :Integer; var RetCode: TImageOperation):Boolean;

implementation
{$R *.DFM}

var
  FormImgListEditDlg: TFormImgListEditDlg;

function GetProccesingImageOperation(
 const ImageOperations: TImageOperations; Graphic:TGraphic; SrcWidth,
 SrcHeight, DestWidth, DestHeight :Integer; var RetCode: TImageOperation):Boolean;
var
  i:   Integer;
  bmp: TBitmap;
begin
  if FormImgListEditDlg=nil then
    FormImgListEditDlg := TFormImgListEditDlg.Create(Application);

  if (Integer(RetCode)<Integer(ioCrop))or(Integer(RetCode)>Integer(ioCenterCrop)) then
    RetCode := ioStretch;

  if ImageOperations <> [] then
  begin
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[0] := ioCrop in ImageOperations;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[1] := ioStretch in ImageOperations;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[2] := ioCenter in ImageOperations;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[3] := ioCenterStretch in ImageOperations;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[4] := ioCenterCrop in ImageOperations;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[5] := ioDivideIntoFragment in ImageOperations;
  end
  else
  begin
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[0] := True;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[1] := True;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[2] := False;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[3] := False;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[4] := False;
    FormImgListEditDlg.ElRadioGroup1.ItemEnabled[5] := False;
  end;

  if FormImgListEditDlg.ElRadioGroup1.ItemEnabled[Integer(RetCode)]
  then
    FormImgListEditDlg.ElRadioGroup1.ItemIndex := Integer(RetCode)
  else
    for i:=0 to FormImgListEditDlg.ElRadioGroup1.Items.Count-1 do
      if FormImgListEditDlg.ElRadioGroup1.ItemEnabled[i] then
      begin
        FormImgListEditDlg.ElRadioGroup1.ItemIndex := i;
        break;
      end;

  FormImgListEditDlg.lbDestInfo.Caption := 'The size of purpose: ('+IntToStr(DestWidth)+' x '+IntToStr(DestHeight)+')';
  FormImgListEditDlg.lbSrcInfo.Caption := 'The size of source: ('+IntToStr(SrcWidth{Graphic.Width})+' x '+IntToStr(SrcHeight{Graphic.Height})+')';

  bmp := TBitmap.Create;
  try
    bmp.Width := SrcWidth{Graphic.Width};
    bmp.Height := SrcHeight{Graphic.Height};
    FormImgListEditDlg.Image.Picture.Assign(bmp);
    FormImgListEditDlg.Image.Width := SrcWidth{Graphic.Width};
    FormImgListEditDlg.Image.Height := SrcHeight{Graphic.Height};
  finally
    bmp.Free;
  end;
  FormImgListEditDlg.Image.Picture.Assign(Graphic);

  Result := FormImgListEditDlg.ShowModal = mrOK;

  if Result then
    RetCode := TImageOperation(FormImgListEditDlg.ElRadioGroup1.ItemIndex);
end;

procedure TFormImgListEditDlg.FormCreate(Sender: TObject);
begin
  ElLabel1.Caption := SLMDQuestion;
  Position := poOwnerFormCenter;
end;

end.
