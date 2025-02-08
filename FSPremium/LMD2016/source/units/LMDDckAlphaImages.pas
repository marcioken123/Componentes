unit LMDDckAlphaImages;
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

LMDDckAlphaImages unit (YB)
---------------------------
Alpha channel enabled image list, which works in old Delphi versions.
Primarily, TLMDAlphaImageList class has been developed for LMd demos.
This is not a part of the library, and the correct work of this class
is not guaranteed.

Notes:
  - The class patches image list to use common controls V6 library, which
    supports alpha transparency in image list. This require a manifest to
    be defined; the manifest is stored as a resource and used to create an
    activation context. This manifest is NOT global, thus, it does not enable
    visual styles.
  - Stream, produced by the class remains valid in all Delphi versions, so,
    demos can be safely developed in latest Delphi IDE.
  - Adding images to list inside old Delphi IDEs are not recommended; actually,
    I found that adding 32bit bitmaps in Delphi 6 - Delphi 2007 works Ok, but
    addign icons - is NOT. However, icons added at desing-time in newer Delphi
    IDEs will also work Ok in previous IDEs.

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, ImgList;

type
  { ************************** TLMDAlphaImageList **************************** }

  TLMDAlphaImageList = class(TImageList)
  {$IFNDEF LMDCOMP12}
  protected
    procedure ReadData(Stream: TStream);{$IFDEF LMDCOMP7}override;{$ENDIF}
    procedure WriteData(Stream: TStream);{$IFDEF LMDCOMP7}override;{$ENDIF}
  protected
    procedure DefineProperties(Filer: TFiler); override;
  {$ENDIF}
  protected
    procedure DoDraw(Index: Integer; Canvas: TCanvas; X: Integer; Y: Integer;
                     Style: Cardinal; Enabled: Boolean = True); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure   AddAsDisabled(ASource: TLMDAlphaImageList);
  {$IFDEF LMDCOMP12}
  published
    property ColorDepth default cd32Bit;
  {$ENDIF}
  end;

implementation

{$R lmddckmanifest.res}

uses
  Consts, CommCtrl, ActiveX;

type
  TFilterFiler = class(TFiler) // Filter out image list "Bitmap"
                               // defined property.
  private
    FOrigin: TFiler;
  public
    constructor Create(AOrigin: TFiler);

    procedure DefineProperty(const Name: string; ReadData: TReaderProc;
                             WriteData: TWriterProc; HasData: Boolean); override;
    procedure DefineBinaryProperty(const Name: string; ReadData, WriteData:
                                   TStreamProc; HasData: Boolean); override;
    procedure FlushBuffer; override;
  end;

  TActivationContext = class
  private
    FCookie:    LongWord;
    FSucceeded: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TActCtx = record
    cbSize: ULONG;
    dwFlags: DWORD;
    lpSource: PAnsiChar;
    wProcessorArchitecture: WORD;
    wLangId: LANGID;
    lpAssemblyDirectory: PAnsiChar;
    lpResourceName: PAnsiChar;
    lpApplicationName: PAnsiChar;
    hModule: HMODULE;
  end;

var
  ActCtx: THandle = INVALID_HANDLE_VALUE;
  CC_V6:  HMODULE;

  CreateActCtx:     function(var pActCtx: TActCtx): THandle; stdcall;
  ActivateActCtx:   function(hActCtx: THandle; var lpCookie: LongWord): BOOL; stdcall;
  DeactivateActCtx: function(dwFlags: DWORD; ulCookie: LongWord): BOOL; stdcall;
  ReleaseActCtx:    procedure(hActCtx: THandle); stdcall;

{ ---------------------------------------------------------------------------- }
function GetComCtrlLib_V6: HMODULE;
begin
  if CC_V6 = 0 then
  begin
    with TActivationContext.Create do
    try
      CC_V6 := LoadLibrary('comctl32.dll');
      if CC_V6 = 0 then
        RaiseLastOSError;
    finally
      Free;
    end;
  end;
  Result := CC_V6;
end;

{ ---------------------------------------------------------------------------- }
function ImageList_Create_V6(CX, CY: Integer; Flags: UINT;
  Initial, Grow: Integer): HIMAGELIST;
var
  func: function(CX, CY: Integer; Flags: UINT;
                 Initial, Grow: Integer): HIMAGELIST; stdcall;
begin
  func := GetProcAddress(GetComCtrlLib_V6, 'ImageList_Create');
  if not Assigned(func) then
    RaiseLastOSError;
  Result := func(CX, CY, Flags, Initial, Grow);
end;

{ ---------------------------------------------------------------------------- }
function ImageList_Read_V6(Stream: IStream): HIMAGELIST;
var
  func: function(Stream: IStream): HIMAGELIST; stdcall;
