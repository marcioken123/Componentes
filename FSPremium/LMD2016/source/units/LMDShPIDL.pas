unit LMDShPIDL;
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

LMDShPIDL unit (DS)
-------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, ShellAPI, Forms, ComObj, ShlObj,
  LMDTypes, LMDShBase, LMDShMisc;

var
  hShell32: THandle;

type

  {****************************************************************************}
{
  PLMDShellPIDLArray = ^TLMDShellPIDLArray;
  TLMDShellPIDLArray = array [0..(MaxWord div SizeOf(PItemIDList)) - 1] of PItemIDList;
}
  PLMDShellPIDLArray = array of PItemIDList;//PItemIDList;

  {****************************************************************************}
  TLMDShellPIDLS = class
  private
    FItems      : PLMDShellPIDLArray;//array of PItemIDList;
    FCount      : integer;
    function GetItem(index : integer) : PItemIDList;
    function GetItems : PLMDShellPIDLArray;
    procedure SetCount(V: integer);
    procedure SetItem(Ind: integer; aItem : PItemIDList);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(aItem : PItemIDList);
    property Items[index : integer] : PItemIDList read GetItem write SetItem; default;
    property List : PLMDShellPIDLArray read GetItems;
    property Count : integer read FCount write SetCount;
  end;

  {****************************************************************************}

  TLMDShPIDLClone           = function(aPIDL : PItemIDList) : PItemIDList; stdcall;
  TLMDShPIDLCloneFirst      = function(aPIDL : PItemIDList) : PItemIDList; stdcall;
  TLMDShPIDLCombine         = function(aPIDL1, aPIDL2 : PItemIDList) : PItemIDList; stdcall;
  TLMDShPIDLGetNext         = function(aPIDL : PItemIDList) : PItemIDList; stdcall;
  TLMDShPIDLFindLastID      = function(aPIDL : PItemIDList) : PItemIDList; stdcall;
  TLMDShPIDLIsEqual         = function(aPIDL1, aPIDL2 : PItemIDList) : LongBool; stdcall;
  TLMDShPIDLRemoveLastID    = function(aPIDL : PItemIDList) : LongBool; stdcall;
  TLMDShPIDLGetSize         = function(aPIDL : PItemIDList) : Word; stdcall;
  TLMDShPIDLFree            = procedure(aPIDL : PItemIDList); stdcall;

var
  LMDShPIDLClone             : TLMDShPIDLClone = nil;
  LMDShPIDLCloneFirst        : TLMDShPIDLCloneFirst = nil;
  LMDShPIDLCombine           : TLMDShPIDLCombine = nil;
  LMDShPIDLGetNext           : TLMDShPIDLGetNext = nil;
  LMDShPIDLFindLastID        : TLMDShPIDLFindLastID = nil;

  LMDShPIDLRemoveLastID      : TLMDShPIDLRemoveLastID = nil;
  LMDShPIDLGetSize           : TLMDShPIDLGetSize = nil;
  LMDShPIDLFree              : TLMDShPIDLFree = nil;

//function  LMDShPIDLCombine(aPIDL1, aPIDL2 : PItemIDList) : PItemIDList;

function LMDPIDLIsEqual(aPIDL1, aPIDL2 : PItemIDList):Boolean;

function LMDDesktopFolder : IShellFolder;
function GetIShellFolder(aPIDL: PItemIDList): IShellFolder;
function GetIShellDetails(IFolder: IShellFolder; PIDL: PItemIDList;
    Handle: THandle = 0): IShellDetails;
function LMDDesktopID : PItemIDList;
function LMDPathToPIDL(const aPath : string; Folder: IShellFolder = nil): PItemIDList; overload;
function LMDPathToPIDL(const aPath : string; var Res: PItemIDList;
    Folder: IShellFolder = nil): Boolean; overload;
function LMDPIDLToPath(aPIDL : PItemIDList) : string;
function LMDPIDLToStream(aPIDL: PItemIDList; Dst: TStream): Boolean;

