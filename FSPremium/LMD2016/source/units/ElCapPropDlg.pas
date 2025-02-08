unit ElCapPropDlg;
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

ElCapProDlg unit
----------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Typinfo, 
  {$ifdef LMD_UNICODE}
  LMDUnicodeStrings,
  {$endif}
  LMDTypes,
  ExtCtrls, StdCtrls, ComCtrls, ElIni, ElFrmPers, ElXPThemedControl,
  ElEdits, Buttons;

type
  TElCapPropDialog = class(TForm)
    Panel1: TPanel;
    OkButton: TButton;
    CancelButton: TButton;
    Panel2: TPanel;
    LineCounter: TLabel;
    Memo: TElEdit;
    Load: TSpeedButton;
    Save: TSpeedButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure MemoChange(Sender : TObject);
    procedure LoadClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    function GetValue: TLMDString;
    procedure SetValue(const Value: TLMDString);
  public
    property Value: TLMDString read GetValue write SetValue;
  end;

var
  ElCapPropDialog: TElCapPropDialog;

implementation

{$R *.DFM}

procedure TElCapPropDialog.MemoChange(Sender : TObject);
begin
  LineCounter.Caption := Format('%d Lines', [Memo.Lines.Count])
end;

procedure TElCapPropDialog.LoadClick(Sender: TObject);
begin
  if OpenDialog.Execute then
    Memo.Lines.LoadFromFile(OpenDialog.FileName);
end;

procedure TElCapPropDialog.SaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    Memo.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TElCapPropDialog.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27{VK_ESCAPE} then
    ModalResult := mrCancel;
end;

function TElCapPropDialog.GetValue: TLMDString;
begin
  Result := Memo.Lines.Text;
end;

procedure TElCapPropDialog.SetValue(const Value: TLMDString);
begin
  Memo.Lines.Text := Value;
  MemoChange(Self);
end;

end.
