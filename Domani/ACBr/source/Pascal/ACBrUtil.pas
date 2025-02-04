{******************************************************************************}
{ Projeto: Componentes ACBr                                                    }
{  Biblioteca multiplataforma de componentes Delphi para intera��o com equipa- }
{ mentos de Automa��o Comercial utilizados no Brasil                           }
{                                                                              }
{ Direitos Autorais Reservados (c) 2004 Daniel Simoes de Almeida               }
{                                                                              }
{ Colaboradores nesse arquivo:                                                 }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do  Projeto ACBr    }
{ Componentes localizado em      http://www.sourceforge.net/projects/acbr      }
{                                                                              }
{  Algumas fun�oes dessa Unit foram extraidas de outras Bibliotecas, veja no   }
{ cabe�alho das Fun�oes no c�digo abaixo a origem das informa�oes, e autores...}
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/gpl-license.php                           }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{******************************************************************************
|* Historico
|*
|* 30/06/2004:  Daniel Simoes de Almeida
|*   Fun�oes auxiliares separadas do c�digo do componentes
|* 19/12/2004:  Daniel Simoes de Almeida
|*   Adcionada a procedure DeleteFiles e a Fun�ao CopyFileTo
******************************************************************************}

{$I ACBr.inc}

unit ACBrUtil;

interface
Uses SysUtils, Math, StrUtils, Classes,
 {$ifdef MSWINDOWS} Windows, ShellAPI {$else} Libc {$endif} ;

Function TestBit(const Value: Byte; const Bit: Byte): Boolean;
function padL(AString : string; nLen : Integer; Caracter : Char = ' ') : String;
function padR(AString : string; nLen : Integer; Caracter : Char = ' ') : String;
function padC(AString : string; nLen : Integer; Caracter : Char = ' ') : String;
function padS(AString : string; nLen : Integer; Separador : String;
   Caracter : Char = ' ') : String ;

{ PosEx, retirada de StrUtils, para compatibilizar com o Delphi 6
  (que nao pssui essa fun�ao) }
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
function PosAt(const SubStr, S: string; Ocorrencia : Cardinal = 1): Integer;

function CountStr(AString, SubStr : string ) : Integer ;
Function Poem_Zeros(Texto : String; Tamanho : Integer) : String;
Function IntToStrZero(NumInteiro, Tamanho : Integer) : String;
Function StringToFloat( NumString : String ) : Double ;
Function StringToFloatDef( NumString : String ; DefaultValue : Double ) : Double ;

function StrIsAlpha(const S: String): Boolean;
function StrIsAlphaNum(const S: String): Boolean;
function StrIsNumber(const S: String): Boolean;
function CharIsAlpha(const C: Char): Boolean;
function CharIsAlphaNum(const C: Char): Boolean;
function CharIsNum(const C: Char): Boolean;
function OnlyNumber(const Value: string): String;
function OnlyAlpha(const Value: string): String;
function OnlyAlphaNum(const Value: string): String;
function StrIsIP(const Value: string): Boolean;

function TiraAcentos( AString : String ) : String ;
function TiraAcento( AChar : Char ) : Char ;
function TraduzComando( AString : String ) : String ;

function InPort(PortAddr:word): byte;
procedure OutPort(PortAddr: word; Databyte: byte);

function StrCrypt(AString, StrChave: string): string;
function SomaAscII(AString : string): Integer;

Function FilesExists(FileMask: string) : Boolean ;
Procedure DeleteFiles(FileMask: string)  ;
function CopyFileTo(AFromFileName, AToFileName : String;
   const AFailIfExists : Boolean = false) : Boolean;
procedure RunCommand(Command: String; Params: String = ''; Wait : Boolean = false;
   WindowState : Word = 5);


implementation

{-----------------------------------------------------------------------------
 *** Extraido de JclLogic.pas  - Project JEDI Code Library (JCL) ***
 Retorna True se o nBit est� ativo (ligado) dentro do valor Value. Inicia em 0
 ---------------------------------------------------------------------------- }
