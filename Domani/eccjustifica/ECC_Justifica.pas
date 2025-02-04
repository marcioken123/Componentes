unit ECC_Justifica;

{$RESOURCE ECC_Justifica.dcr}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  quickrpt, Qrctrls, stdctrls;

type

  TQRECC_Check = class(TQRPrintable)
  private
    { Private declarations }
  private
    FChecked : boolean;
    procedure SetChecked(Value : boolean);
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
  published
    property Checked : boolean read FChecked write SetChecked;
  end;

  TAlin=(taRightJustify,taCenter,taLeftJustify,taAllJustify);

  TQRECC_Memo = class(TQRMemo)
  private
    { Private declarations }
  private
    FAlin    : TAlin;
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure SetAlin(Value: TAlin);
  published
    property Alignment : TAlin read FAlin write SetAlin;
  end;

  TQRECC_DBRich = class(TQRDBRichText)
  private
    { Private declarations }
  private
    FAlin    : TAlin;
  public
    constructor Create(AOwner : TComponent); override;
    procedure Paint; override;
    procedure Print(OfsX, OfsY : integer); override;
    procedure SetAlin(Value: TAlin);
  published
    property Alignment : TAlin read FAlin write Setalin;
  end;

  procedure Register;
  procedure Justifica_Texto(Sender:TControl;pLista:TStrings;pCanvas:TCanvas;pEsquerda,pCima,pDireita,pBaixo:Integer;AutoStretch:Boolean);

implementation

procedure Register;
begin
  RegisterComponents('QReport_ECC', [TQRECC_Check,TQRECC_Memo,TQRECC_DBRich]);
end;

constructor TQRECC_DBRich.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
end;

constructor TQRECC_Memo.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  Alignment:=taAllJustify;
  AutoSize:=False;
  AutoStretch:=True;
  Width:=201;
  Lines.Clear;
  Lines.Add('Campo Memo Justificado propriedade alignment igual taAllJustify');
  Lines.Add('Width maior que 200 se o valor for menor Campo não aparecerá Justificado, pois necessita de Espaço maior para Justificar');
  Lines.Add('AutoSize igual a False necessário para Justificar');
  Lines.Add('AutoStretch igual a True mostra todas as linhas necessárias');
  Invalidate;
end;

procedure TQRECC_DBRich.Print(OfsX, OfsY : integer);
var R:TRect;
    CalcLeft  :Integer;
    CalcTop   :Integer;
    CalcRight :Integer;
    CalcBottom:Integer;
begin
  Inherited;
  if (Alignment=taAllJustify) then begin
    with ParentReport.QRPrinter do begin
      try
        CalcLeft := XPos(OfsX + Size.Left);
        CalcTop := YPos(OfsY + Size.Top);
        CalcRight := XPos(OfsX + Size.Left + Size.Width);
        CalcBottom := YPos(OfsY + Size.Top + Size.Height);
        R:=Rect(CalcLeft,CalcTop,CalcRight,CalcBottom);
        Canvas.Brush.Color:=clWhite;
        Canvas.FillRect(R);
        Justifica_Texto(Self,Lines,Canvas,CalcLeft,CalcTop,CalcRight,CalcBottom,AutoStretch);
      except
        ShowMessage('Justificação Não Possivel.');
      end;
    end;
  end;
end;


procedure TQRECC_DBRich.Paint;
var R:TRect;
begin
  Inherited;
  if (Alignment=taAllJustify) and (Width>=200) then begin
    try
      R:=Rect(0,0,Width,Height);
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(R);
      Justifica_Texto(Self,Lines,Canvas,0,0,Width,Height,AutoStretch);
    except
       inherited;
    end;
  end;
end;

procedure TQRECC_Memo.Print(OfsX, OfsY : integer);
var R:TRect;
    CalcLeft  :Integer;
    CalcTop   :Integer;
    CalcRight :Integer;
    CalcBottom:Integer;
begin
  Inherited;
  if (Alignment=taAllJustify) then begin
    with ParentReport.QRPrinter do begin
      try
        CalcLeft := XPos(OfsX + Size.Left);
        CalcTop := YPos(OfsY + Size.Top);
        CalcRight := XPos(OfsX + Size.Left + Size.Width);
        CalcBottom := YPos(OfsY + Size.Top + Size.Height);
        R:=Rect(CalcLeft,CalcTop,CalcRight,CalcBottom);
        Canvas.Brush.Color:=clWhite;
        Canvas.FillRect(R);
        Justifica_Texto(Self,Lines,Canvas,CalcLeft,CalcTop,CalcRight,CalcBottom,AutoStretch);
      except
        ShowMessage('Justificação Não Possivel.');
      end;
    end;
  end;
end;


