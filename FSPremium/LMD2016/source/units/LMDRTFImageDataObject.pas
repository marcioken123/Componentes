unit LMDRTFImageDataObject;
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

LMDRTFImageDataObject unit (RM)
-------------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Graphics, ActiveX,
  LMDRTFInt;

type

  {****************************************************************************}
  TLMDRTFImageDataObject = class(TInterfacedObject, IDataObject)
  private
    FBitmap : TBitmap;
  public
    constructor Create;
    destructor Destroy; override;
  function GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult; stdcall;
    function QueryGetData(const formatetc: TFormatEtc): HResult; stdcall;
    function GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult; stdcall;
    function SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult; stdcall;
    function EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult; stdcall;
    function DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult; stdcall;
    function DUnadvise(dwConnection: Longint): HResult; stdcall;
    function EnumDAdvise(out enumAdvise: IEnumStatData): HResult; stdcall;
  function GetOleObject(OleClientSite : IOleClientSite; Storage : IStorage) : IOleObject;
    procedure InsertBitmap(RichEditOle : IRichEditOle; Bitmap : TBitmap);
    procedure SetBitmap(Bitmap : TBitmap);
  end;

implementation

uses
  ComObj;

const
  {$EXTERNALSYM IID_IDataObject}
  IID_IDataObject: TGUID = (
    D1:$0000010E;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));
  {$EXTERNALSYM IID_IOleObject}
  IID_IOleObject: TGUID = (
    D1:$00000112;D2:$0000;D3:$0000;D4:($C0,$00,$00,$00,$00,$00,$00,$46));

{** TLMDRTFImageDataObject ****************************************************}
{-- public --------------------------------------------------------------------}
constructor TLMDRTFImageDataObject.Create;
begin
  inherited;
  FBitmap := TBitmap.Create;
end;

{------------------------------------------------------------------------------}
destructor TLMDRTFImageDataObject.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.GetData(const formatetcIn: TFormatEtc; out medium: TStgMedium): HResult;

begin
  if FBitmap.Handle = 0 then
    begin
      result := E_HANDLE;
      Exit;
    end;

  medium.tymed := TYMED_GDI;
  medium.hBitmap := FBitmap.Handle;
  medium.unkForRelease := nil;

  result := S_OK;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.GetDataHere(const formatetc: TFormatEtc; out medium: TStgMedium): HResult;

begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.QueryGetData(const formatetc: TFormatEtc): HResult;

begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.GetCanonicalFormatEtc(const formatetc: TFormatEtc; out formatetcOut: TFormatEtc): HResult;

begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.SetData(const formatetc: TFormatEtc; var medium: TStgMedium; fRelease: BOOL): HResult;

begin
  result := S_OK;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.EnumFormatEtc(dwDirection: Longint; out enumFormatEtc: IEnumFormatEtc): HResult;

begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.DAdvise(const formatetc: TFormatEtc; advf: Longint; const advSink: IAdviseSink; out dwConnection: Longint): HResult;

begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.DUnadvise(dwConnection: Longint): HResult;

begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}

function TLMDRTFImageDataObject.EnumDAdvise(out enumAdvise: IEnumStatData): HResult;

begin
  result := E_NOTIMPL;
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFImageDataObject.InsertBitmap(RichEditOle : IRichEditOle; Bitmap : TBitmap);
var
  sc            : SCODE;
  ods           : TLMDRTFImageDataObject;
  DataObject    : IDataObject;
  OleClientSite : IOleClientSite;
  Storage       : IStorage;
  LockBytes     : ILockBytes;
  OleObject     : IOleObject;
  reobject      : TREObject;
  clsid         : TCLSID;

begin
  ods := TLMDRTFImageDataObject.Create;

  ods.QueryInterface(IID_IDataObject, DataObject);

  ods.SetBitmap(Bitmap);
  RichEditOle.GetClientSite(OleClientSite);
  LockBytes := nil;

  sc := CreateILockBytesOnHGlobal(0, True, LockBytes);
  if sc <> S_OK then
    EOleException.Create('', sc, '', '', 0);

  sc := StgCreateDocfileOnILockBytes(LockBytes,
		STGM_SHARE_EXCLUSIVE or STGM_CREATE or STGM_READWRITE, 0, Storage);

  if sc <> S_OK then
    begin
      LockBytes := nil;
      EOleException.Create('', sc, '', '', 0);
    end;

  OleObject := ods.GetOleObject(OleClientSite, Storage);
  OleSetContainedObject(OleObject, True);

  ZeroMemory(@reobject, sizeof(TREObject));

  reobject.cbStruct := sizeof(TREObject);
  sc := OleObject.GetUserClassID(clsid);
  if sc <> S_OK then
    EOleException.Create('', sc, '', '', 0);

  reobject.clsid := clsid;
  reobject.cp := REO_CP_SELECTION;
  reobject.dvaspect := DVASPECT_CONTENT;
  reobject.poleobj := OleObject;
  reobject.polesite := OleClientSite;
  reobject.pstg := Storage;

  RichEditOle.InsertObject(reobject);
end;

{------------------------------------------------------------------------------}
procedure TLMDRTFImageDataObject.SetBitmap(Bitmap : TBitmap);
//var
//  stgm  : STGMEDIUM;
//  fm    : TFORMATETC;

begin
  if (Bitmap = nil) or (Bitmap.Handle = 0) then Exit;

  FBitmap.Assign(Bitmap);
{  SetData(fm, stgm, True);}
end;

{------------------------------------------------------------------------------}
function TLMDRTFImageDataObject.GetOleObject(OleClientSite : IOleClientSite;
  Storage : IStorage) : IOleObject;
var
  sc    : SCODE;
  fm    : TFORMATETC;

begin
  if FBitmap.Handle = 0 then Exit;

  fm.cfFormat := CF_BITMAP;
  fm.ptd := nil;
  fm.dwAspect := DVASPECT_CONTENT;
  fm.lindex := -1;
  fm.tymed := TYMED_GDI;

  sc := OleCreateStaticFromData((Self as IDataObject), IID_IOleObject, OLERENDER_FORMAT,
			@fm, OleClientSite, Storage, Result);

  if sc <> S_OK then
    EOleException.Create('', sc, '', '', 0);
end;

end.

