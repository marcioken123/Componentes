unit LMDFileGrep;
{$I lmdcmps.inc}

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

LMDFileGrep unit (JH)
---------------------

Changes
-------
Release 4.01.01 (March 2008)
* OutStringList property removed (can no longer be used, because existence of
  TLMDListBox component is not assured (e.g. in LMD ShellPack).

Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls,
  LMDShBase, LMDDateTime;

const
  FileMaskDelimiter = ';';

type

  TLMDFileGrep = class;
  TLMDFoundEvent = procedure (Sender : TObject; found : String) of object;
  TLMDFileChangeEvent = procedure (Sender : TObject; name : String) of object;

  TLMDSearchThread = class (TThread)
  private
    FOwner : TLMDFileGrep;
    FToBeAdded: String; //internal use only
    procedure StartGrep;
  protected
    procedure SAddF;
  public
    procedure Execute; override;
    constructor Create (aOwner : TLMDFileGrep;CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure SyncAddFound (s: String);
  end;

  TLMDFileGrepAttribute = (fmReadOnly, fmArchive, fmAnyfile, fmSystem, fmHidden);
  TLMDFileGrepAttributes = set of TLMDFileGrepAttribute;
  TLMDReturnValue = (rvDir, rvFilename, rvAttr, rvSize, rvCreateDate, rvLastAccessDate, rvLastModifiedDate);
  TLMDReturnValues = set of TLMDReturnValue;
  TLMDLookFor = (lfCreateAfter, lfCreateBefore, lfAccessedAfter, lfAccessedBefore, lfModifiedAfter, lfModifiedBefore);
  TLMDLookFors = set of TLMDLookFor;

  TLMDFileGrep = class(TLMDShellComponent)
  private
    FFileMasks,
    FDirs,
    FContent       : String;
    FSizeMin,
    FSizeMax       : Int64;
    FAttr          : TLMDFileGrepAttributes;
    FCreatedMin,
    FCreatedMax,
    FAccessedMin,
    FAccessedMax,
    FModifiedMin,
    FModifiedMax   : TLMDDateTime;
    FFound         : TStrings;
    FCreateFoundList,
    FCaseSensitiveContent,
    FCancelling,
    FRecurseSubDirs,
    FThreaded      : Boolean;
    FThreadPriority: TThreadPriority;
    FOnEnd,
    FOnCancel,
    FOnFinished    : TNotifyEvent;
    FOnFound       : TLMDFoundEvent;
    FReturnVals    : TLMDReturnValues;
    FLookFor       : TLMDLookFors;
    FReturnDelimiter : Char;
    FSrchThread    : TLMDSearchThread;
    FOnDirChanged,
    FOnFileChanged : TLMDFileChangeEvent;
    FOnErrorOpenFile:TLMDFileChangeEvent;

    procedure SetDateTime (index : Integer;aValue : TLMDDateTime);
    procedure SetThreadPriority (aValue : TThreadPriority);
    procedure ReadString(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler); override;
    function lfDate (val : TLMDLookFor) : TDateTime;
    function getAttr : Word;
    procedure GrepFiles (const StartDir, FileMasks : String;
                    RecurseSubDir : Boolean;
                    MinSize, MaxSize : Int64;
                    MinCreateDate, MaxCreateDate,
                    MinLastAccessDate, MaxLastAccessDate,
                    MinLastWriteDate, MaxLastWriteDate : TDateTime;
                    Attr : Word; CaseSensitiveContent : Boolean;
                    Content : String; OnError:TLMDFileChangeEvent=nil);
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Grep;
    procedure Cancel;
    property Found : TStrings read FFound;
    property Files : TStrings read FFound;
  published
    property About;
    property FileMasks : String read FFileMasks write FFileMasks;
    property Dirs : String read FDirs write FDirs;
    property Attributes : TLMDFileGrepAttributes read FAttr write FAttr default [fmAnyFile];
    property CreatedAfter : TLMDDateTime index 0 read FCreatedMin write SetDateTime;
    property CreatedBefore : TLMDDateTime index 1 read FCreatedMax write SetDateTime;
    property AccessedAfter : TLMDDateTime index 2 read FAccessedMin write SetDateTime;
    property AccessedBefore : TLMDDateTime index 3 read FAccessedMax write SetDateTime;
    property ModifiedAfter : TLMDDateTime index 4 read FModifiedMin write SetDateTime;
    property ModifiedBefore : TLMDDateTime index 5 read FModifiedMax write SetDateTime;
    property MinSize : Int64 read FSizeMin write FSizeMin default 0;
    property MaxSize : Int64 read FSizeMax write FSizeMax default 0;
    property Content : String read FContent write FContent;
    property CaseSensitiveContent : Boolean read FCaseSensitiveContent write FCaseSensitiveContent default true;
    property ThreadedSearch : Boolean read FThreaded write FThreaded default true;
    property ThreadPriority : TThreadPriority read FThreadPriority write SetThreadPriority default tpNormal;
    property RecurseSubDirs : Boolean read FRecurseSubDirs write FRecurseSubDirs default true;
    property ReturnValues : TLMDReturnValues read FReturnVals write FReturnVals default [rvDir, rvFileName];
    property ReturnDelimiter : Char read FReturnDelimiter write FReturnDelimiter default ';';
    property LookForDates : TLMDLookFors read FLookFor write FLookFor default [];
    property InternalFoundList: Boolean read FCreateFoundList write FCreateFoundList default true;

    property OnFinished : TNotifyEvent read FOnFinished write FOnFinished;
    property OnCancel : TNotifyEvent read FOnCancel write FOnCancel;
    property OnFound : TLMDFoundEvent read FOnFound write FOnFound;
    property OnDirChange : TLMDFileChangeEvent read FOnDirChanged write FOnDirChanged;
    property OnEnd : TNotifyEvent read FOnEnd write FOnEnd;
    property OnFileChange : TLMDFileChangeEvent read FOnFileChanged write FOnFileChanged;
    property OnErrorOpenFile:TLMDFileChangeEvent read FOnErrorOpenFile write FOnErrorOpenFile;
  end;

implementation

uses

  Windows, SysUtils, Forms, FileCtrl, LMDStrings, LMDProcs;

{ ---------------------------------------------------------------------------- }
procedure TLMDSearchThread.StartGrep;
begin
  with FOwner do
    GrepFiles(Dirs, FileMasks, RecurseSubDirs, MinSize, MaxSize,
                lfDate(lfCreateAfter), lfDate(lfCreateBefore),
                lfDate(lfAccessedAfter), lfDate(lfAccessedBefore),
                lfDate(lfModifiedAfter), lfDate(lfModifiedBefore),
                getAttr, FCaseSensitiveContent, Content, FOnErrorOpenFile);
end;

{ ----------------------------- protected ------------------------------------ }
procedure TLMDSearchThread.SAddF;
begin
  FOwner.FFound.Add (FToBeAdded)
end;

{ ------------------------------- public ------------------------------------- }
procedure TLMDSearchThread.Execute;
begin
  Synchronize (StartGrep);
  //Synchroize needed here because of properties of grep component
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSearchThread.Create (aOwner : TLMDFileGrep;CreateSuspended: Boolean);
begin
  inherited Create (CreateSuspended);
  FOwner := aOwner;
  FreeOnTerminate:=True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSearchThread.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSearchThread.SyncAddFound (s: String);
begin
  FToBeAdded := s;
  Synchronize (SAddF);
end;

{ ************************** TLMDFileGrep *************************************}
{ ------------------------------------ private ------------------------------- }
procedure TLMDFileGrep.SetDateTime (index : Integer;aValue : TLMDDateTime);
begin
  case index of
    0:FCreatedMin.Assign (aValue);
    1:FCreatedMax.Assign (aValue);
    2:FAccessedMin.Assign (aValue);
    3:FAccessedMin.Assign (aValue);
    4:FModifiedMin.Assign (aValue);
    5:FModifiedMax.Assign (aValue);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileGrep.SetThreadPriority (aValue : TThreadPriority);
begin
  if aValue <> FThreadPriority then
    begin
      FThreadPriority := aValue;
      if FSrchThread <> nil then
        FSrchThread.Priority := aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFileGrep.ReadString(Reader:TReader);
begin
  Reader.SkipValue;
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDFileGrep.DefineProperties(Filer:TFiler);
begin
  inherited;
  Filer.DefineProperty('OutStringList', ReadString, nil, false );
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileGrep.lfDate (val : TLMDLookFor) : TDateTime;
begin
  result := 0;
  if val in LookForDates then
    case val of
      lfCreateAfter : result := CreatedAfter.DateTimeValue;
      lfCreateBefore : result := CreatedBefore.DateTimeValue;
      lfAccessedAfter : result := AccessedAfter.DateTimeValue;
      lfAccessedBefore : result := AccessedBefore.DateTimeValue;
      lfModifiedAfter : result := ModifiedAfter.DateTimeValue;
      lfModifiedBefore : result := ModifiedBefore.DateTimeValue;
    end
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileGrep.getAttr : Word;
begin
  result := 0;
  if fmHidden in Attributes then
    result := result + faHidden;
  if fmSystem in Attributes then
    result := result + faSysFile;
  if fmReadOnly in Attributes then
    result := result + faReadOnly;
  if fmArchive in Attributes then
    result := result + faArchive;
  if fmAnyFile in Attributes then
    result := faAnyFile;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileGrep.GrepFiles (const StartDir, FileMasks : String;
                     RecurseSubDir : Boolean;
                     MinSize, MaxSize : Int64;
                     MinCreateDate, MaxCreateDate,
                     MinLastAccessDate, MaxLastAccessDate,
                     MinLastWriteDate, MaxLastWriteDate : TDateTime;
                     Attr : Word; CaseSensitiveContent : Boolean;
                     Content : String; OnError:TLMDFileChangeEvent=nil);

var
  SilentSearch: Boolean;
{
var
  SearchMasks : ^TSearchMasks;
  i           : Integer;
  s           : String;
}
   function CheckTerminated:Boolean;
   begin

     result := ((FSrchThread <> nil) and FSrchThread.Terminated) or
               Application.Terminated or FCancelling;

   end;

   function CompareFTWithDT (const ft : TFileTime; dt : TDateTime) : Integer;
   var
     st  : TSystemTime;
     dt1: TDateTime;
   begin
     FileTimeToSystemTime (ft, st);
     dt1 := SystemTimeToDateTime(st);
     if dt1 > dt then
       result := 1
     else
       if dt1 < dt then  result := -1
         else
           result := 0;
   end;

   function FileTimeToDateTime(Time: TFileTime): TDateTime;
   var
     lt: TFileTime;
     dt:Integer;
     LTime, LDate: word;
   begin
     FileTimeToLocalFileTime(Time, lt);
     FileTimeToDosDateTime(lt, LDate, LTime);
     dt := MakeLong(LTime, LDate);
     try
       result:=FileDateToDateTime(dt);
     except
       on EConvertError do Result := 0;
     end;
   end;

   function SystemDateTimeToStr(st : SYSTEMTIME) : String;
   begin
     DateTimeToString (result, {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}longdateformat, SystemTimeToDateTime(st));
   end;

  function CheckContent(const FileName: String) : Boolean;
  var
    fs: TMemoryStream;
    i, l: Int64;
    Source, SourceEnd : PChar;
    begin
    //assumption: this file won't match
    result := false;

     //if the found file is a directory we should not test its content ...
     //better check this BEFORE this method is called ...
//     if DirectoryExists(s) then exit; //line below replalced, omitted ALL files, if rvDir was given in the search attributes ...
//     if (Attr and faDirectory = faDirectory) then exit; //11 June 2001, JH

    //read the file content
    fs := TMemoryStream.Create;
    try
      try
         fs.LoadFromFile (FileName);
         fs.Position := 0;
      except
        on Exception do
          begin
           if Assigned(OnError) then OnError(nil, FileName);
           exit;
          end;
      end;

      //if the stream is empty we can exit
      if fs.Size = 0 then
         exit;
      //get char pointers to the streams memory
      Source := fs.Memory;
      SourceEnd := Source + fs.Size;
      i := 1;
      l := Length(content);

      //step through the whole stream
      while Source <= SourceEnd do
      begin
          //if not case sensitive -> uppercase the char
          if not CaseSensitiveContent then
            Source^ := UpCase (Source^);
            //if current char is equal to the next char to be found of the content
          if (Source^ = Content[i]) then
          inc(i) //inc our content counter
          else //the current char does not fit into the content
            begin
              //step back in source to the first found fitting letter
              //(example: content='compiling'; i = 4 means that we have found 'comp' and one letter <> 'i'
              //          => let's move to the 'o' of 'ompiling' to restart search from there)
              //!!! if i = 1 nothing is done in here !!!
              dec(Source, i - 1);
              //we are at the first pos
              i := 1;
            end;

          if i = l+1 then
            begin          //we have found i matching letters and had to find l
              //file found
              result := true;
              exit;
            end;

          //get the next character
          inc(Source);
          end;
    finally
      fs.Free;
    end;
  end;

  procedure SearchDir (const sDir : String; SearchMasks: TStrings);
  var
    sr       : TSearchRec;
    ls,
    tempint  : Int64;
    j        : Integer;
    acc      : Boolean;
    SecAttr  : TSECURITYATTRIBUTES;   // needed for open file
    DosError : Integer;
    ssDir, S : string;
    st: SYSTEMTIME;
  begin
    ssDir := LMDAnsiSlashAdd(sDir);
    if  not SilentSearch  then
    //let the application handle some urgent messages
      Application.ProcessMessages;
     //generate on dir changed event
    if Assigned (FOnDirChanged) then FOnDirChanged (self, ssDir);
     //search directoy for all masks (i = number of filemasks to look for)
    for j := 0 to SearchMasks.Count - 1 do
      begin
        //find first file in the directory
        DosError := FindFirst(ssDir + SearchMasks[j], faAnyFile{ Attr}, sr);
        if DosError = 0  then
        try
         //while there are files in the directory
        while DosError = 0 do
          begin
            if CheckTerminated then
              break;
             //we have found a file which we will examine now (whether it fits in our search criterias or not)
            if Assigned (FOnFileChanged) then FOnFileChanged (self, sr.Name);
             //let's assume taht it fits (acc = true)
            acc := true;

            //let's check file size
            tempint := sr.FindData.nFileSizeHigh * MAXDWORD;
            ls := sr.FindData.nFileSizeLow + tempint;
            if MinSize > ls then //vb: sr.Size => ls
              acc := false;
            if (MaxSize <> 0) and (ls > MaxSize) then //vb: sr.Size => ls
              acc := false;

            //one of the two entries exisitng in each directory ('self' and 'up')?
            if (sr.name = '.') or (sr.name = '..') then
              acc := false;

            //check the file attributes
            if (Attr and faAnyFile <> faAnyFile) then
              begin
                if (Attr and faArchive = faArchive) and not (sr.Attr and faArchive = faArchive) then
                  acc := false;
                if (Attr and faReadOnly = faReadOnly) and not (sr.Attr and faReadOnly = faReadOnly) then
                  acc := false;
                if (Attr and faSysFile = faSysFile) and not (sr.Attr and faSysFile = faSysFile) then
                  acc := false;
                if (Attr and faHidden = faHidden) and not (sr.Attr and faHidden = faHidden) then
                  acc := false;
              end;

            if acc then
              begin //we currently accept the file - let's check date/time ranges
                //File Time

                SecAttr.nLength := SizeOf(TSecurityAttributes);

                SecAttr.bInheritHandle := false;
                //(lfCreateAfter, lfCreateBefore, lfAccessedAfter, lfAccessedBefore, lfModifiedAfter, lfModifiedBefore);

                //thanks to MD!
                //check creation time
                FileTimeToLocalFileTime (sr.FindData.ftCreationTime, sr.FindData.ftCreationTime);
                if (lfCreateBefore in self.LookForDates) and (MaxCreateDate > 0) and
                    (CompareFTWithDT (sr.FindData.ftCreationTime, MaxCreateDate) > 0) then
                   acc := false; //date is younger as the last accepted date
                if (lfCreateAfter in self.LookForDates) and (MinCreateDate > 0) and
                   (CompareFTWithDT (sr.FindData.ftCreationTime, MinCreateDate) < 0) then
                  acc := false; //date is older as the last accepted date

                //check access time
                FileTimeToLocalFileTime (sr.FindData.ftLastAccessTime, sr.FindData.ftLastAccessTime);
                if (lfAccessedBefore in self.LookForDates) and (MaxLastAccessDate > 0) and
                   (CompareFTWithDT (sr.FindData.ftLastAccessTime, MaxLastAccessDate) > 0) then
                  acc := false; //date is younger as the last accepted date
                if (lfAccessedAfter in self.LookForDates) and (MinLastAccessDate > 0) and
                    (CompareFTWithDT (sr.FindData.ftLastAccessTime, MinLastAccessDate) < 0) then
                  acc := false; //date is older as the last accepted date

                //check modification time
                FileTimeToLocalFileTime (sr.FindData.ftLastWriteTime, sr.FindData.ftLastWriteTime);
                if (lfModifiedBefore in self.LookForDates) and (MaxLastWriteDate > 0) and
                   (CompareFTWithDT (sr.FindData.ftLastWriteTime, MaxLastWriteDate) > 0) then
                  acc := false; //date is younger as the last accepted date
                if (lfModifiedAfter in self.LookForDates) and (MinLastWriteDate > 0) and
                    (CompareFTWithDT (sr.FindData.ftLastWriteTime, MinLastWriteDate) < 0) then
                  acc := false; //date is older as the last accepted date
              end;

            //check whether current file is a directory -> we should not try to check it for
            //the content
            if (acc) and (sr.Attr and faDirectory = faDirectory) and (Content <> '') then
              acc := false;
            //if acc=true and we have to look up the file for a special content let's do it
            //!!this is the last test, because is the most time expensive one!!
            if (acc) and (Content <> '') and (not CheckContent(LMDAnsiSlashAdd (sDir) + sr.name)) then
              acc := false;

            //acc = true means now that we have found a file -> let's build up the output string
            if acc then
              begin
                s := '';
                if rvDir in FReturnVals then
                  s := s + LMDAnsiSlashAdd (sDir) + FReturnDelimiter;
                if rvFilename in FReturnVals then
                  s := s + sr.name + FReturnDelimiter;
                if rvSize in FReturnVals then
                  s := s + IntToStr (ls) + FReturnDelimiter; //vb
                if rvCreateDate in FReturnVals then
                  begin
                    FileTimeToSystemTime(sr.FindData.ftCreationTime, st);
                    s := s + SystemDateTimeToStr(st) + FReturnDelimiter;
                  end;
                if rvLastAccessDate in FReturnVals then
                  begin
                    FileTimeToSystemTime(sr.FindData.ftLastAccessTime, st);
                    s := s + SystemDateTimeToStr(st) + FReturnDelimiter;
                  end;
                if rvLastModifiedDate in FReturnVals then
                  begin
                    FileTimeToSystemTime(sr.FindData.ftLastWriteTime, st);
                    s := s + SystemDateTimeToStr(st) + FReturnDelimiter;
                  end;
                if rvAttr in FReturnVals then
                  begin
                    if faReadOnly and sr.Attr = faReadOnly then
                      s := s + 'r';
                    if faArchive and sr.Attr = faArchive then
                      s := s + 'a';
                    if faSysFile and sr.Attr = faSysFile then
                      s := s + 's';
                    if faVolumeId and sr.Attr = faVolumeId then
                      s := s + 'v';
                    if faDirectory and sr.Attr = faDirectory then
                      s := s + 'd';
                    if faHidden and sr.Attr = faHidden then
                      s := s + 'h';
                  end;
                //rise OnFound event
                if Assigned (FOnFound) then
                  FOnFound (self, s);
                //add to internal found list
                if FCreateFoundList then
{                   if FSrchThread <> nil then
                     FSrchThread.SyncAddFound(s)
                   else JH Okt 2001 -> synchronize execute }
                   FFound.Add (s);
              end;
            //find next file and jump back to start of while loop
            DosError := FindNext (sr);
          end;

        finally
          FindClose(sr);
        end;
    end;
    if CheckTerminated then exit;
    if RecurseSubDir then
      begin //we have to walk through all sub directories
        //find first directory
        DosError := FindFirst (ssDir+'*.*', faDirectory + faHidden + faSysFile, sr);
        //if we found a directory
        if DosError = 0 then
          try
            while DosError = 0 do
              begin
                //check for system directories (self, up) and whether this file is a directory
                if (sr.name <> '.') and (sr.name <> '..') and
                    (sr.Attr and faDirectory = faDirectory) then
                   //recurse this procedure with the new found directory
                  SearchDir(ssDir + sr.name, SearchMasks);
                if CheckTerminated then   //has the thread terminated?
                  break;
                //search next directory
                DosError := FindNext (sr);
              end;
          finally
            //close the directory search
            FindClose (sr);
          end;
      end;
  end;

var
  k: integer;
  S: string;
  sFileMasks, sStartDir: string;
  SearchMasks : TStrings;
begin
  if not CaseSensitiveContent then
    content := LMDAnsiUpperCase (content);

  sStartDir := StartDir;
  sFileMasks := FileMasks;
  SearchMasks := TStringList.Create;
  if  sFileMasks = '' then
    sFileMasks := '*.*';

  try
    k := Pos(FileMaskDelimiter, sFileMasks);
    //extract all filemasks to be searched for
    while k <> 0 do
      begin
        S := Trim(Copy(sFileMasks, 1, k - 1));

        if  (S <> '') and (SearchMasks.IndexOf(S) < 0)  then
          SearchMasks.Add(S);

        sFileMasks := Trim(Copy(sFileMasks, k + 1, MAXINT));
        k := Pos(FileMaskDelimiter, sFileMasks);
      end;
    //get last (if i > 1) or just get the only filemask to look for
    if  Trim(sFileMasks) <> '' then
      SearchMasks.Add(sFileMasks);

    SilentSearch :=

      (GetCurrentThreadID <> MainThreadID);

    //scan more than one directory -> delimited by ;
    k := Pos(FileMaskDelimiter, sStartDir);
    while k <> 0 do
      begin
        S := Trim(Copy(sStartDir, 1, k - 1));

        if (S <> '') and ((not CheckTerminated) or (FSrchThread = nil)) then
          SearchDir (S, SearchMasks);
        sStartDir := Trim(Copy(sStartDir, k + 1, MAXINT));
        k := Pos(FileMaskDelimiter, sStartDir);
      end;
    //scan last directory (if there had been more than one dir to be scanned)
    //or the first - and only - directory
    if (sStartDir <> '') and ((not CheckTerminated) or (FSrchThread = nil)) then
      SearchDir (sStartDir, SearchMasks);
  finally
    SearchMasks.Free;
  end;

  //is needed to terminate the thread
  //if it is a not threaded search this call does nothing
  if FSrchThread <> nil then
    begin
      if not FSrchThread.Terminated then FSrchThread.Terminate;
      FSrchThread := nil;
    end;
  if not FCancelling then
    begin
      if Assigned (FOnFinished) then FOnFinished (self)
    end
  else
    if Assigned (FOnCancel) then FOnCancel (self);
  FCancelling := false; //all done
  //this event will always be executed if the search is ended
  if Assigned (FOnEnd) then FOnEnd (self);
end;

{ --------------------------------- public ----------------------------------- }
constructor TLMDFileGrep.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FThreaded := true;
  FThreadPriority := tpNormal;
  FRecurseSubDirs := true;
  FSizeMin := 0;
  FSizeMax := 0;
  FReturnDelimiter := ';';
  FAttr := [fmAnyFile];
  FReturnVals := [rvDir, rvFileName];
  FLookFor := [];
  FSrchThread := nil;
  FFound := TStringList.Create;
  FCancelling :=false;
  FCaseSensitiveContent := true;
  FCreateFoundList := true;

  FCreatedMin := TLMDDateTime.Create;
  FCreatedMax := TLMDDateTime.Create;
  FAccessedMin := TLMDDateTime.Create;
  FAccessedMax := TLMDDateTime.Create;
  FModifiedMin := TLMDDateTime.Create;
  FModifiedMax := TLMDDateTime.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFileGrep.Destroy;
begin
  //if there is currently a thread running it should be stopped
  Cancel;
  FModifiedMax.Free;
  FModifiedMin.Free;
  FAccessedMax.Free;
  FAccessedMin.Free;
  FCreatedMax.Free;
  FCreatedMin.Free;
  FFound.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileGrep.Grep;
begin
  if FSrchThread <> nil then exit;
  //if there is already one thread running destroy it
  //Cancel;
  //clear previous found
  FFound.Clear;
  if FThreaded then
    begin
      FSrchThread := TLMDSearchThread.Create (self, True);
      FSrchThread.Priority := FThreadPriority;
      FSrchThread.Resume;
    end
  else
    GrepFiles (Dirs, FileMasks, RecurseSubDirs, MinSize, MaxSize,
             lfDate(lfCreateAfter), lfDate(lfCreateBefore),
             lfDate(lfAccessedAfter), lfDate(lfAccessedBefore),
             lfDate(lfModifiedAfter), lfDate(lfModifiedBefore),
             getAttr, CaseSensitiveContent, Content, FOnErrorOpenFile);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileGrep.Cancel;
begin
  FCancelling := true;
  //stop currently running thread and destroy it
  if FSrchThread <> nil then
    FSrchThread.Terminate;
end;

end.