function IsElement(Element, Flag: LongWord): Boolean;
function LMDGetDisplayFileName(ParentFolder: IShellFolder; PIDL: PItemIDList; Flags: DWORD): string;
function LMDCopyPIDL(IDList: PItemIDList): PItemIDList;
function LMDGetPIDLSize(IDList: PItemIDList): Integer;
function LMDNextPIDL(IDList: PItemIDList): PItemIDList;
function LMDCreatePIDL(Size: Integer): PItemIDList;
procedure LMDDisposePIDL(PIDL: PItemIDList);
procedure LMDStripLastID(IDList: PItemIDList);
function LMDConcatPIDLs(IDList1, IDList2: PItemIDList): PItemIDList;
function LMDSamePIDL(ID1, ID2: PItemIDList): Boolean;
function LMDGetIDFromPath(const aPath: String): PItemIDList;
function LMDPathFromPIDL(PIDL: PItemIDList): String;
function LMDCreatePIDLList(ID: PItemIDList): TList;
procedure LMDDestroyPIDLList(List: TList);
procedure LMDShPIDLsFree(var PIDLs: array of PItemIDList);
function LMDGetItemCount(IDList: PItemIDList): Integer;
function LMDGetParentPIDL(PIDL: PItemIDList): PItemIDList;

function LMDSHGetFileInfo(const pszPath: string; uFlags: UINT;
    var psfi: TSHFileInfo; dwFileAttributes: DWORD = 0): DWORD; overload;
function LMDSHGetFileInfo(aPIDL: PItemIDList; uFlags: UINT;
    var psfi: TSHFileInfo; dwFileAttributes: DWORD = 0): DWORD; overload;

implementation

uses
  Activex,
  SysUtils;

var
  lDesktopID          : PItemIDList;
  lDesktopFolder      : IShellFolder;
  Malloc : IMalloc;
  fLMDShPIDLIsEqual   : TLMDShPIDLIsEqual;

{** TLMDShellPIDLS ************************************************************}
{-- private -------------------------------------------------------------------}
function TLMDShellPIDLS.GetItem(index : integer) : PItemIDList;
begin
  Result := PItemIDList(FItems[index]);
end;

{------------------------------------------------------------------------------}
function TLMDShellPIDLS.GetItems : PLMDShellPIDLArray;
begin
  Result := FItems;
//  result := @FItems;
end;

