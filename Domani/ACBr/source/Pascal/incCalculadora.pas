procedure TFrCalculadora.FormCreate(Sender: TObject);
begin
  pOnCalKey := nil ;
  pOnDisplayChange := nil ;
  bponto.Caption := DecimalSeparator ;
  bce.Click ;
  pPrecisao  := 4 ;
  pSaiComEsc := True ;
end;

procedure TFrCalculadora.ExecOnCalcKey(Sender : TObject; Key : Char ) ;
begin
  if Assigned( pOnCalKey ) and (Key <> '') then
     pOnCalKey( Sender, Key ) ;
end ;

procedure TFrCalculadora.ExecOnDisplayChange(Sender : TObject ) ;
var Valor : Double ;
begin
  Valor := StrToFloatDef( pValor.Caption, 0 );
  
  if Assigned( pOnDisplayChange ) then
     pOnDisplayChange( Sender, Valor ) ;
end ;

procedure TFrCalculadora.ZeraDisplay( Sender : TObject ) ;
begin
  pValor.Caption := '0' ;
  if mBobina.Showing then
     mBobina.SetFocus ;
end ;

procedure TFrCalculadora.b1Click(Sender: TObject);
var Tecla : String ;
begin
  if Sender is TButton then
     with Sender as TButton do begin
        if fOperacao = '=' then begin
           pValor.Caption := Caption ;
           fOperacao := '' ;
          end
        else
           if pValor.Caption = '0' then
              pValor.Caption := Caption
           else
              pValor.Caption := pValor.Caption + Caption ;

        Tecla := Caption ;
        ExecOnCalcKey(Sender, Tecla[1]);
     end;

  mBobina.SetFocus ;
end ;

