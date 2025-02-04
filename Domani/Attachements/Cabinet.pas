unit Cabinet;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,filectrl,cabstructs,masks;

const
 statusFile:integer=0;
 statusFolder:integer=1;
 statusCabinet:integer=2;
 WM_OnStatusChange:longword=WM_USER+1;
 WM_OnOpen:longword=WM_USER+2;
 WM_OnWrite:longword=WM_USER+3;
 WM_OnRead:longword=WM_USER+4;
 WM_OnSeek:longword=WM_USER+5;
 WM_OnClose:longword=WM_USER+6;
 WM_OnGetTempFile:longword=WM_USER+7;
 WM_OnPlaceFile:longword=WM_USER+8;
 WM_AfterCopyFile:longword=WM_USER+9;
 WM_OnEndProcess:longword=WM_USER+10;
 WM_OnBegProcess:longword=WM_USER+11;
 
 function fci_fileplaced(pccab:PFCICabInfo;pszfile:pchar;cbfile:integer;fContinuation:integer;pv:pointer):integer;cdecl;
 function mem_alloc(cb:integer):pointer;cdecl;
 function mem_free(memory:pointer):pointer;cdecl;
 function fci_open(pszFile:pchar;oflag:integer;pmode:integer;err:PInteger;pv:pointer):integer;cdecl;
 function fci_read(hf:integer;memory:pointer;cb:integer;err:pinteger;pv:pointer):integer;cdecl;
 function fci_write(hf:integer;memory:pointer;cb:integer;err:pinteger;pv:pointer):integer;cdecl;
 function fci_close(hf:integer;err:pinteger;pv:pointer):integer;cdecl;
 function fci_seek(hf:integer;dist:integer;seektype:integer;err:pinteger;pv:pointer):integer;cdecl;
 function fci_delete(pszFile:pchar;err:pinteger;pv:pointer):integer;cdecl;
 function fci_getnextcab(pccab:PFCICabInfo;cbPrevCab:integer;pv:pointer):bool;cdecl;
 function fci_getopeninfo(pszName:pchar;pdate:pword;ptime:pword;pattribs:pword;err:pinteger;pv:pointer):integer;cdecl;
 function fci_getstatus(typeStatus:integer;cb1:longword;cb2:longword;pv:pointer):integer;cdecl;
 function fci_gettempfile(pszTempName:pchar;cbTempName:integer;pv:pointer):bool;cdecl;
 function fdi_open(pszFile:PChar;oflag:Integer;pmode:Integer):Integer; cdecl;
 function fdi_read(hf: Integer; memory : pointer; cb : longword):integer ; cdecl;
 function fdi_write(hf: Integer; memory : pointer; cb : longword):integer; cdecl;
 function fdi_close(hf: Integer): Integer; cdecl;
 function fdi_seek(hf : Integer; dist : Longint; seektype : Integer):Longint; cdecl;
 function fdi_notify(fdint : TFDINOTIFICATIONTYPE;pfdin:PFDINOTIFICATION):Integer; cdecl;

 type
  TCompressionType=(ctNone,ctMsZip,ctQuantum,ctLzx);
  TLzxLevel= 15..21;
  TQuantumLevel=1..7;
  TQuantumMemory=10..21;
  TCompParams = record
   Compression : TCompressionType;
   LzxLevel:TLzxLevel;
   QuantumLevel:TQuantumLevel;
   QuantumMemory:TQuantumMemory;
  end;

  TPostInfo=record
   sender:pointer;
   hf:integer;
   cb:integer;
   fname:string;
   seektype:integer;
  end;
  PPostInfo=^TPostInfo;

 TFileInfo=packed record
  filedata:TSearchRec;
  fexecute:integer;
  fpathname:string;
  fstoredpathname:string;
  fwildcard:string;
 end;
 PFileInfo=^TFileInfo;

 TCabCompressor = class;
 TCabDecompressor = class;
 TCabStream=class;

 TOnPlaceFile=procedure(FileName:string) of object;
 TOnOpenfile=procedure(FileName:string;filehandle:integer;mode:Word)of object;
 TOnreadfile=procedure(FileName:string;filehandle:integer;bytesread:integer)of object;
 TOnseekfile=procedure(FileName:string;filehandle:integer;distance:integer;seektype:integer)of object;
 TOnwritefile=procedure(FileName:string;filehandle:integer;byteswritten:integer)of object;
 TOnGetTempfile=procedure(FileName:string)of object;
 TOnClosefile=procedure(FileName:string;fhandle:integer)of object;
 TOnDeleteFile=procedure(FileName:string)of object;
 TOnGetNextCab=procedure(var CabinetName,DiskName:string)of object;
 TOnSetNextCab=procedure(var CabinetName:string) of object;
 TOnstatusChange=procedure(bytesprocessed:integer;totalbytes:integer)of object;
 TBeforeCopyFile=procedure(var Filename:string;overwrite:boolean)of object ;
 TAfterCopyFile=procedure(Filename:string;execute:boolean)of object;
 TOnBeginProcess=procedure of object;
 TOnEndProcess=procedure of object;
 ECabError=class(Exception);

 TCompressorBase=class(TComponent);

 TThreadInfo=record
  threadid:integer;
  fcompressorbase:TCompressorBase;
 end;
 PThreadInfo=^TThreadInfo;

 TFileList=class(Tlist)
  public
   procedure Clear;override;
  end;

 TCompressionParameters=class
  private
   fcompParams:TCompParams;
   fcabcompressor:tCabCompressor;
   function GetCompType:TCompressionType;
   procedure SetCompType(Atype:TCompressionType);
   function GetLzxLevel:TLzxLevel;
   procedure SetLzxLevel(ALevel:TLzxLevel);
   function GetQuantumLevel:TQuantumLevel;
   procedure SetQuantumLevel(Alevel:TQuantumLevel);
   function GetQuantumMemory:TQuantumMemory;
   procedure SetQuantumMemory(AQuantumMemory:TQuantumMemory);
  public
   constructor Create(ACabCompressor:TCabCompressor);
   property CompressionType:TCompressionType read GetCompType write SetCompType;
   property LzxLevel:TLzxLevel read GetLzxLevel write SetLzxLevel;
   property QuantumLevel:TQuantumLevel read GetQuantumLevel write SetQuantumLevel;
   property QuantumMemory:TQuantumMemory read GetQuantumMemory write SetQuantumMemory;
  end;

 TFileData=class
 private
  fname:string;
  fowner:TCabDecompressor;
  fdate:longword;
  ftime:longword;
  fsize:longword;
  fselected:boolean;
  function GetDate:string;
  function GetTime:string;
  procedure SetSelected(aselect:boolean);
 public
  constructor create(aowner:TcabDecompressor);
  property Name:string read fname;
  property Date:string read GetDate;
  property Time:string read GetTime;
  property Size:longword read fsize;
  property Select:boolean read fselected write SetSelected;
 end;

 TCustomFileStream=class(TFilestream)
  public
   FileName:string;
   constructor Create(const FileName:string;mode:Word);
  end;

 TCabStream=class
  private
   ffilelist:Tlist;
   function GetStreamFromHandle(ahandle:integer):TCustomfilestream;
   procedure clear;
  public
   constructor create;
   destructor destroy;override;
   function AddFile(fname:string;mode:Word;pasmode:pword):integer;
   procedure CloseFile(ahandle:integer);
   property files[ahandle:integer]:TCustomFilestream read getstreamfromhandle;
  end;

 TCompressionThread=class(TThread)
  private
   fcabcompressor:tcabcompressor;
   procedure Compress;
  protected
   procedure execute;override;
  public
   constructor Create(acabcompressor:TCabCompressor;CreateSuspended:boolean);
  end;

 TDecompressionThread=class(TThread)
  private
   fcabdecompressor:TCabDecompressor;
   procedure Decompress;
  protected
   procedure execute;override;
  public
   constructor Create(acabdecompressor:TCabDecompressor;CreateSuspended:boolean);
  end;

 TCabDecompressor=class(TCompressorBase)
  private
   fdihandle:HFDI;
   fwinhandle:Thandle;
   fdefaulthandler:TWndMethod;
   fcabstream:Tcabstream;
   fcabname:string;
   fcabpath:string;
   ftargetpath:string;
   fnames:Tlist;
   fabort:boolean;
   fprocessing:boolean;
   funcompressed:longword;
   ftotalbytes:longword;
   fdecompthread:TDecompressionThread;
   ferf:terf;
   ffdicabinfo:TFDICabInfo;
   fBeforeCopyFile:TBeforeCopyFile;
   fAfterCopyFile:TAfterCopyFile;
   fOnOpenfile:TOnOpenfile;
   fOnReadfile:TOnReadFile;
   fOnSeekfile:TOnSeekFile;
   fOnWritefile:TOnWriteFile;
   fOnClosefile:TOnClosefile;
   fOnStatusChange:TOnstatusChange;
   fOnSetNextCab:TOnSetNextCab;
   fOnBegProcess:TOnBeginProcess;
   fOnEndProcess:TOnEndProcess;
  protected
   procedure Loaded; override;
   procedure MessageHandler(var msg:TMessage);
   procedure InitializeVariables;
   procedure InitializeDecompressor;
   procedure FinalizeDecompressor;
   procedure fDecompress;
   function GetCabName:string;
   function GetFileCount:integer;
   function GetFileItem(index:integer):TFileData;
   procedure CheckCabAndLoadfiles(aname:string);
   procedure SetCabName(acabname:string);
   procedure SetTargetPath(apath:string);
   function IsFileChecked(aname:string):boolean;
  public
   constructor Create(aowner:TComponent);override;
   destructor Destroy;override;
   property CabPathName:string read GetCabName write SetCabName;
   property FileCount:integer read GetFileCount;
   property TargetPath:string read ftargetpath write SetTargetPath;
   property Processing:boolean read fprocessing;
   procedure SelectAllFiles;
   procedure SelectByWildCard(awildcard:string);
   procedure Decompress;
   procedure Abort;
   property Files[index:integer]:TFileData read GetFileItem;
  published
   property OnBeginDecompression:TOnBeginProcess read fOnBegProcess write fOnBegProcess;
   property OnEndDecompression:TOnEndProcess read fOnEndProcess write fOnEndProcess;
   property BeforeCopyFile:TBeforeCopyFile read fBeforeCopyFile write fBeforeCopyFile;
   property AfterCopyFile:TAfterCopyFile read fAfterCopyFile write fAfterCopyFile;
   property OnSetCabinetName:TOnSetNextCab read fOnSetNextCab write fOnSetNextCab;
   property OnReadFile:TOnReadFile read fOnReadFile write fOnReadfile;
   property OnOpenFile:TOnOpenFile read fOnOpenFile write fOnOpenFile;
   property OnWriteFile:TOnWriteFile read fOnWritefile write fOnWriteFile;
   property OnSeekFile:TOnSeekFile read fOnSeekFile write fOnSeekFile;
   property OnCloseFile:TOnCloseFile read fOnClosefile write fOnCloseFile;
   property OnStatusChange:TOnStatusChange read fOnStatusChange write fOnStatusChange;
  end;

 TCabCompressor = class(TCompressorBase)
  private
   fcabstream:Tcabstream;
   fcompthread:TCompressionthread;
   ffcicabinfo:Tfcicabinfo;
   fcihandle:HFCI;
   fdefaulthandler:TWndMethod;
   fwinhandle:Thandle;
   ferf:terf;
   fCompParams:TCompressionParameters;
   fcompressed:longword;
   ftotalbytes:longword;
   frecdir:boolean;
   fcabpathname:string;
   fcabname:string;
   fdiskname:string;
   fnames:tfilelist;
   fabort:boolean;
   fprocessing:boolean;
   fOnPlacefile:TOnPlaceFile;
   fOnOpenfile:TOnOpenfile;
   fOnreadfile:TOnreadfile;
   fOnseekfile:TOnseekfile;
   fOnwritefile:TOnwritefile;
   fOnGetTempfile:TOnGetTempfile;
   fOnClosefile:TOnClosefile;
   fOnDeleteFile:TOnDeleteFile;
   fOnstatusChange:TOnstatusChange;
   fOnGetNextCab:TOnGetNextCab;
   fOnBegProcess:TOnBeginProcess;
   fOnEndProcess:TOnEndProcess;
   function DeleteFile(afilename:string):integer;
   function GetCabsize:longword;
   procedure Setcabsize(asize:longword);
   function GetThresholdSize:longword;
   procedure SetThresholdsize(asize:Longword);
   function GetCabname:string;
   procedure SetCabname(aname:string);
   procedure SetDiskName(aname:string);
   procedure GetFileInfoFromName(aname:pchar;pdate:pword;ptime:pword;pattribs:pword);
   procedure GetFiles(fname:string;var apath:string;aexecute:boolean); 
   function GetRHS:longword;
   procedure SetRHS(asize:longword);
   function GetRFS:longword;
   procedure SetRFS(asize:longword);
   function GetRDS:longword;
   procedure SetRDS(asize:longword);
   procedure SetRecDir(arecdir:boolean);
  protected
   procedure InitializeVariables;
   procedure InitializeCompressor;
   procedure Loaded; override;
   procedure MessageHandler(var msg:Tmessage);
   procedure FinalizeCompressor(aabort:boolean=false);
   procedure Reset;
   procedure fCompress;
  public
   property CabPathName: string read GetCabname write SetCabname;
   property DiskName:string read fDiskName write SetDiskName;
   property Cabsize:longword read GetCabSize write SetCabsize;
   property CompressionParameters:TCompressionParameters read fcompparams;
   property ReserveHeaderSize:longword read GetRHS write SetRHS;
   property ReserveFolderSize:longword read GetRFS write SetRFS;
   property ReserveDataSize:longword read GetRDS write SetRDS;
   property ThresholdSize:Longword read getThresholdSize write setThresholdsize;
   property RecurseDirectories:boolean read frecdir write SetRecDir;
   property Processing:boolean read fprocessing;
   constructor Create(aowner:TComponent);override;
   function Addfile(aname:string;apath:string='';execute:boolean=false):boolean;
   function ClearFiles:boolean;
   procedure Abort;
   procedure Compress;
   destructor destroy;override;
  published
   property OnBeginCompression:TOnBeginProcess read fOnBegProcess write fOnBegProcess;
   property OnEndCompression:TOnEndProcess read fOnEndProcess write fOnEndProcess;
   property OnPlaceFile:TOnPlacefile read fonplacefile write fonplacefile;
   property OnOpenFile:TOnOpenfile read fOnOpenfile write fOnOpenfile;
   property OnReadFile:TOnreadfile read fOnreadfile write fOnreadfile;
   property OnSeekFile:TOnseekfile read fOnseekfile write fOnseekfile;
   property OnWriteFile:TOnwritefile read fOnwritefile write fOnwritefile;
   property OnGetTempFile:TOnGetTempfile read fOnGetTempfile write fOnGetTempfile;
   property OnCloseFile:TOnClosefile read fOnClosefile write fOnClosefile;
   property OnDeleteFile:TOnDeleteFile read fOnDeleteFile write fOnDeleteFile;
   property OnStatusChange:TOnstatusChange read fOnstatusChange write fOnstatusChange;
   property OnGetNextCab: TOnGetNextCab read fOnGetNextCab write fOnGetNextCab;
  end;

