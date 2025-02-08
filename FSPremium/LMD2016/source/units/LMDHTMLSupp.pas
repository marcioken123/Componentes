unit LMDHTMLSupp;
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

LMDHTMLSupp unit (DD)
--------------------

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Variants;

const
  MAX_HTML_PROCESS_CONST = 600;
type
  {
     function FindTemplate(szTemplate:String; iParams:Integer):Variant;
      Found Template in HTML and return array of parameters.
      Template Chars:
        #$ - any space
        ## - #
        #1# - Param number 1
        ......
        #N# - Param number N
        #*# - any symbols
        #? - any symbol (one symbol)

       Any symbols and Params support exclude words syntax.
       #*-"word"# - any symbols exclude "WORD".

      Example:
        <a#$href="#1-"<"#">2#<#*#>END

      <a    href="http://www.altavista.com"> AltaVista</b>END
      <a href="http://www.altavista.com/"> AltaVista</p></b>END
      .....
      Result:
        Ole variant array of Strings. (VarArrayCreate)
        Dimention of array and number of params equal.

      This function modify FIndex.
  }
  TTokenType = (ttConst, ttAnySpace, ttAnySymbols, ttParam, ttAnySymbol);
  TWordsArray = array of string;

  PLMDTemplateToken = ^TLMDTemplateToken;
  TLMDTemplateToken = record
    szToken: string;
    TokenType: TTokenType;
    iTag: Integer;
    nearWords: TWordsArray;
  end;

  TTemplateResult = array of WideString;
  TLMDTemplateTokens = array of TLMDTemplateToken;

  TLMDHTMLProcessor = class
  private
    //Index in HTML
    FIndex: Integer;
    FHTML: string;
    FSearchHTML: string;
    procedure SetHTML(const Value: string);
    function InternalFindTemplate(aTemplate: TLMDTemplateTokens; iTokenIndex:
      Integer;
      var iStartIndex, iEndIndex: Integer; var TemplateResult: TTemplateResult;
        bSearch: Boolean): Boolean;

  public
    constructor Create;
    destructor Destroy; override;
    function FindTemplate(const szTemplate: string): Variant;//OleVariant;
    property HTML: string read FHTML write SetHTML;
  end;

function GetTag(const szTmp: string; var Index: Integer; var szTag: string): Integer;
function RemoveTags(const Str: string): string;
function HTMLDecode(const AStr: string): string;

implementation

uses
//  SysUtils,
  LMDStringsSupport, LMDWebConst, LMDStrings;
{-----------------------------------------------------------------------------}

function HTMLDecode(const AStr: string): string;
var
  i, iPos: Integer;
  szTmp: string;
