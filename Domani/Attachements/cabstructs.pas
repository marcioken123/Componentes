unit Cabstructs;

interface
uses
  Windows,SysUtils,Classes;

{$A+}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT ON}

const
 cfhdrPREV_CABINET:integer=1;
 cfhdrNEXT_CABINET:integer=2;
 cfhdrRESERVE_PRESENT:integer=4;
 ifoldCONTINUED_FROM_PREV:integer=$FFFD;
 ifoldCONTINUED_TO_NEXT:integer=$FFFE;
 ifoldCONTINUED_PREV_AND_NEXT:integer=$FFFF;

type
 TCabHeader=packed record
  signature: array[0..3] of char;
  reserved1:longword;
  cabsize:longword;
  reserved2:longword;
  cfoffset:longword;
  reserved3:longword;
  versionminor:byte;
  versionmajor:byte;
  foldercount:word;
  filescount:word;
  flags:word;
  setid:word;
  cabid:word;
 end;
 PCabHeader=^TCabHeader;

type
 TCabFileHeader=packed record
  cbfilesize:longword;
  folderstartoffset:longword;
  folderid:word;
  date:word;
  time:word;
  attribs:word;
 end;
 PCabFileHeader=^TCabFileHeader;

const
 CB_MAX_CHUNK        :integer=32768;
 CB_MAX_DISK         :integer=$7ffffff;
 CB_MAX_FILENAME     :integer=256;
 CB_MAX_CABINET_NAME :integer=256;
 CB_MAX_CAB_PATH     :integer=256;
 CB_MAX_DISK_NAME    :integer=256;

type
 TCOMP=word;

 const
 tcompMASK_TYPE    :TComp=$000F;  // Mask for compression type
 tcompTYPE_NONE    :TComp=$0000;  // No compression
 tcompTYPE_MSZIP   :TComp=$0001;  // MSZIP
 tcompTYPE_QUANTUM :TComp=$0002;  // Quantum
 tcompTYPE_LZX     :TComp=$0003;  // LZX
 tcompBAD          :TComp=$000F;
 tcompMASK_LZX_WINDOW :TComp=$1F00;
 tcompLZX_WINDOW_LO       :integer=$0F00;  // Lowest LZX Memory (15)
 tcompLZX_WINDOW_HI       :integer=$1500;  // Highest LZX Memory (21)
 tcompSHIFT_LZX_WINDOW    :integer=8;  // Amount to shift over to get int
 tcompMASK_QUANTUM_LEVEL  :integer=$00F0;  // Mask for Quantum Compression Level
 tcompQUANTUM_LEVEL_LO    :integer=$0010;  // Lowest Quantum Level (1)
 tcompQUANTUM_LEVEL_HI    :integer=$0070;  // Highest Quantum Level (7)
 tcompSHIFT_QUANTUM_LEVEL :integer=4;  // Amount to shift over to get int
 tcompMASK_QUANTUM_MEM    :integer=$1F00;  // Mask for Quantum Compression Memory
 tcompQUANTUM_MEM_LO      :integer=$0A00;  // Lowest Quantum Memory (10)
 tcompQUANTUM_MEM_HI      :integer=$1500;  // Highest Quantum Memory (21)
 tcompSHIFT_QUANTUM_MEM   :integer=8;  // Amount to shift over to get int
  _O_RDONLY = $0000;
  _O_WRONLY = $0001;
  _O_RDWR = $0002;
  _O_APPEND = $0008;
  _O_CREAT = $0100;
  _O_TRUNC = $0200;
  _O_EXCL = $0400;
  _O_TEXT = $4000;
  _O_BINARY = $8000;
  _O_RAW = _O_BINARY;
  _O_NOINHERIT = $0080;
  _O_TEMPORARY = $0040;
  _O_SHORT_LIVED = $1000;
  _O_SEQUENTIAL = $0020;
  _O_RANDOM = $0010;
  _A_NAME_IS_UTF = $80;
  _A_EXEC = $40;

const
 cpuUNKNOWN = (-1);
 cpu80286 = (0);
 cpu80386 = (1);


type
 HFCI=pointer;
 HFDI=pointer;


