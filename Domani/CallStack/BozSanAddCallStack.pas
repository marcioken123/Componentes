unit BozSanAddCallStack;

interface

procedure AddCallStackFuncToUnit(const FileName: String);
procedure DeleteCallStack(const FileName: String);

implementation

uses
    Windows, BozSanPasParser, Classes, SysUtils;

const
    sCallStackString = '// CallStack';

procedure DeleteCallStack(const FileName: String);
var
    F, FOut: TextFile;
    s, sTemp: String;
    procedure CopiaFile(const Src, Dest: String);
    var
        Stream: TMemoryStream;
    begin
        Stream := TMemoryStream.Create;
        try
            Stream.LoadFromFile(Src);
            Stream.SaveToFile(Dest);

        finally
            FreeandNIL(Stream);
        end;
    end;

begin
    sTemp := 'c:\' + ExtractFileName(FileName);
    if FileExists(sTemp) then
        DeleteFile(sTemp);

    CopiaFile(FileName, sTemp);
    AssignFile(F, sTemp);
    AssignFile(FOut, FileName);
    Reset(F);
    try
        Rewrite(FOut);
        try

            while not EOF(F) do
                begin
                Readln(F, s);
                if pos(sCallStackString, s) = 1 then
                    ReadLn(F, s)
                else
                    Writeln(FOut, s);
                end;
        finally
            CloseFile(F);
            CloseFile(FOut);
        end;
    except
        DeleteFile(FileName);
        RenameFile(sTemp, FileName);
        raise;
    end;
    if FileExists(sTemp) then
        DeleteFile(sTemp);
end;

procedure AddCallStackFuncToUnit(const FileName: String);
var
    MemStreamOrigin,
    MemStreamParser: TMemoryStream;
    Parser: TBozSanPasParser;
    iBegin: Integer;
    sUnit,
    sParametri,
    sProc: string;
    FileStream: TFileStream;
    iRoundOpen,
    iOldPos: Integer;
    sBackupFileName: String;
    bColon: boolean;

    function FindProcName: String;
    begin
        while not(Parser.Token.Id in [tkProcedure, tkFunction]) and (Parser.Token.Id <> tkNull) do
            Parser.NextToken;
        case Parser.Token.Id of
            tkProcedure: Result := 'procedure ';
            tkFunction: Result := 'function ';
        end;
        Parser.NextToken;
        while (Parser.Token.ID <> tkIdentifier) and (Parser.Token.Id <> tkNull) do
            Parser.NextToken;
        if Parser.Token.ID = tkIdentifier then
            begin
            Result := Result + Parser.Token.data;
            Parser.NextToken;
            if Parser.Token.Id = tkPoint then
                begin
                Parser.NextToken;
                Result := Result + '.' + Parser.Token.data;
                Parser.NextToken;
                end;
            end;

        // Mi posiziono al primo ;, oppure mi apsetto una parentesi aperta
        while not(Parser.Token.ID in [tkSemiColon, tkRoundOpen]) and (Parser.Token.Id <> tkNull) do
            Parser.NextToken;

        sParametri := '';
        if Parser.Token.ID = tkRoundOpen then
            begin
            iRoundOpen := 1;
            bColon := FALSE;
            while iRoundOpen > 0 do
                begin
                Parser.NextToken;
                case Parser.Token.ID of
                    tkColon: bColon := TRUE;
                    tkIdentifier:
                    begin
                    if bColon then
                        bColon := FALSE
                    else
                        if length(sParametri) = 0 then
                            sParametri := Parser.Token.Data
                        else
                            sParametri := format('%s,%s', [sParametri, Parser.Token.Data]);
                    end;
                    tkRoundClose: Dec(iRoundOpen);
                    tkRoundOpen: Inc(iRoundOpen);
                end
                end;
            end;
    end;

    procedure AddBeginCallStack;
    var
        s, sBuffer: String;
    begin
        //FileStream.Position := Parser.RunPos + iOffset;
        MemStreamOrigin.Position := iOldPos;
        SetLength(sBuffer, Parser.RunPos - iOldPos);
        MemStreamOrigin.ReadBuffer(pChar(sBuffer)^, Parser.RunPos - iOldPos);
        FileStream.Write(pChar(sBuffer)^, length(sBuffer));
        iOldPos := Parser.RunPos;
        s := format(sLineBreak + sCallStackString + sLineBreak +'BeginCallStack(''%s: %s'', [%s]);',
            [sUnit, sProc, sParametri]);
        FileStream.Write(PChar(s)^, length(s));
    end;


    procedure AddUses;
    var
        s, sBuffer: String;
    begin
        //FileStream.Position := Parser.RunPos + iOffset;
        MemStreamOrigin.Position := iOldPos;
        SetLength(sBuffer, Parser.RunPos - iOldPos);
        MemStreamOrigin.ReadBuffer(pChar(sBuffer)^, Parser.RunPos - iOldPos);
        FileStream.Write(pChar(sBuffer)^, length(sBuffer));
        iOldPos := Parser.RunPos;
        s := sLineBreak + '// CallStack'+ sLineBreak +'BozSanCallStack, ';
        FileStream.Write(PChar(s)^, length(s));
    end;

    procedure AddEndCallStack;
    var
        s, sBuffer: String;
    begin
        //FileStream.Position := Parser.RunPos + iOffset;
        MemStreamOrigin.Position := iOldPos;
        SetLength(sBuffer, Parser.RunPos - iOldPos - 3);
        MemStreamOrigin.ReadBuffer(pChar(sBuffer)^, Parser.RunPos - iOldPos - 2);
        FileStream.Write(pChar(sBuffer)^, length(sBuffer));
        iOldPos := Parser.RunPos - 3;
        s := format('// CallStack'+ sLineBreak +'EndCallStack(''%s: %s'');' + sLineBreak, [sUnit, sProc]);
        FileStream.Write(PChar(s)^, length(s));
    end;

    procedure AddEnd;
    var
        sBuffer: String;
    begin
        //FileStream.Position := Parser.RunPos + iOffset;
        MemStreamOrigin.Position := iOldPos;
        SetLength(sBuffer, MemStreamOrigin.Size - iOldPos);
        MemStreamOrigin.ReadBuffer(pChar(sBuffer)^, MemStreamOrigin.Size - iOldPos);
        FileStream.Write(pChar(sBuffer)^, length(sBuffer));
    end;

    const sBkExt = '.~PasBk';

