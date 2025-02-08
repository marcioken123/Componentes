unit wwmidas;

interface

{$i wwIfDef.pas}

uses classes, wwclient, wwprovider;

procedure Register;

implementation

procedure Register;
begin
  {$ifdef wwdelphi4up}
  RegisterComponents('IP Access', [TwwClientDataSet]);
//  RegisterComponents('IP Access', [TwwProvider]);
  {$endif}
end;


end.
 