{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDShellPIDLS.Create;
begin
  inherited;
  FCount := 0;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellPIDLS.Destroy;
var
  i : integer;
begin
  for i := 0 to FCount-1 do
    LMDShPIDLFree(FItems[i]);

  SetLength(FItems, 0);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellPIDLS.Add(aItem : PItemIDList);
begin
  Count := Count + 1;
  Items[FCount - 1] := aItem;
//  FItems[FCount] := LMDShPIDLClone(aItem);
//  Inc(FCount);
end;

{------------------------------------------------------------------------------}
procedure TLMDShellPIDLS.SetCount(V: integer);
var
  i: integer;
begin
  if  V > Count then
    begin
      SetLength(FItems, V);

      for i := Count to V - 1 do
        FItems[i] := nil;
    end
  else
    begin
      for i := Count - 1 downto V do
        LMDShPIDLFree(FItems[i]);

      SetLength(FItems, V);
    end;

  FCount := V;
end;

{------------------------------------------------------------------------------}
procedure TLMDShellPIDLS.SetItem(Ind: integer; aItem : PItemIDList);
begin
  if  Ind < Count then
    FItems[Ind] := LMDShPIDLClone(aItem);
end;

{------------------------------------------------------------------------------}
function LMDPIDLIsEqual(aPIDL1, aPIDL2 : PItemIDList):Boolean;
begin
  if (aPIDL1=nil) and (aPIDL2 = nil) then
    result := true
  else
    if (aPIDL1=nil) or (aPIDL2 = nil) then
      result:=false
    else
      if Assigned(fLMDShPIDLIsEqual) then
        result:=fLMDShPIDLIsEqual(aPIDL1, aPIDL2)
      else
        result:=LMDSamePIDL(aPIDL1, aPIDL2);
end;

{------------------------------------------------------------------------------}
function LMDDesktopFolder : IShellFolder;
begin
  result := lDesktopFolder;
end;

{------------------------------------------------------------------------------}

function GetIShellFolder(aPIDL: PItemIDList): IShellFolder;
begin
  Result := nil;

  if  Assigned(aPIDL) then

    LMDDesktopFolder.BindToObject(aPIDL, nil, IID_ISHellFolder, Result);

  if Result = nil then
    Result := LMDDesktopFolder;
end;

{------------------------------------------------------------------------------}
function GetIShellDetails(IFolder: IShellFolder; PIDL: PItemIDList;
  Handle: THandle): IShellDetails;
var
  HR : HResult;
begin
  if Assigned(IFolder) then
  begin

    HR := IFolder.BindToObject(PIDL, nil, IID_IShellDetails, Result);
    if Failed(HR) then
      HR := IFolder.GetUIObjectOf(Handle, 1, PIDL, IID_IShellDetails, nil, Result);
    if Failed(HR) then
      IFolder.CreateViewObject(Handle, IID_IShellDetails, Result);

  end;

  if not Assigned(Result) then

    LMDDesktopFolder.BindToObject(PIDL, nil, IID_IShellDetails, Result);

end;

{------------------------------------------------------------------------------}
function LMDDesktopID: PItemIDList;
begin
  result := lDesktopID;
end;

{------------------------------------------------------------------------------}
function LMDPathToPIDL(const aPath : string; var Res: PItemIDList;
    Folder: IShellFolder = nil): Boolean; overload;
var

  P       : PWideChar;

  Flags   : ULONG;
  NumChars: ULONG;
  HR      : HRESULT;
begin
  NumChars := Length(aPath);
  Flags := 0;

  if  Folder = nil  then
    Folder := lDesktopFolder;

  P := StringToOleStr(aPath);
  HR := Folder.ParseDisplayName(0, nil, P, NumChars, Res, Flags);

  Result := Succeeded(HR);

  if  not Result  then
    Res := nil;
end;

{------------------------------------------------------------------------------}
function LMDPathToPidl(const aPath : string; Folder: IShellFolder) : PItemIDList;
begin
  if  not LMDPathToPidl(aPath, Result, Folder) then
    Result := nil;
end;

{------------------------------------------------------------------------------}
function LMDPidlToPath(aPIDL : PItemIDList) : string;
var
  Flags         : DWORD;
  StrRet        : TStrRetEx;
begin
  result := '';
  Flags := SHGDN_FORPARSING;

  FillChar(StrRet, SizeOf(StrRet), 0);

  if  Succeeded(lDesktopFolder.GetDisplayNameOf(aPIDL, Flags, StrRet))  then
    //Result := String(LMDStrRetToStringEx(aPIDL, StrRet));
    Result := LMDStrRetToStr(aPIDL, StrRet);
end;

{ ---------------------------------------------------------------------------- }
function IsElement(Element, Flag: LongWord): Boolean;
begin
  Result := ((Element and Flag) = Element);
end;

{------------------------------------------------------------------------------}
function LMDGetDisplayFileName(ParentFolder: IShellFolder; PIDL: PItemIDList;
                        Flags: DWORD): string;
var
  StrRet: TStrRetEx;
begin
  Result := '';
  if ParentFolder = nil then
  begin
    Result := 'parentfolder = nil';  { Do not localize }
    exit;
  end;

  FillChar(StrRet, SizeOf(StrRet), 0);

  ParentFolder.GetDisplayNameOf(PIDL, Flags, StrRet);
  //Result := String(LMDStrRetToStringEx(PIDL, StrRet));
  Result := LMDStrRetToStr(PIDL, StrRet);
  if (Pos('::{', Result) = 1) then
    Result := LMDGetDisplayFileName(ParentFolder, PIDL, SHGDN_NORMAL);
end;

{ ---------------------------------------------------------------------------- }

function LMDCopyPIDL(IDList: PItemIDList): PItemIDList;
begin
  if Assigned(IDList) then
  begin
    Result := LMDShPIDLClone(IDList);
  end
  else
    Result:= nil;
end;

{ ---------------------------------------------------------------------------- }

function LMDPIDLToStream(aPIDL: PItemIDList; Dst: TStream): Boolean;
var
  S: integer;
begin
  Result := False;
  S := LMDGetPIDLSize(aPIDL);

  if  S > 0 then
    Result := (Dst.Write(aPIDL^, S) = S);
end;

{ ---------------------------------------------------------------------------- }
function LMDGetPIDLSize(IDList: PItemIDList): Integer;
begin
  Result := 0;
  if Assigned(IDList) then
  begin
    Result := SizeOf(IDList.mkid.cb);
    while IDList.mkid.cb <> 0 do
    begin
      Result:= Result + IDList.mkid.cb;
      IDList:= LMDNextPIDL(IDList);
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDNextPIDL(IDList: PItemIDList): PItemIDList;
begin
  Result := IDList;

  if  Assigned(IDList)  then
    Inc(PAnsiChar(Result), IDList.mkid.cb);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDStripLastID(IDList: PItemIDList);
var
  MarkerID: PItemIDList;
begin
  MarkerID := IDList;
  if Assigned(IDList) then
  begin
     while IDList.mkid.cb <> 0 do
    begin
      MarkerID := IDList;
      IDList := LMDNextPIDL(IDList);
    end;
    MarkerID.mkid.cb := 0;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDConcatPIDLs(IDList1, IDList2: PItemIDList): PItemIDList;
var
  cb1, cb2: Integer;
begin
  if Assigned(IDList1) then
    cb1:= LMDGetPIDLSize(IDList1) - SizeOf(IDList1.mkid.cb)
  else
    cb1:= 0;

  cb2:= LMDGetPIDLSize(IDList2);

  Result:= LMDCreatePIDL(cb1 + cb2);
  if Assigned(Result) then
  begin
    if Assigned(IDList1) then
      CopyMemory(Result, IDList1, cb1);
    CopyMemory(PAnsiChar(Result) + cb1, IDList2, cb2);
  end;
end;

{ ---------------------------------------------------------------------------- }

function GetOwnPIDL(PIDL: PItemIDList): PItemIDList;
  var
    oldPIDL: PItemIDList;
begin
  oldPIDL := nil;
  while (PIDL<>nil) and (PIDL.mkid.cb > 0) do
  begin
    oldPIDL := PIDL;
    PIDL := PItemIDList(TLMDPtrInt(PIDL) + PIDL.mkid.cb);
  end;
  Result := oldPIDL;
end;

{ ---------------------------------------------------------------------------- }

function LMDGetParentPIDL(PIDL: PItemIDList): PItemIDList;
  var
    PIDLLast, PIDLTemp :PItemIDList;
    cb                 :integer;
begin
  if Assigned(Malloc) then
  begin
    PIDLLast := GetOwnPIDL(PIDL);
    if PIDLLast = nil then
    begin
      Result := LMDCreatePIDL(2);
      Result.mkid.cb := 0;
    end
    else
    begin
      cb := TLMDPtrInt(PIDLLast) - TLMDPtrInt(PIDL) + SizeOf(PIDLTemp.mkid.cb);
      PIDLTemp := LMDCreatePIDL(cb);
      CopyMemory(PIDLTemp, PIDL, cb);
      PItemIDList(PAnsiChar(PIDLTemp) + cb - SizeOf(PIDLTemp.mkid.cb)).mkid.cb := 0;
      Result := PIDLTemp;
    end;
  end
  else
    Result := nil;
end;

{ ---------------------------------------------------------------------------- }
function LMDGetIDFromPath(const aPath: String): PItemIDList;
var
  P: PWideChar;
  Flags,
  NumChars: LongWord;
begin
  NumChars:= Length(aPath);
  Flags:= 0;
  P:= StringToOleStr(aPath);
  OLECheck(lDesktopFolder.ParseDisplayName(
      0,
      nil,
      P,
      NumChars,
      Result,
      Flags)
   );
end;

{------------------------------------------------------------------------------}
function LMDPathFromPIDL(PIDL: PItemIDList): String;
begin
  SetLength(Result, Max_Path);
  if not SHGetPathFromIDList(PIDL, PChar(Result)) then
    Result := '';
  if pos(#0, Result) > 0 then
    SetLength(Result, pos(#0, Result) - 1);
end;

{ ---------------------------------------------------------------------------- }
function LMDCreatePIDLList(ID: PItemIDList): TList;
var
  TempID: PItemIDList;
begin
  Result := TList.Create;
  TempID := ID;
  while Assigned(TempID) and (TempID.mkid.cb <> 0) do
  begin
    TempID := LMDCopyPIDL(TempID);
    Result.Insert(0, TempID);
    LMDStripLastID(TempID);
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDGetItemCount(IDList: PItemIDList): Integer;
begin
  Result := 0;
  while Assigned(IDList) and (IDList.mkid.cb <> 0) do
  begin
    Inc(Result);
    IDList:= LMDNextPIDL(IDList);
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCreatePIDL(Size: Integer): PItemIDList;
begin
  if  Size <= 0 then
    Result := nil
  else

    Result := Malloc.Alloc(Size);

  if Assigned(Result) then
    ZeroMemory(Result, Size);
end;

{ ---------------------------------------------------------------------------- }
procedure LMDDisposePIDL(PIDL: PItemIDList);
begin
  if  Assigned(PIDL)  then
    if  Assigned(LMDShPIDLFree) then
      LMDShPIDLFree(PIDL)
    else
      MAlloc.Free(PIDL);
end;

procedure LMDShPIDLsFree(var PIDLs: array of PItemIDList);
var
  i: integer;
begin
  for i := Low(PIDLs) to High(PIDLs) do
    begin
      LMDDisposePIDL(PIDLs[i]);
      PIDLs[i] := nil;
    end;

end;

function LMDSamePIDL(ID1, ID2: PItemIDList): Boolean;
begin
  if (ID1=nil) or (ID2 = nil) then
    result := true
  else if (ID1=nil) or (ID2 = nil) then
    result := false
  else
    Result:= lDesktopFolder.CompareIDs(0, ID1, ID2) = 0;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDDestroyPIDLList(List: TList);
var
  I: Integer;
begin
  If List = nil then Exit;
  for I:= 0 to List.Count-1 do
    LMDDisposePIDL(PItemIDList(List[I]));
  List.Free;
end;

{------------------------------------------------------------------------------}

function LMDSHGetFileInfo(const pszPath: string; uFlags: UINT;
    var psfi: TSHFileInfo; dwFileAttributes: DWORD = 0): DWORD;
begin

  Result := SHGetFileInfo(PChar(pszPath), dwFileAttributes, psfi,
    SizeOf(psfi), uFlags);

end;

function LMDSHGetFileInfo(aPIDL: PItemIDList; uFlags: UINT;
    var psfi: TSHFileInfo; dwFileAttributes: DWORD = 0): DWORD;
begin
  uFlags := SHGFI_PIDL or uFlags;
  psfi.dwAttributes := uFlags;

  Result := SHGetFileInfo(PChar(aPIDL), dwFileAttributes, psfi,
              SizeOf(psfi), uFlags);

end;

const
  shell32 = 'shell32.dll';

procedure GetFunctions;
begin
  hShell32 := LoadLibrary(shell32);
  if hShell32 <> 0 then
    begin

      LMDShPIDLClone        := GetProcAddress(hShell32, PChar(18));
      LMDShPIDLCloneFirst   := GetProcAddress(hShell32, PChar(19));
      LMDShPIDLCombine      := GetProcAddress(hShell32, PChar(25));
      LMDShPIDLGetNext      := GetProcAddress(hShell32, PChar(153));
      LMDShPIDLFindLastID   := GetProcAddress(hShell32, PChar(16));
      fLMDShPIDLIsEqual     := GetProcAddress(hShell32, PChar(21));
      LMDShPIDLRemoveLastID := GetProcAddress(hShell32, PChar(17));
      LMDShPIDLGetSize      := GetProcAddress(hShell32, PChar(152));
      LMDShPIDLFree         := GetProcAddress(hShell32, PChar(155));

    end;
end;

procedure InitUnit;

begin
  GetFunctions;

  OLECheck(SHGetDesktopFolder(lDesktopFolder));

  OLECheck(SHGetSpecialFolderLocation(Application.Handle, CSIDL_DESKTOP, lDesktopID));
  OleCheck(SHGetMalloc(Malloc));
end;

initialization
  InitUnit;

finalization
  lDesktopFolder := nil;
  lDesktopID := nil;
  Malloc:=nil;
  if hShell32 <> 0 then
    begin
      FreeLibrary(hShell32);
      hShell32 := 0;
    end;

end.

