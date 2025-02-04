unit PropEdExcelColorsD40;

{
********************************************************************************
******* XLSReadWrite V1.36                                               *******
*******                                                                  *******
******* Copyright(C) 1999, 2001 Lars Arvidsson, Axolot Data              *******
*******                                                                  *******
******* email: components@axolot.com                                     *******
******* URL:   http://www.axolot.com                                     *******
********************************************************************************
** Users of the XLSReadWrite component must accept the following disclaimer   **
** of warranty:                                                               **
**                                                                            **
** XLSReadWrite is supplied as is. The author disclaims all warranties,       **
** expressedor implied, including, without limitation, the warranties of      **
** merchantability and of fitness for any purpose. The author assumes no      **
** liability for damages, direct or consequential, which may result from the  **
** use of XLSReadWrite.                                                       **
********************************************************************************
}

{$I XLSRW.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, BIFFRecs, Buttons,
{$ifdef OLD_COMPILER}
  DsgnIntf,
{$else}
  DesignIntf,
  DesignEditors,
{$endif}
  ComCtrls, ToolWin,ImgList;

type
  TfrmPropEdExcelColors = class(TForm)
    ImageList: TImageList;
    pbColors: TPaintBox;
    Button1: TButton;
    Button2: TButton;
    ToolBar1: TToolBar;
    btnNoColor: TToolButton;
    procedure pbColorsPaint(Sender: TObject);
    procedure pbColorsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnNoColorClick(Sender: TObject);
  private
    FColorIndex: integer;

    procedure SetColorIndex(Value: integer);
    function  ColorIndexToRect: TRect;
    procedure DrawColors;
    procedure ColorsPaintOver;
  public
    property EditorColor: integer read FColorIndex write SetColorIndex;
  end;

type TExcelColorsProperty = class(TEnumProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

type TExcelColorsEditor = class(TDefaultEditor)
  protected
{$ifdef OLD_COMPILER}
    procedure EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor: Boolean); override;
{$else}
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;
{$endif}
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

implementation

{$R *.DFM}

procedure TExcelColorsProperty.Edit;
var
  Color: TExcelColor;
  ColorsEditor: TfrmPropEdExcelColors;
begin
  Color := TExcelColor(GetOrdValue);
  ColorsEditor := TfrmPropEdExcelColors.Create(Application);
  try
    ColorsEditor.EditorColor := Integer(Color);
    ColorsEditor.ShowModal;
  finally
    SetOrdValue(Byte(ColorsEditor.EditorColor));
    ColorsEditor.Free;
  end;
end;

function TExcelColorsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{$ifdef OLD_COMPILER}
procedure TExcelColorsEditor.EditProperty(PropertyEditor: TPropertyEditor; var Continue, FreeEditor: Boolean);
var
  PropName: string;
begin
  PropName := PropertyEditor.GetName;
  if (CompareText(PropName, 'CELLCOLOR') = 0) then begin
    PropertyEditor.Edit;
    Continue := False;
  end;
end;
{$else}
procedure TExcelColorsEditor.EditProperty(const Prop: IProperty; var Continue: Boolean);
var
  PropName: string;
begin
  PropName := Prop.GetName;
  if (CompareText(PropName, 'CELLCOLOR') = 0) then begin
    Prop.Edit;
    Continue := False;
  end;
end;
{$endif}

function TExcelColorsEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

function TExcelColorsEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Edit Colors'
  else Result := '';
end;

procedure TExcelColorsEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then Edit;
end;

procedure TfrmPropEdExcelColors.SetColorIndex(Value: integer);
begin
  if Value > 55 then begin
    btnNoColor.Down := True;
    FColorIndex := COLORINDEX_NONE;
  end
  else                            
    FColorIndex := Value;
  ColorsPaintOver;
end;

function TfrmPropEdExcelColors.ColorIndexToRect: TRect;
begin
  Result.Left := (FColorIndex mod 8) * 18;
  Result.Top := (FColorIndex div 8) * 18;
  Result.Right := Result.Left + 20;
  Result.Bottom := Result.Top + 20;
end;

procedure TfrmPropEdExcelColors.ColorsPaintOver;
var
  R: TRect;
begin
  if FColorIndex >= 0 then begin
    R := ColorIndexToRect;
    pbColors.Canvas.Pen.Color := clBtnFace;
    pbColors.Canvas.Brush.Color := clBtnFace;
    pbColors.Canvas.Rectangle(R.Left,R.Top,R.Right,R.Bottom);
    pbColors.Canvas.Pen.Color := clBlack;
    pbColors.Canvas.Brush.Color := TExcelColorPalette64[FColorIndex];
    pbColors.Canvas.Rectangle(R.Left + 4,R.Top + 4,R.Right - 4,R.Bottom - 4);
  end;
end;

procedure TfrmPropEdExcelColors.DrawColors;
var
  X,Y,i,j: integer;
begin
  Y := 4;
  pbColors.Canvas.Pen.Color := clBlack;
  for j := 0 to 6 do begin
    X := 4;
    for i := 0 to 7 do begin
      pbColors.Canvas.Brush.Color := TExcelColorPalette64[i + j * 8];
      pbColors.Canvas.Rectangle(X,Y,X + 12,Y + 12);
      Inc(X,18);
    end;
    Inc(Y,18);
  end;
end;

procedure TfrmPropEdExcelColors.pbColorsPaint(Sender: TObject);
var
  R: TRect;
begin
  DrawColors;
  if FColorIndex >= 0 then begin
    R := ColorIndexToRect;
    DrawEdge(pbColors.Canvas.Handle,R,BDR_SUNKENINNER,BF_TOPLEFT);
    DrawEdge(pbColors.Canvas.Handle,R,BDR_SUNKENOUTER,BF_BOTTOMRIGHT);
  end;
end;

procedure TfrmPropEdExcelColors.pbColorsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  R: TRect;
begin
  btnNoColor.Down := False;
  ColorsPaintOver;
  FColorIndex := (X div 18) + (Y div 18) * 8;
  if FColorIndex < 0 then
    FColorIndex := 0;
  if FColorIndex > High(TExcelColorPalette64) then
    FColorIndex := High(TExcelColorPalette64);
  R := ColorIndexToRect;
  DrawEdge(pbColors.Canvas.Handle,R,BDR_SUNKENINNER,BF_TOPLEFT);
  DrawEdge(pbColors.Canvas.Handle,R,BDR_SUNKENOUTER,BF_BOTTOMRIGHT);
  if ssDouble in Shift then
    ModalResult := mrOk;
end;

procedure TfrmPropEdExcelColors.btnNoColorClick(Sender: TObject);
begin
  ColorsPaintOver;
  if btnNoColor.Down then
    FColorIndex := COLORINDEX_NONE;
end;

end.


