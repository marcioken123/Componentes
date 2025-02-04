unit ECCPrinter;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,dbctrls, db;

type
  TECCPrinter = class(TComponent)
  private
    { Private declarations }
    FDataLink: TFieldDataLink;
    procedure SetDataSource(Value: TDataSource);
    function GetDataSource: TDataSource;
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
    property DataSource: TDataSource read GetDataSource write SetDataSource;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('QReport', [TECCPrinter]);
end;

function TECCPrinter.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

procedure TECCPrinter.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;


end.
