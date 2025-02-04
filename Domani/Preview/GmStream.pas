{******************************************************************************}
{                                                                              }
{                          GmStream.pas v2.61 Pro                              }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmStream;

interface

uses Windows, Classes, GmTypes, Graphics;

type
  TGmExtStream = class(TMemoryStream)
  public
    function ReadByte: Byte;
    function ReadRect: TRect;
    function ReadInteger: integer;
    function ReadExtended: Extended;
    function ReadStr: string;
    function ReadBoolean: Boolean;
    function ReadDateTime: TDateTime;
    function ReadBrush: TGmBrush;
    function ReadFont: TGmFont;
    function ReadPen: TGmPen;
    procedure LoadFromStream(AStream: TStream);
    procedure ReadSubStream(ASubStream: TStream);
    procedure SaveToStream(AStream: TStream);
    procedure WriteByte(AValue: Byte);
    procedure WriteRect(ARect: TRect);
    procedure WriteInteger(AValue: integer);
    procedure WriteExtended(AValue: Extended);
    procedure WriteStr(const AValue: string);
    procedure WriteBoolean(AValue: Boolean);
    procedure WriteDateTime(AValue: TDateTime);
    procedure WriteBrush(AValue: TGmBrush);
    procedure WriteFont(AValue: TGmFont);
    procedure WritePen(AValue: TGmPen);
    procedure WriteSubStream(ASubStream: TStream);
  end;

  function FontStringToStyle(AStyle: string): TFontStyles;
  function FontStyleToString(AStyle: TFontStyles): string;

implementation

function FontStringToStyle(AStyle: string): TFontStyles;
begin
  Result := [];
  if Pos('B', AStyle) <> 0 then Result := Result + [fsBold];
  if Pos('I', AStyle) <> 0 then Result := Result + [fsItalic];
  if Pos('U', AStyle) <> 0 then Result := Result + [fsUnderline];
  if Pos('S', AStyle) <> 0 then Result := Result + [fsStrikeOut];
end;


function FontStyleToString(AStyle: TFontStyles): string;
begin
  Result := '';
  if (fsBold in AStyle)      then Result := Result + 'B';
  if (fsItalic in AStyle)    then Result := Result + 'I';
  if (fsUnderline in AStyle) then Result := Result + 'U';
  if (fsStrikeOut in AStyle) then Result := Result + 'S';
end;

function TGmExtStream.ReadByte: Byte;
begin
  if Self.Position < Self.Size then Read(Result, SizeOf(Result));
end;

function TGmExtStream.ReadRect: TRect;
begin
  Result.Left   := ReadInteger;
  Result.Top    := ReadInteger;
  Result.Right  := ReadInteger;
  Result.Bottom := ReadInteger;
end;

function TGmExtStream.ReadInteger: integer;
begin
  if Self.Position < Self.Size then Read(Result, SizeOf(Result));
end;

function TGmExtStream.ReadExtended: Extended;
begin
  Read(Result, SizeOf(Result));
end;

function TGmExtStream.ReadStr: string;
var
  StringLength: integer;
begin
  StringLength := ReadInteger;
  SetLength(Result, StringLength);
  if StringLength > 0 then
    Read(Result[1], StringLength)
end;

function TGmExtStream.ReadBoolean: Boolean;
begin
  Read(Result, SizeOf(Result));
end;

function TGmExtStream.ReadDateTime: TDateTime;
begin
  Read(Result, SizeOf(Result));
end;

function TGmExtStream.ReadBrush: TGmBrush;
var
  ABrushStream: TGmExtStream;
begin
  ABrushStream := TGmExtStream.Create;
  try
    ABrushStream.LoadFromStream(Self);
    Result.Color := ABrushStream.ReadInteger;
    Result.Style := TBrushStyle(ABrushStream.ReadInteger);
  finally
    ABrushStream.Free;
  end;
end;

function TGmExtStream.ReadFont: TGmFont;
var
  AFontStream: TGmExtStream;
begin
  AFontStream := TGmExtStream.Create;
  try
    AFontStream.LoadFromStream(Self);
    Result.Angle := AFontStream.ReadExtended;
    Result.Color := AFontStream.ReadInteger;
    Result.Name  := AFontStream.ReadStr;
    Result.Size  := AFontStream.ReadInteger;
    Result.Style := FontStringToStyle(AFontStream.ReadStr)
  finally
    AFontStream.Free;
  end;
