unit wwrichobjinfo;
{
//
// Components : OLE Object Information for Richedit
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
interface

uses
  Windows, WinTypes, Messages, SysUtils, Classes,
  Controls, comobj, forms,
  RichEdit, wwrichole, olectnrs, activex, OleDlg, oleconst,
  wwriched;

type
  TwwOleUIObjInfo = class(TInterfacedObject, IOleUIObjInfo)
  private
    FRichEdit: TwwCustomRichEdit;
    FReObject: TReObject;
  public
    constructor Create(RichEdit: TwwCustomRichEdit; ReObject: TReObject);
    function GetObjectInfo(dwObject: Longint;
      var dwObjSize: Longint; var lpszLabel: PChar;
      var lpszType: PChar; var lpszShortType: PChar;
      var lpszLocation: PChar): HResult; stdcall;
    function GetConvertInfo(dwObject: Longint; var ClassID: TCLSID;
      var wFormat: Word; var ConvertDefaultClassID: TCLSID;
      var lpClsidExclude: PCLSID; var cClsidExclude: Longint): HResult; stdcall;
    function ConvertObject(dwObject: Longint;
      const clsidNew: TCLSID): HResult; stdcall;
    function GetViewInfo(dwObject: Longint; var hMetaPict: HGlobal;
      var dvAspect: Longint; var nCurrentScale: Integer): HResult; stdcall;
    function SetViewInfo(dwObject: Longint; hMetaPict: HGlobal;
      dvAspect: Longint; nCurrentScale: Integer;
      bRelativeToOrig: BOOL): HResult; stdcall;
  end;

  TwwOleUILinkInfo = class(TInterfacedObject, IOleUILinkInfo)
  private
    FReObject: TReObject;
    FRichEdit: TwwCustomRichEdit;
    FOleLink: IOleLink;
  public
    constructor Create(RichEdit: TwwCustomRichEdit; ReObject: TReObject);
    function GetNextLink(dwLink: Longint): Longint; stdcall;
    function SetLinkUpdateOptions(dwLink: Longint;
      dwUpdateOpt: Longint): HResult; stdcall;
    function GetLinkUpdateOptions(dwLink: Longint;
      var dwUpdateOpt: Longint): HResult; stdcall;
    function SetLinkSource(dwLink: Longint; pszDisplayName: PChar;
      lenFileName: Longint; var chEaten: Longint;
      fValidateSource: BOOL): HResult; stdcall;
    function GetLinkSource(dwLink: Longint; var pszDisplayName: PChar;
      var lenFileName: Longint; var pszFullLinkType: PChar;
      var pszShortLinkType: PChar; var fSourceAvailable: BOOL;
      var fIsSelected: BOOL): HResult; stdcall;
    function OpenLinkSource(dwLink: Longint): HResult; stdcall;
    function UpdateLink(dwLink: Longint; fErrorMessage: BOOL;
      fErrorAction: BOOL): HResult; stdcall;
    function CancelLink(dwLink: Longint): HResult; stdcall;
    function GetLastUpdate(dwLink: Longint;
      var LastUpdate: TFileTime): HResult;  stdcall;
  end;


implementation

function WStrLen(Str: PWideChar): Integer;
begin
  Result := 0;
  while Str[Result] <> #0 do Inc(Result);
end;

procedure ReleaseObject(var Obj);
begin
  if IUnknown(Obj) <> nil then begin
    IUnknown(Obj) := nil;
  end;
end;

function OleSetDrawAspect(OleObject: IOleObject; Iconic: Boolean;
  IconMetaPict: HGlobal; var DrawAspect: Longint): HResult;
var
  OleCache: IOleCache;
  EnumStatData: IEnumStatData;
  OldAspect, AdviseFlags, Connection: Longint;
  TempMetaPict: HGlobal;
  FormatEtc: TFormatEtc;
  Medium: TStgMedium;
  ClassID: TCLSID;
  StatData: TStatData;
begin
  Result := S_OK;
  OldAspect := DrawAspect;
  if Iconic then begin
    DrawAspect := DVASPECT_ICON;
    AdviseFlags := ADVF_NODATA;
  end
  else begin
    DrawAspect := DVASPECT_CONTENT;
    AdviseFlags := ADVF_PRIMEFIRST;
  end;
  if (DrawAspect <> OldAspect) or (DrawAspect = DVASPECT_ICON) then begin
    Result := OleObject.QueryInterface(IOleCache, OleCache);
    if Succeeded(Result) then
    try
      if DrawAspect <> OldAspect then begin
        FillChar(FormatEtc, SizeOf(FormatEtc), 0);
        FormatEtc.dwAspect := DrawAspect;
        FormatEtc.lIndex := -1;
        Result := OleCache.Cache(FormatEtc, AdviseFlags, Connection);
      end;
      if Succeeded(Result) and (DrawAspect = DVASPECT_ICON) then begin
        TempMetaPict := 0;
        if IconMetaPict = 0 then begin
          if Succeeded(OleObject.GetUserClassID(ClassID)) then begin
            TempMetaPict := OleGetIconOfClass(ClassID, nil, True);
            IconMetaPict := TempMetaPict;
          end;
        end;
        try
          FormatEtc.cfFormat := CF_METAFILEPICT;
          FormatEtc.ptd := nil;
          FormatEtc.dwAspect := DVASPECT_ICON;
          FormatEtc.lIndex := -1;
          FormatEtc.tymed := TYMED_MFPICT;
          Medium.tymed := TYMED_MFPICT;
          Medium.hMetaFilePict := IconMetaPict;
          Medium.unkForRelease := nil;
          Result := OleCache.SetData(FormatEtc, Medium, False);
        finally
          DestroyMetaPict(TempMetaPict);
        end;
      end;
      if Succeeded(Result) and (DrawAspect <> OldAspect) then begin
        OleCache.EnumCache(EnumStatData);
        if EnumStatData <> nil then
        try
          while EnumStatData.Next(1, StatData, nil) = 0 do
            if StatData.formatetc.dwAspect = OldAspect then
              OleCache.Uncache(StatData.dwConnection);
        finally
          ReleaseObject(EnumStatData);
        end;
      end;
    finally
      ReleaseObject(OleCache);
    end;
    if Succeeded(Result) and (DrawAspect <> DVASPECT_ICON) then
      OleObject.Update;
  end;
end;


constructor TwwOleUIObjInfo.Create(RichEdit: TwwCustomRichEdit;
  ReObject: TReObject);
begin
  inherited Create;
  FRichEdit := RichEdit;
  FReObject := ReObject;
end;

function OleStdGetFirstMoniker(Moniker: IMoniker): IMoniker;
var
  Mksys: Longint;
  EnumMoniker: IEnumMoniker;
begin
  Result := nil;
  if Moniker <> nil then begin
    if (Moniker.IsSystemMoniker(Mksys) = 0) and
      (Mksys = MKSYS_GENERICCOMPOSITE) then
    begin
      if Moniker.Enum(True, EnumMoniker) <> 0 then Exit;
      EnumMoniker.Next(1, Result, nil);
      ReleaseObject(EnumMoniker);
    end
    else begin
      Result := Moniker;
    end;
  end;
end;

function OleStdGetLenFilePrefixOfMoniker(Moniker: IMoniker): Integer;
var
  MkFirst: IMoniker;
  BindCtx: IBindCtx;
  Mksys: Longint;
  P: PWideChar;
begin
  Result := 0;
  if Moniker <> nil then begin
    MkFirst := OleStdGetFirstMoniker(Moniker);
    if MkFirst <> nil then begin
      if (MkFirst.IsSystemMoniker(Mksys) = 0) and
        (Mksys = MKSYS_FILEMONIKER) then
      begin
        if CreateBindCtx(0, BindCtx) = 0 then begin
          if (MkFirst.GetDisplayName(BindCtx, nil, P) = 0) and (P <> nil) then
          begin
            Result := WStrLen(P);
            CoTaskMemFree(P);
          end;
          ReleaseObject(BindCtx);
        end;
      end;
      ReleaseObject(MkFirst);
    end;
  end;
end;

function CoAllocCStr(const S: string): PChar;
begin
  Result := StrCopy(CoTaskMemAlloc(Length(S) + 1), PChar(S));
end;

function WStrToString(P: PWideChar): string;
begin
  Result := '';
  if P <> nil then begin
    Result := WideCharToString(P);
    CoTaskMemFree(P);
  end;
end;

function GetFullNameStr(const OleObject: IOleObject): string;
var
  P: PWideChar;
begin
  OleObject.GetUserType(USERCLASSTYPE_FULL, P);
  Result := P;
  CoTaskMemFree(P);
end;

function GetDisplayNameStr(const OleLink: IOleLink): string;
var
  P: PWideChar;
begin
  OleLink.GetSourceDisplayName(P);
  Result := P;
  CoTaskMemFree(P);
end;

function GetShortNameStr(OleObject: IOleObject): string;
var
  P: PWideChar;
begin
  OleObject.GetUserType(USERCLASSTYPE_SHORT, P);
  Result := WStrToString(P);
end;

function TwwOleUIObjInfo.GetObjectInfo(dwObject: Longint;
  var dwObjSize: Longint; var lpszLabel: PChar;
  var lpszType: PChar; var lpszShortType: PChar;
  var lpszLocation: PChar): HResult;
begin
  if @dwObjSize <> nil then
    dwObjSize := -1 { Unknown size };
  if @lpszLabel <> nil then
    lpszLabel := CoAllocCStr(GetFullNameStr(FReObject.oleobj));
  if @lpszType <> nil then
    lpszType := CoAllocCStr(GetFullNameStr(FReObject.oleobj));
  if @lpszShortType <> nil then
    lpszShortType := CoAllocCStr(GetShortNameStr(FReObject.oleobj));
  if (@lpszLocation <> nil) then begin
    if Trim(FRichEdit.Title) <> '' then
      lpszLocation := CoAllocCStr(Format('%s - %s',
        [FRichEdit.Title, Application.Title]))
    else
      lpszLocation := CoAllocCStr(Application.Title);
  end;
  Result := S_OK;
end;

function TwwOleUIObjInfo.GetConvertInfo(dwObject: Longint; var ClassID: TCLSID;
  var wFormat: Word; var ConvertDefaultClassID: TCLSID;
  var lpClsidExclude: PCLSID; var cClsidExclude: Longint): HResult;
begin
  FReObject.oleobj.GetUserClassID(ClassID);
  Result := S_OK;
end;

function TwwOleUIObjInfo.ConvertObject(dwObject: Longint;
  const clsidNew: TCLSID): HResult;
begin
  Result := E_NOTIMPL;
end;

function GetIconMetaPict(OleObject: IOleObject; DrawAspect: Longint): HGlobal;
var
  DataObject: IDataObject;
  FormatEtc: TFormatEtc;
  Medium: TStgMedium;
  ClassID: TCLSID;
begin
  Result := 0;
  if DrawAspect = DVASPECT_ICON then begin
    OleObject.QueryInterface(IDataObject, DataObject);
    if DataObject <> nil then begin
      FormatEtc.cfFormat := CF_METAFILEPICT;
      FormatEtc.ptd := nil;
      FormatEtc.dwAspect := DVASPECT_ICON;
      FormatEtc.lIndex := -1;
      FormatEtc.tymed := TYMED_MFPICT;
      if Succeeded(DataObject.GetData(FormatEtc, Medium)) then
        Result := Medium.hMetaFilePict;
      ReleaseObject(DataObject);
    end;
  end;
  if Result = 0 then begin
    OleCheck(OleObject.GetUserClassID(ClassID));
    Result := OleGetIconOfClass(ClassID, nil, True);
  end;
end;

function TwwOleUIObjInfo.GetViewInfo(dwObject: Longint; var hMetaPict: HGlobal;
  var dvAspect: Longint; var nCurrentScale: Integer): HResult;
begin
  if @hMetaPict <> nil then
    hMetaPict := GetIconMetaPict(FReObject.oleobj, FReObject.dvAspect);
  if @dvAspect <> nil then dvAspect := FReObject.dvAspect;
  if @nCurrentScale <> nil then nCurrentScale := 0;
  Result := S_OK;
end;

function TwwOleUIObjInfo.SetViewInfo(dwObject: Longint; hMetaPict: HGlobal;
  dvAspect: Longint; nCurrentScale: Integer;
  bRelativeToOrig: BOOL): HResult;
var
  Iconic: Boolean;
begin
  if Assigned(FRichEdit.RichEditOle) then begin
    case dvAspect of
      DVASPECT_CONTENT:
        Iconic := False;
      DVASPECT_ICON:
        Iconic := True;
      else
        Iconic := FReObject.dvAspect = DVASPECT_ICON;
    end;
    IRichEditOle(FRichEdit.RichEditOle).InPlaceDeactivate;
    Result := OleSetDrawAspect(FReObject.oleobj, Iconic, hMetaPict,
      longint(FReObject.dvAspect));
    if Succeeded(Result) then
      IRichEditOle(FRichEdit.RichEditOle).SetDvaspect(
        Longint(REO_IOB_SELECTION), FReObject.dvAspect);
  end
  else Result := E_NOTIMPL;
end;

procedure LinkError(const Ident: string);
begin
  Application.MessageBox(PChar(Ident), PChar(SLinkProperties),
    MB_OK or MB_ICONSTOP);
end;

constructor TwwOleUILinkInfo.Create(RichEdit: TwwCustomRichEdit;
  ReObject: TReObject);
begin
  inherited Create;
  FReObject := ReObject;
  FRichEdit := RichEdit;
//  OleCheck(FReObject.oleobj.QueryInterface(IID_IOleLink, FOleLink));
  OleCheck(FReObject.oleobj.QueryInterface(IOleLink, FOleLink));
end;

function TwwOleUILinkInfo.GetNextLink(dwLink: Longint): Longint;
begin
  if dwLink = 0 then Result := Longint(FRichEdit)
  else Result := 0;
end;

function TwwOleUILinkInfo.SetLinkUpdateOptions(dwLink: Longint;
  dwUpdateOpt: Longint): HResult;
begin
  Result := FOleLink.SetUpdateOptions(dwUpdateOpt);
  if Succeeded(Result) then FRichEdit.Modified := True;
end;

function TwwOleUILinkInfo.GetLinkUpdateOptions(dwLink: Longint;
  var dwUpdateOpt: Longint): HResult;
begin
  Result := FOleLink.GetUpdateOptions(dwUpdateOpt);
end;

function TwwOleUILinkInfo.SetLinkSource(dwLink: Longint; pszDisplayName: PChar;
  lenFileName: Longint; var chEaten: Longint;
  fValidateSource: BOOL): HResult;
var
  DisplayName: string;
  Buffer: array[0..255] of WideChar;
begin
  Result := E_FAIL;
  if fValidateSource then begin
    DisplayName := pszDisplayName;
    if Succeeded(FOleLink.SetSourceDisplayName(StringToWideChar(DisplayName,
      Buffer, SizeOf(Buffer) div 2))) then
    begin
      chEaten := Length(DisplayName);
      try
        OleCheck(FReObject.oleobj.Update);
      except
        Application.HandleException(FRichEdit);
      end;
      Result := S_OK;
    end;
  end
  else LinkError(SInvalidLinkSource);
end;

function TwwOleUILinkInfo.GetLinkSource(dwLink: Longint; var pszDisplayName: PChar;
  var lenFileName: Longint; var pszFullLinkType: PChar;
  var pszShortLinkType: PChar; var fSourceAvailable: BOOL;
  var fIsSelected: BOOL): HResult;
var
  Moniker: IMoniker;
begin
  if @pszDisplayName <> nil then
    pszDisplayName := CoAllocCStr(GetDisplayNameStr(FOleLink));
  if @lenFileName <> nil then begin
    lenFileName := 0;
    FOleLink.GetSourceMoniker(Moniker);
    if Moniker <> nil then begin
      lenFileName := OleStdGetLenFilePrefixOfMoniker(Moniker);
      ReleaseObject(Moniker);
    end;
  end;
  if @pszFullLinkType <> nil then
    pszFullLinkType := CoAllocCStr(GetFullNameStr(FReObject.oleobj));
  if @pszShortLinkType <> nil then
    pszShortLinkType := CoAllocCStr(GetShortNameStr(FReObject.oleobj));
  Result := S_OK;
end;

function TwwOleUILinkInfo.OpenLinkSource(dwLink: Longint): HResult;
begin
  try
    OleCheck(FReObject.oleobj.DoVerb(OLEIVERB_SHOW, nil, FReObject.olesite,
      0, FRichEdit.Handle, FRichEdit.ClientRect));
  except
    Application.HandleException(FRichEdit);
  end;
  Result := S_OK;
end;

function TwwOleUILinkInfo.UpdateLink(dwLink: Longint; fErrorMessage: BOOL;
  fErrorAction: BOOL): HResult;
begin
  try
    OleCheck(FReObject.oleobj.Update);
  except
    Application.HandleException(FRichEdit);
  end;
  Result := S_OK;
end;

function TwwOleUILinkInfo.CancelLink(dwLink: Longint): HResult;
begin
  LinkError(SCannotBreakLink);
  Result := E_NOTIMPL;
end;

function TwwOleUILinkInfo.GetLastUpdate(dwLink: Longint;
  var LastUpdate: TFileTime): HResult;
begin
  Result := S_OK;
end;
{
function ResStr(const Ident: string): string;
begin
  Result := Ident;
end;
}
end.
