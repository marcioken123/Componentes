unit LMDUpdateInternetOptionsUnit;
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

LMDUpdateInternetOptionsUnit unit (AlH)
---------------------------------------

Changes
-------
Release 5.0 (August 2008)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LMDCustomComponent, LMDWebBase, LMDRAS, ComCtrls,
  LMDWebConfig;

type
  TLMDUpdateInternetOptions = class(TForm)
    LMDRAS1: TLMDRAS;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    gbEnableDUN: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    cbUseModem: TCheckBox;
    cbDUN: TComboBox;
    edRetries: TEdit;
    UpDown1: TUpDown;
    cbAutoDial: TCheckBox;
    cbAutoClose: TCheckBox;
    edURL: TEdit;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    cbUseProxy: TCheckBox;
    edHost: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    edPort: TEdit;
    GroupBox2: TGroupBox;
    cbProxyAuth: TCheckBox;
    Label6: TLabel;
    edUser: TEdit;
    lbPWD: TLabel;
    edPWD: TEdit;
    Label7: TLabel;
    cmbProxyType: TComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure edRetriesKeyPress(Sender: TObject; var Key: Char);
    procedure edPortKeyPress(Sender: TObject; var Key: Char);
    procedure cbUseModemClick(Sender: TObject);
    procedure cbUseProxyClick(Sender: TObject);
    procedure cbProxyAuthClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LMDUpdateInternetOptions: TLMDUpdateInternetOptions;

implementation

uses
  LMDStrings;

{$R *.dfm}

procedure TLMDUpdateInternetOptions.UpDown1Click(Sender: TObject;
  Button: TUDBtnType);
begin
  if Button = btPrev then
    if edRetries.Text <> '0' then
      edRetries.Text := IntToStr(StrToInt(edRetries.Text) - 1);
  if Button = btNext then
    edRetries.Text := IntToStr(StrToInt(edRetries.Text) + 1);
end;

procedure TLMDUpdateInternetOptions.edRetriesKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not LMDAnsiCharInSet(Key, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
    Key := #0;
end;

procedure TLMDUpdateInternetOptions.edPortKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not LMDAnsiCharInSet(Key, ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
    Key := #0; 
end;

procedure TLMDUpdateInternetOptions.cbUseModemClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to gbEnableDUN.ControlCount - 1 do
    gbEnableDUN.Controls[i].Enabled := cbUseModem.Checked;
  cbUseModem.Enabled := True;
end;

procedure TLMDUpdateInternetOptions.cbUseProxyClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to GroupBox1.ControlCount - 1 do
    GroupBox1.Controls[i].Enabled := cbUseProxy.Checked;
  cbUseProxy.Enabled := True;
end;

procedure TLMDUpdateInternetOptions.cbProxyAuthClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to GroupBox2.ControlCount - 1 do
    GroupBox2.Controls[i].Enabled := cbProxyAuth.Checked;
  cbProxyAuth.Enabled := True;
end;

procedure TLMDUpdateInternetOptions.FormShow(Sender: TObject);
begin
  PageControl1.TabIndex := 0;
  edURL.SetFocus();
end;

end.
