unit ElCBFmts;
{$I lmdcmps.inc}
{###############################################################################

ElCBFmts unit
-------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  {$ifdef CLR}System.Text,{$ENDIF} Types,
  Windows, SysUtils;

function GetFormatName(AFormat : integer) : string;
function GetFormatIndex(const FormatName : string) : integer;
function HasFormat(Handle : THandle; Index : integer) : boolean;

implementation

function HasFormat(Handle : THandle; Index : integer) : boolean;
 var Fmt : integer;
begin
  result := false;
  if not OpenClipboard(Handle) then Exit;
  try
    Fmt := EnumClipboardFormats(0);
    while Fmt <> 0 do
    begin
      if Fmt = Index then
      begin
        result := true;
        break;
      end;
      Fmt := EnumClipboardFormats(Fmt);
    end;
  finally
    CloseClipboard;
  end;
end;

function GetFormatName(AFormat : integer) : string;
 const
   FormatNames : array[1..16] of string =
     ('TEXT', 'BITMAP', 'METAFILEPICT', 'SYLK', 'DIF', 'TIFF',
     'OEMTEXT', 'DIB', 'PALETTE', 'PENDATA', 'RIFF', 'WAVE',
     'UNICODETEXT', 'ENHMETAFILE', 'HDROP', 'LOCALE');
begin
  if (AFormat >= CF_TEXT) and (AFormat <= CF_LOCALE) then
    Result := FormatNames[AFormat]
  else
  begin
    SetLength(Result, 128);
    {$ifdef CLR}
      SetLength(Result, GetClipboardFormatName(AFormat, StringBuilder.Create(Result),
        Length(Result) ));
    {$else}
      SetLength(Result, GetClipboardFormatName(AFormat, PChar(Result), Length(Result) ));
    {$endif}
  end;
end;

function GetFormatIndex(const FormatName : string) : integer;
 const
   FormatNames = ':TEXT:BITMAP:METAFILEPICT:SYLK:DIF:TIFF:OEMTEXT:DIB:PALETTE:' +
     'PENDATA:RIFF:WAVE:UNICODETEXT:ENHMETAFILE:HDROP:LOCALE:';
 var
   S : string;
begin
  S := UpperCase(FormatName);
  case Pos(':' + S + ':', FormatNames) of
    1    : Result := CF_TEXT;
    6    : Result := CF_BITMAP;
    13   : Result := CF_METAFILEPICT;
    26   : Result := CF_SYLK;
    31   : Result := CF_DIF;
    35   : Result := CF_TIFF;
    40   : Result := CF_OEMTEXT;
    48   : Result := CF_DIB;
    52   : Result := CF_PALETTE;
    60   : Result := CF_PENDATA;
    68   : Result := CF_RIFF;
    73   : Result := CF_WAVE;
    78   : Result := CF_UNICODETEXT;
    90   : Result := CF_ENHMETAFILE;
    102  : Result := CF_HDROP;
    108  : Result := CF_LOCALE;
  else
         {$ifdef CLR}
           Result := RegisterClipboardFormat(S);
         {$else}
           Result := RegisterClipboardFormat(PChar(S));
         {$endif}
  end;
end;

end.
