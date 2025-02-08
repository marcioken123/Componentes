unit LMDFile;
{$I LMDCmps.inc}
{$IFDEF CONDITIONALEXPRESSIONS}
  {$WARN SYMBOL_PLATFORM OFF}
  {$WARN UNIT_PLATFORM OFF}
{$ENDIF}
interface

uses
  Windows, SysUtils, Messages, Classes, Forms, filectrl, shellAPI,
  LMDCustomComponent, lmdclass;

type

  TLMDFileOption=(foVerifyAction, foNewFileAsActual, foCopiedFileAsActual, foCopyTimeStamp);
  TLMDFileOptions=set of TLMDFileOption;

  TLMDFileAction=(fcNone, fcChange, fcCreate, fcCopy, fcMove, fcDelete, fcRename, fcExecute);
  TLMDFilePosAction= (fpStart, fpProgress, fpEnd);

  TFileErrorcode=(feNone,
                  feErrorCreateFile,
                  feErrorExecuteFile,
                  feErrorOpenSrc,
                  feErrorOpenDest,
                  feFileAlreadyExist,
                  feFileReadOnly,
                  feFileNotExist,
                  feFileDestSrcSame,
                  feMoveSrcNotKilled,
                  feDelFileNotKilled,
                  feDateTimeConvErr,
                  feDateTimeWriteErr,
                  feSetAttrFailed,
                  feRenameFailed,
                  feChangeExtFailed,
                  feParameterNull);

  TActualData=record
    Action:TLMDFileAction;
    Source:String;
    Destination:String;
  end;

  TLMDErrorEvent=procedure(Sender:TObject; Errorcode: TFileErrorcode;ActData:TActualData) of object;
  TLMDActionEvent=procedure(Sender:TObject; ActData:TActualData) of object;

  TLMDFile = class(TLMDCustomComponent)
  private
    FBufferSize:LongInt;
    FActualData:TActualData;
    FFileAttributes:TFiletype;
    FFileAttrShort:String;
    FFileexists:Boolean;
    FFileExt:String;
    FFilePath:String;
    FFileName:String;
    FFileNameExt:String;
    {FFileExecutable:TFileName;}
    FFileNameAlone:String;
    FFileDateTime:TDateTime;
    FFileDate:String;
    FFileTime:String;
    FFileSize:LongInt;
    FProcessed:Byte;
    FOnError:TLMDErrorEvent;
    FOnStart:TLMDActionEvent;
    FOnEnd:TLMDActionEvent;
    FOnProgress:TLMDActionEvent;
    FOptions:TLMDFileOptions;
    procedure SetActualData(Act:TLMDFileAction;const cw1,cw2:String);
    procedure SetBufferSize(aValue:LongInt);
    procedure SetFileAttributes(aValue:TFileType);
    procedure SetFileAttrShort(aValue:String);
    procedure SetFileName(aValue:String{TFileName});
    procedure SetFileNameAlone(aValue:String);
    procedure SetFileNameExt(aValue:String);
    procedure SetOptions(aValue:TLMDFileOptions);
    procedure SetFileExists(aValue:Boolean);
    procedure SetFileExt(aValue:string);
    procedure SetFilePath(aValue:String);
    procedure SetFileDateTime(aValue:String; mode:Boolean);
    procedure SetFileDate(aValue:String);
    procedure SetFileTime(aValue:String);
    procedure SetFileSize(aValue:longint);
    procedure SetCreateFile(aValue:TFileName);
    procedure SetCopyFile(aValue:TFileName);
    procedure SetMoveFile(aValue:TFileName);
    procedure SetDeleteFile(aValue:TFileName);
    procedure SetRenameFile(aValue:TFileName);
    Procedure SetExecuteFile(aValue:TFileName);
    function  GetFileAttributes:TFileType;
    function  GetFileSize(const filename:TFileName):Longint;
    procedure CopyMoveFile(aValue:TFileName; mode:Boolean);
    procedure PrepareOnEvent(mode:TLMDFilePosAction;error:TFileErrorCode);
    function  checkifExist(const aValue:TFileName):Boolean;
    function  checkifEmpty(const aValue:TFileName):Boolean;
    procedure RefreshState;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property aCreateFile:TFileName write SetCreateFile stored false;
    property aCopyFile:TFileName write SetCopyFile stored false;
    property aMoveFile:TFileName write SetMoveFile stored false;
    property aDeleteFile:TFileName write SetDeleteFile stored false;
    property aRenameFile:TFileName write SetRenameFile stored false;
    property aExecuteFile:TFileName write SetExecuteFile stored false;
    function ExecuteFile(const FileName:String; ShowCmd: Integer): THandle;
    function GetFileExecutable:TFileName;
    property Processed:Byte read FProcessed stored false;
    function TestAttr(const aValue: TFileName; Attr: Word):Boolean;
  published
    Property About;
    property BufferSize:LongInt read FBufferSize write SetBufferSize default 8192;
    Property OnError:TLMDErrorEvent read FOnError write FOnError;
    property OnStart:TLMDActionEvent read FOnStart write FOnStart;
    property OnEnd:TLMDActionEvent read FOnEnd write FOnEnd;
    property OnProgress:TLMDActionEvent read FOnProgress write FOnProgress;

    Property Options:TLMDFileOptions read FOptions write SetOptions default
                     [foVerifyAction, foNewFileAsActual, foCopyTimeStamp];

    Property FileDate:string read FFileDate write SetFileDate stored false;
    Property FileTime:string read FFileTime write SetFileTime stored false;
    property FileExt:String read FFileExt write SetFileExt stored false;
    Property FilePath:String read FFilePath write SetFilePath stored False;
    property FileNameExt:string read FFileNameExt write SetFileNameExt stored false;
    property FileNameAlone:String read FFileNAmeAlone write SetFileNameAlone stored false;
    Property FileName:String read FFileName write SetFileName stored false;
    {Property FileExecutable:TFileName read FFileExecutable write SetFileExecutable stored false;}
    property FileAttributes:TFileType read FFileAttributes write SetFileAttributes stored false;
    property FileAttrShort:String read FFileAttrShort write SetFileAttrShort stored false;
    Property FileExist:Boolean read FFileExists write SetFileExists stored false;
    property FileSize:LongInt read FFileSize write SetFileSize stored false;
  end;

