unit BarCodeFS;

interface

uses
  Classes, StdCtrls, ExtCtrls, RxDUALLIST;

type
  TBarCode = class(TPanel)

  end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TBarCode]);
end;

end.