type
 TFCICabInfo = packed record
  cb: longint;
  cbFolderThresh :longint;
  cbReserveCFHeader: integer;
  cbReserveCFFolder: integer;
  cbReserveCFData: integer;
  iCab : Integer;
  iDisk : Integer;
  {$IFNDEF REMOVE_CHICAGO_M6_HACK}
  fFailOnIncompressible : Integer;
  {$ENDIF}
  setID: smallint;
  szDisk : array[0..256 - 1] of Char;
  szCab : array[0..256 - 1] of Char;
  szCabPath : array[0..256 - 1] of Char;
 end;
 PFCICabInfo= ^TFCICabInfo;

type
 TFDICabInfo = record
  cbCabinet : Longint;
  cFolders : shortint;
  cFiles : shortint;
  setID : shortint;
  iCabinet : shortint;
  fReserve : BOOL;
  hasprev : BOOL;
  hasnext : BOOL;
 end;
 PFDICabInfo= ^TFDICabInfo;


type
 TErf=packed record
  erfOper:integer;
  erfType:integer;
  fError:integer;
 end;
 PErf=^TErf;

type
 TFDIERROR =
  (
   FDIERROR_NONE,
   FDIERROR_CABINET_NOT_FOUND,
   FDIERROR_NOT_A_CABINET,
   FDIERROR_UNKNOWN_CABINET_VERSION,
   FDIERROR_CORRUPT_CABINET,
   FDIERROR_ALLOC_FAIL,
   FDIERROR_BAD_COMPR_TYPE,
   FDIERROR_MDI_FAIL,
   FDIERROR_TARGET_FILE,
   FDIERROR_RESERVE_MISMATCH,
   FDIERROR_WRONG_CABINET,
   FDIERROR_USER_ABORT
  );

type
 TFDIDECRYPTTYPE =
  (fdidtNEW_CABINET,fdidtNEW_FOLDER,fdidtDECRYPT);


type
 TFDIDECRYPT = record
  fdidt: TFDIDECRYPTTYPE;
  pvUser: pointer;
  noname: record
   case Integer of
    1:
      (
       cabinet: record
        pHeaderReserve: Pointer;
        cbHeaderReserve:shortint;
        setID : shortint;
        iCabinet : Integer;
       end;
      );
    2:
      (
       folder: record
        pFolderReserve: Pointer;
        cbFolderReserve: shortint;
        iFolder: shortint;
       end;
      );
    3:
      (
       decrypt: record
        pDataReserve: Pointer;
        cbDataReserve: shortint;
        pbData: Pointer;
        cbData: shortint;
        fSplit: BOOL;
        cbPartial: shortint;
       end;
      );
   end;
  end;
  PFDIDECRYPT = ^TFDIDECRYPT;


type
 TFDINOTIFICATION=record
  cb : Longint;
  psz1: PChar;
  psz2: PChar;
  psz3: PChar;
  pv: Pointer;
  hf: Integer;
  date: shortint;
  time: shortint;
  attribs: shortint;
  setID: shortint;
  iCabinet: shortint;
  iFolder: shortint;
  fdie: TFDIERROR;
 end;
 PFDINOTIFICATION = ^TFDINOTIFICATION;

type
 TFDINOTIFICATIONTYPE =
  (
   fdintCABINET_INFO,
   fdintPARTIAL_FILE,
   fdintCOPY_FILE,
   fdintCLOSE_FILE_INFO,
   fdintNEXT_CABINET,
   fdintENUMERATE
  );