implementation
{*************************** Class TLMDFile ***********************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDFile.SetActualData(Act:TLMDFileAction;const cw1,cw2:String);
begin
  {Initialization of the FActualData-Structure at the
   beginning of every main action}
  FActualData.Action:=Act;
  FActualData.Source:=cw1;
  FActualData.Destination:=cw2;

  FProcessed:=0;   {no progress until yet!}
  if act<>fcNone then PrepareOnEvent(fpStart, feNone);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetBufferSize;
begin
  if aValue<>FBufferSize then FBufferSize:=aValue;
end;

{------------------------------------------------------------------------------}
Procedure TLMDFile.SetFileName(aValue:String);
begin
   if aValue<>FFileName then
   begin
     if FileExists(aValue) then
       FFileName:=aValue
     else
       FFileName:='';
     RefreshState;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetOptions(aValue:TLMDFileOptions);
begin
   FOptions:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileAttributes(aValue:TFiletype);
var
  temp:Integer;
begin
  if aValue<>FFileAttributes then
    begin
      temp:=FileGetAttr(FFileName);
      if (ftReadOnly in aValue) then temp:=temp or faReadOnly else temp:=temp and not faReadOnly;
      if (ftHidden in aValue) then temp:=temp or faHidden else temp:=temp and not faHidden;
      if (ftSystem in aValue) then temp:=temp or faSysFile else temp:=temp and not faSysFile;
      if (ftArchive in aValue) then temp:=temp or faArchive else temp:=temp and not faArchive;
      {if (ftNormal in aValue) then temp:=0;}

      if FileSetAttr(FFileName, temp)=0 then
        RefreshState
      else
        SetActualData(fcChange, FFileName,'');
        PrepareOnEvent(fpProgress, feSetAttrFailed);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileAttrShort(aValue:String);
begin
  FFileAttrShort:='----';
  if (ftReadOnly in FFileAttributes) then FFileAttrShort[1]:='r';
  if (ftHidden in FFileAttributes) then FFileAttrShort[2]:='h';
  if (ftSystem in FFileAttributes) then FFileAttrShort[3]:='s';
  if (ftArchive in FFileAttributes) then FFileAttrShort[4]:='a';
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileExists(aValue:Boolean);
begin
   FFileExists:=FileExists(FFileName);
end;

{------------------------------------------------------------------------------}
Function TLMDFile.GetFileExecutable:TFileName;
var
  zFileName,
  zdirectory,
  zresult: array[0..79] of Char;

begin
  result:='';
  if Length(FFilename)=0 then exit;

  FindExecutable(StrPCopy(zFileName, FFileName), StrPCopy(zDirectory, ExtractFilePath(FFileName)),zResult);
  result:=StrPas(zResult);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFilePath(aValue:String);
begin
   FFilePAth:=ExtractFilePath(FFileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileNameAlone(aValue:String);
var
  Temp:Byte;
begin
   FFileNameAlone:=ExtractFileName(FFileName);
   temp:=pos('.', FFileNameAlone);
   if temp>0 then
     FFileNameAlone:=copy(FFileNameAlone,1,temp-1);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileSize(aValue:Longint);
begin
   FFileSize:=GetFileSize(FFileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileNameExt(aValue:String);
begin
   FFileNameExt:=ExtractFileName(FFileName);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileDateTime(aValue:String; mode:Boolean);
var
  temp:TDateTime;
  handle:Integer;

begin
   SetActualData(fcChange, FFileName, '');
   if (Length(aValue)=0) or (Length(FFileName)=0) then exit;
   try
     if mode then
       temp:=strToDateTime(aValue+' '+FFileTime)
     else
       temp:=strToDateTime(FFileDate+' '+aValue);
   except
     on exception do
       begin
         PrepareOnEvent(fpProgress, feDateTimeConvErr);exit;
       end;
   end;

   handle:=Fileopen(FFileName,2);
   try
     if handle>=0 then
       FileSetDate(handle, DateTimeToFileDate(temp))
     else
       begin
         PrepareOnEvent(fpProgress, feDateTimeWriteErr);
       end;
   finally
     Fileclose(handle);
     RefreshState;
   end;

end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileDate(aValue:String);
begin
   if aValue<>FFileDate then SetFileDateTime(aValue, true);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileTime(aValue:String);
begin
   if aValue<>FFileTime then SetFileDateTime(aValue, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetFileExt(aValue:String);
var
  temp:TFilename;

begin

   if FFileExt<>aValue then
     begin
       if Length(avalue)=0 then
         begin
           FFileExt:=ExtractFileExt(FFilename);exit;
         end;

       if avalue[1]<>'.' then avalue:='.'+avalue;
       avalue:=copy(avalue,1,4);

       temp:=AnsiUpperCase(ChangeFileExt(FFileName,aValue));
       if temp<>FFileName then
         if RenameFile(FFIleName, temp) then
           begin
             FFileName:=temp;
             RefreshState;
           end
         else
           begin
             setactualdata(fcChange, aValue,'');
             PrepareOnEvent(fpProgress, feChangeExtFailed);
           end;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.PrepareOnEvent(mode:TLMDFilePosAction;error:TFileErrorCode);
begin
   if error=feNone then
     case mode of
     fpStart:    if assigned(FOnStart) then FOnStart(self,FActualData);
     fpEnd:      begin   {this event will be only fired, if no error occures}
                   FProcessed:=100;
                   if assigned(FOnEnd) then FOnEnd(self,FActualData);
                   SetActualData(fcNone,'','');
                 end;
     fpProgress: if assigned(FOnProgress) then FOnProgress(self,FActualData);
   end
   else
     begin
       If assigned(FOnError) then FOnError(self, error, FActualdata);
       SetActualData(fcNone,'','');
     end;

end;

{------------------------ writeonly properties---------------------------------}
procedure TLMDFile.SetCreateFile(aValue:TFileName);
var
  handle:Integer;

begin

  {Standard-Procedure at the Beginning}
  SetActualData(fcCreate, aValue, '');

  {Checking Routines}
  if CheckIfEmpty(aValue) then exit;
  aValue:=ExpandFileName(aValue);
  if CheckIfExist(aValue) then exit;

  handle:=FileCreate(aValue);
  if handle>=0 then
    begin
      FileClose(Handle);
      if foNewFileAsActual in FOptions then
        begin
          FFilename:=aValue;
          RefreshState;
        end;
    end
  else
    begin
      PrepareOnEvent(fpProgress, feErrorCreateFile);
      Exit;
    end;

  {The End of the Action, no error occured}
  PrepareOnEvent(fpStart, feNone);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.CopyMoveFile(aValue:TFileName; mode:Boolean);
var
  CopyBuffer: Pointer; { buffer for copying }
  TimeStamp, BytesCopied, old, ChunkSize: Longint;
  Source, Dest: Integer; { handles }

begin

  {Checking if there is no Paramater a Null-String}
  if (checkifempty(aValue)) or (checkifempty(FFileName)) then exit;

  ChunkSize:=FBufferSize;
  {Checking if Parameter is only Path}
  if TestAttr(aValue, faDirectory) then
    begin
      if aValue[Length(aValue)] = '\' then
        aValue := avalue+ ExtractFileName(FFilename)
      else
        aValue := aValue + '\' + ExtractFileName(FFilename);
    end;

  aValue:=expandfileName(aValue);

  {More Checking}
  if aValue=FFileName then
    begin
      prepareOnEvent(fpProgress, feFileDestSrcSame);exit;
    end;

  if CheckIfExist(aValue) then exit;

  {falls Verschieben - erst enmal die einfache Variante versuchen!}
  if not mode then
    if renamefile(FFileName, aValue) then
      begin
        FFileName:= aValue;RefreshState;PrepareOnEvent(fpEnd, feNone);Exit;
        {falls geglückt, war's das schon...}
      end;

  {The Copy-Routine}
  TimeStamp := FileAge(FFileName);
  GetMem(CopyBuffer, ChunkSize);
  try
    Source := FileOpen(FFileName, fmShareDenyWrite);
    if Source < 0 then
      begin  {Call ErrorHandler}
        PrepareOnEvent(fpProgress, feErrorOpenSrc);exit;
      end;
    try
      Dest := FileCreate(aValue);
      if Dest < 0 then
        begin  {Call ErrorHandler}
          PrepareOnEvent(fpProgress, feErrorOpenDest);exit;
        end;
      try
        {eigentlicher Kopiervorgang}
        old:=0;
        repeat
          BytesCopied := FileRead(Source, CopyBuffer^, ChunkSize);
          if BytesCopied > 0 then
            FileWrite(Dest, CopyBuffer^, BytesCopied);

          Inc(old, BytesCopied);
          FProcessed:= Trunc(((old / FFileSize)*100));

          PrepareOnEvent(fpProgress, feNone);
          Application.ProcessMessages;
        until BytesCopied < ChunkSize;

        if mode then
          begin
            if foCopyTimeStamp in Foptions then FileSetDate(Dest, TimeStamp);
            if foCopiedFileAsActual in Foptions then
              FFileName:=aValue;
          end
        else
          begin
            FileSetDate(Dest, TimeStamp);
            FileClose(source);
            if not SysUtils.deletefile(FFilename) then
              PrepareOnEvent(fpProgress, feMoveSrcNotKilled);
            FFileName:=aValue;
          end;
      finally
        FileClose(Dest);
      end;
    finally
      FileClose(Source);
    end;
  finally
    FreeMem(CopyBuffer, ChunkSize);
  end;
  RefreshState;

  {Everything was OK}
  PrepareOnEvent(fpEnd, feNone);

end;

{------------------------------------------------------------------------------}
Procedure TLMDFile.SetCopyFile(aValue:TFileName);
begin
  SetActualData(fcCopy, FFileName, aValue);
  CopyMoveFile(aValue, true);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetMoveFile(aValue:TFileName);
begin
  SetActualData(fcMove, FFileName, aValue);
  CopyMoveFile(aValue, false);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetDeleteFile(aValue:TFileName);
begin
  {Beginning}
  if Length(aValue)=0 then aValue:=FFileName;
  SetActualData(fcDelete, aValue, '');

  avalue:=ExpandFileName(aValue);

  if not SysUtils.DeleteFile(aValue) then
    begin
      prepareOnEvent(fpProgress, feDelFileNotKilled);
      exit;
    end
  else
    if aValue=FFileName then
      begin
        FFileName:='';
        refreshstate;
      end;

  PrepareOnEvent(fpEnd, feNone);
end;

{------------------------------------------------------------------------------}
procedure TLMDFile.SetRenameFile(aValue:TFileName);
begin
  {Beginning}
  if Length(aValue)=0 then aValue:=FFileName;
  SetActualData(fcRename,FFileName, aValue);

  {Checking if there is no Parameter a Null-String}
  if (checkifempty(aValue)) or (checkifempty(FFileName)) then exit;
  aValue:=expandfileName(aValue);

  {More Checking}
  if aValue=FFileName then
    begin
      prepareOnEvent(fpProgress, feFileDestSrcSame);exit;
    end;

  if checkifexist(aValue) then exit;

  if renamefile(FFileName, aValue) then
    begin
      FFileName:= aValue;RefreshState;  {falls geglückt, war's das schon...}
      PrepareOnEvent(fpEnd, feNone);
    end
  else
   PrepareOnEvent(fpProgress, feRenameFailed);
end;

{------------------------------------------------------------------------------}
Procedure TLMDFile.SetExecuteFile(aValue:TFileName);
begin
   SetActualData(fcExecute,FFileName,'');
   aValue:=expandfileName(aValue);
   if not Fileexists(aValue) then
     PrepareOnEvent(fpProgress, feFileNotExist)
   else
     if ExecuteFile(aValue, SW_SHOW) <=32 then
       PrepareOnEvent(fpProgress, feErrorExecuteFile)

end;

{-------------------------- Helper-Routines------------------------------------}
function TLMDFile.GetFileAttributes:TFileType;
var
  temp:Integer;
begin

  result:=[];
  temp:=FileGetAttr(FFileName);
  if temp>-1 then
    begin
      if (temp and faReadOnly)=faReadOnly then result:=[ftReadOnly];
      if (temp and faHidden)=faHidden then result:=result+[ftHidden];
      if (temp and faSysFile)=faSysFile then result:=result+[ftSystem];
      if (temp and faVolumeID)=faVolumeID then result:=result+[ftVolumeID];
      if (temp and faDirectory)=faDirectory then result:=result+[ftDirectory];
      if (temp and faArchive)=faArchive then result:=result+[ftArchive];
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFile.TestAttr(const aValue: TFileName; Attr: Word): Boolean;
var
  temp:integer;
begin
  temp:=FileGetAttr(aValue);
  if temp<0 then
    result:=false
  else
    Result := (temp and Attr) = Attr;
end;

{------------------------------------------------------------------------------}
function TLMDFile.GetFileSize(const FileName: TFileName): LongInt;
var
  SearchRec: TSearchRec;
begin
  if FindFirst(ExpandFileName(FileName), faAnyFile, SearchRec) = 0 then
    begin
      Result := SearchRec.Size;
      FindClose(SearchRec);
    end
  else
    Result := -1;
end;

{---------------------------------------------------------------------------}
function TLMDFile.checkifExist(const aValue:TFileName):boolean;
begin
  result:=false;
  {check if File already exists, but only if foVerifyAction-Flag is set}
  if FileExists(aValue) then
    begin
      if foVerifyAction in FOptions then
        begin
          prepareOnEvent(fpProgress, feFileAlreadyExist);
          result:=true;
          exit;
        end;
      if TestAttr(AValue, faReadonly) then
        begin
          prepareOnEvent(fpProgress, feFileReadOnly);
          result:=true;
        end;
    end;
end;

{---------------------------------------------------------------------------}
function TLMDFile.checkifEmpty(const aValue:TFileName):boolean;
begin
  result:=false;
  {check if avalue is empty}
  if Length(aValue)=0 then
    begin
      prepareOnEvent(fpProgress, feParameterNull);
      result:=true;
    end;
end;

{---------------------------------------------------------------------------}
function TLMDFile.ExecuteFile(const FileName:string;ShowCmd: Integer): THandle;
begin
  Result := ShellExecute(0, 'open', PChar(FileName), '', '', ShowCmd);
end;

{----------------Wichtigste UpdateRoutine-----------------------------------}
procedure TLMDFile.RefreshState;
var
  Handle:integer;
begin

   if Length(FFileName)<>0 then
     FFileName:=ExpandFileName(FFileName);

   SetFileExists(false);
   SetFileNameAlone('');
   SetFileNameExt('');
   SetFilePath('');
   {SetFileExecutable('');}
   FFileExt:=ExtractFileExt(FFileName);
   FFileAttributes:=GetFileAttributes;
   SetFileAttrShort('');

   FFileSize:=GetFileSize(FFileName);
   {if FFilesize<0 then FFileSize:=0;}

   handle:=FileOpen(FFileName,0);
   if handle>=0 then
     begin
       FFileDateTime:=FileDateToDateTime(FileGetDate(handle));
       {FFileDateTime:=FileDateToDateTime(FileAge(FFileName));}
       FFileDate:=Datetostr(FFileDateTime);
       FFileTime:=Timetostr(FFileDateTime);
     end
   else
     begin
       FFileDateTime:=0;FFileDate:='';FFileTime:='';
     end;
   fileclose(handle);
end;

{---------------------Public Teil-------------------------------------------}
constructor TLMDFile.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FBufferSize:=8192;
  FOptions:=[foVerifyAction, foNewFileAsActual, foCopyTimeStamp];
end;

{---------------------------------------------------------------------------}
Destructor TLMDFile.Destroy;
begin
  inherited Destroy;
end;

end.