procedure Register;

implementation

var
 findex:longword;

constructor TCompressionThread.create(acabcompressor:TcabCompressor;Createsuspended:boolean);
begin
 if acabcompressor=nil then
  raise ECabError.Create('Invalid parameter');
 fcabcompressor:=acabcompressor;
 inherited create(CreateSuspended);
end;

constructor TDeCompressionThread.Create(acabdecompressor:TCabDecompressor;CreateSuspended:boolean);
begin
 if acabdecompressor=nil then
  raise ECabError.Create('Invalid parameter');
 fcabdecompressor:=acabdecompressor;
 inherited Create(CreateSuspended);
end;

constructor TCompressionParameters.Create(ACabCompressor:TCabCompressor);
begin
 if acabcompressor=nil then
  raise ECabError.Create('Invalid Parameter');
 fcabcompressor:=acabcompressor;
end;

function TCompressionParameters.GetCompType:TCompressionType;
begin
 result:=fcompParams.Compression;
end;

procedure TCompressionParameters.SetCompType(Atype:TCompressionType);
begin
 if not(fcabcompressor.processing) then
  fcompParams.Compression:=Atype;
end;

function TCompressionParameters.GetLzxLevel:TLzxLevel;
begin
 result:=fcompParams.LzxLevel;
end;

