unit ElClipMon;
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

ElClipMon unit
--------------

Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Messages, Controls,Types,
  LMDUtils, ElBaseComp;

type

    TElClipboardMonitor = class(TElBaseComponent)
    protected
      FPrevHandle : HWND;
      FDataFormats: TStrings;
      FOnChange: TNotifyEvent;

      procedure WndProc(var Message : TMessage); override;
      procedure DoSetEnabled(AEnabled : boolean);override;
      procedure TriggerChangeEvent; virtual;
      function GetDataFormats: TStrings;
    public
      destructor Destroy; override;
      function GetDataString(const Format : String): string;
      function HasDataFormat(Format : integer): Boolean;
      property DataFormats: TStrings read GetDataFormats;
    published
      property Enabled;
      property OnChange: TNotifyEvent read FOnChange write FOnChange;
    end;

implementation

procedure TElClipboardMonitor.WndProc(var Message : TMessage);
begin
  inherited;
  if Message.Msg = WM_CHANGECBCHAIN then
  begin
    if HWND(Message.wParam) = FPrevHandle then
      FPrevHandle := Message.lParam
    else
      with Message do
        Result := SendMessage(FPrevHandle, Msg, wParam, lParam);
  end
  else
  if Message.Msg = WM_DRAWCLIPBOARD then
  begin
    TriggerChangeEvent;
    with Message do
      Result := SendMessage(FPrevHandle, Msg, wParam, lParam);
  end;
end;

procedure TElClipboardMonitor.DoSetEnabled(AEnabled : boolean);
begin
  if not AEnabled then
    ChangeClipboardChain(Handle, FPrevHandle);
  inherited;
  if AEnabled then
    FPrevHandle := SetClipboardViewer(Handle);
end;

procedure TElClipboardMonitor.TriggerChangeEvent;
begin
  if Assigned(FOnChange) then FOnChange(Self);
end;

function TElClipboardMonitor.GetDataFormats: TStrings;
var AFmt : integer;
begin
  if FDataFormats = nil then
    FDataFormats := TStringList.Create;
  FDataFormats.Clear;

  OpenClipboard(0);
  try
    AFmt := 0;
    repeat
      AFmt := EnumClipboardFormats(AFmt);
      FDataFormats.AddObject(LMDGetClipboardFormatName(AFmt), TObject(Pointer(AFmt)));
      until AFmt = 0;
    Result := FDataFormats;
  finally
    CloseClipboard;
  end;
end;

destructor TElClipboardMonitor.Destroy;
begin
  inherited;
  FDataFormats.Free;
end;

function TElClipboardMonitor.GetDataString(const Format : String): string;
var
  H  : THandle;
  i: Integer;
  Buf: PChar;
  Len: integer;
begin
  if DataFormats.IndexOf(Format) = -1 then
    raise Exception.CreateFmt('No format %s present', [Format]);
  OpenClipboard(Handle);
  try
    i := LMDGetClipboardFormatIndex(Format);
    if i = 0 then
      Result := ''
    else
    begin
      H := GetClipboardData(i);
      Buf := GlobalLock(H);
      Len := GlobalSize(H);
      SetLength(Result, Len);
      Move(Buf^, Result[1], Len);
      GlobalUnlock(H);
    end;
  finally
    CloseClipboard;
  end;
end;

function TElClipboardMonitor.HasDataFormat(Format : integer): Boolean;
begin
  Result := DataFormats.IndexOfObject(TObject(Pointer(Format))) <> -1;
  end;

end.
