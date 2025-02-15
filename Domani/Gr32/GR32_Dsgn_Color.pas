unit GR32_Dsgn_Color;

{*********************************************}
{  This unit is a part of Graphics32 library  }
{  Copyright � 2000-2003 Alex Denisov         }
{  See License.txt for licence information    }
{*********************************************}
// $Id: GR32_Dsgn_Color.pas,v 1.3 2003/02/23 20:10:16 Alex Exp $

interface

{$I GR32.INC}

uses
  Windows, Classes, SysUtils, Graphics, Dialogs, Forms, Registry, Consts,
  GR32, GR32_Image,
  {$IFDEF COMPILER6}DesignIntf, DesignEditors{$ELSE}DsgnIntf{$ENDIF};

type
  { TColorManager }
  PColorEntry = ^TColorEntry;
  TColorEntry = record
    Name: string[31];
    Color: TColor32;
  end;

  TColorManager = class(TList)
  public
    destructor Destroy; override;
    procedure AddColor(const AName: string; AColor: TColor32);
    procedure EnumColors(Proc: TGetStrProc);
    function  FindColor(const AName: string): TColor32;
    function  GetColor(const AName: string): TColor32;
    function  GetColorName(AColor: TColor32): string;
    procedure RegisterDefaultColors;
    procedure RemoveColor(const AName: string);
  end;

  { TColor32Property }
  TColor32Property = class(TIntegerProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
{$IFDEF EXT_PROP_EDIT}
    procedure Edit; override;
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean); override;
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean); override;
{$ENDIF}
  end;

procedure RegisterColor(const AName: string; AColor: TColor32);
procedure UnregisterColor(const AName: string);

var ColorManager: TColorManager;

implementation

{ TColorManager }

destructor TColorManager.Destroy;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do FreeMem(Items[I], SizeOf(TColorEntry));
  inherited;
end;

procedure TColorManager.AddColor(const AName: string; AColor: TColor32);
var
  NewEntry: PColorEntry;
begin
  New(NewEntry);
  if NewEntry = nil then
    raise Exception.Create('Could not allocate memory for color registration!');
  with NewEntry^ do
  begin
    Name := AName;
    Color := AColor;
  end;
  Add(NewEntry);
end;

procedure TColorManager.EnumColors(Proc: TGetStrProc);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do Proc(TColorEntry(Items[I]^).Name);
end;

function TColorManager.FindColor(const AName: string): TColor32;
var
  I: Integer;
begin
  Result := clBlack32;
  for I := 0 to Count - 1 do
    with TColorEntry(Items[I]^) do
      if Name = AName then
      begin
        Result := Color;
        Break;
      end;
end;

function TColorManager.GetColor(const AName: string): TColor32;
var
  S: string;

  function HexToClr(const HexStr: string): Cardinal;
  var
    I: Integer;
    C: Char;
  begin
    Result := 0;
    for I := 1 to Length(HexStr) do
    begin
      C := HexStr[I];
      case C of
        '0'..'9': Result := Int64(16) * Result + (Ord(C) - $30);
        'A'..'F': Result := Int64(16) * Result + (Ord(C) - $37);
        'a'..'f': Result := Int64(16) * Result + (Ord(C) - $57);
      else
        raise EConvertError.Create('Illegal character in hex string');
      end;
    end;
  end;

begin
  S := Trim(AName);
  if S[1] = '$' then S := Copy(S, 2, Length(S) - 1);
  if (S[1] = 'c') and (S[2] = 'l') then Result := FindColor(S)
  else
  try
    Result := HexToClr(S);
  except
    Result := clBlack32;
  end;
end;

function TColorManager.GetColorName(AColor: TColor32): string;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    with TColorEntry(Items[I]^) do
      if Color = AColor then
      begin
        Result := TColorEntry(Items[I]^).Name;
        Exit;
      end;
  Result := '$' + IntToHex(AColor, 8);
end;

procedure TColorManager.RegisterDefaultColors;
begin
  Capacity := 50;
  AddColor('clBlack32',              clBlack32);
  AddColor('clDimGray32',            clDimGray32);
  AddColor('clGray32',               clGray32);
  AddColor('clLightGray32',          clLightGray32);
  AddColor('clWhite32',              clWhite32);
  AddColor('clMaroon32',             clMaroon32);
  AddColor('clGreen32',              clGreen32);
  AddColor('clOlive32',              clOlive32);
  AddColor('clNavy32',               clNavy32);
  AddColor('clPurple32',             clPurple32);
  AddColor('clTeal32',               clTeal32);
  AddColor('clRed32',                clRed32);
  AddColor('clLime32',               clLime32);
  AddColor('clYellow32',             clYellow32);
  AddColor('clBlue32',               clBlue32);
  AddColor('clFuchsia32',            clFuchsia32);
  AddColor('clAqua32',               clAqua32);

  AddColor('clTrWhite32',            clTrWhite32);
  AddColor('clTrBlack32',            clTrBlack32);
  AddColor('clTrRed32',              clTrRed32);
  AddColor('clTrGreen32',            clTrGreen32);
  AddColor('clTrBlue32',             clTrBlue32);