procedure TCompressionParameters.SetLzxLevel(ALevel:TLzxLevel);
begin
 if not(fcabcompressor.processing) then
  fcompParams.LzxLevel:=alevel;
end;

function TCompressionParameters.GetQuantumLevel:TQuantumLevel;
begin
  result:=fcompParams.QuantumLevel;
end;

procedure TCompressionParameters.SetQuantumLevel(Alevel:TQuantumLevel);
begin
 if not(fcabcompressor.processing) then
  fcompParams.QuantumLevel:=alevel;
end;

function TCompressionParameters.GetQuantumMemory:TQuantumMemory;
begin
 result:=fcompParams.QuantumMemory;
end;

procedure TCompressionParameters.SetQuantumMemory(AQuantumMemory:TQuantumMemory);
begin
 if not(fcabcompressor.processing) then
  fcompParams.QuantumMemory:=AQuantumMemory;
end;

constructor TFileData.create(aowner:TcabDecompressor);
begin
 if aowner=nil then
  raise ECabError.Create('Invalid Parameter');
 fowner:=aowner;
 fname:='';
 fdate:=0;
 ftime:=0;
end;

function TFileData.GetDate:string;
var
 systime:TSystemTime;
 asize:integer;
 tmp:string;
begin
 if fdate=0 then
  result:=DateToStr(sysutils.Date)
 else
  begin
   systime.wMilliseconds:=0;
   systime.wSecond:=0;
   systime.wMinute:=0;
   systime.wHour:=0;
   systime.wDay:=fdate and $1F;
   systime.wMonth:=(fdate shr 5) and $F;
   systime.wYear:=(fdate shr 9)+1980;
   asize:=Getdateformat(LOCALE_USER_DEFAULT,0,@systime,nil,nil,0);
   setlength(tmp,asize);
   setlength(result,asize-1);
   Getdateformat(LOCALE_USER_DEFAULT,0,@systime,nil,pchar(tmp),asize);
   strcopy(pchar(result),pchar(tmp));
  end;
end;

function TFileData.GetTime:string;
var
 systime:TSystemTime;
 asize:integer;
 tmp:string;
begin
 systime.wDay:=0;
 systime.wDayOfWeek:=0;
 systime.wYear:=0;
 systime.wMonth:=0;
 systime.wMilliseconds:=0;
 systime.wSecond:=(ftime and $1F)*2;
 systime.wMinute :=(ftime shr 5) and $3F;
 systime.wHour:=(ftime shr 11) and $1F;
 asize:=Gettimeformat(LOCALE_SYSTEM_DEFAULT,0,@systime,nil,nil,0);
 setlength(tmp,asize);
 setlength(result,asize-1);
 Gettimeformat(LOCALE_USER_DEFAULT,0,@systime,nil,pchar(tmp),asize);
 strcopy(pchar(result),pchar(tmp));
end;

procedure TFileData.SetSelected(aselect:boolean);
begin
 if (aselect=true) and (fselected=false) then
  fowner.ftotalbytes:=fowner.ftotalbytes+fsize
 else if (aselect=false) and (fselected=true) then
  fowner.ftotalbytes:=fowner.ftotalbytes-fsize;
 fselected:=aselect;
end;
procedure TCompressionThread.compress;
begin
 fcabcompressor.fCompress;
 terminate;
end;

procedure TCompressionThread.Execute;
begin
 freeonterminate:=false;
 if fcabcompressor.processing then
  exit;
 fcabcompressor.fprocessing:=true;
 compress;
end;

procedure TDecompressionThread.Execute;
begin
 freeonterminate:=false;
 if fcabdecompressor.fprocessing then
  exit;
 tlssetvalue(findex,fcabdecompressor);
 fcabdecompressor.fprocessing:=true;
 decompress;
end;

procedure TDecompressionThread.Decompress;
begin
 fcabdecompressor.fDecompress;
 terminate;
