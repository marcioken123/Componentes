unit LMDRTFScanner;
{$I LMDCmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDRTFScanner unit (VO)
-----------------------

RTF RTF lexical scanner

ToDo:

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  classes, LMDRTFTape;

type
  {****************************************************************************}
  TLMDRTFScanner = class
  private
    FEOF        : boolean;
    FStream     : TStream;
    FTape       : TLMDRTFTape;
    function GetNextChar : char;
    procedure ParseControlWord;
    procedure ParsePlainText;
    property EOF : boolean read FEOF;
  public
    constructor Create(aStream : TStream; aTape : TLMDRTFTape);
    procedure Execute;
  end;

implementation
uses
  Sysutils, LMDRTFLookupTable, LMDDataType;

{** TLMDRTFScanner ************************************************************}
{-- private -------------------------------------------------------------------}
function TLMDRTFScanner.GetNextChar : char;
begin
  if FStream.Position >= FStream.Size then
    begin
      result := #0;
      FEOF := True;
    end
  else
    begin
      result := #10;
      while (AnsiChar(Result) in [#10, #13]) and (FStream.Position < FStream.Size) do
        FStream.Read(Result, 1);
      if AnsiChar(Result) in [#10, #13] then
        begin
          result := #0;
          FEOF := True;
        end
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFScanner.ParseControlWord;
var
  ch : char;
  Name : string;
  Param : string;
  Sign : integer;
  Code : LongInt;
begin
  Name := '';
  Param := '0';
  Sign := 1;
  ch := GetNextChar;

  if ch = '*' then Exit;
  if not (AnsiChar(ch) in ['a'..'z','A'..'Z']) then Exit;

  Name := Name + ch;
  while not EOF do
    begin
      ch := GetNextChar;
      if not EOF then
        if AnsiChar(ch) in ['a'..'z','A'..'Z'] then
          Name := Name + ch
        else Break;
    end;

  if not EOF then
    begin
      if ch <> ' ' then
        begin
          if AnsiChar(ch) in ['-','0'..'9'] then
            begin
              if ch = '-' then
                Sign := -1
              else
                Param := Param + ch;

              while not EOF do
                begin
                  ch := GetNextChar;
                    if not EOF then
                      if AnsiChar(ch) in ['0'..'9'] then
                        Param := Param + ch
                      else Break;
                end;

              if not EOF then
                FStream.Position := FStream.Position-1;
            end
          else
            FStream.Position := FStream.Position-1;
        end;
    end;
  Code := RTFLookup(Name);
  if Code = -1 then Exit;
  FTape.AddICell(Code, StrToInt(Param)*Sign);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFScanner.ParsePlainText;
var
  tmpStr : string;
  ch : char;
begin
  tmpStr := '';
  while true do
    begin
      ch := GetNextChar;
      if EOF then break;
      case ch of
        '\' :
          begin
            ch := GetNextChar;
            if EOF then Break;
            if AnsiChar(ch) in ['\', '{', '}'] then tmpStr := tmpStr + ch
            else
              begin
                FStream.Position := FStream.Position-2;
                Break;
              end;
          end;
        '{', '}' :
          begin
            FStream.Position := FStream.Position-1;
            Break;
          end;
        else tmpStr := tmpStr + ch;
      end;
    end;
  if tmpStr <> '' then
    FTape.AddPCell(tocPLAINTEXT, tmpStr);
end;

{-- public --------------------------------------------------------------------}
constructor TLMDRTFScanner.Create(aStream : TStream; aTape : TLMDRTFTape);
begin
  inherited Create;
  FStream := aStream;
  FTape := aTape;
  FEOF := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFScanner.Execute;
var
  ch : char;
  tmpPos : LongInt;
  GroupRef : integer;

  function UnknownGroup : boolean;
  var
    Name : string;
  begin
    result := False;

    ch := GetNextChar;
    if EOF then Exit;
    if ch <> '\' then Exit;

    ch := GetNextChar;
    if EOF then Exit;
    if ch <> '*' then Exit;

    ch := GetNextChar;
    if EOF then Exit;
    if ch <> '\' then Exit;

    Name := '';
    while not EOF do
      begin
        ch := GetNextChar;
        if not EOF then
          if AnsiChar(ch) in ['a'..'z','A'..'Z'] then
            Name := Name + ch
          else
            Break;
      end;

    if not EOF and (Name = '') and (ch = '*') then Name := ch;
    result := RTFLookup(Name) = -1;
  end;

  function ControlWord : boolean;
  begin
    result := False;
    ch := GetNextChar;
    if EOF then Exit;
    Result := not (AnsiChar(ch) in [' ','0'..'9']);
  end;

begin
  while true do
    begin
      ch := GetNextChar;
      if EOF then
        begin
          FTape.AddCell(tocEOF);
          Break;
        end
      else
        case ch of
          '}' : FTape.AddCell(tocCLOSEGROUP);
          '{' :
            begin
              tmpPos := FStream.Position;
              if UnknownGroup then
                begin
                  GroupRef := 1;
                  while (GroupRef > 0) and not EOF do
                    begin
                      ch := GetNextChar;
                      if not EOF then
                        begin
                          if ch = '{' then Inc(GroupRef);
                          if ch = '}' then Dec(GroupRef);
                        end;
                    end;
                end
              else
                begin
                  FStream.Position := tmpPos;
                  FTape.AddCell(tocOPENGROUP);
                end;
            end;
          '\' :
            begin
              tmpPos := FStream.Position;
              if ControlWord then
                begin
                  FStream.Position := tmpPos;
                  ParseControlWord;
                end
              else
                begin
                  FStream.Position := tmpPos-1;
                  ParsePlainText;
                end;
            end;
          else
            begin
              FStream.Position := FStream.Position-1;
              ParsePlainText;
            end;
        end;
    end;
end;

end.
