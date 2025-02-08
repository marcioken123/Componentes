{$IFNDEF VER90}
  {$IFNDEF VER100}
    {$IFNDEF VER120}
      {$IFNDEF VER130}
        {$IFNDEF VER140}
          {$IFDEF VER110}
            {$ObjExportAll On}
            {$Define ver100}
          {$ELSE}
            {$IFDEF VER125}
              {$Define ver120}
            {$ELSE}
              {$Define ver90}
            {$ENDIF}
          {$ENDIF}
        {$ELSE}
          {$IFNDEF BCB}
            {$Define Delphi}
          {$ENDIF}
          {$Define ver120}
          {$Define ver130}
        {$ENDIF}
      {$ELSE}
        {$IFNDEF BCB}
          {$Define Delphi}
        {$ENDIF}
        {$Define ver120}
      {$ENDIF}
    {$ELSE}
      {$Define Delphi}
    {$ENDIF}
  {$ELSE}
    {$Define Delphi}
  {$ENDIF}
{$ELSE}
  {$Define Delphi}
{$ENDIF}
unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {$IFDEF VER120}ImgList,{$ENDIF} ExtCtrls, CoolCtrls, StdCtrls, CoolTools,
  Grids;

type
  TForm5 = class(TForm)
    CoolAnimate1: TCoolAnimate;
    CoolImages1: TCoolImages;
    CoolLoupe1: TCoolLoupe;
    CoolScrollingText1: TCoolScrollingText;
    CoolStringGrid1: TCoolStringGrid;
    Button2: TCoolBtn;
    CoolFormHook1: TCoolFormHook;
    CoolBtn9: TCoolBtn;
    CoolTransparentArea1: TCoolTransparentArea;
    CoolCaptionEffects1: TCoolCaptionEffects;
    procedure CoolLoupe1MouseEnter(Sender: TObject);
    procedure CoolLoupe1MouseLeave(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.DFM}

uses
  Unit11;

procedure TForm5.CoolLoupe1MouseEnter(Sender: TObject);
begin
  CoolLoupe1.Active := False;
end;

procedure TForm5.CoolLoupe1MouseLeave(Sender: TObject);
begin
  CoolLoupe1.Active := True;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  with CoolStringGrid1 do
  begin
    Cells[0,1] := 'This cool stringgrid can:';
    Cells[1,0] := '1';
    Cells[2,0] := '2';
    Cells[3,0] := '3';
    Cells[4,0] := '4';

    Cells[1,1] := 'handle multiline text';
    Cells[2,1] := 'work with clipboard';
    Cells[3,1] := 'save / load data';
    Cells[4,1] := 'have custom colors for cells';

    Cells[1,2] := 'align text in any way';
    Cells[2,2] := 'have edges for cells';
    Cells[3,2] := 'insert / remove columns and rows';
    Cells[4,2] := 'have read-only cells';

    Cells[1,3] := 'format text as you type';
    Cells[2,3] := 'have caption and flat borders';
    Cells[3,3] := 'save data in HTML format';
    Cells[4,3] := 'search for text';

    Cells[1,4] := 'have custom fonts for each cell';
    Cells[2,4] := 'be moved in run-time when it has caption';
    Cells[3,4] := 'paint wallpaper in caption area';
    Cells[4,4] := 'have custom colors for selection AND MORE!';

    ReadOnlyCells[4,2] := True;
    Fonts[0,1].Style := [fsBold];
    Fonts[1,0].Style := [fsBold];
    Fonts[2,0].Style := [fsBold];
    Fonts[3,0].Style := [fsBold];
    Fonts[4,0].Style := [fsBold];

    Fonts[1,4].Name := 'Arial';
    Fonts[1,4].Style := [fsItalic];
    Fonts[1,4].Color := clNavy;
  end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  I, J: Integer;
begin
  with CoolStringGrid1 do
  begin
    for I := 1 to ColCount-1 do
    begin
      J := I;
      Colors[I, J] := $B0DEFF;
      WallpaperForCells[I, J] := False;
    end;

    J := RowCount-1;
    for I := 1 to ColCount-1 do
    begin
      Colors[I, J] := $C8B7C0;
      WallpaperForCells[I, J] := False;
      Dec(J);
    end;
  end;
end;

procedure TForm5.FormShow(Sender: TObject);
begin
  CoolScrollingText1.Active := True;
end;

procedure TForm5.FormHide(Sender: TObject);
begin
  CoolScrollingText1.Active := False;
end;

end.
