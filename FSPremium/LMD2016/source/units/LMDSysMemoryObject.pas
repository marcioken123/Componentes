unit LMDSysMemoryObject;
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

LMDSysMemoryObject unit (JH)
----------------------------
Contains info about system memory properties

Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes,
  LMDSysObject, LMDSysBase, LMDSysConst;

type
  TLMDSysMemoryDisplayInfo=(mlpidTotalPhysicalMemory, mlpidAvailablePhysicalMemory,
                            mlpidMemoryLoad, mlpidTotalPageFile, mlpidAvailablePageFile,
                            mlpidTotalVirtual, mlpidAvailableVirtual, mlpidAvailableExtendedVirtual,
                            mlpidPageSize, mlpidAllocationGranularity, mlpidMinAppAddress,
                            mlpidMaxAppAddress);
  TLMDSysMemoryDisplayInfos=set of TLMDSysMemoryDisplayInfo;

const
  def_TLMDSysMemoryDisplayInfos=[mlpidTotalPhysicalMemory, mlpidAvailablePhysicalMemory,
                                 mlpidMemoryLoad, mlpidTotalPageFile, mlpidAvailablePageFile,
                                 mlpidTotalVirtual, mlpidAvailableVirtual, mlpidAvailableExtendedVirtual,
                                 mlpidPageSize, mlpidAllocationGranularity, mlpidMinAppAddress,
                                 mlpidMaxAppAddress];

  LMDSysMemoryProps:array[TLMDSysMemoryDisplayInfo] of TLMDSysProperty =(
    (Name: sLMDSysMemoryPropTitleTotalPhysicalMemory; Description: sLMDSysMemoryPropDescTotalPhysicalMemory),
    (Name: sLMDSysMemoryPropTitleAvailablePhysicalMemory; Description: sLMDSysMemoryPropDescAvailablePhysicalMemory),
    (Name: sLMDSysMemoryPropTitleMemoryLoad; Description: sLMDSysMemoryPropDescMemoryLoad),
    (Name: sLMDSysMemoryPropTitleTotalPageFile; Description: sLMDSysMemoryPropDescTotalPageFile),
    (Name: sLMDSysMemoryPropTitleAvailablePageFile; Description: sLMDSysMemoryPropDescAvailablePageFile),
    (Name: sLMDSysMemoryPropTitleTotalVirtual; Description: sLMDSysMemoryPropDescTotalVirtual),
    (Name: sLMDSysMemoryPropTitleAvailableVirtual; Description: sLMDSysMemoryPropDescAvailableVirtual),
    (Name: sLMDSysMemoryPropTitleAvailableExtendedVirtual; Description: sLMDSysMemoryPropDescAvailableExtendedVirtual),
    (Name: sLMDSysMemoryPropTitleAllocationGranularity; Description: sLMDSysMemoryPropDescAllocationGranularity),
    (Name: sLMDSysMemoryPropTitlePageSize; Description: sLMDSysMemoryPropDescPageSize),
    (Name: sLMDSysMemoryPropTitleMinAppAddress; Description: sLMDSysMemoryPropDescMinAppAddress),
    (Name: sLMDSysMemoryPropTitleMaxAppAddress; Description: sLMDSysMemoryPropDescMaxAppAddress));

type
  TLMDSysMemoryDisplayFormat=(mdfByte, mdfKB, mdfMB);

const
  sLMDSysMemory:array[TLMDSysMemoryDisplayFormat] of String=('Bytes', 'KB', 'MB');