end;
constructor TCustomFileStream.Create(const FileName:string;mode:Word);
begin
 Self.FileName:=FileName;
 inherited Create(FileName,mode);
end;

constructor TCabStream.create;
begin
 inherited;
 ffilelist:=tlist.create;
end;

destructor TCabStream.destroy;
begin
 clear;
 ffilelist.free;
 inherited;
end;

function TCabStream.AddFile(fname:string;mode:Word;pasmode:pword):integer;
var
 tmpstream:TCustomFileStream;
 amode:word;
begin
 if (mode and _O_CREAT) <> 0 then
  aMode:=fmCreate
 else
  begin
   aMode:=0;
   if mode and _O_WRONLY <> 0 then
      aMode:=aMode or fmOpenWrite
    else
      aMode:=aMode or fmOpenRead;
    if mode and _O_EXCL <> 0 then
      aMode:=aMode or fmShareExclusive
    else
      aMode:=aMode or fmShareDenyNone;
  end;
 tmpstream:=TCustomfilestream.create(fname,amode);
 if tmpstream<>nil then
  begin
   ffilelist.Add(tmpstream);
   Result:=tmpstream.Handle;
  end
 else
  Result:=-1;
 if pasmode<>nil then
  pasmode^:=amode;
end;

procedure TCabStream.clear;
var
 i:integer;
 tmpstream:TCustomfilestream;
begin
 if Assigned(ffilelist) then
  begin
   for i:=0 to ffilelist.count-1 do
    begin
     tmpstream:=TCustomFilestream(ffilelist.items[i]);
     tmpstream.free;
    end;
  end;
end;
function TCabStream.GetStreamFromHandle(ahandle:integer):TCustomfilestream;
var
 i:integer;
 tmpstream:TCustomfilestream;
begin
 result:=nil;
 for i:=0 to ffilelist.count-1 do
  begin
   tmpstream:=tCustomfilestream(ffilelist.items[i]);
   if tmpstream.Handle=ahandle then
    begin
     result:=tmpstream;
     break;
    end;
  end;
end;

procedure TCabStream.CloseFile(ahandle:integer);
var
 tmpstream:TCustomFileStream;
begin
 tmpstream:=GetStreamFromHandle(ahandle);
 if tmpstream=nil then
  raise ECabError.create('File Handle not valid');
 ffilelist.Remove(tmpstream);
 tmpstream.free;
end;

constructor TCabDecompressor.Create(aowner:TComponent);
begin
 InitializeVariables;
 inherited;
end;

destructor TCabDeCompressor.Destroy;
var
 i:integer;
 tmpdata:TFileData;
begin
 abort;
 freeandnil(fcabstream);
 if assigned(fnames) then
  for i:=0 to fnames.count-1 do
   begin
    tmpdata:=TFileData(fnames[i]);
    freeandnil(tmpdata);
   end;
 freeandnil(fnames);
 inherited;
end;

procedure TCabDecompressor.Loaded;
begin
 fdefaulthandler:=(Owner as TWinControl).WindowProc;
 (Owner as TWinControl).WindowProc:=MessageHandler;
 fwinhandle:=(Owner as TWinControl).Handle;
 inherited;
end;

procedure TCabDecompressor.MessageHandler(var msg:TMessage);
var
 pinfo:PPostInfo;
 fstatus:boolean;
begin
 fstatus:=false;
 if (msg.Msg=WM_OnStatusChange) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnStatusChange) then
      fOnStatusChange(funcompressed,ftotalbytes);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnWrite) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnWritefile) then
      fOnWritefile(pinfo.fname,pinfo.hf,pinfo.cb);
     dispose(pinfo);
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnRead) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnReadfile) then
      fOnReadfile(pinfo.fname,pinfo.hf,pinfo.cb);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnSeek) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnSeekfile) then
      fOnSeekfile(pinfo.fname,pinfo.hf,pinfo.cb,pinfo.seektype);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnOpen) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnOpenfile) then
      fOnOpenfile(pinfo.fname,pinfo.hf,pinfo.cb);
      dispose(pinfo);
      msg.wparam:=0;
      fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnClose) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnClosefile) then
      fOnClosefile(pinfo.fname,pinfo.hf);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_AfterCopyFile) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fAfterCopyFile) then
      fAfterCopyFile(pinfo.fname,boolean(pinfo.cb));
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnBegProcess) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnBegProcess) then
      fOnBegProcess;
     dispose(pinfo);
    end;
  end
 else if (msg.Msg=WM_OnEndProcess) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnEndProcess) then
      fOnEndProcess;
     dispose(pinfo);
    end;
  end;

 if not fstatus then
  fdefaulthandler(msg);
end;

procedure TCabDecompressor.InitializeVariables;
begin
 fcabstream:=TCabStream.Create;
 funcompressed:=0;
 fnames:=Tlist.create;
 fabort:=false;
 fprocessing:=false;
 ftargetpath:='';
 fcabname:='';
 fcabpath:='';
 fdihandle:=nil;
 fdecompthread:=nil;
end;

procedure TCabDecompressor.SelectAllFiles;
var
 i:integer;
begin
 if processing then
  exit;
 for i:=0 to fnames.count-1 do
  TFileData(fnames.Items[i]).fselected:=true;
end;

procedure TCabDecompressor.SelectByWildCard(awildcard:string);
var
 i:integer;
begin
 if processing then
  exit;
 for i:=0 to fnames.count-1 do
  if matchesmask(TFileData(fnames.Items[i]).fname,awildcard) then
   TFileData(fnames.Items[i]).fselected:=true;
end;


procedure TCabDecompressor.Decompress;
begin
 if processing=false then
  fdecompthread:=TDecompressionthread.create(self,false);
end;

procedure TCabDeCompressor.Abort;
begin
 if processing=true then
  begin
   if assigned(fdecompthread) then
    begin
     fabort:=true;
     fdecompthread.terminate;
     fdecompthread.WaitFor;
     freeandnil(fdecompthread);
     fabort:=false;
     fprocessing:=false;
    end;
  end;
end;

function TCabDecompressor.IsFileChecked(aname:string):boolean;
var
 i:integer;
begin
 result:=false;
 for i:= 0 to fnames.Count-1 do
  begin
   with (TFileData(fnames.items[i])) do
    begin
     if (fname=aname) and (fselected=true) then
      begin
       result:=true;
       break;
      end;
    end;
  end;
end;

procedure TCabDecompressor.InitializeDecompressor;
var
 ahandle:integer;
 asuccess:boolean;
begin
 fdihandle:=Fdicreate(mem_alloc,
                      mem_free,
                      fdi_open,
                      fdi_read,
                      fdi_write,
                      fdi_close,
                      fdi_seek,
                      cpuUNKNOWN,
                      @ferf);
 if fdihandle=nil then
  raise ECabError.Create('Could Not Create FDI Context');
 ahandle:=fcabstream.AddFile(fcabpath+fcabname,_O_RDONLY,nil);
 asuccess:=FDIIsCabinet(fdihandle,ahandle,@ffdicabinfo);
 if asuccess=false then
  raise ECabError.Create('Not A Valid Cab Archive');
 fcabstream.CloseFile(ahandle);
