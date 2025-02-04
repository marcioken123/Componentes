Acco RTTI
----------------
ver. 1.0

(c) 2002 Igor Forgac
if@enterkosice.sk

-- copy AcRTTI.dcu and AcGrids.dcu to the search path defined in your Delphi

Example:

Use AcRTTI;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowRTTI(self);
end;