function TestBit(const Value: Byte; const Bit: Byte): Boolean;
begin
  Result := (Value and (1 shl (Bit mod 8))) <> 0;
end;

{-----------------------------------------------------------------------------
  Completa <AString> com <Caracter> a direita, at� o tamanho <nLen>, Alinhando
  a <AString> a Esquerda. Se <AString> for maior que <nLen>, ela ser� truncada
 ---------------------------------------------------------------------------- }
function padL(AString : string; nLen : Integer; Caracter : Char) : String ;
begin
  Result := copy(AString,1,nLen) ;
  Result := Result + StringOfChar(Caracter, (nLen - Length(Result))) ;
end ;

{-----------------------------------------------------------------------------
  Completa <AString> com <Caracter> a esquerda, at� o tamanho <nLen>, Alinhando
  a <AString> a Direita. Se <AString> for maior que <nLen>, ela ser� truncada 
 ---------------------------------------------------------------------------- }
function padR(AString : string; nLen : Integer; Caracter : Char) : String ;
begin
  Result := copy(AString,1,nLen) ;
  Result := StringOfChar(Caracter, (nLen - Length(Result))) + Result ;
end ;

{-----------------------------------------------------------------------------
 Completa <AString> Centralizando, preenchendo com <Caracter> a esquerda e direita
 ---------------------------------------------------------------------------- }
function padC(AString : string; nLen : Integer; Caracter : Char) : String ;
Var nCharLeft : Integer ;
begin
  Result    := copy(AString,1,nLen) ;
  nCharLeft := Trunc( (nLen - Length( Result )) / 2 ) ;
  Result    := padL( StringOfChar(Caracter, nCharLeft)+Result, nLen, Caracter) ;
end ;

{-----------------------------------------------------------------------------
  Ajusta a <AString> com o tamanho de <nLen> inserindo espa�os no meio,
  substituindo <Separador> por n X <Caracter>  (Justificado)
 ---------------------------------------------------------------------------- }
function padS(AString : string; nLen : Integer; Separador : String;
   Caracter : Char = ' ') : String ;
var StuffStr : String ;
    nSep, nCharSep, nResto, nFeito, Ini : Integer ;
begin
  Result := copy(AString,1,nLen) ;
  if Separador = Caracter then  { Troca Separador, senao fica em loop infinito }
  begin
     Result   := StringReplace( Result,Separador,#255,[rfReplaceAll]) ;
     Separador:= #255 ;
  end ;

  nSep   := CountStr( Result, Separador ) ;

  if nSep < 1 then
  begin
     Result := PadL(Result, nLen, Caracter ) ;
     exit ;
  end ;

  Result   := Trim( Result ) ;
  nCharSep := Trunc( (nLen - (Length(Result)-nSep)) / nSep ) ;
  nResto   := nLen - ( (Length(Result)-nSep) + (nCharSep*nSep) ) ;
  nFeito   := nSep ;
  StuffStr := StringOfChar( Caracter, nCharSep ) ;

  Ini := Pos( Separador, Result ) ;
  while Ini > 0 do
  begin
     Result := StuffString(Result, Ini, length(Separador),
                 StuffStr + ifthen(nFeito <= nResto, Caracter, '' ) );

     nFeito := nFeito - 1 ;
     Ini := Pos( Separador, Result ) ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Retorna quantas ocorrencias de <SubStr> existem em <AString> 
 ---------------------------------------------------------------------------- }
function CountStr(AString, SubStr : string ) : Integer ;
Var ini : Integer ;
begin
  result := 0 ;
  if SubStr = '' then exit ;

  ini := Pos( SubStr, AString ) ;
  while ini > 0 do
  begin
     Result := Result + 1 ;
     ini    := PosEx( SubStr, AString, ini + 1 ) ;
  end ;
end ;