type
 PFNFCIFILEPLACED= function(pccab:PFCICabInfo;pszfile:pchar;cbfile:integer;fContinuation:integer;pv:pointer):integer;cdecl;
 PFNFCIALLOC=function(cb:integer):pointer;cdecl;
 PFNFCIFREE=function(memory:pointer):pointer;cdecl;
 PFNFCIOPEN=function(pszFile:pchar;oflag:integer;pmode:integer;err:PInteger;pv:pointer):integer;cdecl;
 PFNFCIREAD=function(hf:integer;memory:pointer;cb:integer;err:pinteger;pv:pointer):integer ;cdecl;
 PFNFCIWRITE=function(hf:integer;memory:pointer;cb:integer;err:pinteger;pv:pointer):integer;cdecl;
 PFNFCICLOSE=function(hf:integer;err:pinteger;pv:pointer):integer;cdecl;
 PFNFCISEEK=function(hf:integer;dist:integer;seektype:integer;err:pinteger;pv:pointer):integer;cdecl;
 PFNFCIDELETE=function(pszFile:pchar;err:pinteger;pv:pointer):integer;cdecl;
 PFNFCIGETNEXTCABINET=function(pccab:PFCICabInfo;cbPrevCab:integer;pv:pointer):bool;cdecl;
 PFNFCIGETOPENINFO=function(pszName:pchar;pdate:pword;ptime:pword;pattribs:pword;err:pinteger;pv:pointer):integer;cdecl;
 PFNFCISTATUS=function(typeStatus:integer;cb1:longword;cb2:longword;pv:pointer):integer;cdecl;
 PFNFCIGETTEMPFILE=function(pszTempName:pchar;cbTempName:integer;pv:pointer):bool;cdecl;
 PFNFDIALLOC=function(cb : integer):Pointer; cdecl;
 PFNFDIFREE=function(pv : Pointer):Pointer; cdecl;
 PFNFDIOPEN=function(pszFile : PChar; oflag : Integer; pmode : Integer):Integer; cdecl;
 PFNFDIREAD=function(hf: Integer; memory: pointer; cb : longword):integer ; cdecl;
 PFNFDIWRITE=function(hf: Integer; memory: pointer; cb : longword):integer; cdecl;
 PFNFDICLOSE=function(hf: Integer): Integer; cdecl;
 PFNFDISEEK=function(hf : Integer; dist : Longint; seektype : Integer):Longint; cdecl;
 PFNFDIDECRYPT=function(pfdid : PFDIDECRYPT): Integer; cdecl;
 PFNFDINOTIFY=function (fdint : TFDINOTIFICATIONTYPE;pfdin:PFDINOTIFICATION):Integer; cdecl;

 function FCICreate(perf:PErf;
                    pfnfcifp:PFNFCIFILEPLACED;
                    pfna:PFNFCIALLOC;
                    pfnf:PFNFCIFREE;
                    pfnopen:PFNFCIOPEN;
                    pfnread:PFNFCIREAD;
                    pfnwrite:PFNFCIWRITE;
                    pfnclose:PFNFCICLOSE;
                    pfnseek:PFNFCISEEK;
                    pfndelete:PFNFCIDELETE;
                    pfnfcigtf:PFNFCIGETTEMPFILE;
                    pccab:PFCICabInfo;
                    pv:pointer
                   ):HFCI;cdecl;external 'cabinet.dll';

 function FCIAddFile(fci:HFCI;
                     pszSourceFile:pchar;
                     pszFileName:pchar;
                     fExecute:integer;
                     pfnfcignc:PFNFCIGETNEXTCABINET;
                     pfnfcis:PFNFCISTATUS;
                     pfnfcigoi:PFNFCIGETOPENINFO;
                     typeCompress:TCOMP
                    ):integer;cdecl;external 'cabinet.dll';

 function FCIFlushCabinet(fci:HFCI;
                          fGetNextCab:integer;
                          pfnfcignc:PFNFCIGETNEXTCABINET;
                          pfnfcis:PFNFCISTATUS
                         ):integer;cdecl;external 'cabinet.dll';
 function FCIFlushFolder(fci:hfci;
                         pfnfcignc:PFNFCIGETNEXTCABINET;
                         pfnfcis:PFNFCISTATUS
                        ):longbool;cdecl;external 'cabinet.dll';


 function FCIDestroy (fci:HFCI):integer;cdecl;external 'cabinet.dll';

 function FDICreate (pfnalloc : PFNFDIALLOC; pfnfree : PFNFDIFREE;
                     pfnopen : PFNFDIOPEN; pfnread : PFNFDIREAD;
                     pfnwrite : PFNFDIWRITE; pfnclose : PFNFDICLOSE;
                     pfnseek : PFNFDISEEK;cpuType : Integer; perf : PERF) : HFDI; cdecl;external 'cabinet.dll';

 function FDIIsCabinet (hfdi : HFDI; hf : Integer; pfdici : PFDICabInfo) : BOOL; cdecl;external 'cabinet.dll';
 function FDICopy (hfdi : HFDI; pszCabinet : PChar; pszCabPath : PChar;
                   flags : Integer; pfnfdin : PFNFDINOTIFY;
                   pfnfdid : PFNFDIDECRYPT;pvUser : Pointer): BOOL; cdecl;external 'cabinet.dll';

 function FDIDestroy (hfdi : HFDI) : BOOL; cdecl;external 'cabinet.dll';


implementation

end.
