unit LMDUnicodeDialogs;
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

LMDUnicodeDialogs unit (AH)
---------------------------
This unit contains unicode wrappers for TOpendDialog and TSaveDialog

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, SysUtils, Dialogs, CommDlg, Controls, Forms, Messages,
  StdCtrls, ExtCtrls, Math, Buttons, LMDUnicodeControl, LMDUnicodeStrings, LMDUnicode,
  LMDStrings, LMDTypes, intfLMDBase, LMDPngImage;

type
  TLMDOpenDialog = class(TOpenDialog, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
  public
    function getLMDPackage: TLMDPackageID; virtual;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
  {$ifdef LMD_UNICODE}
  private
    FDefaultExt: TLMDString;
    FFileName: TLMDString;
    FFilter: TLMDString;
    FInitialDir: TLMDString;
    FTitle: TLMDString;
    FFiles: TLMDMemoryStrings;
    procedure SetDefaultExt(const Value: TLMDString);
    function GetFiles: TLMDStrings;
    procedure SetFileName(const Value: TLMDString);
    function GetFileName: TLMDString;
    procedure SetFilter(const Value: TLMDString);
    procedure SetInitialDir(const Value: TLMDString);
    procedure SetTitle(const Value: TLMDString);
  protected
    FHackOpenFileName: TOpenFileNameA;
    function CanCloseUnicode(var OpenFileName: TOpenFileNameW): Boolean;
    procedure GetFileNamesUnicode(var OpenFileName: TOpenFileNameW);
    procedure DefineProperties(Filer: TFiler); override;
    procedure WndProc(var Message: TMessage); override;
    function DoExecuteUnicode(AFunc: Pointer; AParentWnd: HWND): Boolean; overload;
    function DoExecuteUnicode(AFunc: Pointer): Boolean; overload;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; overload; override;
    {$ENDIF}
    function Execute: Boolean; {$IFDEF LMDCOMP9}overload;{$ENDIF} override;
    property Files: TLMDStrings read GetFiles;
  published
    property DefaultExt: TLMDString read FDefaultExt write SetDefaultExt;
    property FileName: TLMDString read GetFileName write SetFileName;
    property Filter: TLMDString read FFilter write SetFilter;
    property InitialDir: TLMDString read FInitialDir write SetInitialDir;
    property Title: TLMDString read FTitle write SetTitle;
  {$endif}
  end;

  TLMDSaveDialog = class(TLMDOpenDialog)
  public
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; overload; override;
    {$ENDIF}
    function Execute: Boolean;{$IFDEF LMDCOMP9}overload;{$ENDIF} override;
  end;

  TLMDPictureLoadEvent = procedure (Sender: TObject; Picture: TPicture; const FileName: string) of object;

  TLMDOpenPictureDialog = class(TLMDOpenDialog)
  private
    FPreviewPanel: TPanel;
    FPaintPane: TPanel;
    FPreviewButton: TSpeedButton;
    FImage: TImage;
    FSizeLabel: TLabel;
    FPreviewForm: TForm;
    FPopupImage: TImage;
    FPopupPanel: TPanel;
    FOnPictureLoad: TLMDPictureLoadEvent;
  protected
    procedure DoSelectionChange; override;
    procedure DoShow; override;
    procedure DoPreviewClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; overload; override;
    {$ENDIF}
    function Execute: Boolean;{$IFDEF LMDCOMP9}overload;{$ENDIF} override;
  published
    property OnCustomPictureLoad: TLMDPictureLoadEvent read FOnPictureLoad write FOnPictureLoad;
  end;

  TLMDSavePictureDialog = class(TLMDOpenPictureDialog)
  public
    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; overload; override;
    {$ENDIF}
    function Execute: Boolean;{$IFDEF LMDCOMP9}overload;{$ENDIF} override;
  end;

implementation

{$R LMDDlgs.res}

{$ifdef LMD_UNICODE}
{ ************************** TLMDOpenDialog ********************************** }
{------------------------------------------------------------------------------}
function TLMDOpenDialog.Execute: Boolean;
begin
  if LMDIsUnicodePlatform then
    Result := DoExecuteUnicode(@GetOpenFileNameW)
  else
    Result := DoExecute(@GetOpenFileName)
end;

{------------------------------------------------------------------------------}
constructor TLMDOpenDialog.Create(AOwner: TComponent);
begin
  inherited;
  FFiles := TLMDMemoryStrings.Create;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.DefineProperties(Filer: TFiler);
begin
  inherited;
  LMDDefineUnicodeProperties(Filer, Self);
end;

{------------------------------------------------------------------------------}
destructor TLMDOpenDialog.Destroy;
begin
  FFiles.Free;
  inherited;
end;

var
  GHackDialog: TLMDOpenDialog;

{------------------------------------------------------------------------------}
function HackDialogFunc(var ADialogData: TOpenFilenameA): Boolean; stdcall;
begin
  GHackDialog.FHackOpenFileName := ADialogData;
  GHackDialog := nil;
  Result := False;
end;

{------------------------------------------------------------------------------}
function TLMDOpenDialog.DoExecuteUnicode(AFunc: Pointer;
  AParentWnd: HWND): Boolean;
var
  LOpenFilename: TOpenFilenameW;
  LTempFile: TLMDString;
  LTempFilter: TLMDString;

  function AllocFilterStr(const S: TLMDString): TLMDString;
  var
    P: PWideChar;
  begin
    Result := '';
    if S <> '' then
    begin
      Result := S + #0;  // double null terminators
      P := LMDWideStrScan(PWideChar(Result), '|');
      while P <> nil do
      begin
        P^ := #0;
        Inc(P);
        P := LMDWideStrScan(P, '|');
      end;
    end;
  end;

begin
  GHackDialog := Self;
  DoExecute(@HackDialogFunc);
  LOpenFilename := TOpenFileNameW(FHackOpenFileName);

  with LOpenFilename do
  begin
    SetLength(LTempFile, nMaxFile);
    lpstrFile := PWideChar(LTempFile);
    if nMaxFile > 0 then
    begin
      FillChar(lpstrFile^, (nMaxFile + 2) * SizeOf(WideChar), 0);
      LMDWideStrLCopy(lpstrFile, PWideChar(FileName), nMaxFile);
    end;
    lpstrTitle := PWideChar(FTitle);
    LTempFilter := AllocFilterStr(FFilter);
    lpstrFilter := PWideChar(LTempFilter);
    lpstrInitialDir := PWideChar(FInitialDir);
    lpstrDefExt := PWideChar(FDefaultExt);
    Result := TaskModalDialog(AFunc, LOpenFilename);
    if Result then
    begin
      GetFileNamesUnicode(LOpenFilename);
      if (Flags and OFN_EXTENSIONDIFFERENT) <> 0 then
        Options := Options + [ofExtensionDifferent]
      else
        Options := Options - [ofExtensionDifferent];
      if (Flags and OFN_READONLY) <> 0 then
        Options := Options + [ofReadOnly]
      else
        Options := Options + [ofReadOnly];
      FilterIndex := nFilterIndex;
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDOpenDialog.CanCloseUnicode(var OpenFileName: TOpenFileNameW): Boolean;
begin
  GetFileNamesUnicode(OpenFileName);
  Result := DoCanClose;
  FFiles.Clear;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.GetFileNamesUnicode(var OpenFileName: TOpenFileNameW);
var
  Separator: WideChar;

  function ExtractFileName(P: PWideChar; var S: TLMDString): PWideChar;
  begin
    Result := LMDWideStrScan(P, Separator);
    if Result = nil then
    begin
      S := P;
      Result := LMDWideStrEnd(P);
    end
    else
    begin
      LMDSetString(S, P, Result - P);
      Inc(Result);
    end;
  end;

  procedure ExtractFileNames(P: PWideChar);
  var
    DirName, FileName: TLMDString;
  begin
    P := ExtractFileName(P, DirName);
    P := ExtractFileName(P, FileName);
    if FileName = '' then
      FFiles.Add(DirName)
    else
    begin
      if LMDWideLastChar(DirName)^ <> '\' then
        DirName := DirName + '\';
      repeat
        if (FileName[1] <> '\') and ((Length(FileName) <= 3) or
          (FileName[2] <> ':') or (FileName[3] <> '\')) then
          FileName := DirName + FileName;
        FFiles.Add(FileName);
        P := ExtractFileName(P, FileName);
      until FileName = '';
    end;
  end;

begin
  Separator := #0;
  if (ofAllowMultiSelect in Options) and
    ((ofOldStyleDialog in Options) or not NewStyleControls) then
    Separator := ' ';
  with OpenFileName do
  begin
    if ofAllowMultiSelect in Options then
    begin
      ExtractFileNames(lpstrFile);
      FFileName := FFiles[0];
    end else
    begin
      ExtractFileName(lpstrFile, FFileName);
      FFiles.Add(FFileName);
    end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDOpenDialog.DoExecuteUnicode(AFunc: Pointer): Boolean;
var
  LParentWnd: HWND;
begin
  {$ifdef LMDCOMP10}
  if Application.ModalPopupMode <> pmNone then
  begin
  {$endif}
    {$ifdef LMDCOMP9}
    LParentWnd := Application.ActiveFormHandle;
    if LParentWnd = 0 then
    {$endif}
      LParentWnd := Application.Handle;
  {$ifdef LMDCOMP10}
  end
  else
    LParentWnd := Application.Handle;
  {$endif}
  Result := DoExecuteUnicode(AFunc, LParentWnd);
end;

{$IFDEF LMDCOMP9}
{------------------------------------------------------------------------------}
function TLMDOpenDialog.Execute(ParentWnd: HWND): Boolean;
begin
  if LMDIsUnicodePlatform then
    Result := DoExecuteUnicode(@GetOpenFileNameW, ParentWnd)
  else
    Result := DoExecute(@GetOpenFileName, ParentWnd);
end;
{$ENDIF}

{------------------------------------------------------------------------------}
function TLMDOpenDialog.GetFiles: TLMDStrings;
begin
  Result := FFiles;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.SetDefaultExt(const Value: TLMDString);
begin
  FDefaultExt := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.SetFileName(const Value: TLMDString);
begin
  FFileName := Value;
end;

function TLMDOpenDialog.GetFileName: TLMDString;
var
  LFileName: array[0..MAX_PATH] of TLMDChar;
begin
  if Handle <> 0 then
  begin
    SendMessage(GetParent(Handle), CDM_GETFILEPATH, Length(LFileName), LPARAM(@LFileName));
    Result := LFileName;
  end
  else
    Result := FFileName;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.SetFilter(const Value: TLMDString);
begin
  FFilter := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.SetInitialDir(const Value: TLMDString);
begin
  FInitialDir := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.SetTitle(const Value: TLMDString);
begin
  FTitle := Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenDialog.WndProc(var Message: TMessage);
begin
  Message.Result := 0;
  { If not ofOldStyleDialog then DoShow on CDN_INITDONE, not WM_INITDIALOG }
  if (Message.Msg = WM_INITDIALOG) and not (ofOldStyleDialog in Options) then
    Exit
  else
    if LMDIsUnicodePlatform and (Message.Msg = WM_NOTIFY) then
      case (POFNotify(Message.LParam)^.hdr.code) of
        CDN_FILEOK:
          if not CanCloseUnicode(POFNotifyW(Message.LParam)^.lpOFN^) then
          begin
            Message.Result := 1;
            SetWindowLong(Handle, DWL_MSGRESULT, Message.Result);
            Exit;
          end;
        CDN_SELCHANGE:
          begin
            DoSelectionChange;
            exit;
          end;
      end;
  inherited WndProc(Message);
end;
{$endif}

{------------------------------------------------------------------------------}
function TLMDOpenDialog.getLMDPackage: TLMDPackageID;
begin
  Result := pi_LMD_RTLX;
end;

{ ************************** TLMDSaveDialog ********************************** }
{------------------------------------------------------------------------------}

{------------------------------------------------------------------------------}
function TLMDSaveDialog.Execute: Boolean;
begin
  {$ifdef LMD_UNICODE}
  if LMDIsUnicodePlatform then
    Result := DoExecuteUnicode(@GetSaveFileNameW)
  else
  {$endif}
    Result := DoExecute(@GetSaveFileName);
end;

{$IFDEF LMDCOMP9}
{------------------------------------------------------------------------------}
function TLMDSaveDialog.Execute(ParentWnd: HWND): Boolean;
begin
  {$ifdef LMD_UNICODE}
  if LMDIsUnicodePlatform then
    Result := DoExecuteUnicode(@GetSaveFileNameW, ParentWnd)
  else
  {$endif}
    Result := DoExecute(@GetSaveFileName, ParentWnd);
end;
{$ENDIF}

{ ************************* TLMDOpenPictureDailog **************************** }
{$IFDEF LMDCOMP9}
{------------------------------------------------------------------------------}
function TLMDOpenPictureDialog.Execute(ParentWnd: HWND): Boolean;
begin
  Template := 'PICTUREDIALOGTEMPLATE';
  Result := inherited Execute(ParentWnd);
end;
{$ENDIF}

{------------------------------------------------------------------------------}
constructor TLMDOpenPictureDialog.Create(AOwner: TComponent);
begin
  inherited;
  Filter := GraphicFilter(TGraphic);

  FPreviewPanel := TPanel.Create(Self);
  FPreviewPanel.BorderStyle := bsNone;
  FPreviewPanel.BevelOuter := bvNone;

  FPaintPane := TPanel.Create(FPreviewPanel);
  FPaintPane.Parent := FPreviewPanel;
  FPaintPane.BorderStyle := bsNone;
  FPaintPane.BevelOuter := bvNone;
  {$ifdef LMDCOMP9}
  FPaintPane.BevelKind := bkFlat;
  {$endif}
  FPaintPane.BorderWidth := 5;
  FPaintPane.Height := 350;
  FPaintPane.Align := alBottom;
  FPaintPane.Caption := '(None)';

  FPreviewButton := TSpeedButton.Create(FPreviewPanel);
  FPreviewButton.Parent := FPreviewPanel;
  FPreviewButton.SetBounds(FPaintPane.Width - 48, 5, 25, 25);
  FPreviewButton.Glyph.LoadFromResourceName(HInstance, 'PREVIEWICON');
  FPreviewButton.Enabled := false;
  FPreviewButton.OnClick := DoPreviewClick;

  FSizeLabel := TLabel.Create(FPreviewPanel);
  FSizeLabel.Parent := FPreviewPanel;
  FSizeLabel.AutoSize := True;
  FSizeLabel.Caption := 'Picture:';
  FSizeLabel.Left := 0;
  FSizeLabel.Top := 5 + (25 - FSizeLabel.Height) div 2;

  FImage := TImage.Create(FPreviewPanel);
  FImage.Parent := FPaintPane;
  FImage.Align := alClient;
  FImage.Center := True;
  FImage.Stretch := True;
  FImage.Proportional := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenPictureDialog.DoPreviewClick(Sender: TObject);
begin
  FPreviewForm := TForm.Create(Self);
  try
    FPreviewForm.BorderStyle := bsSizeToolWin;
    FPreviewForm.Position := poScreenCenter;
    FPreviewForm.ClientWidth := Min(FImage.Picture.Width + 10, MulDiv(Screen.Width, 80, 100));
    FPreviewForm.ClientHeight := Min(FImage.Picture.Height + 10, MulDiv(Screen.Height, 80, 100));

    FPopupPanel := TPanel.Create(FPreviewForm);
    FPopupPanel.Parent := FPreviewForm;
    FPopupPanel.Align := alClient;
    FPopupPanel.BorderStyle := bsNone;
    FPopupPanel.BorderWidth := 5;
    FPopupPanel.BevelOuter := bvNone;

    FPopupImage := TImage.Create(FPopupPanel);
    FPopupImage.Parent := FPopupPanel;
    FPopupImage.Align := alClient;
    FPopupImage.Stretch := true;
    FPopupImage.Center := true;
    FPopupImage.Proportional := true;
    FPopupImage.Picture.Assign(FImage.Picture);

    FPreviewForm.ShowModal;
  finally
    FPreviewForm.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenPictureDialog.DoSelectionChange;
begin
  inherited;
  if FileExists(FileName) then
  begin
    try
      if Assigned(FOnPictureLoad) then
        FOnPictureLoad(Self, FImage.Picture, FileName)
      else
        FImage.Picture.LoadFromFile(FileName);
    except
      exit;
    end;
    FSizeLabel.Caption := Format('(%dx%d)', [FImage.Picture.Width, FImage.Picture.Height]);
    FPreviewButton.Enabled := true;
    FPaintPane.Caption := '';
  end
  else
  begin
    FImage.Picture := nil;
    FSizeLabel.Caption := 'Picture:';
    FPreviewButton.Enabled := false;
    FPaintPane.Caption := '(None)';
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenPictureDialog.DoShow;
var
  LPreviewRect: TRect;
  LStaticRect: TRect;
begin
  { Set preview area to entire dialog }
  GetClientRect(Handle, LPreviewRect);
  LStaticRect := GetStaticRect;
  { Move preview area to right of static area }
  LPreviewRect.Left := LStaticRect.Left + (LStaticRect.Right - LStaticRect.Left);
  Inc(LPreviewRect.Top, 4);
  FPreviewPanel.BoundsRect := LPreviewRect;
  FPreviewPanel.ParentWindow := Handle;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDOpenPictureDialog.Execute: Boolean;
begin
  Template := 'PICTUREDIALOGTEMPLATE';
  Result := inherited Execute();
end;

{ *************************** TLMDSavePictureDialog ************************** }
{------------------------------------------------------------------------------}
{$IFDEF LMDCOMP9}
function TLMDSavePictureDialog.Execute(ParentWnd: HWND): Boolean;
begin
  Template := 'PICTUREDIALOGTEMPLATE';
  {$ifdef LMD_UNICODE}
  if LMDIsUnicodePlatform then
    Result := DoExecuteUnicode(@GetSaveFileNameW, ParentWnd)
  else
  {$endif}
    Result := DoExecute(@GetSaveFileName, ParentWnd);
end;
{$ENDIF}

{------------------------------------------------------------------------------}
function TLMDSavePictureDialog.Execute: Boolean;
begin
  Template := 'PICTUREDIALOGTEMPLATE';
  {$ifdef LMD_UNICODE}
  if LMDIsUnicodePlatform then
    Result := DoExecuteUnicode(@GetSaveFileNameW)
  else
  {$endif}
    Result := DoExecute(@GetSaveFileName);
end;

end.