{-----------------------------------------------------------------------------
 *** PosEx, retirada de StrUtils.pas do Borland Delphi ***
  para compatibilizar com o Delphi 6  (que nao possui essa fun�ao) 
 ---------------------------------------------------------------------------- }
function PosEx(const SubStr, S: string; Offset: Cardinal = 1): Integer;
var
  I,X: Integer;
  Len, LenSubStr: Integer;
begin
  if Offset = 1 then
    Result := Pos(SubStr, S)
  else
  begin
    I := Offset;
    LenSubStr := Length(SubStr);
    Len := Length(S) - LenSubStr + 1;
    while I <= Len do
    begin
      if S[I] = SubStr[1] then
      begin
        X := 1;
        while (X < LenSubStr) and (S[I + X] = SubStr[X + 1]) do
          Inc(X);
        if (X = LenSubStr) then
        begin
          Result := I;
          exit;
        end;
      end;
      Inc(I);
    end;
    Result := 0;
  end;
end;

{-----------------------------------------------------------------------------
  Acha a e-nesima "Ocorrencia" de "SubStr" em "S" 
 ---------------------------------------------------------------------------- }
function PosAt(const SubStr, S: string; Ocorrencia : Cardinal = 1): Integer;
Var Count : Cardinal ;
begin
  Result := Pos( SubStr, S) ;
  Count  := 1 ;
  while (Count < Ocorrencia) and (Result > 0) do
  begin
     Result := PosEx( SubStr, S, Result+1) ;
     Count  := Count + 1 ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Insere ZEROS (0) a esquerda de <Texto> at� completar <Tamanho> 
 ---------------------------------------------------------------------------- }
Function Poem_Zeros(Texto : String; Tamanho : Integer) : String;
begin
  Result := PadR(Trim(Texto),Tamanho,'0') ;
end ;

{-----------------------------------------------------------------------------
  Transforma <NumInteiro> em String, preenchendo com Zeros a Esquerda at�
  atingiros digitos de <Tamnho>
 ---------------------------------------------------------------------------- }
Function IntToStrZero(NumInteiro, Tamanho : Integer) : String;
begin
  Result := '' ;
  try
     Result := IntToStr( NumInteiro ) ;
     Result := Poem_Zeros( Result, Tamanho) ;
  except
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <NumString> para Double, semelhante ao StrToFloatDef, mas
  verifica se a virgula � '.' ou ',' efetuando a convers�o se necess�rio
  Se n�o for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToFloatDef( NumString : String ; DefaultValue : Double ) : Double ;
begin
  try
     Result := StringToFloat( NumString ) ;
  except
     Result := DefaultValue ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Converte uma <NumString> para Double, semelhante ao StrToFloat, mas
  verifica se a virgula � '.' ou ',' efetuando a convers�o se necess�rio
  Se n�o for possivel converter, retorna <DefaultValue>
 ---------------------------------------------------------------------------- }
Function StringToFloat( NumString : String ) : Double ;
begin
  if DecimalSeparator <> '.' then
     NumString := StringReplace(NumString,'.',DecimalSeparator,[rfReplaceAll]) ;

  if DecimalSeparator <> ',' then
     NumString := StringReplace(NumString,',',DecimalSeparator,[rfReplaceAll]) ;

  Result := StrToFloat(NumString)
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Alpha maiusculo/minuscula
 ---------------------------------------------------------------------------- }
function StrIsAlpha(const S: String): Boolean;
Var A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsAlpha( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Numericos
 ---------------------------------------------------------------------------- }
function StrIsNumber(const S: String): Boolean;
Var A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsNum( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <S> contem apenas caracteres Alpha maiusculo/minuscula
  ou Numericos
 ---------------------------------------------------------------------------- }