begin
  Result:= '';
  i:= 1;
  while i <= Length(AStr) do
    begin
      if (AStr[i] = '&') then
        begin
          iPos:= LMDAnsiPosEx(';', AStr, i) - i;
          if (iPos > 0) and (iPos < 15) then
            begin
              szTmp:= Copy(AStr, i + 1, iPos - 1);
              i:= i + iPos;
              if szTmp = 'quot' then
                Result:= Result + ''''
              else
                if szTmp = 'amp' then
                  Result:= Result + '&'
                else
                  if szTmp = 'lt' then
                    Result:= Result + '<'
                  else
                    if szTmp = 'gt' then
                      Result:= Result + '>'
                    else
                      if szTmp = 'nbsp' then
                        Result:= Result + ' '
                      else
                        begin
                          if (Length(szTmp) > 0) and (szTmp[1] = '#') then
                            try
                              Result:= Result + Char(StrToInt(Copy(szTmp, 2,
                                10)));
                            except
                            end;
                        end;
            end;
        end
      else
        Result:= Result + AStr[i];
      Inc(i);
    end;
end;

{-----------------------------------------------------------------------------}

function GetTag(const szTmp: string; var Index: Integer; var szTag: string): Integer;
var
  i: Integer;
  iCount: Integer;
  OldIndex: Integer;
  bTag: Boolean;
begin
  iCount:= Length(szTmp);
  Result:= -1;
  if Index > iCount then
    exit;
  bTag:= (szTmp[Index] = '<');
  szTag:= szTmp[Index];
  OldIndex:= Index;
  Index:= iCount + 1;
  for i:= OldIndex + 1 to iCount do
    begin
      if bTag then
        begin
          if szTmp[i] = '>' then
            begin
              szTag:= szTag + szTmp[i];
              Index:= i + 1;
              break;
            end;
        end
      else
        if szTmp[i] = '<' then
          begin
            Index:= i;
            break;
          end;
      szTag:= szTag + szTmp[i];
    end;
  if not bTag then
    Result:= 0
  else
    Result:= 1;
end;

{-----------------------------------------------------------------------------}

function RemoveTags(const Str: string): string;
var
  i: Integer;
  szTag: string;
  iTag: Integer;
begin
  Result:= '';
  i:= 1;
  iTag:= GetTag(Str, i, szTag);
  while iTag >= 0 do
    begin
      if iTag = 0 then
        Result:= Result + szTag;
      iTag:= GetTag(Str, i, szTag);
    end;
end;

{-----------------------------------------------------------------------------}

constructor TLMDHTMLProcessor.Create;
begin
  inherited;
  FIndex:= 1;
end;

{-----------------------------------------------------------------------------}

destructor TLMDHTMLProcessor.Destroy;
begin
  inherited;
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLProcessor.FindTemplate(const szTemplate: string): Variant;//OleVariant;
var
  i: Integer;
  TT: TLMDTemplateTokens;
  szToken: string;
  iTokens: Integer;
  iParam: Integer;
  iParams: Integer;
  iTmp: Integer;
  TR: TTemplateResult;
  szTmp: string;
  iPPos : Integer;

  function AddToken(const szT: string; aTokenType: TTokenType):
    PLMDTemplateToken;
  begin
    SetLength(TT, iTokens + 1);
    Inc(iTokens);
    with TT[High(TT)] do
      begin
        szToken:= szT;
        TokenType:= aTokenType;
      end;
    Result:= @TT[High(TT)];
  end;

  procedure AddConstToken;
  begin
    if szToken <> '' then
      begin
        szToken:= WideUpperCase(szToken);
        AddToken(szToken, ttConst);
        szToken:= '';
      end;
  end;

  procedure ParseWords(const szParam: string; var Words: TWordsArray);
  var
    i: Integer;
    szWord: string;
    iState: Integer;
    iTmp: Integer;
  begin
    if szParam <> '' then
      begin
        i:= 1;
        szWord:= '';
        iState:= 0;
        while i <= Length(szParam) do
          begin
            case iState of
              0:
                begin
                  if szParam[i] = '-' then
                    iState:= 1
                  else
                    break;
                end;

              1:
                begin
                  if szParam[i] = '"' then
                    iState:= 2
                  else
                    break;
                end;

              2:
                begin
                  if szParam[i] = '"' then
                    begin
                      iState:= 0;
                      if szWord <> '' then
                        begin
                          iTmp:= Length(Words);
                          SetLength(Words, iTmp + 1);
                          Words[iTmp]:= WideUpperCase(szWord);
                        end;
                      szWord:= '';
                    end
                  else
                    szWord:= szWord + szParam[i];
                end;
            end;
            Inc(i);
          end;
      end;
  end;

var
  T: PLMDTemplateToken;

begin
  {$IFDEF THREADSAFE}
  Synchronizer.BeginWrite;
  try
    {$ENDIF}
    Result:= Unassigned;//0;
    VarClear(Result);
    {chekit}
    if szTemplate = '' then
      exit;
    {prepair}
    szToken:= '';
    iTokens:= 0;
    iParams:= 0;
    i:= 1;
    while i <= Length(szTemplate) do
      begin
        if szTemplate[i] = '#' then
          begin
            Inc(i);
            if i <= Length(szTemplate) then
              begin
                case szTemplate[i] of
                  '0'..'9', 'A'..'F':
                    begin
                      AddConstToken;
                      iPPos := 4;
                      iParam := 0;
                      while (AnsiChar(szTemplate[i]) in ['0'..'9', 'A'..'F']) and (iPPos>=0) do
                      begin
                        iTmp:= Word(szTemplate[i]) - Byte('0');
                        if iTmp > 9 then
                          iTmp:= iTmp - (Byte('A') - Byte('0') - 10);
                        iParam := iParam + (iTmp shl (iPPos*4));
                        Dec(iPPos);
                        Inc(i);
                      end;
                      if iPPos>=0 then
                        iParam := iParam shr ((iPPos+1)*4);
                      if iParam=0 then
                        raise Exception.Create(MSG_BAD_PARAM_INDEX);
                      iTmp:= LMDAnsiPosEx('#', szTemplate, i);
                      T := AddToken('#' + IntToHex(iParam,4), ttParam);
                      T.iTag:= iParam;
                      if iTmp > 0 then
                         begin
                           szTmp:= Copy(szTemplate, i, iTmp - i - 2);
                           i:= iTmp;
                           ParseWords(szTmp, T.nearWords);
                         end;

                      if iParam > iParams then
                        iParams:= iParam;
                    end;

                  '$':
                    begin
                      AddConstToken;
                      AddToken('#$', ttAnySpace);
                    end;

                  '*':
                    begin
                      AddConstToken;
                      iTmp:= LMDAnsiPosEx('#', szTemplate, i + 1);
                      T := AddToken('#*', ttAnySymbols);

                      if iTmp > 0 then
                        begin
                          szTmp:= Copy(szTemplate, i + 1, iTmp - i - 1);
                          i:= iTmp;
                          ParseWords(szTmp, T.nearWords);
                        end;
                    end;

                  '?':
                    begin
                      AddConstToken;
                      AddToken('#$', ttAnySymbol);
                    end;

                else
                  szToken:= szToken + szTemplate[i];
                end;
              end;
          end
        else
          szToken:= szToken + szTemplate[i];
        Inc(i);
      end;
    AddConstToken;
    SetLength(TR, iParams);
    iTmp:= FIndex;
    if InternalFindTemplate(TT, 0, iTmp, FIndex, TR, True)
        and (Length(TR) > 0) then
      begin
        Result := VarArrayCreate([Low(TR), High(TR)],
            varOleStr);

        for i:= Low(TT) to High(TT) do
          Result[i] := TR[i];
      end;
    for i:= Low(TT) to High(TT) do
      begin
        SetLength(TT[i].nearWords, 0);
      end;
    SetLength(TT, 0);
    SetLength(TR, 0);
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndWrite;
  end;
    {$ENDIF THREADSAFE}
end;

{-----------------------------------------------------------------------------}

function TLMDHTMLProcessor.InternalFindTemplate(aTemplate: TLMDTemplateTokens;
  iTokenIndex: Integer; var iStartIndex, iEndIndex: Integer;
  var TemplateResult: TTemplateResult; bSearch: Boolean): Boolean;
var
  i, j: Integer;
  Token: TLMDTemplateToken;
  tmpToken: TLMDTemplateToken;
  iStrIndex: Integer;
  iTmp: Integer;
  iTmp1: Integer;
  szTmp: string;
  iCount: Integer;
  iPos: Integer;
  bFlag: Boolean;
  iWhileCount: Integer;
begin
  Result:= True;
  if iTokenIndex >= Length(aTemplate) then
    exit;
  iStrIndex:= iStartIndex;
  Token:= aTemplate[iTokenIndex];
  case Token.TokenType of
    ttConst:
      begin
        Result:= False;
        if bSearch then
          begin
            j:= iStrIndex;
            iCount:= Length(FSearchHTML) - Length(Token.szToken);
            iWhileCount:= 0;
            while j <= iCount do
              begin
                iPos:= LMDAnsiPosEx(Token.szToken, FSearchHTML, j);
                if iPos > 0 then
                  begin
                    j:= iPos;
                    if iTokenIndex > 0 then
                      begin
                        szTmp:= Copy(FSearchHTML, iStrIndex, iPos - iStrIndex);
                        tmpToken:= aTemplate[iTokenIndex - 1];
                        bFlag:= True;
                        for i:= 0 to Length(tmpToken.nearWords) - 1 do
                          begin
                            if Pos(tmpToken.nearWords[i], szTmp) <> 0 then
                              begin
                                bFlag:= False;
                                break;
                              end;
                          end;
                        if not bFlag then
                          break;
                      end;
                    iTmp:= j + Length(Token.szToken);
                    iTmp1:= iTmp;
                    if InternalFindTemplate(aTemplate, iTokenIndex + 1, iTmp,
                      iTmp1, TemplateResult, False) then
                      begin
                        iStartIndex:= j;
                        iEndIndex:= iTmp1;
                        Result:= True;
                        break;
                      end
                    else
                      Inc(j);
                  end
                else
                  break;
                Inc(iWhileCount);
                if iWhileCount > MAX_HTML_PROCESS_CONST then
                  raise Exception.Create(MSG_MAX_HTML_PROCESS_CONST);
              end;
          end
        else
          begin
            if Length(Token.szToken) <> 0 then
              szTmp:= Copy(FSearchHTML, iStrIndex, Length(Token.szToken))
            else
              szTmp:= '';
            szTmp:= WideUpperCase(szTmp);
            if szTmp = Token.szToken then
              begin
                iTmp:= iStrIndex + Length(Token.szToken);
                iTmp1:= iTmp;
                if InternalFindTemplate(aTemplate, iTokenIndex + 1, iTmp, iTmp1,
                  TemplateResult, False) then
                  begin
                    iStartIndex:= iStrIndex;
                    iEndIndex:= iTmp1;
                    Result:= True;
                  end;
              end;
          end;
      end;

    ttAnySymbols, ttParam:
      begin
        iTmp:= iStartIndex;
        iTmp1:= iTmp;
        if InternalFindTemplate(aTemplate, iTokenIndex + 1, iTmp, iTmp1,
          TemplateResult, True) then
          begin
            iEndIndex:= iTmp1;
            if Token.TokenType = ttParam then
              TemplateResult[Token.iTag - 1]:= Copy(FHTML, iStartIndex, iTmp -
                iStartIndex);
          end
        else
          Result:= False;
      end;

    ttAnySymbol:
      begin
        if iStrIndex > Length(FHTML) then
          Result:= False
        else
          begin
            iTmp:= iStartIndex + 1;
            iTmp1:= iTmp;
            if InternalFindTemplate(aTemplate, iTokenIndex + 1, iTmp, iTmp1,
              TemplateResult, False) then
              iEndIndex:= iTmp1
            else
              Result:= False;
          end;
      end;

    ttAnySpace:
      begin
        iCount:= Length(FSearchHTML);
        //        j:=iStrIndex;
        for j:= iStrIndex to iCount do
          begin
            if FSearchHTML[j] > #32 then
              break;
          end;
        iTmp:= j;
        iTmp1:= iTmp;
        if InternalFindTemplate(aTemplate, iTokenIndex + 1, iTmp, iTmp1,
          TemplateResult, False) then
          begin
            iStartIndex:= j;
            iEndIndex:= iTmp1;
          end
        else
          Result:= False;
      end;

  end;
end;

{-----------------------------------------------------------------------------}

procedure TLMDHTMLProcessor.SetHTML(const Value: string);
begin
  {$IFDEF THREADSAFE}
  Synchronizer.BeginWrite;
  try
    {$ENDIF}
    FHTML:= Value; //DeleteBlackSpace(Value);
    FIndex:= 1;
    FSearchHTML:= WideUpperCase(FHTML);
    {$IFDEF THREADSAFE}
  finally
    Synchronizer.EndWrite;
  end;
  {$ENDIF}
end;

end.