begin
  func := GetProcAddress(GetComCtrlLib_V6, 'ImageList_Read');
  if not Assigned(func) then
    RaiseLastOSError;
  Result := func(Stream);
end;

{ ---------------------------------------------------------------------------- }
procedure InitialiseActivationContext;
var
  path:      array[0..256] of AnsiChar;
  acdt:      TActCtx;
  hKernel32: HMODULE;
begin
  hKernel32    := GetModuleHandle(kernel32);
  CreateActCtx := GetProcAddress(hKernel32, 'CreateActCtxA');

  GetModuleFileNameA(HInstance, path, 256);

  if Assigned(CreateActCtx) then
  begin
    ReleaseActCtx    := GetProcAddress(hKernel32, 'ReleaseActCtx');
    ActivateActCtx   := GetProcAddress(hKernel32, 'ActivateActCtx');
    DeactivateActCtx := GetProcAddress(hKernel32, 'DeactivateActCtx');

    ZeroMemory(@acdt, SizeOf(acdt));
    acdt.cbSize := SizeOf(acdt);
    acdt.dwFlags        := $00000008; // ACTCTX_FLAG_RESOURCE_NAME_VALID
    acdt.lpSource       := path;
    acdt.lpResourceName := 'LMD_DCK_IMGLISTMANIFEST';

    ActCtx := CreateActCtx(acdt);
    if ActCtx = INVALID_HANDLE_VALUE then
      RaiseLastOSError;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure FinaliseActivationContext;
begin
  if ActCtx <> INVALID_HANDLE_VALUE then
    ReleaseActCtx(ActCtx);
end;

{ ---------------------------------------------------------------------------- }
constructor TActivationContext.Create;
begin
  inherited;
  FSucceeded := (ActCtx <> INVALID_HANDLE_VALUE) and
                ActivateActCtx(ActCtx, FCookie);
end;

{ ---------------------------------------------------------------------------- }
destructor TActivationContext.Destroy;
begin
  if FSucceeded then
    DeactivateActCtx(0, FCookie);
  inherited;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDAlphaImageList.Create(AOwner: TComponent);
begin
  inherited;
  {$IFNDEF LMDCOMP12}
  Handle  := ImageList_Create_V6(Width, Height, ILC_COLOR32 or
                                 ILC_MASK, 0, AllocBy);
  {$ELSE}
  ColorDepth := cd32Bit;
  {$ENDIF}
end;

{ ---------------------------------------------------------------------------- }
{$IFNDEF LMDCOMP12}
procedure TLMDAlphaImageList.DefineProperties(Filer: TFiler);
{$IFDEF LMDCOMP7}
var
  fltr: TFiler;
begin
  fltr := TFilterFiler.Create(Filer);
  try
    inherited DefineProperties(fltr); // Filter out "Bitmap" property,
                                      // but preserve TComponent Left/Right.
  finally
    fltr.Free;
  end;
  Filer.DefineBinaryProperty('Bitmap', ReadData, WriteData, Count > 0);
end;
{$ELSE}
begin
  inherited;
end;
{$ENDIF}
{$ENDIF}

{ ---------------------------------------------------------------------------- }
{$IFNDEF LMDCOMP12}
procedure TLMDAlphaImageList.ReadData(Stream: TStream);
var
  sa:     IStream;
  imglst: HImageList;
begin
  sa     := TStreamAdapter.Create(Stream);
  imglst := ImageList_Read_V6(sa);
  if imglst = 0 then
    raise EReadError.CreateRes(@SImageReadFail);
  Handle := imglst;
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
{$IFNDEF LMDCOMP12}
procedure TLMDAlphaImageList.WriteData(Stream: TStream);
var
  sa: IStream;
begin
  sa := TStreamAdapter.Create(Stream);
  if not ImageList_Write(Handle, sa) then
    raise EWriteError.CreateRes(@SImageWriteFail);
end;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
constructor TFilterFiler.Create(AOrigin: TFiler);
begin
  inherited Create(nil, 16);
  FOrigin := AOrigin;
end;

{ ---------------------------------------------------------------------------- }
procedure TFilterFiler.DefineBinaryProperty(const Name: string; ReadData,
  WriteData: TStreamProc; HasData: Boolean);
begin
  if Name <> 'Bitmap' then
    FOrigin.DefineBinaryProperty(Name, ReadData, WriteData, HasData);
end;

{ ---------------------------------------------------------------------------- }
procedure TFilterFiler.DefineProperty(const Name: string;
  ReadData: TReaderProc; WriteData: TWriterProc; HasData: Boolean);
begin
  FOrigin.DefineProperty(Name, ReadData, WriteData, HasData);
end;