type
  { ************************************************************************** }
  TLMDSysMemoryObject = class(TLMDSysObject)
  private
    FMemoryLoad,
    FTotalPhys,
    FAvailPhys,
    FTotalPageFile,
    FAvailPageFile,
    FTotalVirtual,
    FAvailVirtual,
    FPageSize,
    FMinAppAddress,
    FMaxAppAddress,
    FAvailExtendedVirtual,
    FAllocGranularity: Int64;
    FDisplayInfo:TLMDSysMemoryDisplayInfos;
    FDisplayFormat:TLMDSysMemoryDisplayFormat;
    procedure SetDummyCardinal(index: Integer; aValue: Int64);
    procedure SetDisplayInfo(const Value: TLMDSysMemoryDisplayInfos);
    procedure SetDisplayFormat(const Value: TLMDSysMemoryDisplayFormat);
    function GetValue(index: Integer): Int64;
  protected
    procedure RegisterProperties; override;
  public
    constructor Create; override;
    //    procedure GetValues(aText: TStrings); override;
    procedure Refresh; override;
    procedure Apply; override;
    function GetElementTitle : string; override;
    function GetElementDescription : string; override;
    function GetElementType : TLMDSysInfoType; override;
  published
    //percentage value of memory load
    property MemoryLoad: Int64 index 0 read GetValue write SetDummyCardinal stored false;
    //amount (in bytes) of total physical memory installed in the system
    property TotalPhysicalMemory: Int64 index 1 read GetValue write SetDummyCardinal stored false;
    //amount (in bytes) of available (free) physical memory installed in the system
    property AvailablePhysicalMemory: Int64 index 2 read GetValue write SetDummyCardinal stored false;
    //amount (in bytes) of total page file memory prepared for use in the system
    property TotalPageFile: Int64 index 3 read GetValue write SetDummyCardinal stored false;
    //amount (in bytes) of free page file memory prepared for use in the system
    property AvailablePageFile: Int64 index 4 read GetValue write SetDummyCardinal stored false;
    //amount (in bytes) of total memory (physical + page file) prepared for use in the system
    property TotalVirtual: Int64 index 5 read GetValue write SetDummyCardinal stored false;
    //amount (in bytes) of available memory (physical + page file) prepared for use in the system
    property AvailableVirtual: Int64 index 6 read GetValue write SetDummyCardinal stored false;
    //size (in bytes) of one page in the system memory
    property PageSize: Int64 index 7 read GetValue write SetDummyCardinal stored false;
    //amount of bytes allocated at least in one allocation step -> this means that it is not possible to allocate less!
    property AllocationGranularity: Int64 index 8 read GetValue write SetDummyCardinal stored false;
    //minimal application adress
    property MinAppAddress: Int64 index 9 read GetValue write SetDummyCardinal stored false;
    //maximal application adress
    property MaxAppAddress: Int64 index 10 read GetValue write SetDummyCardinal stored false;
    // Size of unreserved and uncommitted memory in the extended portion of the virtual address space of the calling process, in bytes.
    property AvailExtendedVirtual: Int64 index 11 read GetValue write SetDummyCardinal stored false;

    property MemoryFormat:TLMDSysMemoryDisplayFormat read FDisplayFormat write SetDisplayFormat default mdfByte;
    property DisplayInfo:TLMDSysMemoryDisplayInfos read FDisplayInfo write SetDisplayInfo default def_TLMDSysMemoryDisplayInfos;
  end;

implementation
uses
  SysUtils, LMDSysIn;

type
  DWORDLONG = Int64;
  {$EXTERNALSYM DWORDLONG}
  _MEMORYSTATUSEX = packed record
    dwLength: DWORD;
    dwMemoryLoad: DWORD;
    ullTotalPhys: DWORDLONG;
    ullAvailPhys: DWORDLONG;
    ullTotalPageFile: DWORDLONG;
    ullAvailPageFile: DWORDLONG;
    ullTotalVirtual: DWORDLONG;
    ullAvailVirtual: DWORDLONG;
    ullAvailExtendedVirtual: DWORDLONG;
  end;
  {$EXTERNALSYM _MEMORYSTATUSEX}
  TMemoryStatusEx = _MEMORYSTATUSEX;
  {$ifdef LMDCOMP12}
  {$EXTERNALSYM TMemoryStatusEx}
  {$endif}
  MEMORYSTATUSEX = _MEMORYSTATUSEX;
  {$EXTERNALSYM MEMORYSTATUSEX}

{------------------------------------------------------------------------------}

function GlobalMemoryStatusEx(var lpBuffer: TMemoryStatusEx): BOOL; stdcall;
type
  TGlobalMemoryStatusEx = function(var mstatex: TMemoryStatusEx): BOOL; stdcall;
