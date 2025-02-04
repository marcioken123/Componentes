unit uControle;

interface

uses
  SysUtils, Classes, Controls, Forms;

type
  TControle = class(TComponent)
  private
    FArquivoHelp: String;
    FCampoChave: String;
    FModuloChave: String;
    FNomeTabela: String;
    FReportName: String;
    FReportTitle: String;
    FReportSubTitle: String;
    procedure SetArquivoHelp(const Value: String);
    procedure SetCampoChave(const Value: String);
    procedure SetModuloChave(const Value: String);
    procedure SetNomeTabela(const Value: String);
    procedure SetReportName(const Value: String);
    procedure SetReportSubTitle(const Value: String);
    procedure SetReportTitle(const Value: String);
    { Private declarations }
  protected
    { Protected declarations }
  public
    Constructor Create(AWOner: TComponent); override;
    { Public declarations }
  published
    property ArquivoHelp: String read FArquivoHelp write SetArquivoHelp;
    property CampoChave: String read FCampoChave write SetCampoChave;
    property ModuloChave: String read FModuloChave write SetModuloChave;
    property NomeTabela: String read FNomeTabela write SetNomeTabela;
    property ReportName: String read FReportName write SetReportName;
    property ReportTitle: String read FReportTitle write SetReportTitle;
    property ReportSubTitle: String read FReportSubTitle write SetReportSubTitle;
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Tropicom', [TControle]);
end;

{ TControle }

constructor TControle.Create(AWOner: TComponent);
begin
   inherited;
   if Length(ReportName) = 0 then
      ReportName := TForm(AWOner).Caption;
end;

procedure TControle.SetArquivoHelp(const Value: String);
begin
  FArquivoHelp := Value;
end;

procedure TControle.SetCampoChave(const Value: String);
begin
  FCampoChave := Value;
end;

procedure TControle.SetModuloChave(const Value: String);
begin
  FModuloChave := Value;
end;

procedure TControle.SetNomeTabela(const Value: String);
begin
  FNomeTabela := Value;
end;

procedure TControle.SetReportName(const Value: String);
begin
  FReportName := Value;
end;

procedure TControle.SetReportSubTitle(const Value: String);
begin
  FReportSubTitle := Value;
end;

procedure TControle.SetReportTitle(const Value: String);
begin
   FReportTitle := Value;
end;

end.
