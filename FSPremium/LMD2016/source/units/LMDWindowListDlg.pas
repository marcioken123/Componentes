unit LMDWindowListDlg;
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

LMDWindowListDlg unit (RM)
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms, StdCtrls, Classes,
  LMDButton, LMDBaseDialog, LMDExtListBox;

type
  TLMDWLFormEvent = procedure(Sender:TObject; aForm:TForm; var Accept:Boolean) of object;

  TLMDWLOption=(wlAddInVisible, wlAddDialogForms, wlAddMainForm,
                wlAddParentForm, wlAddNoCaptionForms);
  TLMDWLOptions=set of TLMDWLOption;

  {---------------------- TLMDWindowListDlg -----------------------------------}
  TLMDWindowListDlg = class(TLMDBaseDialog)
   private
     FDescription: String;
     FForm       : TForm;
     FOptions    : TLMDWLOptions;
     FOnShow,
     FOnList     : TLMDWLFormEvent;
     ok          : TLMDButton;
     lb          : TLMDExtListBox;
     procedure lbClick(Sender: TObject);
     procedure lbDblClick(Sender: TObject);
     procedure okClick(Sender: TObject);
   public
     constructor Create(AOwner:TComponent);override;
     function Execute:Boolean;override;
     function ExecuteEnh(Main:TForm):Boolean;
     property CtlXP;  // compatibility
     property Form:TForm read FForm;
   published
     property About;
     property CaptionFill;
     property CaptionTitle;
     property Colors;
     property CustomButton;
     Property Description:String read FDescription write FDescription;
     property Effect;
     property Hints;
     property ImageList;
     property ImageIndex;
     property ListIndex;
     property Options:TLMDWLOptions read FOptions write FOptions default [wlAddInvisible];
     property Position;
     property RelatePos;
     property ThemeMode;
     property ThemeGlobalMode;     
     property ShowHints;

     {Events}
     property OnShow:TLMDWLFormEvent read FOnShow write FOnShow;
     property OnList:TLMDWLFormEvent read FOnList write FOnList;
     property OnCustomize;
     property OnCustomClick;
   end;

implementation

uses
  Controls,
  Graphics,
  Consts,
  LMDConst,
  LMDStrings,
  LMDFormStyler,
  LMDBack;

{------------------------------- Private---------------------------------------}
procedure TLMDWindowListDlg.lbClick(Sender: TObject);
begin
  if (ok=nil) or (lb=nil) then exit;
  ok.Enabled:=lb.ItemIndex<>-1;
end;