procedure TFrCalculadora.FormKeyPress(Sender: TObject; var Key: Char);
Var Botao : TButton ;
begin

  Botao := nil ;

  if (Key = #27) and pSaiComEsc then
    Close ;

  case Key of
     '1' : Botao := b1 ;
     '2' : Botao := b2 ;
     '3' : Botao := b3 ;
     '4' : Botao := b4 ;
     '5' : Botao := b5 ;
     '6' : Botao := b6 ;
     '7' : Botao := b7 ;
     '8' : Botao := b8 ;
     '9' : Botao := b9 ;
     '0' : Botao := b0 ;
     'C' : Botao := bc ;
     'c' : Botao := bc ;
     'E' : Botao := bce ;
     'e' : Botao := bce ;
     '+' : Botao := bmais ;
     '-' : Botao := bmenos ;
     '*' : Botao := bmulti ;
     'x' : Botao := bmulti ;
     '/' : Botao := bdiv ;
     '.' : Botao := bponto ;
     ',' : Botao := bponto ;
     '%' : Botao := bporc ;
     #8  : Botao := bapaga ;
     { #13 : Botao := bigual ; (nao funciona em CLX, usei Default no Botao =) }
  end;

  if Botao is TButton then begin
     { Simulando um CLICK }
     Botao.Visible := False ;
     Timer1.Enabled := true ;
     while Timer1.Enabled do
        Application.ProcessMessages ;
     Botao.Visible := True ;

     Botao.Click
  end ;

end;

procedure TFrCalculadora.Timer1Timer(Sender: TObject);
begin
  { O proprio Timer se desabilita }
  Timer1.Enabled := false ;
end;

procedure TFrCalculadora.bapagaClick(Sender: TObject);
begin
  pValor.Caption := copy( pValor.Caption, 1, length(pValor.Caption)-1 ) ;
  if pValor.Caption  = '' then
   begin
     ZeraDisplay( Sender ) ;
     ExecOnCalcKey(Sender, #8);
   end ;
   
  mBobina.SetFocus ;
end;

procedure TFrCalculadora.bpontoClick(Sender: TObject);
begin
  if pos(DecimalSeparator,pValor.Caption ) = 0 then
   begin
     b1Click(Sender) ;
     ExecOnCalcKey(Sender, DecimalSeparator);
   end ;
   
  mBobina.SetFocus ;
end;

procedure TFrCalculadora.bcClick(Sender: TObject);
begin
  ZeraDisplay( Sender ) ;
  ExecOnCalcKey(Sender, 'C');
  ExecOnDisplayChange(Sender);
end;

procedure TFrCalculadora.b0Click(Sender: TObject);
begin
  if pValor.Caption <> '0' then
     b1Click(Sender) ;
end;

procedure TFrCalculadora.bceClick(Sender: TObject);
begin
  fValor    := 0 ;
  fOperacao := '' ;
  ZeraDisplay( Sender ) ;

  mBobina.Lines.Clear ;
  mBobina.Lines.Add('0   CE') ;

  ExecOnCalcKey(Sender, 'E');
  ExecOnDisplayChange(Sender);
end;

procedure TFrCalculadora.AcaoClick(Sender: TObject);
Var ValDisp : Double ;
    Acao    : String ;
begin
  Acao := '' ;
  if Sender is TButton then
   begin
     Acao := TButton(Sender).Caption ;
   end ;

  Try
     ValDisp := StrToFloat(pValor.Caption) ;
  except
     ValDisp := 0
  end ;

  if ValDisp > 0 then
   begin
     if (fOperacao <> '') and (fOperacao <> '=') then
      begin
        if fOperacao = '+' then fValor := fValor + ValDisp ;
        if fOperacao = '-' then fValor := fValor - ValDisp ;
        if fOperacao = 'x' then fValor := fValor * ValDisp ;
        if fOperacao = '/' then fValor := fValor / ValDisp ;
      end
     else
        fValor := ValDisp ;

     if Acao <> '=' then begin
        mBobina.Lines.Add(pValor.Caption + '  ' + Acao ) ;
        ExecOnDisplayChange(Sender) ;
        ZeraDisplay( Sender ) ;
      end
     else
        if pValor.Caption <> '0' then begin
           fValor := RoundTo(fValor,-pPrecisao) ;
           mBobina.Lines.Add(pValor.Caption + '    ' ) ;
           mBobina.Lines.Add('===============') ;
           mBobina.Lines.Add(FloatToStr(fValor) + '  =') ;
           pValor.Caption := FloatToStr(fValor) ;
           ExecOnDisplayChange(Sender) ;
        end ;
   end 
  else
   begin   { Usu�rio Trocou de Opera�ao }
    mBobina.Lines.Delete(mBobina.Lines.Count-1) ;
    mBobina.Lines.Add(FloatToStr(fValor) + '  ' + Acao ) ;
   end ;

  fOperacao := Acao ;

  if Acao <> '' then
     ExecOnCalcKey(Sender, Acao[1]);

  mBobina.SetFocus ;
end;

procedure TFrCalculadora.bporcClick(Sender: TObject);
Var ValDisp : Double ;
begin
  Try
     ValDisp := StrToFloat(pValor.Caption) ;
     ValDisp := fValor * ( ValDisp / 100 ) ;
     pValor.Caption := FloatToStr(ValDisp) ;
     ExecOnDisplayChange(Sender) ;

     ExecOnCalcKey(Sender, '%');
  except
     pValor.Caption := '0' ;
  end ;

  mBobina.SetFocus ;
end;

procedure TFrCalculadora.Salvar1Click(Sender: TObject);
begin
  if SaveDialog1.Execute then
     mBobina.Lines.SaveToFile(SaveDialog1.FileName);
end;

procedure TFrCalculadora.Copiar1Click(Sender: TObject);
begin
  mBobina.SelectAll ;
  mBobina.CopyToClipboard ;
  mBobina.SelLength := 0 ;
end;

procedure TFrCalculadora.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  {$IFDEF VisualCLX}
    if (Key = 4100) and (ssCtrl in Shift) then
  {$ELSE}
    if (Key = 13) and (ssCtrl in Shift) then
  {$ENDIF}
     begin
       mBobina.Text := pValor.Caption ;
       Copiar1Click(Sender);
       ModalResult := mrOk ;
     end ;
end;

