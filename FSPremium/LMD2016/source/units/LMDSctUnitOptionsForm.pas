unit LMDSctUnitOptionsForm;
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

LMDSctUnitForm unit (YB)
-------------------------
LMD Script Pack Importer options form for import working document.

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, LMDSctImporterTree, LMDSctImporterUnitDoc;

type
  {************************* class TLMDUnitOptionsFrm *************************}

  TLMDUnitOptionsFrm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    cbIsSysLibDoc: TCheckBox;
    cbIsLocked: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    FDocument: TLMDUnitDocument;
  protected
    procedure UpdateView;
    procedure UpdateDoc;
  public
    constructor Create(AOwner: TComponent;
                       ADocument: TLMDUnitDocument); reintroduce;
    class function Execute(ADocument: TLMDUnitDocument): Boolean;

    property Document: TLMDUnitDocument read FDocument;
  end;

implementation

{$R *.dfm}

{************************** class TLMDUnitOptionsFrm **************************}
{ --------------------------------- published -------------------------------- }

procedure TLMDUnitOptionsFrm.Button1Click(Sender: TObject);
begin
  UpdateDoc;
  ModalResult := mrOk;
end;

{ --------------------------------- protected -------------------------------- }

procedure TLMDUnitOptionsFrm.UpdateView;
begin
  cbIsSysLibDoc.Checked := FDocument.IsSysLibDoc;
  cbIsLocked.Checked    := FDocument.IsLocked;
end;

{ ---------------------------------------------------------------------------- }

procedure TLMDUnitOptionsFrm.UpdateDoc;
begin
  FDocument.IsSysLibDoc := cbIsSysLibDoc.Checked;
  FDocument.IsLocked    := cbIsLocked.Checked;
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDUnitOptionsFrm.Create(AOwner: TComponent;
  ADocument: TLMDUnitDocument);
begin
  inherited Create(AOwner);
  FDocument := ADocument;
  UpdateView;
end;

{ ---------------------------------------------------------------------------- }

class function TLMDUnitOptionsFrm.Execute(ADocument: TLMDUnitDocument): Boolean;
var
  dlg: TLMDUnitOptionsFrm;
begin
  dlg := TLMDUnitOptionsFrm.Create(Application, ADocument);
  try
    Result := (dlg.ShowModal = mrOk);
  finally
    dlg.Free;
  end;
end;
     
{ ---------------------------------------------------------------------------- }

end.
