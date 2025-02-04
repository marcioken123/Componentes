{******************************************************************************}
{                                                                              }
{                          GmRtfFuncs.pas v2.61 Pro                            }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmRtfFuncs;

interface

uses Windows, Classes, stdctrls, Graphics, RichEdit, GmTypes, comctrls, Forms, Dialogs;

type
  TGmRtfInformation = class;

  TGmRtfOffset = class
  private
    FRtfInfo: TGmRtfInformation;
    FPage: integer;
    FStartChar: integer;
    FEndChar: integer;
    FRtfRect: TRect;
    FTopMargin: Extended;
    FBottomMargin: Extended;
  public
    constructor Create(RtfInfo: TGmRtfInformation);
    constructor CreateRect(RtfInfo: TGmRtfInformation; ARect: TRect; SC, EC, Page: integer;
      MT, MB: Extended);
    property StartChar: integer read FStartChar write FStartChar;
    property EndChar: integer read FEndChar write FEndChar;
    property Page: integer read FPage write FPage;
    property RtfRect: TRect read FRtfRect write FRtfRect;
    property MarginTop: Extended read FTopMargin;
    property MarginBottom: Extended read FBottomMargin;
  end;

  TGmRtfInformation = class(TCustomRtfInformation)
  private
    FRichEdit: TCustomMemo;
    FClassName: string;
    FTempForm: TForm;
    FOnChange: TNotifyEvent;
    function GetOffset(index: integer): TGmRtfOffset;
    function GetOffsetForPage(index: integer): TGmRtfOffset;
    procedure SetOfffset(index: integer; const Value: TGmRtfOffset);
    procedure SetRichEdit(ARichEdit: TCustomMemo);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddOffset(ARect: TRect; Page, StartChar, EndChar: integer; MT, MB: Extended);
    procedure Clear; {$IFNDEF VER100} {$IFNDEF VER110} override; {$ENDIF}{$ENDIF}
    property RichEdit: TCustomMemo read FRichEdit write SetRichEdit;
    property Form: TForm read FTempForm;
    property Offset[index: integer]: TGmRtfOffset read GetOffset write SetOfffset;
    property OffsetForPage[index: integer]: TGmRtfOffset read GetOffsetForPage;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  procedure DrawRichText(ACanvas: TCanvas; ARichText: TCustomMemo; Sc, Ec: integer;
    AMargins: TGmRect; PageSize: TGmSize);
  procedure GetRtfText( ARichEdit: TCustomMemo; intoStream: TStream );
  procedure InsertRTF(aRichEdit: TCustomMemo; s: String);
  procedure PutRTFSelection( aRichEdit: TCustomMemo; sourceStream: TStream);

implementation

uses GmPreview, Controls, Messages, Printers;

//------------------------------------------------------------------------------

type TEditStreamCallBack = function (dwCookie: Longint; pbBuff: PByte;
cb: Longint; var pcb: Longint): {$IFDEF VER100} DWORD; stdcall; {$ELSE}
                                {$IFDEF VER120} DWORD; stdcall; {$ELSE}
                                                Integer; stdcall;
                                {$ENDIF} {$ENDIF}

TEditStream = record
  dwCookie: Longint;
  dwError: Longint;
  pfnCallback: TEditStreamCallBack;
end;

function EditStreamInCallback(dwCookie: Longint; pbBuff: PByte;
cb: Longint; var pcb: Longint): {$IFDEF VER110} DWORD; stdcall; {$ELSE}
                                {$IFDEF VER120} DWORD; stdcall; {$ELSE}
                                                Integer; stdcall;
                                {$ENDIF} {$ENDIF}
var
  theStream: TStream;
  dataAvail: LongInt;
