unit LMDShDragDrop;
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

LMDShDragDrop unit (DS)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

{
  ##############################################################################
  # Author:             LMD Innovative (DS)
  # Created:            September 2001
  # Description:
  #                     Contains shell virtual List View
  # State:
  # Comments:
  # ToDo:
  #---------------------------------- CHANGES ----------------------------------
  # Author:             VO
  # Date:               13 sep 2004
  # Description:        [*] Delphi-8 support
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:             VO
  # Date:               9 December 2003
  # Description:        Decrease memory use via open array FFormats
  #                     fixed memory leaks in TLMDShellDataObject.Destroy;
  ##############################################################################
}

interface
uses
  Windows,
  ShlObj,
  ActiveX,
  Classes,

  LMDShBase,
  LMDShPIDL;

type
  {****************************************************************************}
  TLMDShellFormatArray = array[0..255] of TFormatEtc;

  {****************************************************************************}
  TLMDShellDropSource = class(TInterfacedObject, IDropSource)
  public
    function GiveFeedback(dwEffect: Longint): HResult; stdcall;
    function QueryContinueDrag(fEscapePressed: BOOL; grfKeyState: Longint): HResult; stdcall;
  end;

  {****************************************************************************}

  TLMDShellDataObject = class(TInterfacedObject, IDataObject)
  private
    { internal variables }
    FPIDLS              : TLMDShellPIDLS;
    FFormats            : array of TFormatEtc;
    FPIDLS_Buffer       : TMemoryStream;
    FPaths_Buffer       : TMemoryStream;
  public
    { constructor / destructor }
    constructor Create(aPIDLS : TLMDShellPIDLS);
    destructor Destroy; override;

    { methods }

    function DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function DUnadvise(dwConnection: Longint): HResult; stdcall;
    function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult; stdcall;
    function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
    function SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult; stdcall;

  end;

  {****************************************************************************}

  TLMDShellEnumFormatEtc = class(TInterfacedObject, IEnumFormatEtc)
  private
    { property variables }
    FCurrentIndex       : Integer;
    FFormats            : array of TFormatEtc;
  public
    { constructor / destructor }
    constructor Create(const AFormats : array of TFormatEtc);

    { methods }

    function Clone(out Enum: IEnumFormatEtc): HResult; stdcall;
    function Next(celt: Longint; out elt; pceltFetched: PLongint): HResult; stdcall;
    function Reset: HResult; stdcall;
    function Skip(celt: Longint): HResult; stdcall;

    { properties }
    property CurrentIndex : Integer
      read FCurrentIndex
      write FCurrentIndex;

  end;

var
  LMDShPIDLCFormat : word;

implementation
uses
  Sysutils,

  LMDShMisc;