function StrIsAlphaNum(const S: String): Boolean;
Var A : Integer ;
begin
  Result := true ;
  A      := 1 ;
  while Result and ( A <= Length( S ) )  do
  begin
     Result := CharIsAlphaNum( S[A] ) ;
     Inc(A) ;
  end;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> � Alpha maiusculo/minusculo 
 ---------------------------------------------------------------------------- }
function CharIsAlpha(const C: Char): Boolean;
begin
  Result := ( C in ['A'..'Z','a'..'z'] ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> � N�merico 
 ---------------------------------------------------------------------------- }
function CharIsNum(const C: Char): Boolean;
begin
  Result := ( C in ['0'..'9'] ) ;
end ;

{-----------------------------------------------------------------------------
 *** Extraido de JclStrings.pas  - Project JEDI Code Library (JCL) ***
  Retorna <True> se <C> � Alpha maiusculo/minusculo ou Numerico
 ---------------------------------------------------------------------------- }
function CharIsAlphaNum(const C: Char): Boolean;
begin
  Result := ( CharIsAlpha( C ) or CharIsNum( C ) );
end ;

{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Numericos contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyNumber(const Value: string): String;
Var I : Integer ;
begin
  Result := '' ;
  For I := 1 to Length( Value ) do
  begin
     if CharIsNum( Value[I] ) then
        Result := Result + Value[I] ;
  end;
end ;

{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Alpha contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyAlpha(const Value: string): String;
Var I : Integer ;
begin
  Result := '' ;
  For I := 1 to Length( Value ) do
  begin
     if CharIsAlpha( Value[I] ) then
        Result := Result + Value[I] ;
  end;
end ;
{-----------------------------------------------------------------------------
  Retorna uma String apenas com os char Alpha-Numericos contidos em <Value>
 ---------------------------------------------------------------------------- }
function OnlyAlphaNum(const Value: string): String;
Var I : Integer ;
begin
  Result := '' ;
  For I := 1 to Length( Value ) do
  begin
     if CharIsAlphaNum( Value[I] ) then
        Result := Result + Value[I] ;
  end;
end ;

{-----------------------------------------------------------------------------
 ** Baseada em "IsIp" de synautil.pas - Synapse http://www.ararat.cz/synapse/ **
  Retorna <True> se <Value> � um IP Valido
 ---------------------------------------------------------------------------- }
function StrIsIP(const Value: string): Boolean;
var
  TempIP : string;
  function ByteIsOk(const Value: string): Boolean;
  var
    x: integer;
  begin
    x := StrToIntDef(Value, -1);
    Result := (x >= 0) and (x < 256);
    // X may be in correct range, but value still may not be correct value!
    // i.e. "$80"
    if Result then
       Result := StrIsNumber( Value ) ;
  end;

  function Fetch(var Value: string; const Delimiter: string): string;
  var
    p : Integer ;
  begin
    p := pos(Delimiter,Value) ;
    Result := copy(Value, 1, p-1);
    Value  := copy(Value, p+1, Length(Value)); 
  end;
begin
  TempIP := Value;
  Result := False;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if not ByteIsOk(Fetch(TempIP, '.')) then
    Exit;
  if ByteIsOk(TempIP) then
    Result := True;
end;

{-----------------------------------------------------------------------------
  Substitui todos os caracteres acentuados por compativeis.  
 ---------------------------------------------------------------------------- }
function TiraAcentos( AString : String ) : String ;
Var A : Integer ;
    Letra : Char ;
begin
  Result := '' ;
  For A := 1 to Length( AString ) do
  begin
     Letra := TiraAcento( AString[A] ) ;
     if not (Letra in [#32..#126]) then    {Letras / numeros / pontos / sinais}
        Letra := ' ' ;
     Result := Result + Letra ;
  end
end ;

{-----------------------------------------------------------------------------
  Substitui caracter acentuado por compativel
 ---------------------------------------------------------------------------- }
function TiraAcento( AChar : Char ) : Char ;
begin
  case AChar of
    '�','�','�','�','�' : Result := 'a' ;
    '�','�','�','�','�' : Result := 'A' ;
    '�','�',    '�','�' : Result := 'e' ;
    '�','�',    '�','�' : Result := 'E' ;
    '�','�',    '�','�' : Result := 'i' ;
    '�','�',    '�','�' : Result := 'I' ;
    '�','�','�','�','�' : Result := 'o' ;
    '�','�','�','�','�' : Result := 'O' ;
    '�','�',    '�','�' : Result := 'u' ;
    '�','�',    '�','�' : Result := 'U' ;
    '�'                 : Result := 'c' ;
    '�'                 : Result := 'C' ;
    '�'                 : Result := 'n' ;
    '�'                 : Result := 'N' ;
  else
    Result := AChar ;
  end;
end ;

{-----------------------------------------------------------------------------
  Traduz Strings do Tipo '#13,v,#10, substituindo #nn por chr(nn). Ignora todo
   texto apos a String ' | '
 ---------------------------------------------------------------------------- }
function TraduzComando( AString : String ) : String ;
Var A : Integer ;
    C : Char ;
    Token : String ;
begin
  A := pos(' | ',AString) ;
  if A > 0 then
     AString := copy(AString,1,A-1) ;   { removendo texto apos ' | ' }

  AString := Trim( AString ) ;
  Result  := '' ;
  A       := 1 ;
  Token   := '' ;

  while A <= length( AString ) + 1 do
  begin
     if A > length( AString ) then
        C := ','
     else
        C := AString[A] ;

     if (C = ',') and (Length( Token ) >= 1) then
      begin
        if Token[1] = '#' then
        try
           Token := chr( StrToInt( copy(Token,2,length(Token)) ) ) ;
        except
        end ;

        Result := Result + Token ;
        Token := '' ;
      end
     else
        Token := Token + C ;

     A := A + 1 ;
  end ;
end ;

{-----------------------------------------------------------------------------
 Retorna a String <AString> encriptada por <StrChave>.
 Use a mesma chave para Encriptar e Desencriptar
 ---------------------------------------------------------------------------- }
function StrCrypt(AString, StrChave: string): string;
var
  i, TamanhoString, pos, PosLetra, TamanhoChave: Integer;
begin
  Result        := AString;
  TamanhoString := Length(AString);
  TamanhoChave  := Length(StrChave);

  for i := 1 to TamanhoString do
  begin
     pos := (i mod TamanhoChave);
     if pos = 0 then
        pos := TamanhoChave;

     posLetra := ord(Result[i]) xor ord(StrChave[pos]);
     if posLetra = 0 then
        posLetra := ord(Result[i]);

     Result[i] := chr(posLetra);
  end;
end ;

{-----------------------------------------------------------------------------
 Retorna a soma dos Valores ASCII de todos os char de <AString>
 -----------------------------------------------------------------------------}
function SomaAscII(AString : string): Integer;
Var A , TamanhoString : Integer ;
begin
  Result        := 0 ;
  TamanhoString := Length(AString);
  
  For A := 1 to TamanhoString do
     Result := Result + ord( AString[A] ) ;
end ;

{-----------------------------------------------------------------------------
 L� 1 byte de uma porta de Hardware
 Nota: - Essa fun�ao funciona normalmente em Win9x,
        - XP /NT /2000, deve-se usar um device driver que permita acesso direto
          a porta do Hardware a ser acessado (consulte o fabricante do Hardware)
        - Linux: � necess�rio ser ROOT para acessar /dev/port
          (use: su  ou  chmod u+s SeuPrograma ) 
 ---------------------------------------------------------------------------- }
{$WARNINGS OFF}
function InPort(PortAddr:word): byte;
{$IFDEF LINUX}
var Buffer : Pointer ;
    FDevice : String ;
    N : Integer ;
    FHandle : Integer ;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  asm
    mov dx,PortAddr
    in al,dx
  end;
{$ELSE}
  FDevice := '/dev/port' ;
  Buffer  := @Result ;

  FHandle := FileOpen(FDevice, fmOpenRead);
  if FHandle <= 0 then
     raise Exception.Create('Erro abrindo:  '+FDevice+#10+#10+
                            'Voc� deve ter direito de Leitura nesse diret�rio.');
  try
     N := FileSeek( FHandle, PortAddr, 0 )  ;
     if N <= 0 then
        raise Exception.Create('Erro ao acessar a porta: '+IntToStr(PortAddr));

     N := FileRead(FHandle, Buffer^, 1) ;
     if N <= 0 then
        raise Exception.Create('Erro ao ler a porta: '+IntToStr(PortAddr));
  finally
     FileClose( FHandle );
  end ;
  sleep(5) ;   
{$ENDIF}
end ;
{$WARNINGS ON}

{-----------------------------------------------------------------------------
 Envia 1 byte para uma porta de Hardware 
 Nota: - Essa fun�ao funciona normalmente em Win9x,
        - XP /NT /2000, deve-se usar um device driver que permita acesso direto
          a porta do Hardware a ser acessado (consulte o fabricante do Hardware)
        - Linux: � necess�rio ser ROOT para acessar /dev/port
          (use: su  ou  chmod u+s SeuPrograma ) 
 ---------------------------------------------------------------------------- }
procedure OutPort(PortAddr: word; Databyte: byte);
{$IFDEF LINUX}
var Buffer : Pointer ;
    FDevice : String ;
    N : Integer ;
    FHandle : Integer ;
{$ENDIF}
begin
{$IFDEF MSWINDOWS}
  asm
     mov al, Databyte
     mov dx,PortAddr
     out dx,al
  end;
{$ELSE}
  Buffer := @Databyte ;
  FDevice := '/dev/port' ;

  FHandle := FileOpen(FDevice, fmOpenWrite);
  if FHandle <= 0 then
     raise Exception.Create('Erro abrindo:  '+FDevice+#10+#10+
                            'Voc� deve ter direito de Escrita nesse diret�rio.');
  try
     N := FileSeek( FHandle, PortAddr, 0 )  ;
     if N <= 0 then
        raise Exception.Create('Erro ao acessar a porta: '+IntToStr(PortAddr));

     N := FileWrite(Fhandle, Buffer^, 1) ;
     if N <= 0 then
        raise Exception.Create('Erro ao escrever na porta: '+IntToStr(PortAddr));
  finally
     FileClose( FHandle );
  end ;
  sleep(5) ;
{$ENDIF}
end ;

{-----------------------------------------------------------------------------
  Semelhante a FileExists, mas permite uso de mascaras Ex:(*.BAK, TEST*.PX, etc)
 ---------------------------------------------------------------------------- }
Function FilesExists(FileMask: string) : Boolean ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
begin
  LastFile := '' ;
  Result   := false ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec) ;
  try
     while (not Result) and (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;
        Result   := (pos(LastFile, '..') = 0) ;   { ignora . e .. }
        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;

{-----------------------------------------------------------------------------
  Semelhante a DeleteFile, mas permite uso de mascaras Ex:(*.BAK, TEST*.PX, etc)
  Gera Exce��o se n�o conseguir apagar algum dos arquivos.
 ---------------------------------------------------------------------------- }
Procedure DeleteFiles(FileMask: string)  ;
var SearchRec : TSearchRec ;
    RetFind   : Integer ;
    LastFile  : string ;
    Path      : String ;
begin
  LastFile := '' ;
  Path     := ExtractFilePath(FileMask) ;
  RetFind  := SysUtils.FindFirst(FileMask, faAnyFile, SearchRec);
  try
     while (RetFind = 0) and (LastFile <> SearchRec.Name) do
     begin
        LastFile := SearchRec.Name ;

        if pos(LastFile, '..') = 0 then    { ignora . e .. }
        begin
           if not SysUtils.DeleteFile(Path + LastFile) then
             raise Exception.Create('Erro ao apagar: ' + Path + LastFile);
        end ;

        SysUtils.FindNext(SearchRec) ;
     end ;
  finally
     SysUtils.FindClose(SearchRec) ;
  end ;
end ;

{-----------------------------------------------------------------------------
 *** CopyFileTo Extraida de idGlobals.pas - INDY ***
 Copia arquivo "AFromFilename" para "AToFilename".  Retorna true se OK
 Nao copia, e retorna false se o destino "AToFilename" j� existir e
   "AFailIfExists"  for true
 ---------------------------------------------------------------------------- }
function CopyFileTo(AFromFileName, AToFileName : String;
   const AFailIfExists : Boolean) : Boolean;
{$IFNDEF MSWINDOWS}
var LStream : TStream;
{$ENDIF}
begin
  {$IFDEF MSWINDOWS}
    Result := CopyFile(PChar(AFromFileName), PChar(AToFileName), AFailIfExists);
  {$ELSE}
    if FileExists(AToFileName) and AFailIfExists then
       Result := False
    else
     begin
       LStream := TFileStream.Create(AFromFileName, fmOpenRead or fmShareDenyWrite);
       try
          with TFileStream.Create(AToFileName, fmCreate) do
             try
                CopyFrom(LStream, 0);
             finally
                Free;
             end;
       finally
          FreeAndNil(LStream);
       end;
       Result := True;
     end;
  {$ENDIF}
end;

{-----------------------------------------------------------------------------
 - Executa programa Externo descrito em "Command", adcionando os Parametros
   "Params" na linha de comando
 - Se "Wait" for true para a execu��o da aplica��o para esperar a conclusao do
   programa externo executado por "Command"
 - WindowState apenas � utilizado na plataforma Windows
 ---------------------------------------------------------------------------- }
procedure RunCommand(Command: String; Params: String; Wait : Boolean;
   WindowState : Word);
var
  {$ifdef MSWINDOWS}
  SUInfo: TStartupInfo;
  ProcInfo: TProcessInformation;
  Executed : Boolean ;
  PCharStr : PChar ;
  {$endif}
  ConnectCommand : PChar;
begin
  {$ifdef LINUX}
     Command := Trim(Command + ' ' + Params) ;
     if not Wait then
        Command := Command + ' &' ;  { & = Rodar em BackGround }
     ConnectCommand := PChar(Command);
     Libc.system(ConnectCommand);
  {$endif}
  {$ifdef MSWINDOWS}
     Command  := Trim(Command) ;
     PCharStr := PChar(Trim(Params)) ;
     if Length(PCharStr) = 0 then
        PCharStr := nil ;

     if not Wait then
        ShellExecute(0,'open',PChar(Command),PCharStr, nil, WindowState )
//        winexec(ConnectCommand, WindowState)
     else
      begin
        ConnectCommand := PChar(Trim(Command + ' ' + Params));
        PCharStr := PChar(ExtractFilePath(Command)) ;
        if Length(PCharStr) = 0 then
           PCharStr := nil ;
        FillChar(SUInfo, SizeOf(SUInfo), #0);
        with SUInfo do
        begin
           cb          := SizeOf(SUInfo);
           dwFlags     := STARTF_USESHOWWINDOW;
           wShowWindow := WindowState;
        end;

        Executed := CreateProcess(nil, ConnectCommand, nil, nil, false,
                    CREATE_NEW_CONSOLE or NORMAL_PRIORITY_CLASS, nil,
                    PCharStr, SUInfo, ProcInfo);

        try
           { Aguarda at� ser finalizado }
           if Executed then
              WaitForSingleObject(ProcInfo.hProcess, INFINITE);
        finally
           { Libera os Handles }
           CloseHandle(ProcInfo.hProcess);
           CloseHandle(ProcInfo.hThread);
        end;
      end;
  {$endif}
end;


end.