{------------------------------------------------------------------------------}
procedure TLMDWindowListDlg.lbDblClick(Sender: TObject);
begin
  okClick(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDWindowListDlg.okClick(Sender: TObject);
begin
  if (ok=nil) or (lb=nil) then exit;
  if lb.ItemIndex<>-1 then TForm(lb.Owner).ModalResult:=mrOk;
end;

{------------------------------- Public ---------------------------------------}
constructor TLMDWindowListDlg.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FForm:=nil;
  FOptions:=[wlAddInvisible];
  ok:=nil;
  lb:=nil;
end;

{------------------------------------------------------------------------------}
function TLMDWindowListDlg.ExecuteEnh(main:TForm):Boolean;
var
  WLBox,
  tmp    :TForm;
  i      :Integer;
  accept :Boolean;
  custom,
  cancel : TLMDButton;
  desc   : TLabel;
  fs     : TLMDFormStyler;
  b      : TLMDBack;

begin
  Result:=False;
  WLBox:=TForm.Create(nil);
  with WLBox do
    try
      FForm:=nil;

      BorderStyle:=bsDialog;
      Font.Color:=clWindowText;
      Font.Name:='MS Sans Serif';
      Font.Height:=-12;
      Position:=poDefault;
      PixelsPerInch:=96;

      ok:=TLMDButton.Create(WLBox);
      with ok do
        begin
          Parent:=WLBox;
          Left:=300;
          Top:=24;
          Width:=86;
          Height:=24;
          ModalResult:=1;
          Caption:='OK';
          Default:=True;
          TabOrder:=0;
        end;

      cancel:=TLMDButton.Create(WLBox);
      with cancel do
        begin
          Parent:=WLBox;
          Left:=300;
          Top:=51;
          Width:=86;
          Height:=24;
          ModalResult:=2;
          Cancel:=True;
          TabOrder:=1;
        end;

      custom:=TLMDButton.Create(WLBox);
      with custom do
        begin
          Parent:=WLBox;
          Left:=300;
          Top:=85;
          Width:=86;
          Height:=24;
          TabOrder:=2;
          Visible:=False;
        end;

      desc:=TLabel.Create(WLBox);
      with desc do
        begin
          Parent:=WLBox;
          Left:=6;
          Top:=10;
          Width:=3;
          Height:=10;
          FocusControl:=lb;
          Transparent:=True;
        end;

      lb:=TLMDExtListBox.Create(WLBox);
      with lb do
        begin
          Parent:=WLBox;
          Left:=6;
          Top:=25;
          Width:=287;
          Height:=227;
          ItemHeight:=13;
          TabOrder:=3;
        end;

      fs:=TLMDFormStyler.Create(WLBox);
      fs.Enabled:=False;
      fs.Options:=[fsAdjustRect, fsUseDefaultFont, fsUseFormCaption];

      b:=TLMDBack.Create(WLBox);
      b.Enabled:=False;
      {---}

      {needed because of minor quirk in Delphi 2.01}
      ClientWidth:=ok.Left+ok.Width+7;
      ClientHeight:=lb.Top+lb.Height+6;
      {----}
      if LMDAnsiEmpty(FDescription) then desc.Caption:=IDS_WLDESC else desc.Caption:=FDescription;
      cancel.caption:=SCancelButton;

      if ShowHints and (Hints.Count>0) then
        begin
          ShowHint:=True;
          ok.Hint:=Hints[0];
          if Hints.Count>1 then custom.Hint:=Hints[1];
          if Hints.Count>2 then cancel.Hint:=Hints[2];
        end;

      {Fill the list...}
      with Screen do
        for i:=0 to FormCount-1 do
          begin
            tmp:=Forms[i];
            accept:=True;
            if tmp=WLBox then accept:=False;
            if Assigned(FOnList) then FOnList(Self, tmp, accept);
            if Accept and not (wlAddInVisible in FOptions) then
              if not tmp.Visible then accept:=False;
            if Accept and not (wlAddDialogForms in FOptions) then
              if tmp.BorderStyle=bsDialog then accept:=false;
            if Accept and not (wlAddMainForm in FOptions) then
              if tmp=Application.MainForm then accept:=false;
            if Accept and not (wlAddParentForm in FOptions) then
              if tmp=self.Owner then accept:=False;
            if Accept and not (wlAddNoCaptionForms in FOptions) then
              if LMDAnsiTrim(tmp.Caption)='' then accept:=False;
            if accept then LB.Items.AddObject(tmp.Caption, tmp);
          end;

      ok.Enabled:=LB.Items.Count>0;
      if ok.Enabled then LB.ItemIndex:=0;

      ok.OnClick:=okClick;
      lb.OnClick:=lbClick;
      lb.OnDblClick:=lbDblClick;
      ActiveControl:=lb;
      if BaseExecute(WLBox, Main, Custom,  fs, b, IDS_WLCAPTION)=mrOK then
        begin
          accept:=True;
          with LB do tmp:=TForm(Items.Objects[ItemIndex]);
          FForm:=tmp;
          if Assigned(FOnShow) then FOnShow(self, tmp, accept);
          if not accept then exit;
          with tmp do
            begin
              if WindowState=wsMinimized then WindowState:=wsNormal;
              Show;
            end;
          result:=True;
        end;
    finally
      WLBox.free;
      ok:=nil;
      lb:=nil;
    end;

end;

{------------------------------------------------------------------------------}
Function TLMDWindowListDlg.Execute:Boolean;
begin
  result:=ExecuteEnh(nil);
end;

end.
