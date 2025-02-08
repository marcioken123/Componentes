unit LMDSedSchemeEditDialog;
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

LMDSedSchemeEditDialog unit (VT)
---------------------------------

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LMDTypes, LMDSedUtils, LMDSedView, LMDSedDocument, LMDStrings;

type
  TLMDSedSchemeEditDlg = class(TForm)
    Doc: TLMDEditDocument;
    Button1: TButton;
    Button2: TButton;
    LMDEditView1: TLMDEditView;
    Button3: TButton;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure LMDSedView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  end;

  TLMDEditSchemeEditKind = (skSyntax, skColor);

function LMDEditExecSchemeXMLDialog(AScheme: TLMDStrings;
                                    AKind: TLMDEditSchemeEditKind): Boolean;

implementation

uses LMDSedConst;

{$R *.dfm}

function LMDEditExecSchemeXMLDialog(AScheme: TLMDStrings;
  AKind: TLMDEditSchemeEditKind): Boolean;
var
  dlg: TLMDSedSchemeEditDlg;
  res: Integer;
  msg: TLMDString;
begin
  dlg := TLMDSedSchemeEditDlg.Create(nil);
  try
    dlg.Doc.Lines.Text := AScheme.Text;
    res                := dlg.ShowModal;
    Result             := (res = mrOk);

    if Result then
    begin
      try
        AScheme.Text := dlg.Doc.Lines.Text;
      except
        on E: Exception do
        begin
          case AKind of
            skSyntax: msg := SLMDSedErrorLoadingSyntaxScheme;
            skColor:  msg := SLMDSedErrorLoadingColorScheme;
          else
            Assert(False);
          end;

          MessageDlg(Format(msg, [E.ClassName, E.Message]),
                     mtError, [mbOk], 0);
        end;
      end;
    end;
  finally
    dlg.Free;
  end;
end;

procedure TLMDSedSchemeEditDlg.Button3Click(Sender: TObject);
begin
  OpenDialog1.FileName := '';
  if OpenDialog1.Execute then
    Doc.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TLMDSedSchemeEditDlg.Button4Click(Sender: TObject);
begin
  SaveDialog1.FileName := '';
  if SaveDialog1.Execute then
    Doc.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TLMDSedSchemeEditDlg.FormCreate(Sender: TObject);
begin
  LMDGetDialogFont(Font);
end;

procedure TLMDSedSchemeEditDlg.LMDSedView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    ModalResult := mrCancel;
    Close;
  end;
end;

end.