var
  FNGlobalMemoryStatusEx: TGlobalMemoryStatusEx;
begin
  FNGlobalMemoryStatusEx := TGlobalMemoryStatusEx(GetProcAddress(GetModuleHandle(kernel32), 'GlobalMemoryStatusEx'));
  if not Assigned(FNGlobalMemoryStatusEx) then
    begin
      SetLastError(ERROR_CALL_NOT_IMPLEMENTED);
      result := False;
    end
  else
    result:=FNGlobalMemoryStatusEx(lpBuffer);
end;

{ **************************************************************************** }
{ --------------------------------- private ---------------------------------- }
procedure TLMDSysMemoryObject.SetDummyCardinal(index: Integer; aValue: Int64);
begin
end;

{------------------------------------------------------------------------------}
procedure TLMDSysMemoryObject.SetDisplayInfo(const Value: TLMDSysMemoryDisplayInfos);
begin
  if FDisplayInfo<>Value then
    begin
      FDisplayInfo := Value;
      RegisterProperties;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysMemoryObject.SetDisplayFormat(const Value: TLMDSysMemoryDisplayFormat);
begin
  if Value<>FDisplayFormat then
    begin
      FDisplayFormat:=Value;
      Refresh;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMemoryObject.GetValue(index: Integer): Int64;
begin
  Result:= 0;
  if FInstantUpdate then Refresh;
  case index of
    0: Result:= FMemoryLoad;
    1: Result:= FTotalPhys;
    2: Result:= FAvailPhys;
    3: Result:= FTotalPageFile;
    4: Result:= FAvailPageFile;
    5: Result:= FTotalVirtual;
    6: Result:= FAvailVirtual;
    7: Result:= FPageSize;
    8: Result:= FAllocGranularity;
    9: Result:= FMinAppAddress;
    10: Result:= FMaxAppAddress;
    11: Result:= FAvailExtendedVirtual;
  end;
end;

{ --------------------------------- protected -------------------------------- }
procedure TLMDSysMemoryObject.RegisterProperties;
var
  i:TLMDSysMemoryDisplayInfo;
begin
 FPropertiesDesc.Clear;
 for i:=Low(TLMDSysMemoryDisplayInfo) to High(TLMDSysMemoryDisplayInfo) do
   if i in FDisplayInfo then
     FPropertiesDesc.Add(Ord(i), LMDSysMemoryProps[i].Name, LMDSysMemoryProps[i].Description);
end;

{ --------------------------------- public ----------------------------------- }

constructor TLMDSysMemoryObject.Create;
begin
  FDisplayInfo:=def_TLMDSysMemoryDisplayInfos;
  inherited Create;
end;

{ ---------------------------------------------------------------------------- }

//procedure TLMDSysMemoryObject.GetValues(aText: TStrings);
//begin
//  aText.Add(IntToStr(FMemoryLoad));
//  aText.Add(IntToStr(FTotalPhys));
//  aText.Add(IntToStr(FAvailPhys));
//  aText.Add(IntToStr(FTotalPageFile));
//  aText.Add(IntToStr(FAvailPageFile));
//  aText.Add(IntToStr(FTotalVirtual));
//  aText.Add(IntToStr(FAvailVirtual));
//  aText.Add(IntToStr(FPageSize));
//  aText.Add(IntToStr(FMinAppAddress));
//  aText.Add(IntToStr(FMaxAppAddress));
//end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysMemoryObject.Refresh;
var
  i:TLMDSysMemoryDisplayInfo;
  mstat: TMemoryStatus;
  mstatex: TMemoryStatusEx;
  si: TSystemInfo;

const
  MB = 1024 * 1024;

  function ConvertBytes(const Value:DWORDLong):DWORDLong;
  begin
    case FDisplayFormat of
      mdfKB: result:=Round(Value/1024);
      mdfMB: result:=Round(Value/MB);
    else
      result:=Value;
    end;
  end;

  function ConvertToString(const Value:DWORDLong):String;
  begin
    result:=IntToStr(ConvertBytes(Value))+' '+sLMDSysMemory[FDisplayFormat];
  end;
