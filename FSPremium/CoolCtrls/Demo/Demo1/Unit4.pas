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
unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CoolPolygons, ExtCtrls, StdCtrls, CoolCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    CoolPolygones1: TCoolPolygones;
    CoolPolyRegions1: TCoolPolyRegions;
    Label1: TCoolLabel;
    CoolFormHook1: TCoolFormHook;
    CoolBtn9: TCoolBtn;
    procedure CoolPolygones1PolygonClick(Sender: TObject; Index: Integer;
      Pt: TPoint);
    procedure FormCreate(Sender: TObject);
    procedure CoolPolygones1PolygonMove(Sender: TObject; Index: Integer;
      Pt: TPoint);
    procedure CoolPolygones1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.DFM}

uses
  Unit11;

procedure TForm4.CoolPolygones1PolygonClick(Sender: TObject;
  Index: Integer; Pt: TPoint);
begin
  case Index of
    0: ShowMessage('Eurasia');
    1: ShowMessage('Africa');
    2: ShowMessage('North America');
    3: ShowMessage('South America');
    4: ShowMessage('Australia');
  end;
end;

procedure TForm4.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Pred(CoolPolygones1.Polygones.Count) do
    CoolPolygones1.Polygones[I].TransparentEdges := True;
end;

procedure TForm4.CoolPolygones1PolygonMove(Sender: TObject; Index: Integer;
 Pt: TPoint);
begin
  if Index <> -1 then
    CoolPolygones1.Cursor := crHandPoint;
end;

procedure TForm4.CoolPolygones1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  CoolPolygones1.Cursor := crDefault
end;

end.
