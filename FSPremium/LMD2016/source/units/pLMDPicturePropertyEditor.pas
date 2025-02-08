unit pLMDPicturePropertyEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ExtDlgs, LMDPNGImage;

type
  TLMDPicturePropertyEditorDlg = class(TForm)
    Bevel1: TBevel;
    Panel1: TPanel;
    Image: TImage;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    OpenPictureDialog: TOpenPictureDialog;
    SavePictureDialog: TSavePictureDialog;
    procedure Button5Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure SetPicture(const Value: TPicture);
    function GetPicture: TPicture;
    { Private declarations }
  public
    { Public declarations }
    PNGImage: TLMDPNGObject;
    property Picture: TPicture read GetPicture write SetPicture;
    function Execute: Boolean;
  end;

var
  LMDPicturePropertyEditorDlg: TLMDPicturePropertyEditorDlg;

implementation

{$R *.dfm}

{ TForm2 }

function TLMDPicturePropertyEditorDlg.Execute: Boolean;
begin
  Result := (ShowModal = mrOk);
end;

procedure TLMDPicturePropertyEditorDlg.FormCreate(Sender: TObject);
begin
  PNGImage := TLMDPNGObject.Create;
end;

procedure TLMDPicturePropertyEditorDlg.FormDestroy(Sender: TObject);
begin
  PNGImage.Free;
end;

procedure TLMDPicturePropertyEditorDlg.SetPicture(const Value: TPicture);
begin
  Image.Picture.Assign(Value);
end;

function TLMDPicturePropertyEditorDlg.GetPicture: TPicture;
begin
  Result := Image.Picture;
end;

procedure TLMDPicturePropertyEditorDlg.Button5Click(Sender: TObject);
begin
  Image.Picture.Graphic := nil;
end;

procedure TLMDPicturePropertyEditorDlg.Button3Click(Sender: TObject);
begin
  if OpenPictureDialog.Execute then
  begin
    Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
    PNGImage.LoadFromFile(OpenPictureDialog.FileName);
  end;
end;

procedure TLMDPicturePropertyEditorDlg.Button4Click(Sender: TObject);
begin
  if SavePictureDialog.Execute then
    Image.Picture.SaveToFile(SavePictureDialog.FileName);
end;

end.
