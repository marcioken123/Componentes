unit LMDSearchFileGrep;
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

LMDSearchFileGrep unit (JH, VO, RM)
-----------------------------------

ToDo
----
Use of same ancestor of TLMDFileGrep and TLMDSearchFileGrep

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Forms,
  LMDSearchBase, LMDRefineUnit, LMDDateTime, LMDThreads;

const
  FileMaskDelimiter = ';';

type

  { ------------------------- class TLMDSPDateTime --------------------------- }
  {TLMDSPDateTime = class(TPersistent)
  private
    FDateTime : TDateTime;
    procedure SetWord(Index:Integer; aValue:Word);
    procedure SetDateTime (aValue : TDateTime);
    function GetWord(Index:Integer):Word;
  public
    constructor Create;
    procedure Assign (Source : TPersistent);override;
    procedure SetDate(aValue:TDateTime);
    procedure SetTime(aValue:TDateTime);
    property DateTimeValue:TDateTime read FDateTime write SetDateTime;
  published
    property Day: Word index 0 read GetWord write SetWord default 1;
    property Month: Word index 1 read GetWord write SetWord default 1;
    property Year: Word index 2 read GetWord write SetWord default 1990;
    property Hour: Word index 3 read GetWord write SetWord default 0;
    property Minute: Word index 4 read GetWord write SetWord default 0;
    property Second: Word index 5 read GetWord write SetWord default 0;
  end;}

  TLMDSearchFileGrep = class;

  TLMDSSearchThread = class(TThread)
  private
    FOwner : TLMDSearchFileGrep;
    FToBeAdded: String; //internal use only
    procedure StartGrep;
  protected
    procedure SAddF;
    procedure Execute; override;
  public
    constructor Create (aOwner: TLMDSearchFileGrep; CreateSuspended: Boolean);
    destructor Destroy; override;
    procedure SyncAddFound (const s: String);
  end;

  // used types
  TLMDSPFileAttribute = (fmReadOnly, fmArchive, fmAnyfile, fmSystem, fmHidden);
  TLMDSPFileAttributes = set of TLMDSPFileAttribute;
  TLMDSPResult=(srsDir, srsFilename, srsAttr, srsSize, srsCreateDate, srsLastAccessDate, srsLastModifiedDate);
  TLMDSPResults = set of TLMDSPResult;
  TLMDSPCheckDate=(scdCreateAfter, scdCreateBefore, scdAccessedAfter, scdAccessedBefore, scdModifiedAfter, scdModifiedBefore);
  TLMDSPCheckDates=set of TLMDSPCheckDate;

  // search result record
  PLMDSPFileRecord=^TLMDSPFileRecord;
  TLMDSPFileRecord = record
  Directory:String;
    FileName:String;
    Attributes:TLMDSPFileAttributes;
    AttributeString:String;
    FileSize:Int64;
    CreateDate,
    LastAccess,
    LastModified:TDateTime;
  end;
  // event types
  TLMDSPOnFileChangeEvent = procedure (Sender : TObject; filename : String) of object;
  TLMDSPOnFoundEvent = procedure (Sender : TObject; filedata: PLMDSPFileRecord) of object;

  { ******************* TLMDSearchFileGrep ************************************}
  TLMDSearchFileGrep = class(TLMDSearchBaseDlgComponent)
  private
    FFileMasks     : String;
    FDirs          : String;
    FSizeMin       : Int64;
    FSizeMax       : Int64;
    FAttr          : TLMDSPFileAttributes;
    FCreatedMin    : TLMDDateTime;
    FCreatedMax    : TLMDDateTime;
    FAccessedMin   : TLMDDateTime;
    FAccessedMax   : TLMDDateTime;
    FModifiedMin   : TLMDDateTime;
    FModifiedMax   : TLMDDateTime;
    FFound         : TStrings;
    FCreateFoundList: Boolean;
    FCancelling    : Boolean;
    FRecurseSubDirs: Boolean;
    FThreaded      : Boolean;
    FThreadPriority: TThreadPriority;
    FOnEnd         : TNotifyEvent;
    FOnCancel      : TNotifyEvent;
    FOnFinished    : TNotifyEvent;
    FOnFound       : TLMDSPOnFoundEvent;
    FReturnVals    : TLMDSPResults;
    FLookFor       : TLMDSPCheckDates;
    FSrchThread    : TLMDSSearchThread;
    FOnDirChanged  : TLMDSPOnFileChangeEvent;
    FOnFileChanged : TLMDSPOnFileChangeEvent;
    FOnErrorOpenFile:TLMDSPOnFileChangeEvent;
    FRefine: TLMDRefine;
    //CONDEV 20040612
    FPauseMutex: TLMDMutex;
    FOnTemplateInvalid : TNotifyEvent;
    FTemplateValid : Boolean;
    FPaused: Boolean;
    procedure SetDateTime (index : Integer;aValue : TLMDDateTime);
    procedure SetThreadPriority (aValue : TThreadPriority);
    procedure SetPaused(const Value: Boolean);
  protected
    procedure SetTemplate(const Value: TLMDSearchTemplate);override;
    function GetTemplate:TLMDSearchTemplate;override;
    procedure GetChange(Sender: TObject);override;
    function GetCheckDate (Index:TLMDSPCheckDate) : TDateTime;
    function getAttr : Word;
    procedure GrepFiles (const StartDir, FileMasks : String;
                        RecurseSubDir : Boolean;
                        MinSize, MaxSize : int64;
                        MinCreateDate, MaxCreateDate,
                        MinLastAccessDate, MaxLastAccessDate,
                        MinLastWriteDate, MaxLastWriteDate : TDateTime;
                        Attr : Word; Refine: TLMDRefine;
                        ContentSearchOptions: TLMDSearchOptions; content:String;
                        OnError:TLMDSPOnFileChangeEvent=nil);
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

    procedure Execute;
    procedure Cancel;
    function ShowBuilderDialog(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;
    property FileNames : TStrings read FFound;
    //CONDEV 20040612
    property TemplateValid : Boolean read FTemplateValid;
    property Paused: Boolean read FPaused write SetPaused;
  published
    property About;

    property InternalFoundList: Boolean read FCreateFoundList write FCreateFoundList default true;
    property ResultValues : TLMDSPResults read FReturnVals write FReturnVals default [srsDir, srsFileName];

    property AccessedAfter : TLMDDateTime index 2 read FAccessedMin write SetDateTime;
    property AccessedBefore : TLMDDateTime index 3 read FAccessedMax write SetDateTime;
    property Attributes : TLMDSPFileAttributes read FAttr write FAttr default [fmAnyFile];
    property CheckDates : TLMDSPCheckDates read FLookFor write FLookFor default [];

    property CreatedAfter : TLMDDateTime index 0 read FCreatedMin write SetDateTime;
    property CreatedBefore : TLMDDateTime index 1 read FCreatedMax write SetDateTime;
    property Dirs : String read FDirs write FDirs;
    property FileMasks : String read FFileMasks write FFileMasks;
    property MinSize : Int64 read FSizeMin write FSizeMin default 0;
    property MaxSize : Int64 read FSizeMax write FSizeMax default 0;
    property ModifiedAfter : TLMDDateTime index 4 read FModifiedMin write SetDateTime;
    property ModifiedBefore : TLMDDateTime index 5 read FModifiedMax write SetDateTime;

    property ThreadedSearch : Boolean read FThreaded write FThreaded default true;
    property ThreadPriority : TThreadPriority read FThreadPriority write SetThreadPriority default tpNormal;
    property RecurseSubDirs : Boolean read FRecurseSubDirs write FRecurseSubDirs default true;

    //CONDEV 20040612
    property OnTemplateInvalid : TNotifyEvent read FOnTemplateInvalid write FOnTemplateInvalid;

    property OnFinished : TNotifyEvent read FOnFinished write FOnFinished;
    property OnCancel : TNotifyEvent read FOnCancel write FOnCancel;
    property OnFound : TLMDSPOnFoundEvent read FOnFound write FOnFound;
    property OnDirChange : TLMDSPOnFileChangeEvent read FOnDirChanged write FOnDirChanged;
    property OnEnd : TNotifyEvent read FOnEnd write FOnEnd;
    property OnFileChange : TLMDSPOnFileChangeEvent read FOnFileChanged write FOnFileChanged;
    property OnErrorOpenFile:TLMDSPOnFileChangeEvent read FOnErrorOpenFile write FOnErrorOpenFile;

    // derived
    property SearchOptions;
    property SearchString;
    property DlgBuilderOptions;
    property OnDlgHelpClick;
    property OnDlgCustomize;
  end;

implementation

uses
  SysUtils, Dialogs, FileCtrl, Windows,
  LMDBaseRefine, LMDSearchConsts, LMDStrSupp, LMDStrings;

{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

 type
  TThreadStringList = class(TStringList)
  protected
    FCriticalSection: TLMDCriticalSection;
  public
    procedure LockList;
    procedure UnlockList;
    constructor Create;
    destructor Destroy; override;
    function Add(const S: string): Integer; override;
    function IndexOf(const S: string): Integer; override;
  end;

{ *************************** class TLMDDateTime**************************** }
{ ----------------------------------- private -------------------------------- }
{rocedure TLMDSPDateTime.SetWord(Index:Integer; aValue : Word);
var
  t1,t2,t3, t4 : Word;
begin
  if index<3 then
    DecodeDate (FDateTime, t1, t2, t3)
  else
    DecodeTime (FDateTime, t1, t2, t3, t4);
  case index of
    0: if aValue <> t3 then
         FDateTime := Int(EncodeDate (t1, t2, aValue))+Frac(EncodeTime (Hour, Minute, Second,0));
    1: if aValue <> t2 then
         FDateTime := Int(EncodeDate (t1, aValue, t3))+Frac(EncodeTime (Hour, Minute, Second,0));
    2: if aValue <> t1 then
         FDateTime := Int(EncodeDate (aValue, t2, t3))+Frac(EncodeTime (Hour, Minute, Second,0));
    3: if aValue <> t1 then
         FDateTime := Int(FDateTime)+Frac(EncodeTime (aValue, t2, t3, t4));
    4: if aValue <> t2 then
         FDateTime := Int(FDateTime)+Frac(EncodeTime (t1, aValue, t3, t4));
    5: if aValue <> t3 then
         FDateTime := Int(FDateTime)+Frac(EncodeTime (t1, t2, aValue, t4));
   end;
end;

{ ---------------------------------------------------------------------------- }
{rocedure TLMDSPDateTime.SetDateTime (aValue : TDateTime);
begin
  if aValue <> FDateTime then
    FDateTime := aValue;
end;

{ ---------------------------------------------------------------------------- }
{rocedure TLMDSPDateTime.SetDate(aValue : TDateTime);
begin
  ReplaceDate(FDateTime, aValue);
end;

{ ---------------------------------------------------------------------------- }
{rocedure TLMDSPDateTime.SetTime(aValue : TDateTime);
begin
  ReplaceTime(FDateTime, aValue);
end;

{ ---------------------------------------------------------------------------- }
{unction TLMDSPDateTime.GetWord(index:Integer):Word;
var
  t1, t2, t3, t4 : Word;
begin
  if Index<3 then
    DecodeDate (FDateTime, t1, t2, t3)
  else
    DecodeTime (FDateTime,  t1, t2, t3, t4);

  case index of
    2, 3: result:=t1;
    1, 4: result:=t2;
    0, 5: result:=t3;
  else
    result:=0;
  end;
end;

{ ------------------------------------ public -------------------------------- }
{rocedure TLMDSPDateTime.Assign (Source : TPersistent);
begin
  if Source is TLMDSPDateTime then
    begin
      FDateTime := TLMDSPDateTime (Source).DateTimeValue;
    end
  else
    inherited Assign (Source);
end;

{ ---------------------------------------------------------------------------- }
{onstructor TLMDSPDateTime.Create;
begin
  inherited Create;
  FDateTime := EncodeDate (1990, 1, 1);
end;



{ ---------------------------------------------------------------------------- }
procedure TLMDSSearchThread.StartGrep;
begin
  with FOwner do
    GrepFiles (Dirs, FileMasks, RecurseSubDirs, MinSize, MaxSize,
                GetCheckDate(scdCreateAfter), GetCheckDate(scdCreateBefore),
                GetCheckDate(scdAccessedAfter), GetCheckDate(scdAccessedBefore),
                GetCheckDate(scdModifiedAfter), GetCheckDate(scdModifiedBefore),
                getAttr, FRefine, SearchOptions, SearchString, FOnErrorOpenFile);
end;

{ ----------------------------- protected ------------------------------------ }
procedure TLMDSSearchThread.SAddF;
begin
  FOwner.FFound.Add(FToBeAdded)
end;

{ ------------------------------- public ------------------------------------- }
procedure TLMDSSearchThread.Execute;
begin
  StartGrep();
  //Synchronize(StartGrep);
  //Synchroize needed here because of properties of grep component
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDSSearchThread.Create(aOwner: TLMDSearchFileGrep;
 CreateSuspended: Boolean);
begin
  inherited Create (CreateSuspended);
  FOwner := aOwner;
  FreeOnTerminate:=True;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSSearchThread.Destroy;
begin
  FOwner := nil;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSSearchThread.SyncAddFound (const s: String);
begin
  FToBeAdded := s;
  Synchronize(SAddF);
end;

{ ------------------------------------ private ------------------------------- }
procedure TLMDSearchFileGrep.SetDateTime(index: Integer; aValue: TLMDDateTime);
begin
  case index of
    0: FCreatedMin.Assign(aValue);
    1: FCreatedMax.Assign(aValue);
    2: FAccessedMin.Assign(aValue);
    3: FAccessedMin.Assign(aValue);
    4: FModifiedMin.Assign(aValue);
    5: FModifiedMax.Assign(aValue);
  end;
end;

procedure TLMDSearchFileGrep.SetPaused(const Value: Boolean);
begin
  if (FPaused <> Value) then
  begin
    FPaused := Value;
    if FPaused then
      FPauseMutex.GraspIt
    else
      FPauseMutex.ReleaseIt;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSearchFileGrep.SetThreadPriority (aValue : TThreadPriority);
begin
  if aValue <> FThreadPriority then
    begin
      FThreadPriority := aValue;
      if FSrchThread <> nil then
        FSrchThread.Priority := aValue;
    end;
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDSearchFileGrep.GetChange(Sender: TObject);
begin
  FRefine.NearestLength := SearchOptions.NearestLength;
  FRefine.WholeWordsOnly := SearchOptions.WholeWordsOnly;
  FRefine.MatchCase := SearchOptions.MatchCase;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSearchFileGrep.SetTemplate(const Value: TLMDSearchTemplate);
begin
  if Value <> FRefine.Template then
    begin
      FTemplateValid:=FRefine.ParseTemplate(Value);
      if FTemplateValid then
        FRefine.Template := Value
      else
        begin
          if Assigned (FOnTemplateInvalid) then
            FOnTemplateInvalid(self)
          else
            MessageDlg(LMDSP_InvalidTemplate, mtError, [mbYes], 0);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSearchFileGrep.GetTemplate: TLMDSearchTemplate;
begin
  result:=FRefine.Template;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSearchFileGrep.GetCheckDate(Index: TLMDSPCheckDate): TDateTime;
begin
  result := 0;
  if Index in FLookFor then
    case Index of
      scdCreateAfter: result := CreatedAfter.DateTimeValue;
      scdCreateBefore: result := CreatedBefore.DateTimeValue;
      scdAccessedAfter: result := AccessedAfter.DateTimeValue;
      scdAccessedBefore: result := AccessedBefore.DateTimeValue;
      scdModifiedAfter: result := ModifiedAfter.DateTimeValue;
      scdModifiedBefore: result := ModifiedBefore.DateTimeValue;
    end
end;

{ ---------------------------------------------------------------------------- }
function TLMDSearchFileGrep.getAttr : Word;
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
procedure TLMDSearchFileGrep.GrepFiles (const StartDir, FileMasks : String;
                                         RecurseSubDir : Boolean;
                                         MinSize, MaxSize : int64;
                                         MinCreateDate, MaxCreateDate,
                                         MinLastAccessDate, MaxLastAccessDate,
                                         MinLastWriteDate, MaxLastWriteDate : TDateTime;
                                         Attr : Word; Refine: TLMDRefine;
                                         ContentSearchOptions: TLMDSearchOptions; content: String;
                                         OnError: TLMDSPOnFileChangeEvent = nil);

var
  SilentSearch: Boolean;

  procedure CheckPaused;
  begin
    if SilentSearch then
    begin
      FPauseMutex.WaitFor(INFINITE);
      FPauseMutex.ReleaseIt;
    end
    else
      while (FPaused) and (not Application.Terminated) do
        Application.ProcessMessages;
  end;

  function CheckTerminated:Boolean;
  begin
     // TODO: Check this
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

   function FileDateTimeToStr(ft : TFileTime) : String;
   begin
     DateTimeToString (result, {$IFDEF LMDCOMP17}FormatSettings.{$ENDIF}longdateformat, FileTimeToDateTime(ft));
   end;

   function CheckContent(const s : String) : Boolean;
   var
     FS: TFileStream;
     Detail: TLMDRefineDetail;
   begin
     //assumption: this file won't match
     result := false;
     if s = '' then exit;
     if Refine.ParseTemplate(content) then
       try
         FS := TFileStream.Create(s, fmOpenRead or fmShareDenyWrite);
         // DONE: Check
         try
           Result := Refine.SearchTemplateInStream(FS, Detail);
         finally
           FreeAndNil(FS);
         end;
       except
         On Exception do
           if Assigned(OnError) then OnError(self, s);
        end;
   end;

   procedure Initdata(var Data: PLMDSPFileRecord);
   begin
     Data.Directory:='';
     Data.FileName:='';
     Data.Attributes:=[];
     Data.AttributeString:='';
     Data.FileSize:=0;
     Data.CreateDate:=0;
     Data.LastAccess:=0;
     Data.LastModified:=0;
   end;

   procedure SearchDir (const sDir : String; SearchMasks: TStrings;
                        var Data: PLMDSPFileRecord);
   var
     sr       : TSearchRec;
     tmpint, ls       : Int64;
     stime: SYSTEMTIME;

//     c,
     j        : Integer;
     acc      : Boolean;
     SecAttr  : TSECURITYATTRIBUTES;   // needed for open file
     DosError : Integer;
     ssDir, S : string;
  begin
    ssDir := LMDAnsiSlashAdd(sDir);

//    if  not SilentSearch  then
//    //let the application handle some urgent messages
//      Sleep(0)
    if Assigned(FSrchThread) then
      Sleep(0)
    else
      Application.ProcessMessages;
    //generate on dir changed event
    if Assigned (FOnDirChanged) then
      FOnDirChanged (self, ssDir);

    //search directoy for all masks (i = number of filemasks to look for)
    for j := 0 to SearchMasks.Count - 1 do
      begin
        //find first file in the directory
        DosError := FindFirst(ssDir + SearchMasks[j], {faAnyFile} Attr, sr);

        if DosError = 0  then
        try
          //while there are files in the directory
          while DosError = 0 do
            begin
              CheckPaused;
              if CheckTerminated then
                break;

              //we have found a file which we will examine now (whether it fits in our search criterias or not)
              if Assigned (FOnFileChanged) then FOnFileChanged (self, sr.Name);
              //let's assume taht it fits (acc = true)
              acc := true;

              //let's check file size
              tmpint := sr.FindData.nFileSizeHigh*MAXDWORD; //VB July 2008
              ls := sr.FindData.nFileSizeLow + tmpint;      //VB July 2008
              if MinSize > ls then   //vb
                acc := false;
              if (MaxSize <> 0) and (ls > MaxSize) then //vb
                acc := false;

              //one of the two entries exisitng in each directory ('self' and 'up')?
              if Acc and (sr.name = '.') or (sr.name = '..') then
                acc := false;

              //check the file attributes
              if Acc and (Attr and faAnyFile <> faAnyFile) then
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
                  FileTimeToLocalFileTime(sr.FindData.ftCreationTime, sr.FindData.ftCreationTime);
                  if (scdCreateBefore in self.FLookFor) and (MaxCreateDate > 0) and
                      (CompareFTWithDT (sr.FindData.ftCreationTime, MaxCreateDate) > 0) then
                    acc := false; //date is younger as the last accepted date
                  if (scdCreateAfter in self.FLookFor) and (MinCreateDate > 0) and
                      (CompareFTWithDT (sr.FindData.ftCreationTime, MinCreateDate) < 0) then
                    acc := false; //date is older as the last accepted date

                  //check access time
                  FileTimeToLocalFileTime (sr.FindData.ftLastAccessTime, sr.FindData.ftLastAccessTime);
                  if (scdAccessedBefore in self.FLookFor) and (MaxLastAccessDate > 0) and
                      (CompareFTWithDT (sr.FindData.ftLastAccessTime, MaxLastAccessDate) > 0) then
                    acc := false; //date is younger as the last accepted date
                  if (scdAccessedAfter in self.FLookFor) and (MinLastAccessDate > 0) and
                      (CompareFTWithDT (sr.FindData.ftLastAccessTime, MinLastAccessDate) < 0) then
                    acc := false; //date is older as the last accepted date

                  //check modification time
                  FileTimeToLocalFileTime (sr.FindData.ftLastWriteTime, sr.FindData.ftLastWriteTime);
                  if (scdModifiedBefore in self.FLookFor) and (MaxLastWriteDate > 0) and
                      (CompareFTWithDT (sr.FindData.ftLastWriteTime, MaxLastWriteDate) > 0) then
                    acc := false; //date is younger as the last accepted date
                  if (scdModifiedAfter in self.FLookFor) and (MinLastWriteDate > 0) and
                      (CompareFTWithDT (sr.FindData.ftLastWriteTime, MinLastWriteDate) < 0) then
                    acc := false; //date is older as the last accepted date
                end;

              //check whether current file is a directory -> we should not try to check it for
              //the content
              if (acc) and (sr.Attr and faDirectory = faDirectory) and (content <> '') then
                acc := false;
              //if acc=true and we have to look up the file for a special content let's do it
              //!!this is the last test, because is the most time expensive one!!
              if (acc) and (content<>'') and (not CheckContent(ssDir + sr.name)) then
                acc := false;

              //acc = true means now that we have found a file -> let's build up the output string
              if acc then
                begin
                  Initdata(Data);
                  s := '';
                  if srsDir in FReturnVals then
                    data.Directory:=ssDir;
                  if srsFilename in FReturnVals then
                    data.FileName:=sr.name;
                  if srsSize in FReturnVals then
                    data.FileSize:=ls;
                  if srsCreateDate in FReturnVals then
                    begin
                      FileTimeToSystemTime(sr.FindData.ftCreationTime, stime);
                      data.CreateDate :=SystemTimeToDateTime(stime);
                    end;
                  if srsLastAccessDate in FReturnVals then
                    begin
                      FileTimeToSystemTime(sr.FindData.ftLastAccessTime, stime);
                      data.LastAccess :=SystemTimeToDateTime(stime);
                    end;
                  if srsLastModifiedDate in FReturnVals then
                    begin
                      FileTimeToSystemTime(sr.FindData.ftLastWriteTime, stime);
                      data.LastModified :=SystemTimeToDateTime(stime);
                    end;
                  if srsAttr in FReturnVals then
                    begin

                      s:='';
                      if faReadOnly and sr.Attr = faReadOnly then
                        begin
                          s := s + 'r';
                          Include(data.Attributes, fmReadOnly);
                        end;
                      if faArchive and sr.Attr = faArchive then
                        begin
                          s := s + 'a';
                          Include(data.Attributes, fmArchive);
                        end;
                      if faSysFile and sr.Attr = faSysFile then
                        begin
                          s := s + 's';
                          Include(data.Attributes, fmSystem);
                        end;
                      if faVolumeId and sr.Attr = faVolumeId then
                        s := s + 'v';
                      if faDirectory and sr.Attr = faDirectory then
                        s := s + 'd';
                      if faHidden and sr.Attr = faHidden then
                        begin
                          s := s + 'h';
                          Include(data.Attributes, fmHidden);
                        end;
                    end;
                  //add to internal found list
                  // rewrite from Syncronize to TThreadStringList - thread safe string list 
                  if FCreateFoundList and (FFound.IndexOf(ssDir + sr.name) < 0) then
                      FFound.Add(ssDir + sr.name);
                  if Assigned(FOnFound) then
                     FOnFound(self, data);

                end;
              //find next file and jump back to start of while loop
              DosError := FindNext (sr);
            end;
        finally
          SysUtils.FindClose(sr);
        end;
      end;

    CheckPaused;
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
                  ((sr.Attr and faDirectory) = faDirectory) then
                  //recurse this procedure with the new found directory
                  SearchDir(ssDir + sr.name, SearchMasks, Data);

                CheckPaused;
                if CheckTerminated then //has the thread terminated?
                  break;
                //search next directory
                DosError := FindNext (sr);
              end;
           finally
             //close the directory search
             SysUtils.FindClose(sr);
           end;
      end;
   end;

var
  k: integer;
  S: string;
  sFileMasks, sStartDir: string;
  SearchMasks : TStrings;
  Data        : PLMDSPFileRecord;
begin
  if not Refine.MatchCase then
    content := LMDAnsiUpperCase(content);

  sStartDir := StartDir;
  sFileMasks := FileMasks;
  SearchMasks := TStringList.Create;
  if  sFileMasks = '' then
    sFileMasks := '*.*';

   New(Data);
   FillChar(Data^, sizeof(data), 0);

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

    SilentSearch := (GetCurrentThreadID <> MainThreadID);

    //scan more than one directory -> delimited by ;
    k := Pos(FileMaskDelimiter, sStartDir);
    while k <> 0 do
      begin
        S := Trim(Copy(sStartDir, 1, k - 1));

        CheckPaused;
        if (S <> '') and ((not CheckTerminated) or (FSrchThread = nil)) then
          SearchDir (S, SearchMasks, Data);
        sStartDir := Trim(Copy(sStartDir, k + 1, MAXINT));
        k := Pos(FileMaskDelimiter, sStartDir);
      end;
    //scan last directory (if there had been more than one dir to be scanned)
    //or the first - and only - directory
    CheckPaused;
    if (sStartDir <> '') and ((not CheckTerminated) or (FSrchThread = nil)) then
      SearchDir (sStartDir, SearchMasks, Data);
  finally
    SearchMasks.Free;
    Dispose(Data);
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
constructor TLMDSearchFileGrep.Create(aOwner : TComponent);
begin
  inherited Create (aOwner);
  FThreaded := true;
  FRecurseSubDirs := true;
  FThreadPriority:=tpNormal;
  FSizeMin := 0;
  FSizeMax := 0;
  FAttr := [fmAnyFile];
  FReturnVals := [srsDir, srsFileName];
  FLookFor := [];
  FSrchThread := nil;
  FFound := TThreadStringList.Create;
  TStringList(FFound).Duplicates := dupIgnore;

  FCancelling :=false;
  FCreateFoundList := true;
  FPauseMutex := TLMDMutex.Create(False);

  FRefine := TLMDRefine.Create(self);

  FCreatedMin := TLMDDateTime.Create;
  FCreatedMax := TLMDDateTime.Create;
  FAccessedMin := TLMDDateTime.Create;
  FAccessedMax := TLMDDateTime.Create;
  FModifiedMin := TLMDDateTime.Create;
  FModifiedMax := TLMDDateTime.Create;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDSearchFileGrep.Destroy;
begin
  Cancel;
  FreeAndNil(FModifiedMax);
  FreeAndNil(FModifiedMin);
  FreeAndNil(FAccessedMax);
  FreeAndNil(FAccessedMin);
  FreeAndNil(FCreatedMax);
  FreeAndNil(FCreatedMin);
  FreeAndNil(FPauseMutex);
  FreeAndNil(FFound);
  FreeAndNil(FRefine);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSearchFileGrep.Execute;
begin
  if FSrchThread <> nil then exit;
  //if there is already one thread running destroy it
  //Cancel;
  //clear previous found
  FFound.Clear;
  if FThreaded then
    begin
      FSrchThread := TLMDSSearchThread.Create (self, false);
      FSrchThread.Priority := FThreadPriority;
    end
  else
    GrepFiles (Dirs, FileMasks, RecurseSubDirs, MinSize, MaxSize,
             GetCheckDate(scdCreateAfter), GetCheckDate(scdCreateBefore),
             GetCheckDate(scdAccessedAfter), GetCheckDate(scdAccessedBefore),
             GetCheckDate(scdModifiedAfter), GetCheckDate(scdModifiedBefore),
             getAttr, FRefine, SearchOptions, SearchString, FOnErrorOpenFile);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSearchFileGrep.Cancel;
begin
  FCancelling := true;
  //stop currently running thread and destroy it
  if FSrchThread <> nil then
    FSrchThread.Terminate;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSearchFileGrep.ShowBuilderDialog(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;
begin
  Result:=False;

  FRefine.NearestLength := SearchOptions.NearestLength;
  FRefine.WholeWordsOnly := SearchOptions.WholeWordsOnly;
  FRefine.MatchCase := SearchOptions.MatchCase;

  FRefine.DlgBuilderOptions:=self.DlgBuilderOptions;
  FRefine.OnDlgCustomIze:=self.OnDlgCustomize;
  FRefine.OnDlgHelpClick:=self.OnDlgHelpClick;

  if FRefine.ShowDialog(AOwner, X,Y) then
    // update settings only when user clicked on OK
    begin
      Result:=true;
      SearchOptions.BeginUpdate;
      SearchOptions.NearestLength:=FRefine.NearestLength;
      SearchOptions.WholeWordsOnly:=FRefine.WholeWordsOnly;
      SearchOptions.MatchCase:=FRefine.MatchCase;
      SearchOptions.EndUpdate;
    end;
end;

{ TThreadStringList }

function TThreadStringList.Add(const S: string): Integer;
begin
  LockList;
  try
    Result := inherited Add(S);
  finally
    UnlockList;
  end;
end;

constructor TThreadStringList.Create;
begin
  FCriticalSection := TLMDCriticalSection.Create;
end;

destructor TThreadStringList.Destroy;
begin
  FreeAndNil(FCriticalSection);
  inherited;
end;

function TThreadStringList.IndexOf(const S: string): Integer;
begin
  LockList;
  try
    Result := inherited IndexOf(S);
  finally
    UnlockList;
  end;
end;

procedure TThreadStringList.LockList;
begin
  FCriticalSection.Enter;
end;

procedure TThreadStringList.UnlockList;
begin
  FCriticalSection.Leave;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}

end.