end;

function TGmExtStream.ReadPen: TGmPen;
var
  APenStream: TGmExtStream;
begin
  APenStream := TGmExtStream.Create;
  try
    APenStream.LoadFromStream(Self);
    Result.Color := APenStream.ReadInteger;
    Result.Style := TPenStyle(APenStream.ReadInteger);
    Result.Width := APenStream.ReadInteger;
    Result.Mode  := TPenMode(APenStream.ReadInteger);
  finally
    APenStream.Free;
  end;
end;

procedure TGmExtStream.LoadFromStream(AStream: TStream);
var
  StreamSize: integer;
begin
  Clear;
  AStream.ReadBuffer(StreamSize, SizeOf(StreamSize));
  CopyFrom(AStream, StreamSize);
  Seek(0, soFromBeginning);
end;

procedure TGmExtStream.SaveToStream(AStream: TStream);
var
  StreamSize: integer;
begin
  Seek(0, soFromBeginning);
  StreamSize := Self.Size;
  AStream.WriteBuffer(StreamSize, SizeOf(StreamSize));
  AStream.CopyFrom(Self, StreamSize);
end;

procedure TGmExtStream.ReadSubStream(ASubStream: TStream);
var
  StreamSize: integer;
begin
  StreamSize := ReadInteger;
  ASubStream.CopyFrom(Self, StreamSize);
end;

procedure TGmExtStream.WriteRect(ARect: TRect);
begin
  WriteInteger(ARect.Left);
  WriteInteger(ARect.Top);
  WriteInteger(ARect.Right);
  WriteInteger(ARect.Bottom);
end;

procedure TGmExtStream.WriteByte(AValue: Byte);
begin
  Write(AValue, SizeOf(AValue));
end;

procedure TGmExtStream.WriteInteger(AValue: integer);
begin
  Write(AValue, SizeOf(AValue));
end;

procedure TGmExtStream.WriteExtended(AValue: Extended);
begin
  Write(AValue, SizeOf(AValue));
end;

procedure TGmExtStream.WriteStr(const AValue: string);
var
  StringLength: integer;
begin
  StringLength := Length(AValue);
  WriteInteger(StringLength);
  if StringLength > 0 then
    Write(AValue[1], StringLength);
end;

procedure TGmExtStream.WriteBoolean(AValue: Boolean);
begin
  Write(AValue, SizeOf(AValue));
end;

procedure TGmExtStream.WriteDateTime(AValue: TDateTime);
begin
  Write(AValue, SizeOf(AValue));
end;

procedure TGmExtStream.WriteBrush(AValue: TGmBrush);
var
  ABrushStream: TGmExtStream;
begin
  ABrushStream := TGmExtStream.Create;
  try
    ABrushStream.WriteInteger(AValue.Color);
    ABrushStream.WriteInteger(Ord(AValue.Style));
  finally
    ABrushStream.SaveToStream(Self);
    ABrushStream.Free;
  end;
end;

procedure TGmExtStream.WriteFont(AValue: TGmFont);
var
  AFontStream: TGmExtStream;
begin
  AFontStream := TGmExtStream.Create;
  try
    AFontStream.WriteExtended(AValue.Angle);
    AFontStream.WriteInteger(AValue.Color);
    AFontStream.WriteStr(AValue.Name);
    AFontStream.WriteInteger(AValue.Size);
    AFontStream.WriteStr(FontStyleToString(AValue.Style));
  finally
    AFontStream.SaveToStream(Self);
    AFontStream.Free;
  end;
end;

procedure TGmExtStream.WritePen(AValue: TGmPen);
var
  APenStream: TGmExtStream;
begin
  APenStream := TGmExtStream.Create;
  try
    APenStream.WriteInteger(AValue.Color);
    APenStream.WriteInteger(Ord(AValue.Style));

    APenStream.WriteInteger(AValue.Width);
    APenStream.WriteInteger(Ord(AValue.Mode));
  finally
    APenStream.SaveToStream(Self);
    APenStream.Free;
  end;
end;

procedure TGmExtStream.WriteSubStream(ASubStream: TStream);
var
  StreamSize: integer;
begin
  StreamSize := ASubStream.Size;
  WriteInteger(StreamSize);
  ASubStream.Seek(0, soFromBeginning);
  CopyFrom(ASubStream, StreamSize);
end;

end.