end;

function TCabDecompressor.GetCabName:string;
begin
 result:=fcabpath+fcabname;
end;

function TCabDecompressor.GetFileCount:integer;
begin
 result:=fnames.Count;
end;
function TCabDecompressor.GetFileItem(index:integer):TFileData;
begin
 if(index<0) or (index>fnames.count-1) then
  raise ECabError.Create('Range Out of Bounds');
 result:= TFileData(fnames.items[index]);
end;

procedure TCabDecompressor.CheckCabAndLoadFiles(aname:string);
var
 h1,hmap,i:integer;
 bptr:pointer;
 gptr:pointer;
 CabHeader:PCabHeader;
 CabFileHeader:PCabFileHeader;
 tmplength:longword;
 name:pchar;
 fdata:TFileData;
begin
 fnames.clear;
 h1:=fileopen(aname,fmOpenRead or fmShareDenyNone);
 hmap:=CreateFileMapping(h1,nil,PAGE_READONLY,0,0,nil);
 bptr:=mapviewoffile(hmap,FILE_MAP_READ,0,0,0);
 CabHeader:=PCabHeader(bptr);
 if cabheader.signature<>'MSCF' then
  begin
   unmapviewoffile(bptr);
   closehandle(hmap);
   fileclose(h1);
   raise ECabError.create('Not a Valid Cab Archive');
  end;
 gptr:=pointer(cabheader.cfoffset+longword(bptr));
 for i:=0 to cabheader.filescount-1 do
  begin
   cabfileHeader:=PCabFileHeader(gptr);
   fdata:=TFileData.create(self);
   fdata.fdate:=cabfileheader.date;
   fdata.ftime:=cabfileheader.time;
   fdata.fsize:=cabfileheader.cbfilesize;
   name:=pchar(longword(gptr)+sizeof(TCabFileHeader));
   fdata.fname:=name;
   fnames.add(fdata);
   tmplength:=StrLen(name)+1;
   gptr:=pointer(longword(gptr)+sizeof(TCabFileHeader)+tmplength);
  end;
 unmapviewoffile(bptr);
 closehandle(hmap);
 fileclose(h1);
end;

procedure TCabDecompressor.SetCabName(acabname:string);
begin
 if fileexists(acabname)=false then
  raise ECabError.Create('Cab File not found');
 CheckCabAndLoadFiles(acabname);
 fcabname:=Extractfilename(acabname);
 fcabpath:=Extractfilepath(acabname);
end;

procedure TCabDecompressor.SetTargetPath(apath:string);
begin
 if directoryexists(apath)=false then
  raise ECabError.Create('Invalid path specification.');
 ftargetpath:=apath;
end;
procedure TCabDecompressor.FinalizeDecompressor;
begin
 fdidestroy(fdihandle);
 fdihandle:=nil;
end;

procedure TCabDecompressor.fDecompress;
var
 pinfo:Ppostinfo;
begin
 new(pinfo);
 pinfo.sender:=self;
 postmessage(fwinhandle,WM_OnBegProcess,longword(pinfo),0);
 InitializeDecompressor;
 FDICopy(fdihandle,pchar(fcabname),pchar(fcabpath),0,fdi_notify,nil,self);
 FinalizeDecompressor;
 fprocessing:=false;
 new(pinfo);
 pinfo.sender:=self;
 postmessage(fwinhandle,WM_OnEndProcess,longword(pinfo),0);
end;

function TCabCompressor.DeleteFile(afilename:string):integer;
var
 tmp:boolean;
begin
 tmp:=sysutils.deletefile(afilename);
 if tmp=true then
  Result:=0
 else
  Result:=-1;
end;

function TCabCompressor.GetCabsize:longword;
begin
 Result:=ffcicabinfo.cb;
end;
procedure TCabCompressor.Setcabsize(asize:longword);
begin
 if processing=false then
  ffcicabinfo.cb:=asize;
end;

function TCabCompressor.GetThresholdSize:longword;
begin
 Result:=ffcicabinfo.cbFolderThresh;
end;

procedure TCabCompressor.SetThresholdsize(asize:Longword);
begin
 if processing=false then
  ffcicabinfo.cbFolderThresh:=asize;
end;


function TCabCompressor.GetCabname:string;
begin
 Result:=fcabpathname;
end;

procedure TCabCompressor.InitializeVariables;
begin
 fcabstream:=Tcabstream.Create;
 fnames:=tfilelist.create;
 fabort:=false;
 frecdir:=true;
 fprocessing:=false;
 fcompressed:=0;
 ftotalbytes:=0;
 ffcicabinfo.cb:=50000000;
 ffcicabinfo.cbFolderThresh:=50000000;
 ffcicabinfo.setID:=0;
 ffcicabinfo.iCab:=0;
 ffcicabinfo.szCab:='Test.cab';
 ffcicabinfo.szCabPath:='C:\';
 ffcicabinfo.szDisk:='Disk1';
 ffcicabinfo.fFailOnIncompressible:=-1;
 fcihandle:=nil;
end;


procedure TCabCompressor.Loaded;
begin
 fdefaulthandler:=(Owner as TForm).WindowProc;
 (Owner as TForm).WindowProc:=MessageHandler;
 fwinhandle:=(Owner as TForm).Handle;
 fCompParams:=TCompressionParameters.Create(self);
 fCompParams.CompressionType:=ctMsZip;    
 inherited;
end;

procedure TCabCompressor.MessageHandler(var msg:Tmessage);
var
 pinfo:PPostInfo;
 fstatus:boolean;
begin
 fstatus:=false;
 if (msg.Msg=WM_OnStatusChange) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnStatusChange) then
      fOnStatusChange(fcompressed,ftotalbytes);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnWrite) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnWriteFile) then
      fOnWritefile(pinfo.fname,pinfo.hf,pinfo.cb);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnRead) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnReadfile) then
      fOnReadfile(pinfo.fname,pinfo.hf,pinfo.cb);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnSeek) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnSeekfile) then
      fOnSeekfile(pinfo.fname,pinfo.hf,pinfo.cb,pinfo.seektype);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnOpen) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnOpenfile) then
      fOnOpenfile(pinfo.fname,pinfo.hf,pinfo.cb);
      dispose(pinfo);
      msg.wparam:=0;
      fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnClose) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnClosefile) then
      fOnClosefile(pinfo.fname,pinfo.hf);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnGetTempFile) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnGetTempFile) then
      fOnGetTempfile(pinfo.fname);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnPlaceFile) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnPlaceFile) then
      fOnPlacefile(pinfo.fname);
     dispose(pinfo);
     msg.wparam:=0;
     fstatus:=true;
    end;
  end
 else if (msg.Msg=WM_OnBegProcess) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnBegProcess) then
      fOnBegProcess;
     dispose(pinfo);
    end;
  end
 else if (msg.Msg=WM_OnEndProcess) then
  begin
   pinfo:=PPostInfo(msg.WParam);
   if (pinfo<>nil) and (pinfo.sender=self) then
    begin
     if assigned(fOnEndProcess) then
      fOnEndProcess;
     dispose(pinfo);
    end;
  end;
 if not(fstatus) then
  fdefaulthandler(msg);