end;

procedure TColorManager.RemoveColor(const AName: string);
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
    if CompareText(TColorEntry(Items[I]^).Name, AName) = 0 then
    begin
      Delete(I);
      Break;
    end;
end;

procedure RegisterColor(const AName: string; AColor: TColor32);
begin
  ColorManager.AddColor(AName, AColor);
end;

procedure UnregisterColor(const AName: string);
begin
  ColorManager.RemoveColor(AName);
end;


{ TColor32Property }

{$IFDEF EXT_PROP_EDIT}
procedure TColor32Property.Edit;
var
  ColorDialog: TColorDialog;
  IniFile: TRegIniFile;

  procedure GetCustomColors;
  begin
    if BaseRegistryKey = '' then Exit;
    IniFile := TRegIniFile.Create(BaseRegistryKey);
    try
      IniFile.ReadSectionValues(SCustomColors, ColorDialog.CustomColors);
    except
      { Ignore errors while reading values }
    end;
  end;

  procedure SaveCustomColors;
  var
    I, P: Integer;
    S: string;
  begin
    if IniFile <> nil then
      with ColorDialog do
        for I := 0 to CustomColors.Count - 1 do
        begin
          S := CustomColors.Strings[I];
          P := Pos('=', S);
          if P <> 0 then
          begin
            S := Copy(S, 1, P - 1);
            IniFile.WriteString(SCustomColors, S, CustomColors.Values[S]);
          end;
        end;
  end;

begin
  IniFile := nil;
  ColorDialog := TColorDialog.Create(Application);
  try
    GetCustomColors;
    ColorDialog.Color := WinColor(GetOrdValue);
    ColorDialog.HelpContext := 25010;
    ColorDialog.Options := [cdShowHelp];
    if ColorDialog.Execute then
      SetOrdValue(Cardinal(Color32(ColorDialog.Color)));
    SaveCustomColors;
  finally
    IniFile.Free;
    ColorDialog.Free;
  end;
end;
{$ENDIF}

function TColor32Property.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, {$IFDEF EXT_PROP_EDIT}paDialog,{$ENDIF} paValueList,
  paRevertable];
end;

procedure TColor32Property.GetValues(Proc: TGetStrProc);
begin
  try
    ColorManager.EnumColors(Proc);
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

function TColor32Property.GetValue: string;
begin
  try
    Result := ColorManager.GetColorName(Cardinal(GetOrdValue));
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TColor32Property.SetValue(const Value: string);
begin
  try
    SetOrdValue(Cardinal(ColorManager.GetColor(Value)));
    Modified;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

{$IFDEF EXT_PROP_EDIT}
procedure TColor32Property.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);
var
  Right: Integer;
  C: TColor32;
  i, j: Integer;
  W, H: Integer;
  Bitmap32: TBitmap32;
begin
  try
  Right := (ARect.Bottom - ARect.Top) + ARect.Left;
  ACanvas.FillRect(Rect(ARect.Left, ARect.Top, Right, ARect.Bottom));
  Bitmap32 := TBitmap32.Create;
  try
    Bitmap32.SetSize(Right - ARect.Left - 2, ARect.Bottom - ARect.Top - 2);
    if Assigned(ColorManager) then C := ColorManager.GetColor(Value)
    else C := clWhite32;
    W := Bitmap32.Width;
    H := Bitmap32.Height;
    if (W > 8) and (H > 8) then
    begin
      if C and $FF000000 = $FF000000 then
        Bitmap32.FillRect(0, 0, W - 1, H - 1, C)
      else // transparent
      begin
        for j := 0 to H - 1 do
          for i := 0 to W - 1 do
            if Odd(i div 3) = Odd(j div 3) then
              Bitmap32[i, j] := clBlack32
            else
              Bitmap32[i, j] := clWhite32;
      end;
      Bitmap32.FillRectT(0, 0, W - 1, H - 1, C);
    end;
    Bitmap32.FrameRectTS(0, 0, W - 1, H - 1, $DF000000);
    Bitmap32.RaiseRectTS(1, 1, W - 2, H - 2, 20);
    Bitmap32.DrawTo(ACanvas.Handle, ARect.Left + 1, ARect.Top + 1);
  finally
    Bitmap32.Free;
    inherited ListDrawValue(Value, ACanvas,
      Rect(Right, ARect.Top, ARect.Right, ARect.Bottom), ASelected);
  end;
  except
    on E: Exception do ShowMessage(E.Message);
  end;
end;

procedure TColor32Property.PropDrawValue(ACanvas: TCanvas; const ARect: TRect;
  ASelected: Boolean);
begin
  if GetVisualValue <> '' then ListDrawValue(GetVisualValue, ACanvas, ARect, True)
  else inherited PropDrawValue(ACanvas, ARect, ASelected);
end;
{$ENDIF}


initialization
  ColorManager := TColorManager.Create;
  ColorManager.RegisterDefaultColors;

finalization
  ColorManager.Free;

end.