procedure TQRECC_Memo.Paint;
var R:TRect;
begin
  Inherited;
  if (Alignment=taAllJustify) and (Width>=200) then begin
    try
      R:=Rect(0,0,Width,Height);
      Canvas.Brush.Color:=clWhite;
      Canvas.FillRect(R);
      Justifica_Texto(Self,Lines,Canvas,0,0,Width,Height,AutoStretch);
    except
      ShowMessage('Justificação Não Possivel.');
    end;
  end;
end;


constructor TQRECC_Check.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FChecked := False;
end;

procedure TQRECC_Check.SetChecked(Value : boolean);
begin
  if Value <> FChecked then
  begin
    FChecked := Value;
    Invalidate;
  end;
end;

procedure TQRECC_Check.Paint;
begin
  with Canvas do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Rectangle(0, 0, Width - 1, Height - 1);
    if Checked then
    begin
      MoveTo(0, 0);
      LineTo(Width - 1, Height - 1);
      MoveTo(0, Height - 1);
      LineTo(Width - 1, 0);
    end;
  end;
end;

procedure TQRECC_Check.Print(OfsX, OfsY : integer);
var
  CalcLeft,
  CalcTop,
  CalcRight,
  CalcBottom : Longint;
begin
  with ParentReport.QRPrinter do
  begin
    Canvas.Pen.Color := clBlack;
    Canvas.Pen.Width := 1;
    CalcLeft := XPos(OfsX + Size.Left);
    CalcTop := YPos(OfsY + Size.Top);
    CalcRight := XPos(OfsX + Size.Left + Size.Width);
    CalcBottom := YPos(OfsY + Size.Top + Size.Height);
    Canvas.Rectangle(CalcLeft, CalcTop, CalcRight, CalcBottom);
    if Checked then
    begin
      Canvas.MoveTo(CalcLeft, CalcTop);
      Canvas.LineTo(CalcRight, CalcBottom);
      Canvas.MoveTo(CalcLeft, CalcBottom);
      Canvas.LineTo(CalcRight, CalcTop);
    end;
  end;
end;

procedure Justifica_Texto(Sender:TControl;pLista:TStrings;pCanvas:TCanvas;pEsquerda,pCima,pDireita,pBaixo:Integer;AutoStretch:Boolean);
var
  i: Integer;
  Inipa1:Integer;
  Quebras:Integer;
  TamY,PosY,nClientWidth: Integer;
  Linha: string;
  Palavra: String;
  R:TRect;
begin
  nClientWidth:=pDireita-pEsquerda;
  if Sender.Width<200 then exit;
  R:=Rect(pEsquerda,pCima,pDireita,pBaixo);
  i:= 1;
  PosY :=pCima;
  Tamy:= pCanvas.TextHeight('Wy');
  Linha:='';
  Quebras:=0;
  SetBkMode(pCanvas.Handle,0);
  with pLista do begin
    while i<= Length(Text) do begin
      if PosY>pBaixo then begin
        if not AutoStretch then break;
        Sender.Height:=Sender.Height+TamY;
        Break; {acabou linhas disponiveis para o texto}
      end;
      while Text[i] in [' ',#10,#13] do begin
        Inc(i);
        continue;
      end;
      IniPa1:=i;
      while (i<= Length(text)) and not (Text[i] in [' ',#10,#13]) do Inc(i);
      setTextJustification(pCanvas.Handle,0,0);
      Palavra:=copy(Text,IniPa1,i-IniPa1);
      if pcanvas.TextWidth(Linha)+pcanvas.TextWidth(Palavra) > nClientWidth then begin
        setTextJustification(pCanvas.Handle,nClientWidth - pcanvas.textWidth(Linha),Quebras);
        pcanvas.textout(pEsquerda,PosY,Linha);
        Linha:= Palavra;
        Quebras:=0;
        Inc(PosY,TamY);
        Continue;
      end;
      if Linha<>'' then
        Linha:=Linha+' '+Palavra
      else begin
        Linha:=Palavra;
      end;
      if (i > Length(Text)) or (Text[i] in [#10,#13]) then begin
        pCanvas.textOut(pEsquerda,PosY,Linha);
        inc(PosY,TamY);
        Linha:='';
        Quebras:=0;
        if i > Length(Text) then
          break
        else begin
          continue;
        end;
      end;
      Inc(Quebras);
    end;
  end;
end;

procedure TQRECC_DBRich.SetAlin(Value: TAlin);
begin
  if Value <> FAlin then
  begin
    FAlin := Value;
    inValidate;
  end;
end;

procedure TQRECC_Memo.SetAlin(Value: TAlin);
begin
  if Value <> FAlin then
  begin
    FAlin := Value;
    inValidate;
  end;
end;

end.