end;

procedure TCabCompressor.SetCabname(aname:string);
begin
 if processing=true then
  exit;
 if DirectoryExists(ExtractFilePath(aname))=false then
  raise ECabError.create('Not a valid filename');
 fcabpathname:=aname;
 fcabname:=extractfilename(fcabpathname);
 if fcabname='' then
  raise ECabError.create('Not a valid filename.');
 setlength(fcabname,length(fcabname)-length(ExtractFileExt(fcabname)));
 strcopy(ffcicabinfo.szCab,PChar(extractfilename(aname)));
 strcopy(ffcicabinfo.szCabPath,PChar(extractfilepath(aname)));
end;

procedure TCabCompressor.SetDiskName(aname:string);
begin
 if not processing then
  begin
   strcopy(@(ffcicabinfo.szDisk),pchar(aname));
   fdiskname:=aname;
  end; 
end;

constructor TCabCompressor.Create(aowner:Tcomponent);
begin
 inherited;
 Initializevariables;
end;

destructor TCabCompressor.destroy;
begin
 abort;
 if Assigned(fcabstream) then
  fcabstream.Free;
 if assigned(fnames) then
  freeandnil(fnames);
 if assigned(fCompParams) then
  freeandnil(fcompParams);
 inherited;
end;

procedure TCabCompressor.Reset;
begin
 if assigned(fcabstream) then
  freeandnil(fcabstream);
 if assigned(fnames) then
  freeandnil(fnames);
 Initializevariables;
end;

procedure TCabCompressor.InitializeCompressor;
begin
 fcihandle:=FCICreate(@ferf,
                      fci_fileplaced,
		      mem_alloc,
		      mem_free,
                      fci_open,
                      fci_read,
                      fci_write,
                      fci_close,
                      fci_seek,
                      fci_delete,
		      fci_gettempfile,
                      @ffcicabinfo,Self);
 if fcihandle=nil then
  raise ECabError.Create('Could not Create Context');
end;

procedure TCabCompressor.Abort;
begin
 if processing=true then
  begin
   if assigned(fcompthread) then
    begin
     fabort:=true;
     fcompthread.terminate;
     fcompthread.WaitFor;
     freeandnil(fcompthread);
     fabort:=false;
     fprocessing:=false;
    end;
  end;
end;


function TCabCompressor.AddFile(aname:string;apath:string='';execute:boolean=false):boolean;
begin
 if processing=true then
  begin
   result:=false;
   exit;
  end;
 Result:=True;
 getfiles(aname,apath,execute);
end;

function TCabCompressor.ClearFiles:boolean;
begin
 result:=true;
 if processing=true then
  begin
   result:=false;
   exit;
  end;
 fnames.clear;
 ftotalbytes:=0;
 fcompressed:=0;
end;

procedure TCabCompressor.GetFileInfoFromName(aname:pchar;pdate:pword;ptime:pword;pattribs:pword);
var
 i:integer;
begin
 for i:=0 to fnames.count-1 do
  begin
   if stricomp(pchar(aname),pchar(Pfileinfo(fnames.Items[i]).fpathname))=0 then
    begin
     FileTimeToDosDateTime(Pfileinfo(fnames.Items[i]).filedata.FindData.ftLastWriteTime,pdate^,ptime^);
     pattribs^:=Pfileinfo(fnames.Items[i]).filedata.Attr;
     break;
    end;
  end;
end;

function TCabCompressor.GetRHS:longword;
begin
 result:=ffcicabinfo.cbReserveCFHeader;
end;

procedure TCabCompressor.SetRHS(asize:longword);
begin
 if not processing then
  ffcicabinfo.cbReserveCFHeader:=asize;
end;

function TCabCompressor.GetRFS:longword;
begin
 result:=ffcicabinfo.cbReserveCFFolder;
end;

procedure TCabCompressor.SetRFS(asize:longword);
begin
 if not processing then
  ffcicabinfo.cbReserveCFFolder:=asize;
end;

function TCabCompressor.GetRDS:longword;
begin
 result:=ffcicabinfo.cbReserveCFData;
end;

procedure TCabCompressor.SetRDS(asize:longword);
begin
 if not processing then
  ffcicabinfo.cbReserveCFData:=asize;
end;

procedure TCabCompressor.SetRecDir(arecdir:boolean);
begin
 if not processing then
  frecdir:=arecdir;
end;

procedure TCabCompressor.Compress;
begin
 if not processing then
  fcompthread:=tCompressionthread.create(self,false);
end;

procedure TCabCompressor.GetFiles(fname:string;var apath:string;aexecute:boolean);
var
 f1:Tsearchrec;
 fwc:string;
 fpath:string;
 pdata:PFileInfo;