begin

    MemStreamParser := NIL;
    Parser := NIL;
    FileStream := NIL;
    iOldPos := 0;
    sUnit := ExtractFileName(FileName);
    try
        MemStreamParser := TMemoryStream.Create;
        MemStreamOrigin := TMemoryStream.Create;

        sBackupFileName := ChangeFileExt(FileName, sBkExt);
        DeleteCallStack(FileName);
        MemStreamParser.LoadFromFile(FileName);
        RenameFile(FileName, sBackupFileName);
        try


            MemStreamOrigin.CopyFrom(MemStreamParser, MemStreamParser.Size);
            Parser := TBozSanPasParser.Create;
            Parser.Origin := MemStreamParser.Memory;
            FileStream := TFileStream.Create(FileName, fmCreate);

            Parser.NextID(tkUses);
            AddUses;

            Parser.NextID(tkImplementation);

            sProc := FindProcName;
            Parser.NextID(tkBegin);
            AddBeginCallStack;

            iBegin := 0;
            while (Parser.Token.ID <> tkNull) do
                begin
                Parser.NextToken;
                if Parser.Token.Id in [tkBegin, tkTry, tkCase] then
                    Inc(iBegin);
                if Parser.Token.ID = tkEnd then
                    Dec(iBegin);
                if iBegin < 0 then
                    begin
                    //ShowMessage(IntToStr(Parser.RunPos) + ' ' + sProc);
                    AddEndCallStack;
                    iBegin := 0;
                    Parser.NextToken;
                    sProc := FindProcName;
                    Parser.NextID(tkBegin);
                    if Parser.Token.ID = tkBegin then
                        AddBeginCallStack;
                    end;

                end;
            AddEnd;
        except
            RenameFile(sBackupFileName, FileName);
            raise;
        end;

        Sleep(1000);
    finally
        FreeAndNIL(Parser);
        FreeAndNIL(MemStreamParser);
        FreeAndNIL(MemStreamOrigin);
        FreeAndNIL(FileStream);
    end;

    if FileExists(sBackupFileName) then
        DeleteFile(sBackupFileName);

end;

end.