{** TLMDShellDropSource *******************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
function TLMDShellDropSource.GiveFeedback(dwEffect: Longint): HResult;
begin
  Result := DRAGDROP_S_USEDEFAULTCURSORS;
end;

{------------------------------------------------------------------------------}
function TLMDShellDropSource.QueryContinueDrag(fEscapePressed: BOOL; grfKeyState: Longint): HResult;
begin
  if fEscapePressed then
    Result := DRAGDROP_S_CANCEL
  else
    if IsElement(MK_LBUTTON, grfKeyState) then
      Result := S_OK
    else
      Result := DRAGDROP_S_DROP;
end;

{** TLMDShellDataObject *******************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDShellDataObject.Create(aPIDLS : TLMDShellPIDLS);
var
  i : integer;
begin
  inherited Create;

  FPIDLS := TLMDShellPIDLS.Create;

  if aPIDLS <> nil then
    begin
      FPIDLS.Count := aPIDLS.count;
      for i := 0 to aPIDLS.count-1 do
        FPIDLS[i] := aPIDLS[i];
    end;

  FPIDLS_Buffer := nil;
  FPaths_Buffer := nil;

  SetLength(FFormats, 4);
  FFormats[0].cfFormat := LMDShPIDLCFormat;
  FFormats[0].ptd      := nil;
  FFormats[0].dwAspect := DVASPECT_CONTENT;
  FFormats[0].lIndex   := -1;
  FFormats[0].tymed    := TYMED_HGLOBAL;

  FFormats[1].cfFormat := CF_HDROP;
  FFormats[1].ptd      := nil;
  FFormats[1].dwAspect := DVASPECT_CONTENT;
  FFormats[1].lIndex   := -1;
  FFormats[1].tymed    := TYMED_HGLOBAL;

  FFormats[2].cfFormat := CF_TEXT;
  FFormats[2].ptd      := nil;
  FFormats[2].dwAspect := DVASPECT_CONTENT;
  FFormats[2].lIndex   := -1;
  FFormats[2].tymed    := TYMED_HGLOBAL;

  FFormats[3].cfFormat := 0;
  FFormats[3].ptd      := nil;
  FFormats[3].dwAspect := 0;
  FFormats[3].lIndex   := 0;
  FFormats[3].tymed    := 0;
end;

{------------------------------------------------------------------------------}
destructor TLMDShellDataObject.Destroy;
begin
  FPIDLS.Free;
  if FPIDLS_Buffer <> nil then FPIDLS_Buffer.Free;
  if FPaths_Buffer <> nil then FPaths_Buffer.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.DAdvise{(const formatetc: TFormatEtc; advf: Longint;
  const advSink: IAdviseSink; out dwConnection: Longint): HResult};
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.DUnadvise(dwConnection: Longint): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.EnumDAdvise(out enumAdvise: IEnumStatData): HResult;
begin
  Result := OLE_E_ADVISENOTSUPPORTED;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.EnumFormatEtc(dwDirection: Longint;
  out enumFormatEtc: IEnumFormatEtc): HResult;
begin
  if (dwDirection = DATADIR_GET) then
    begin
      enumFormatEtc := TLMDShellEnumFormatEtc.Create(FFormats);
      Result := S_OK;
    end
  else
    begin
      enumFormatEtc := nil;
      Result := E_NOTIMPL;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.GetCanonicalFormatEtc(

    const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult;

begin
  formatetcOut := formatetc;
  formatetcOut.ptd := nil;
  Result := DATA_S_SAMEFORMATETC;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.GetData(

    const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult;

  procedure StreamToMedium(Stream: TMemoryStream);
  var
    HMem          : THandle;
    Buff          : Pointer;
  begin
    HMem := GlobalAlloc(GMEM_SHARE or GMEM_MOVEABLE or GMEM_ZEROINIT, Stream.Size);
    Buff := GlobalLock(HMem);
    Move(Stream.Memory^, Buff^, Stream.Size);
    GlobalUnlock(HMem);
    medium.hGlobal := HMem;
  end;

var
  I             : Integer;
  Count         : integer;
  Offset        : UINT;
  FName         : AnsiString;//[VB April 2012]
  DF            : TDropFiles;
  tmpPIDL       : PItemIDList;
begin
  Result := QueryGetData(formatetcIn);
  if Result <> S_OK then Exit;

  medium.tymed := TYMED_HGLOBAL;
  medium.hGlobal := 0;
  medium.unkForRelease := nil;
  if formatetcIn.cfFormat = LMDShPIDLCFormat then
    begin
      if FPIDLS_Buffer = nil then
        begin
          FPIDLS_Buffer := TMemoryStream.Create;
          FPIDLS_Buffer.Position := 0;
          Count := FPIDLS.count-1;
          FPIDLS_Buffer.Write(Count, SizeOf(Count));
          Offset := ((SizeOf(UINT) * 2) + (Count * SizeOf(UINT)));
          for i := 0 to FPIDLS.count-1 do
            begin
              FPIDLS_Buffer.Write(Offset, SizeOf(UINT));
              Inc(Offset, LMDShPIDLGetSize(FPIDLS[I]));
            end;
          for i := 0 to FPIDLS.count-1 do
            LMDPIDLToStream(FPIDLS[I], FPIDLS_Buffer);
        end;

      StreamToMedium(FPIDLS_Buffer);
    end
  else
  if formatetcIn.cfFormat = CF_TEXT then
    begin
    end
  else
  if formatetcIn.cfFormat = CF_HDROP then
    begin
      if FPaths_Buffer = nil then
        begin
          FPaths_Buffer := TMemoryStream.Create;
          FPaths_Buffer.Position := 0;

          ZeroMemory(@DF, SizeOf(DF));
          DF.pFiles := SizeOf(DF);
          FPaths_Buffer.Write(DF, SizeOf(DF));

          for i := 1 to FPIDLS.Count-1 do
            begin
              tmpPIDL := LMDShPIDLCombine(FPIDLS[0], FPIDLS[i]);
              FName := AnsiString(LMDPathFromPIDL(tmpPIDL));
              LMDShPIDLFree(tmpPIDL);
              FName := FName + #0;

              FPaths_Buffer.Write(FName[1], Length(FName));

            end;
          Offset := 0;
          FPaths_Buffer.Write(Offset, 1);
        end;

      StreamToMedium(FPaths_Buffer);
  end
else
  begin
    Result := DV_E_FORMATETC;
    Exit;
  end;
  if medium.hGlobal = 0 then
    Result := E_OUTOFMEMORY
  else
    Result := S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.GetDataHere{(const formatetc: TFormatEtc; out medium: TStgMedium): HResult};
begin
  Result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.QueryGetData(

    const formatetc: TFormatEtc): HResult;

var
  i     : integer;
  Count : Integer;
begin
  Count := High(FFormats) - 1;
  for I := Low(FFormats) to High(FFormats) do
    if FFormats[i].cfFormat = 0 then
      begin
        Count := i;
        Break;
      end;
  Result := DV_E_FORMATETC;
  if (formatetc.dwAspect <> DVASPECT_CONTENT) then Exit;
  for i := 0 to Count-1 do
    if FFormats[i].cfFormat = formatetc.cfFormat then
      begin
        Result := DV_E_TYMED;
        if (FFormats[i].tymed and formatetc.tymed) <> 0 then
          begin
            Result := S_OK;
            Exit;
          end;
      end;
end;

{------------------------------------------------------------------------------}
function TLMDShellDataObject.SetData{(const formatetc: TFormatEtc; var medium: TStgMedium;
  fRelease: BOOL): HResult};
begin
  Result := E_NOTIMPL;
end;

{** TLMDShellEnumFormatEtc ****************************************************}
{-- private -------------------------------------------------------------------}
{-- protected -----------------------------------------------------------------}
{-- public --------------------------------------------------------------------}
constructor TLMDShellEnumFormatEtc.Create(const AFormats : array of TFormatEtc);//TLMDShellFormatArray);
var
  i: integer;
begin
  inherited Create;
  SetLength(FFormats, Length(AFormats));
  for i := Low(AFormats) to High(AFormats) do
    FFormats[i] := AFormats[i]; 
  FCurrentIndex := 0;
end;

{------------------------------------------------------------------------------}
function TLMDShellEnumFormatEtc.Clone(out Enum: IEnumFormatEtc): HResult;
begin
  Enum := TLMDShellEnumFormatEtc.Create(FFormats);
  Result := S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDShellEnumFormatEtc.Next(

    celt: Longint; out elt; pceltFetched: PLongint): HResult;

var
  i     : ULONG;
  Count : integer;

begin
  Count := High(FFormats) - 1;
  for I := Low(FFormats) to High(FFormats) do
    if FFormats[I].cfFormat = 0 then
      begin
        Count := i;
        Break;
      end;
  i := 0;
  while (i < ULONG(celt)) and (FCurrentIndex < Count) do
    begin

      TLMDShellFormatArray(elt)[i] := FFormats[FCurrentIndex];

      Inc(i);
      Inc(FCurrentIndex);
    end;

  if pceltFetched <> nil  then

    pceltFetched^ := i;

  if i = 0 then
    begin
      Result := S_FALSE;
      Exit;
    end;

  if FCurrentIndex > Count then
    Result := S_FALSE
  else
    Result := S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDShellEnumFormatEtc.Reset: HResult;
begin
  FCurrentIndex := 0;
  Result := S_OK;
end;

{------------------------------------------------------------------------------}
function TLMDShellEnumFormatEtc.Skip(celt: Longint): HResult;
var
  i     : integer;
  Count : integer;
begin
  Inc(FCurrentIndex, celt);
  Count := High(FFormats) - 1;
  for i := Low(FFormats) to High(FFormats) do
    if FFormats[i].cfFormat = 0 then
      begin
        Count := i;
        Break;
      end;
  if FCurrentIndex >= Count then
    begin
      FCurrentIndex := Count;
      Result := S_FALSE
    end
  else
    Result := S_OK;
end;

initialization
  LMDShPIDLCFormat := RegisterClipboardFormat(CFSTR_SHELLIDLIST);
end.
