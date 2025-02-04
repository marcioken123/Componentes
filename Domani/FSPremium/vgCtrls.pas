unit vgCtrls;

interface

uses
  Classes, StdCtrls, ExtCtrls, RxDUALLIST;

type
  TvgLabel = class(TLabel)

  end;

  TTitler = class(TPanel)
  end;

  TDualListDialog = class(TRxDualListDialog)
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('FSPremium', [TvgLabel, TTitler, TDualListDialog]);
end;

end.