{ ---------------------------------------------------------------------------- }
procedure TFilterFiler.FlushBuffer;
begin
  FOrigin.FlushBuffer;
end;

{ ---------------------------------------------------------------------------- }
procedure DrawDisabledImage(DC: HDC; Images: HIMAGELIST; Index, X, Y: Integer);
type
  TBGRA = packed record
    B,G,R,A: Byte;
  end;
var
  i:         Integer;
  icn:       HICON;
  memdc:     HDC;
  bmi:       BITMAPINFO;
  bmp, prev: HBITMAP;
  bits:      Pointer;
  p:        ^TBGRA;
  w, h:      Integer;
  bf:        TBlendFunction;
begin
  if not ImageList_GetIconSize(Images, w, h) then
    Exit;

  icn := ImageList_GetIcon(Images, Index, LR_DEFAULTCOLOR);
  if icn = 0 then
    Exit;

  try
    ZeroMemory(@bmi, SizeOf(bmi));
    bmi.bmiHeader.biSize        := SizeOf(bmi.bmiHeader);
    bmi.bmiHeader.biWidth       := w;
    bmi.bmiHeader.biHeight      := h;
    bmi.bmiHeader.biPlanes      := 1;
    bmi.bmiHeader.biBitCount    := 32;
    bmi.bmiHeader.biCompression := BI_RGB;
    bmi.bmiHeader.biSizeImage   := w*h*4;

    memdc := CreateCompatibleDC(DC);
    if memdc = 0 then
      Exit;
    try
      bmp := CreateDIBSection(memdc, bmi, DIB_RGB_COLORS, bits, 0, 0);
      if bmp = 0 then
        Exit;
      try
        prev := SelectObject(memdc, bmp);
        try
          DrawIconEx(memdc, 0, 0, icn, w, h, 0, 0, DI_NORMAL);

          p := bits;
          for i := 1 to w * h do
          begin
            // Grayscale = 0.30*R + 0.59*G + 0.11*B
            p.B := MulDiv(p.R, 30, 100) + MulDiv(p.G, 59, 100) +
                   MulDiv(p.B, 11, 100);
            p.G := p.B;
            p.R := p.B;

            Inc(p);
          end;

          bf.BlendOp             := AC_SRC_OVER;
          bf.BlendFlags          := 0;
          bf.AlphaFormat         := AC_SRC_ALPHA;
          bf.SourceConstantAlpha := $60;
          AlphaBlend(DC, X, Y, w, h, memdc, 0, 0, w, h, bf);
        finally
          SelectObject(memdc, prev);
        end;
      finally
        DeleteObject(bmp);
      end;
    finally
      DeleteDC(memdc);
    end;
  finally
    DestroyIcon(icn);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure Unpremultiply(B: TBitmap);
type
  TPixel = packed record
    R: Byte;
    G: Byte;
    B: Byte;
    A: Byte;
  end;
  PPixels = ^TPixels;
  TPixels = array[0..1024] of TPixel;
var
  x, y: Integer;
  w, h: Integer;
  ln:   PPixels;
begin
  GDIFlush;
  w := B.Width;
  h := B.Height;

  for y := 0 to h - 1 do
  begin
    ln := B.ScanLine[y];
    for x := 0 to w - 1 do
      with ln[x] do
      begin
        if A = 0 then
        begin
          R := 0;
          G := 0;
          B := 0;
        end
        else
        begin
          R := MulDiv(R, 255, A);
          G := MulDiv(G, 255, A);
          B := MulDiv(B, 255, A);
        end;
      end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaImageList.DoDraw(Index: Integer; Canvas: TCanvas; X,
  Y: Integer; Style: Cardinal; Enabled: Boolean);
begin
  if not Enabled then
    DrawDisabledImage(Canvas.Handle, Handle, Index, X, Y)
  else
    inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDAlphaImageList.AddAsDisabled(ASource: TLMDAlphaImageList);
var
  i:    Integer;
  b:    TBitmap;
  w, h: Integer;
begin
  w := Width;
  h := Height;
  b := TBitmap.Create;
  try
    b.Width       := w;
    b.Height      := h;
    b.PixelFormat := pf32bit;

    for i := 0 to ASource.Count - 1 do
    begin
      b.Canvas.Brush.Color := clBlack;     // Make fully transparent.
      b.Canvas.FillRect(Rect(0, 0, w, h)); //

      ASource.Draw(b.Canvas, 0, 0, i, False);
      Unpremultiply(b);

      Add(b, nil);
    end;
  finally
    b.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
{$IFNDEF LMDCOMP12}
initialization
  InitialiseActivationContext;

finalization
  FinaliseActivationContext;
{$ENDIF}

{ ---------------------------------------------------------------------------- }
end.