begin
  DoProgress(sLMDSysMemoryObjectsTitle, 100, 0);
  FPropertiesDesc.InvalidateProperties;
  // (GlobalMemoryStatus incorrectly shows information about memory on machine with >4Gb of memory)
  FillChar(mstatex, SizeOf(mstatex), 0);
  mstatex.dwLength:=SizeOf(mstatex);
  if LMDSIWindowsNT and GlobalMemoryStatusEx(mstatex) then  // now we have double check, if [..]Ex fails, we use default function
    begin
      with mstatex do
        begin
          FMemoryLoad:= dwMemoryLoad;
          FTotalPhys:= ullTotalPhys;
          FAvailPhys:= ullAvailPhys;
          FTotalPageFile:= ullTotalPageFile;
          FAvailPageFile:= ullAvailPageFile;
          FTotalVirtual:= ullTotalVirtual;
          FAvailVirtual:= ullAvailVirtual;
          FAvailExtendedVirtual := ullAvailExtendedVirtual;
        end;
      end
  else
    begin
      GlobalMemoryStatus(mstat);
      DoProgress(sLMDSysMemoryObjectsTitle, 100, 40);
      with mstat do
        begin
          FMemoryLoad:= dwMemoryLoad;
          FTotalPhys:= dwTotalPhys;
          FAvailPhys:= dwAvailPhys;
          FTotalPageFile:= dwTotalPageFile;
          FAvailPageFile:= dwAvailPageFile;
          FTotalVirtual:= dwTotalVirtual;
          FAvailVirtual:= dwAvailVirtual;
          FAvailExtendedVirtual := 0;
        end;
    end;
  GetSystemInfo(si);
  DoProgress(sLMDSysMemoryObjectsTitle, 80, 0);
  with si do
    begin
      FPageSize:= dwPageSize;
      FMinAppAddress:= Cardinal(lpMinimumApplicationAddress);
      FMaxAppAddress:= Cardinal(lpMaximumApplicationAddress);
      FAllocGranularity:= dwAllocationGranularity;
    end;

  for i:=Low(TLMDSysMemoryDisplayInfo) to High(TLMDSysMemoryDisplayInfo) do
    if i in FDisplayInfo then
      with FPropertiesDesc.PropertyByID(Ord(i)) do
        case i of
          mlpidTotalPhysicalMemory: Text := ConvertToString(FTotalPhys);
          mlpidAvailablePhysicalMemory: Text := ConvertToString(FAvailPhys);
          mlpidMemoryLoad: Text := IntToStr(FMemoryLoad)+'%';
          mlpidTotalPageFile: Text := ConvertToString(FTotalPageFile);
          mlpidAvailablePageFile: Text :=ConvertToString(FAvailPageFile);
          mlpidTotalVirtual: Text :=ConvertToString(FTotalVirtual);
          mlpidAvailableVirtual: Text := ConvertToString(FAvailVirtual);
          mlpidPageSize: Text := IntToStr(FPageSize)+' '+sLMDSysMemory[mdfByte];
          mlpidAllocationGranularity: Text := IntToStr(FAllocGranularity)+' '+sLMDSysMemory[mdfByte];
          mlpidMinAppAddress: Text := IntToStr(FMinAppAddress);
          mlpidMaxAppAddress: Text := IntToStr(FMaxAppAddress);
          mlpidAvailableExtendedVirtual: Text := ConvertToString(FAvailExtendedVirtual);
        end;
  DoProgress('', 100, 0);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDSysMemoryObject.Apply;
begin
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMemoryObject.GetElementTitle : string;
begin
  result := sLMDSysMemoryObjectsTitle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMemoryObject.GetElementDescription : string;
begin
  result := sLMDSysMemoryObjectsDesc;
end;

{ ---------------------------------------------------------------------------- }
function TLMDSysMemoryObject.GetElementType : TLMDSysInfoType;
begin
  result := itMemory;
end;

end.