begin
 fpath:=extractfilepath(fname);
 fwc:=extractfilename(fname);
 if findfirst(fname,faAnyFile,f1)=0 then
  begin
   repeat
    if (f1.Attr and fadirectory)=0 then
     begin
      new(pdata);
      pdata.filedata:=f1;
      pdata.fexecute:=integer(aexecute);
      pdata.fpathname:=fpath+f1.Name;
      pdata.fstoredpathname:=apath;
      pdata.fwildcard:=fwc;
      fnames.Add(pdata);
      ftotalbytes:=ftotalbytes+longword(f1.Size);   
     end;
   until findnext(f1)<>0;
  end;
 findclose(f1);
 if FindFirst(fpath+'*',faAnyFile,f1)=0 then
  begin
   repeat
    if (f1.Name<>'.') and (f1.Name<>'..') and ((f1.Attr and fadirectory)=fadirectory) then
     getfiles(fpath+f1.Name+'\'+fwc,apath,aexecute);
   until findnext(f1)<>0;
  end;
 findclose(f1);
end;

procedure TCabCompressor.fCompress;
var
 i:integer;
 fdata:PFileinfo;
 comp:word;
 path:string;
 pinfo:PPostInfo;
begin
 new(pinfo);
 pinfo.sender:=self;
 postmessage(fwinhandle,WM_OnBegProcess,longword(pinfo),0);
 if fnames.count>0 then
  begin
   initializecompressor;
   Comp:=Integer(fCompParams.CompressionType);
   case fcompParams.CompressionType  of
    ctQuantum :
     Comp:=Comp or
      (fcompParams.QuantumLevel shl tcompSHIFT_QUANTUM_LEVEL) or
      (fcompParams.QuantumMemory shl tcompSHIFT_QUANTUM_MEM);
    ctLzx :
     Comp:=Comp or (fcompParams.LzxLevel shl tcompSHIFT_LZX_WINDOW);
   end;
   for i:=0 to fnames.Count-1 do
    begin
     fdata:=PFileInfo(fnames.items[i]);
     if fdata.fstoredpathname='' then
      path:=fdata.filedata.Name
     else
      begin
       if fdata.fstoredpathname[length(fdata.fstoredpathname)]<>'\' then
        fdata.fstoredpathname:=fdata.fstoredpathname+'\';
       path:=fdata.fstoredpathname+fdata.filedata.Name;
      end;
     FCIAddFile(fcihandle,PChar(fdata.fpathname),PChar(path),fdata.fexecute,fci_getnextcab,fci_getstatus,fci_getopeninfo,Word(comp));
     if fabort then
      begin
       finalizecompressor(true);
       reset;
      end;
    end;
   finalizecompressor;
  end;
 new(pinfo);
 pinfo.sender:=self;
 postmessage(fwinhandle,WM_OnEndProcess,longword(pinfo),0);
end;

procedure TFilelist.Clear;
var
 i:integer;
begin
 for i:=0 to count-1 do
  dispose(Items[i]);
 inherited;
end;

procedure TCabCompressor.FinalizeCompressor(aabort:boolean=false);
begin
 if aabort=false then
  FCIFlushCabinet(fcihandle,0,fci_getnextcab,fci_getstatus);
 FCIDestroy(fcihandle);
 fprocessing:=false;
end;

function fci_fileplaced(pccab:PFCICabInfo;pszfile:pchar;cbfile:integer;fContinuation:integer;pv:pointer):integer;cdecl;
var
 tmp:TCabCompressor;
 pinfo:PPostInfo;
begin
  tmp:=TCabCompressor(pv);
  new(pinfo);
  pinfo.sender:=tmp;
  pinfo.fname:=pszfile;
  postmessage(tmp.fwinhandle,WM_OnPlaceFile,longword(pinfo),0); 
  result:=0;
end;

function mem_alloc(cb:integer):pointer;cdecl;
begin
 getmem(result,cb);
end;

function mem_free(memory:pointer):pointer;cdecl;
begin
 FreeMem(memory);
 result:=nil;
end;

function fci_open(pszFile:pchar;oflag:integer;pmode:integer;err:PInteger;pv:pointer):integer;cdecl;
var
 tmp:TcabCompressor;
 amode:Word;
 pinfo:PPostInfo;
begin
 tmp:=TCabCompressor(pv);
 Result:=tmp.fcabstream.AddFile(pszfile,oflag,@amode);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=result;
 pinfo.cb:=amode;
 pinfo.fname:=pszfile;
 postMessage(tmp.fwinhandle,WM_OnOpen,longword(pinfo),0);
 if result=-1 then
  err^:=GetLastError;
end;

function fci_read(hf:integer;memory:pointer;cb:integer;err:pinteger;pv:pointer):integer;cdecl;
var
 tmp:TcabCompressor;
 pinfo:PpostInfo;
begin
 tmp:=TCabCompressor(pv);
 result:=tmp.fcabstream.files[hf].read(memory^,cb);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.cb:=cb;
 pinfo.fname:=tmp.fcabstream.files[hf].FileName;
 postmessage(tmp.fwinhandle,WM_OnRead,longword(pinfo),0);
 if result<>cb then
  err^:=getlasterror;
end;

function fci_write(hf:integer;memory:pointer;cb:integer;err:pinteger;pv:pointer):integer;cdecl;
var
 tmp:TcabCompressor;
 pinfo:PpostInfo;
begin
 tmp:=TCabCompressor(pv);
 Result:=tmp.fcabstream.files[hf].write(memory^,cb);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.cb:=cb;
 pinfo.fname:=tmp.fcabstream.files[hf].FileName;
 postmessage(tmp.fwinhandle,WM_OnWrite,longword(pinfo),0);
 if result<>cb then
  err^:=GetLastError;
end;

function fci_close(hf:integer;err:pinteger;pv:pointer):integer;cdecl;
var
 tmp:TcabCompressor;
 pinfo:Ppostinfo;
begin
 tmp:=TCabCompressor(pv);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.fname:=tmp.fcabstream.files[hf].FileName;
 postMessage(tmp.fwinhandle,WM_OnClose,longword(pinfo),0);
 err^:=0;
 tmp.fcabstream.closefile(hf);
 Result:=0;
end;

function fci_seek(hf:integer;dist:integer;seektype:integer;err:pinteger;pv:pointer):integer;cdecl;
var
 tmp:TcabCompressor;
 pinfo:PpostInfo;
begin
 tmp:=TCabCompressor(pv);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.cb:=dist;
 pinfo.seektype:=seektype;
 pinfo.fname:=tmp.fcabstream.files[hf].FileName;
 Result:=tmp.fcabstream.files[hf].Seek(dist,seektype);
 postMessage(tmp.fwinhandle,WM_OnSeek,longword(pinfo),0);
 if result=0 then
  err^:=GetLastError;
end;

function fci_delete(pszFile:pchar;err:pinteger;pv:pointer):integer;cdecl;
var
 tmp:TCabCompressor;
begin
 tmp:=TCabCompressor(pv);
 result:=tmp.DeleteFile(pszfile);
 if Assigned(tmp.ondeletefile) then
  tmp.ondeletefile(pszfile);
end;

function fci_getnextcab(pccab:PFCICabInfo;cbPrevCab:integer;pv:pointer):bool;cdecl;
var
 tmp:TCabCompressor;
 cabname:string;
 diskname:string;
begin
 tmp:=TCabCompressor(pv);
 cabname:=extractfilepath(tmp.fcabpathname)+tmp.fcabname+inttostr(pccab.iCab)+'.cab';
 diskname:=tmp.fdiskname+inttostr(pccab.iCab);
 if assigned(tmp.fOnGetNextCab) then
  tmp.fOnGetNextCab(cabname,diskname);
 if directoryexists(extractfilepath(cabname))=false then
  raise ECabError.Create('Not a valid Pathname');
 if extractfilename(cabname)='' then
  raise ECabError.Create('Not a valid Pathname');
 strcopy(pccab.szcab,PChar(extractfilename(cabname)));
 strcopy(pccab.szCabPath,PChar(extractfilepath(cabname)));
 strcopy(pccab.szDisk,pchar(diskname));
 Result:=false;
end;

function fci_getopeninfo(pszName:pchar;pdate:pword;ptime:pword;pattribs:pword;err:pinteger;pv:pointer):integer;cdecl;
begin
 result:=fci_open(pszname,_O_RDONLY or _O_BINARY, 0,nil,pv);
 TCabCompressor(pv).GetFileInfoFromName(pszname,pdate,ptime,pattribs);
end;

function fci_getstatus(typeStatus:integer;cb1:longword;cb2:longword;pv:pointer):integer;cdecl;
var
 tmp:TCabCompressor;
 pinfo:PPostInfo;
begin
 tmp:=TCabCompressor(pv);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=0;
 pinfo.cb:=0;
 if tmp.fabort=true then
  begin
   result:=-1;
   exit;
  end;
 if typestatus<>statuscabinet then
  result:=0
 else
  Result:=cb2;
 if typestatus=statusfile then
  begin
   tmp.fcompressed:=tmp.fcompressed+cb2;
   postMessage(tmp.fwinhandle,WM_OnStatusChange,longword(pinfo),0);
   //if Assigned(tmp.onstatuschange) then
   //tmp.onstatuschange(tmp.fcompressed,tmp.ftotalbytes);
  end;
end;

function fci_gettempfile(pszTempName:pchar;cbTempName:integer;pv:pointer):bool;cdecl;
var
 tmpname:string;
 tmp:TCabCompressor;
 tmppath:string;
 pinfo:PpostInfo;
 i:integer;
begin
 tmp:=TCabcompressor(pv);
 setlength(tmpname,cbtempname);
 for i:=1 to 256 do
  tmpname[i]:=#0;
 Setlength(tmppath,255);
 gettemppath(255,PChar(tmppath));
 repeat
  GetTempFileName(PChar(tmppath),'XXX',Random(65535)+1,pchar(tmpname));
  tmpname:=trim(tmpname);
 until fileexists(tmpname)=False;
 strcopy(pszTempName,pchar(tmpname));
 new(pinfo);
 pinfo.sender:=tmp; 
 pinfo.fname:=tmpname;
 PostMessage(tmp.fwinhandle,WM_OnGetTempFile,longword(pinfo),0);
 result:=true;
end;

function fdi_open(pszFile:PChar;oflag:Integer;pmode:Integer):Integer; cdecl;
var
 tmp:TcabDecompressor;
 amode:Word;
 pinfo:PpostInfo;
begin
 tmp:=TlsGetValue(findex);
 result:=tmp.fcabstream.AddFile(pszfile,oflag,@amode);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.fname:=pszfile;
 pinfo.hf:=result;
 pinfo.cb:=amode;
 postmessage(tmp.fwinhandle,WM_OnOpen,longword(pinfo),0); 
end;

function fdi_read(hf: Integer; memory : pointer; cb : longword):integer ; cdecl;
var
 tmp:TCabDecompressor;
 pinfo:PPostInfo;
begin
 tmp:=TlsGetValue(findex);
 result:=tmp.fcabstream.files[hf].read(memory^,cb);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.cb:=cb;
 pinfo.fname:=tmp.fcabstream.files[hf].FileName;
 PostMessage(tmp.fwinhandle,WM_OnRead,longword(pinfo),0); 
end;

function fdi_write(hf: Integer; memory : pointer; cb : longword):integer; cdecl;
var
 tmp:TCabDecompressor;
 pinfo:pPostInfo;
begin
 tmp:=TlsGetValue(findex);
 Result:=tmp.fcabstream.files[hf].write(memory^,cb);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.cb:=cb;
 pinfo.fname:=extractfilename(tmp.fcabstream.files[hf].FileName);
 PostMessage(tmp.fwinhandle,WM_OnWrite,longword(pinfo),0);
 if tmp.IsFileChecked(extractfilename(tmp.fcabstream.files[hf].FileName)) then
  tmp.funcompressed:=tmp.funcompressed+cb;
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.cb:=cb;
 PostMessage(tmp.fwinhandle,WM_OnStatusChange,longword(pinfo),0);
end;

function fdi_close(hf: Integer): Integer; cdecl;
var
 tmp:TcabDecompressor;
 pinfo:pPostInfo;
begin
 tmp:=TlsGetValue(findex);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.fname:=tmp.fcabstream.files[hf].FileName;
 tmp.fcabstream.closefile(hf);
 postmessage(tmp.fwinhandle,WM_OnClose,longword(pinfo),0);
 Result:=0;
end;

function fdi_seek(hf : Integer; dist : Longint; seektype : Integer):Longint; cdecl;
var
 tmp:TcabDecompressor;
 pinfo:PPostInfo;
begin
 tmp:=TlsGetValue(findex);
 Result:=tmp.fcabstream.files[hf].Seek(dist,seektype);
 new(pinfo);
 pinfo.sender:=tmp;
 pinfo.hf:=hf;
 pinfo.cb:=dist;
 pinfo.fname:=tmp.fcabstream.files[hf].FileName;
 PostMessage(tmp.fwinhandle,WM_OnSeek,longword(pinfo),0); 
end;

function fdi_notify(fdint:TFDINOTIFICATIONTYPE;pfdin:PFDINOTIFICATION):Integer; cdecl;
var
 tmp:TCabDecompressor;
 aname:string;
 ahdle:integer;
 ftime:TFileTime;
 pinfo:PPostInfo;
 ovr:boolean;
begin
 tmp:=TlsGetValue(findex);
 if tmp.fabort=true then
  begin
   result:=-1;
   exit;
  end;
 case fdint of
  fdintCOPY_FILE:
   begin
    aname:=pfdin.psz1;
    if tmp.IsFileChecked(aname) then
     begin
      aname:=tmp.ftargetpath+aname;
      if fileexists(aname) then
       ovr:=true
      else
       ovr:=false;
      if assigned(tmp.fBeforeCopyFile) then
       tmp.fBeforeCopyFile(aname,ovr);
      ahdle:=tmp.fcabstream.AddFile(aname,_O_CREAT or _O_RDWR,nil);
      if ahdle<0 then
       raise ECabError.Create('Invalid Directory');
      result:=ahdle;
     end
    else
     result:=0;
   end;
  fdintCLOSE_FILE_INFO:
   begin
    new(pinfo);
    pinfo.sender:=tmp;
    pinfo.fname:=tmp.fcabstream.files[pfdin.hf].FileName;
    pinfo.cb:=pfdin.cb;
    DosDateTimeToFileTime(pfdin.date,pfdin.time,ftime);
    SetFileTime(pfdin.hf,@ftime,nil,nil);
    tmp.fcabstream.CloseFile(pfdin.hf);
    postmessage(tmp.fwinhandle,WM_AfterCopyFile,longword(pinfo),0);
    result:=1;
   end;
  fdintNEXT_CABINET:
   begin
    aname:=pfdin.psz3;
    aname:=aname+pfdin.psz1;
    if assigned(tmp.fonsetnextcab) then
     tmp.fonsetnextcab(aname);
    result:=1;
   end;
  else
   result:=1;
 end;
end;

procedure Register;
begin
 RegisterComponents('Cabinet', [TCabCompressor]);
 RegisterComponents('Cabinet',[TCabDecompressor]);
end;

initialization
 findex:=tlsalloc;
finalization
 tlsfree(findex);
end.