begin
  theStream := TStream(dwCookie);
  with theStream do
    begin
      dataAvail := Size - Position;
      Result := 0;  {assume everything is ok}
      if dataAvail <= cb then
      begin
        pcb := Read(pbBuff^, dataAvail);
        if pcb <> dataAvail then  {couldn't read req. amount of bytes}
          result := E_FAIL;
      end
      else
      begin
        pcb := Read(pbBuff^, cb);
        if pcb <> cb then
          result := E_FAIL;
      end;
    end;
end;

procedure PutRTFSelection( aRichEdit: TCustomMemo; sourceStream: TStream);
var
  editstream: TEditStream;
begin
  with editstream do
  begin
    dwCookie := Longint(sourceStream);
    dwError := 0;
    pfnCallback := EditStreamInCallBack;
  end;
  aRichedit.Perform( EM_STREAMIN, SF_RTF or SFF_SELECTION, longint(@editstream));
end;


procedure InsertRTF(aRichEdit: TCustomMemo; s: String);
var
  aMemStream: TMemoryStream;
begin
  if Length(s) > 0 then
  begin
    aMemStream := TMemoryStream.Create;
    try
      aMemStream.Write(s[1], length(s));
      aMemStream.Position := 0;
      //aRichEdit.SetSelTextBuf(PChar(s));
      PutRTFSelection( aRichEdit, aMemStream );
    finally
      aMemStream.Free;
    end;
  end;
end;

function EditStreamOutCallback(dwCookie: Longint; pbBuff: PByte; cb:
Longint; var pcb: Longint): {$IFDEF VER100} DWORD; stdcall; {$ELSE}
                            {$IFDEF VER120} DWORD; stdcall; {$ELSE}
                                            Integer; stdcall;
                            {$ENDIF} {$ENDIF}
var 
  theStream: TStream;
begin
  theStream := TStream(dwCookie);
  with theStream do
  begin
    if cb > 0 then
      pcb := Write(pbBuff^, cb);
    Result := 0;
  end;
end;

procedure GetRtfText( ARichEdit: TCustomMemo; intoStream: TStream );
var
  editstream: TEditStream;
begin
  with editstream do
  begin
    dwCookie := Longint(intoStream);
    dwError := 0;
    pfnCallback := EditStreamOutCallBack;
  end;
  ARichEdit.Perform( EM_STREAMOUT, SF_RTF, longint(@editstream));
end;

//------------------------------------------------------------------------------

// *** TGmRtfOffset ***

constructor TGmRtfOffset.Create(RtfInfo: TGmRtfInformation);
begin
  inherited Create;
  FRtfInfo := RtfInfo;
end;

constructor TGmRtfOffset.CreateRect(RtfInfo: TGmRtfInformation; ARect: TRect; SC, EC, Page: integer;
  MT, MB: Extended);
begin
  Create(RtfInfo);
  FStartChar := SC;
  FEndChar := EC;
  FRtfRect := ARect;
  FTopMargin := MT;
  FBottomMargin := MB;
  FPage := Page;
end;

//------------------------------------------------------------------------------

// *** TGmRtfInfotmation ***

constructor TGmRtfInformation.Create;
begin
  inherited Create;
  FTempForm := TForm.Create(nil);
end;

destructor TGmRtfInformation.Destroy;
begin
  if FClassName <> 'TRichEdit98' then FRichEdit.Free;
  FTempForm.Free;
  Clear;
  inherited Destroy;
end;

function TGmRtfInformation.GetOffset(index: integer): TGmRtfOffset;
begin
  Result := TGmRtfOffset(Self[index]);
end;

function TGmRtfInformation.GetOffsetForPage(index: integer): TGmRtfOffset;
var
  ICount: integer;
begin
  Result := nil;
  for ICount := 0 to Count-1 do
    if Offset[ICount].Page = index then Result := Offset[ICount];
end;

procedure TGmRtfInformation.SetOfffset(index: integer;
  const Value: TGmRtfOffset);
begin
  Self[index] := Value;
end;

procedure TGmRtfInformation.SetRichEdit(ARichEdit: TCustomMemo);
begin
	FRichEdit := ARichEdit;
  if Assigned(FRichEdit) then FClassName := FRichEdit.ClassName;
end;

procedure TGmRtfInformation.AddOffset(ARect: TRect; Page, StartChar, EndChar: integer; MT, MB: Extended);
begin
  Add(TGmRtfOffset.CreateRect(Self, ARect, StartChar, EndChar, Page, MT, MB));
  if Assigned(FOnChange) then FOnChange(Self);
end;

procedure TGmRtfInformation.Clear;
var
  ICount: integer;
begin
  // clear the page...
  for ICount := Count-1 downto 0 do
  begin
    TGmRtfOffset(Self[ICount]).Free;
    Self.Delete(ICount);
  end;
  inherited Clear;
  if Assigned(FOnChange) then FOnChange(Self);
end;

//------------------------------------------------------------------------------

procedure DrawRichText(ACanvas: TCanvas; ARichText: TCustomMemo; Sc, Ec: integer;
    AMargins: TGmRect; PageSize: TGmSize);
var
  Ppi,
  pw,
  ph : integer;
  Margins: TRect;
  richedit_outputarea,
  SaveRect,
  printArea: TRect;
  ATwip: Extended;
  Range: TFormatRange;
begin
  Ppi := GetDeviceCaps(Printer.Handle, LOGPIXELSX);
  Pw := Round(PageSize.Width * Ppi);
  Ph := Round(PageSize.Height * Ppi);

  Margins := Rect(Round(AMargins.Left * Ppi),
                  Round(AMargins.Top * Ppi),
                  Round(AMargins.Right * Ppi),
                  Round(AMargins.Bottom * Ppi));
  printarea := Rect(0 + Margins.Left,
                    0 + Margins.Top,
                    pw - Margins.Right,
                    ph - Margins.Bottom);

  {Define a rectangle for the rich edit text. The height is set to the maximum. But
  we need to convert from device units to twips, 1 twip = 1/1440 inch or 1/20 point.}

  ATwip := 1440 / Ppi;
  richedit_outputarea := Rect(Round(printarea.left * ATwip),
                              Round(printarea.top * ATwip) ,
                              Round(printarea.right * ATwip) ,
                              Round(printarea.bottom * ATwip));
  SaveRect := richedit_outputarea;

  {Tell rich edit to format its text to the printer. First set up data record for message:}
  Range.hDC := ACanvas.Handle;  {printer handle}
  Range.hdcTarget := Printer.Handle;  {ditto}
  Range.rc := richedit_outputarea;
  Range.rcPage := richedit_outputarea;
  Range.chrg.cpMin := Sc;
  Range.chrg.cpMax := Ec;

  ARichText.Perform( EM_FORMATRANGE, 0, Longint(@Range));
  try
    ARichText.Perform( EM_FORMATRANGE, 1, Longint(@Range));
  finally
    {Free cached information}
    ARichText.Perform( EM_FORMATRANGE, 0, Longint(@Range));
  end;
end;

end.


