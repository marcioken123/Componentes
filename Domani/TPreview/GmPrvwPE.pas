unit GmPrvwPE;

interface

uses designIntf, DesignEditors, GmPreview, Dialogs;

//------------------------------------------------------------------------------

// object inspector "About" property...

type
  TAboutProperty = class(TPropertyEditor)
  public
    procedure Edit; override;
    procedure ShowAbout;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue:string; override;
  end;

  procedure Register;

implementation

procedure TAboutProperty.Edit;
{call the 'About' dialog window when clicking on ... in the Object Inspector}
begin
  ShowAbout;
end;

function TAboutProperty.GetAttributes: TPropertyAttributes;
{set up to display a string in the Object Inspector}
begin
  GetAttributes := [paDialog, paReadOnly];
end;

function TAboutProperty.GetValue: String;
{set string to appear in the Object Inspector}
begin
  GetValue := '(About)';
end;

procedure TAboutProperty.ShowAbout;
var
  Msg: string;
begin
  // message to display when the about button is pressed...
  Msg := 'TGmPreview Component for Delphi'+#13+
         'Version '+VERSION+#13+#13+
         'Copyright © 2000 Graham Murt'+#13+#13+
         'Website: www.MurtSoft.com'+#13+
         'Email: info@murtsoft.com';
  MessageDlg(Msg, mtInformation, [mbOk], 0);
end;

procedure Register;
begin
  {register the 'About' property editor}
  RegisterPropertyEditor(TypeInfo(String), TGmPreview, 'About',
  	TAboutProperty);
end;

end.