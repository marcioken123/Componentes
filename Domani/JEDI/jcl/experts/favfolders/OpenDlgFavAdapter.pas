{**************************************************************************************************}
{                                                                                                  }
{ Project JEDI Code Library (JCL)                                                                  }
{                                                                                                  }
{ The contents of this file are subject to the Mozilla Public License Version 1.1 (the "License"); }
{ you may not use this file except in compliance with the License. You may obtain a copy of the    }
{ License at http://www.mozilla.org/MPL/                                                           }
{                                                                                                  }
{ Software distributed under the License is distributed on an "AS IS" basis, WITHOUT WARRANTY OF   }
{ ANY KIND, either express or implied. See the License for the specific language governing rights  }
{ and limitations under the License.                                                               }
{                                                                                                  }
{ The Original Code is OpenDlgFavAdapter.pas.                                                      }
{                                                                                                  }
{ The Initial Developer of the Original Code is Petr Vones.                                        }
{ Portions created by Petr Vones are Copyright (C) Petr Vones. All rights reserved.                }
{                                                                                                  }
{ Contributor(s):                                                                                  }
{   Salvatore Besso                                                                                }
{                                                                                                  }
{**************************************************************************************************}
{                                                                                                  }
{ Unit owner: Petr Vones                                                                           }
{                                                                                                  }
{**************************************************************************************************}

// Last modified: $Date: 2005/12/26 18:03:41 $
// For history see end of file

unit OpenDlgFavAdapter;

interface

{$I jcl.inc}

uses
  Windows, Messages, Classes, SysUtils, Controls, StdCtrls, ExtCtrls,
  JclPeImage;

type
  TFavOpenDialog = class (TObject)
  private
    FAddButton: TButton;
    FDeleteMode: Boolean;
    FDisableHelpButton: Boolean;
    FDisablePlacesBar: Boolean;
    FFavoriteComboBox: TComboBox;
    FFavoriteFolders: TStrings;
    FFavoritePanel: TPanel;
    FHandle: HWND;
    FHooks: TJclPeMapImgHooks;
    FIsOpenPictDialog: Boolean;
    FParentWnd: HWND;
    FParentWndInstance: Pointer;
    FOldParentWndInstance: Pointer;
    FPictureDialogLastFolder: string;
    FWndInstance: Pointer;
    FOldWndInstance: Pointer;
    FOnClose: TNotifyEvent;
    FOnShow: TNotifyEvent;
    procedure AddButtonClick(Sender: TObject);
    procedure FavoriteComboBoxClick(Sender: TObject);
    function GetCurrentFolder: string;
    function GetFileNameEditWnd: HWND;
    procedure SetCurrentFolder(const Value: string);
    procedure SetDeleteMode(const Value: Boolean);
  protected
    procedure AdjustControlPos;
    procedure DialogFolderChange;
    procedure DialogShow;
    procedure DoClose;
    procedure DoShow;
    procedure ParentWndProc(var Message: TMessage); virtual;
    procedure WndProc(var Message: TMessage); virtual;
    property CurrentFolder: string read GetCurrentFolder write SetCurrentFolder;
    property DeleteMode: Boolean read FDeleteMode write SetDeleteMode;
    property FileNameEditWnd: HWND read GetFileNameEditWnd;
  public
    constructor Create;
    destructor Destroy; override;
    procedure HookDialogs;
    procedure LoadFavorites(const FileName: string);
    procedure UnhookDialogs;
    property DisableHelpButton: Boolean read FDisableHelpButton write FDisableHelpButton;
    property DisablePlacesBar: Boolean read FDisablePlacesBar write FDisablePlacesBar;
    property FavoriteFolders: TStrings read FFavoriteFolders;
    property IsOpenPictDialog: Boolean read FIsOpenPictDialog;
    property PictureDialogLastFolder: string read FPictureDialogLastFolder write FPictureDialogLastFolder;
    property OnClose: TNotifyEvent read FOnClose write FOnClose;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
  end;

function InitializeFavOpenDialog: TFavOpenDialog;

implementation

uses
  {$IFNDEF RTL140_UP}
  Forms,
  {$ENDIF ~RTL140_UP}
  CommDlg, Dlgs,
  JclFileUtils, JclStrings, JclSysInfo, JclSysUtils,
  JclOtaConsts, JclOtaResources, JclOtaUtils;

{$R FavDlg.res}

type
  TGetOpenFileName = function (var OpenFile: TOpenFilename): Bool; stdcall;

var
  OldGetOpenFileName: TGetOpenFileName;
  OldGetSaveFileName: TGetOpenFileName;
  OldExplorerHook: function(Wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): UINT stdcall;
  FavOpenDialog: TFavOpenDialog;

function NewExplorerHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT; stdcall;
begin
  Result := OldExplorerHook(Wnd, Msg, WParam, LParam);
  if (Msg = WM_INITDIALOG) and Assigned(FavOpenDialog) then
  begin
    FavOpenDialog.FHandle := Wnd;
    FavOpenDialog.FOldWndInstance := Pointer(SetWindowLong(Wnd, GWL_WNDPROC, Longint(FavOpenDialog.FWndInstance)));
    CallWindowProc(FavOpenDialog.FWndInstance, Wnd, Msg, WParam, LParam);
  end;
end;

procedure InitOpenFileStruct(var OpenFile: TOpenFilename);
var
  InitDir: string;
begin
  with OpenFile do
    if Flags and OFN_EXPLORER <> 0 then
    begin
      if Assigned(FavOpenDialog) then
        FavOpenDialog.FIsOpenPictDialog := False;
      if Flags and OFN_ENABLETEMPLATE = 0 then
      begin
        OldExplorerHook := lpfnHook;
        lpfnHook := NewExplorerHook;
        lpTemplateName := FavDialogTemplateName;
        hInstance := FindResourceHInstance(FindClassHInstance(TFavOpenDialog));
        Flags := Flags or OFN_ENABLETEMPLATE;
        if Assigned(FavOpenDialog) then
        begin
          if FavOpenDialog.DisableHelpButton then
            Flags := Flags and (not OFN_SHOWHELP);
          {$IFDEF DELPHI6_UP}
          if FavOpenDialog.DisablePlacesBar and (lStructSize = SizeOf(TOpenFilename)) then
            FlagsEx := FlagsEx or OFN_EX_NOPLACESBAR;
          {$ENDIF DELPHI6_UP}
        end;
      end
      else
      if (StrIComp(lpTemplateName, OpenPictDialogTemplateName) = 0) and Assigned(FavOpenDialog) then
      begin
        FavOpenDialog.FIsOpenPictDialog := True;
        OldExplorerHook := lpfnHook;
        lpfnHook := NewExplorerHook;
        InitDir := FavOpenDialog.PictureDialogLastFolder;
        if DirectoryExists(InitDir) then
          lpstrInitialDir := PChar(FavOpenDialog.PictureDialogLastFolder)
        else
          FavOpenDialog.PictureDialogLastFolder := '';
      end;
   end;
end;

function NewGetOpenFileName(var OpenFile: TOpenFilename): Bool; stdcall;
begin
  InitOpenFileStruct(OpenFile);
  Result := OldGetOpenFileName(OpenFile);
end;

function NewGetSaveFileName(var OpenFile: TOpenFilename): Bool; stdcall;
begin
  InitOpenFileStruct(OpenFile);
  Result := OldGetSaveFileName(OpenFile);
end;

function InitializeFavOpenDialog: TFavOpenDialog;
begin
  if not Assigned(FavOpenDialog) then
    FavOpenDialog := TFavOpenDialog.Create;
  Result := FavOpenDialog;
end;

//=== { TFavOpenDialog } =====================================================

constructor TFavOpenDialog.Create;
begin
  inherited Create;
  FFavoriteFolders := TStringList.Create;
  FHooks := TJclPeMapImgHooks.Create;
  FParentWndInstance := MakeObjectInstance(ParentWndProc);
  FWndInstance := MakeObjectInstance(WndProc);
  FFavoritePanel := TPanel.Create(nil);
  with FFavoritePanel do
  begin
    Name := 'FavoritePanel';
    BevelOuter := bvNone;
    Caption := '';
    FullRepaint := False;
    FFavoriteComboBox := TComboBox.Create(FFavoritePanel);
    with FFavoriteComboBox do
    begin
      SetBounds(6, 14, 300, Height);
      Style := csDropDownList;
      Sorted := True;
      OnClick := FavoriteComboBoxClick;
      Parent := FFavoritePanel;
    end;
    with TStaticText.Create(FFavoritePanel) do
    begin
      AutoSize := False;
      SetBounds(6, 0, 100, 14);
      Caption := RsFavorites;
      FocusControl := FFavoriteComboBox;
      Parent := FFavoritePanel;
    end;
    FAddButton := TButton.Create(FFavoritePanel);
    with FAddButton do
    begin
      SetBounds(333, 14, 75, 23);
      Caption := RsAdd;
      OnClick := AddButtonClick;
      Parent := FFavoritePanel;
    end;
  end;
end;

destructor TFavOpenDialog.Destroy;
begin
  UnhookDialogs;
  FreeObjectInstance(FParentWndInstance);
  FreeObjectInstance(FWndInstance);
  FreeAndNil(FFavoritePanel);
  FreeAndNil(FFavoriteFolders);
  FreeAndNil(FHooks);
  inherited Destroy;
end;

procedure TFavOpenDialog.AddButtonClick(Sender: TObject);
var
  I: Integer;
  Path: string;
begin
  if DeleteMode then
  begin
    I := FFavoriteComboBox.ItemIndex;
    Path := FFavoriteComboBox.Items[I];
    if MessageBox(FHandle, PChar(Format(RsDelConfirm, [Path])), PChar(RsConfirmation),
      MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = ID_YES then
    begin
      FFavoriteComboBox.Items.Delete(I);
      DeleteMode := False;
    end;
  end
  else
  begin
    Path := CurrentFolder;
    I := FFavoriteComboBox.Items.IndexOf(Path);
    if I = -1 then
    begin
      FFavoriteComboBox.Items.Add(Path);
      I := FFavoriteComboBox.Items.IndexOf(Path);
      FFavoriteComboBox.ItemIndex := I;
      DeleteMode := True;
    end;
  end;
end;

procedure TFavOpenDialog.AdjustControlPos;
var
  ParentRect, FileNameEditRect, OkButtonRect: TRect;

  procedure GetDlgItemRect(ItemID: Integer; var R: TRect);
  begin
    GetWindowRect(GetDlgItem(FParentWnd, ItemID), R);
    MapWindowPoints(0, FParentWnd, R, 2);
  end;

begin
  GetWindowRect(FParentWnd, ParentRect);
  if GetDlgItem(FParentWnd, edt1) <> 0 then
    GetDlgItemRect(edt1, FileNameEditRect)
  else
    GetDlgItemRect(cmb1, FileNameEditRect);
  GetDlgItemRect(1, OkButtonRect);

// Salvatore Besso: Changes to avoid truncation of Add button. I don't know why, but debugging I
//   have discovered that ParentRect.Right was equal to 1024, ie Screen.Width. I also can't figure
//   out why I can't preserve original help button that disappears using this expert.
//   As visible in the changes, favorite panel width is just left of the original button column.

  if IsWin2k or IsWinXP then
    FAddButton.Width := 65;
  FFavoritePanel.Width := OkButtonRect.Left - 1;
  FFavoriteComboBox.Width := FFavoritePanel.Width - FFavoriteComboBox.Left - FAddButton.Width - 16;
  FAddButton.Left := FFavoriteComboBox.Width + 14;
end;

procedure TFavOpenDialog.DialogFolderChange;
var
  Path: string;
begin
  Path := CurrentFolder;
  with FFavoriteComboBox do
  begin
    ItemIndex := Items.IndexOf(Path);
    DeleteMode := (ItemIndex <> -1);
  end;
end;

procedure TFavOpenDialog.DialogShow;
var
  PreviewRect: TRect;
begin
  FParentWnd := GetParent(FHandle);
  if IsOpenPictDialog then
    DoShow
  else  
  begin
    GetClientRect(FHandle, PreviewRect);
    PreviewRect.Top := PreviewRect.Bottom - 43;
    FFavoritePanel.BoundsRect := PreviewRect;
    FFavoritePanel.ParentWindow := FHandle;
    if IsWin2k or IsWinXP then
      FOldParentWndInstance := Pointer(SetWindowLong(FParentWnd, GWL_WNDPROC, Longint(FParentWndInstance)));
    AdjustControlPos;
    try
      DoShow;
    finally
      FFavoriteComboBox.Items.Assign(FavoriteFolders);
    end;
  end;  
end;

procedure TFavOpenDialog.DoClose;
begin
  if Assigned(FOnClose) then
    FOnClose(Self);
end;

procedure TFavOpenDialog.DoShow;
begin
  if Assigned(FOnShow) then
    FOnShow(Self);
end;

procedure TFavOpenDialog.FavoriteComboBoxClick(Sender: TObject);
begin
  with FFavoriteComboBox do
    if ItemIndex <> - 1 then
      CurrentFolder := FFavoriteComboBox.Items[ItemIndex];
end;

function TFavOpenDialog.GetCurrentFolder: string;
var
  Path: array [0..MAX_PATH] of Char;
begin
  SetString(Result, Path, SendMessage(FParentWnd, CDM_GETFOLDERPATH, SizeOf(Path), Integer(@Path)));
  StrResetLength(Result);
end;

function TFavOpenDialog.GetFileNameEditWnd: HWND;
begin
  Result := GetDlgItem(FParentWnd, edt1);
  if Result = 0 then
    Result := GetDlgItem(FParentWnd, cmb13);
end;

procedure TFavOpenDialog.HookDialogs;
  procedure HookImportsForModule(ModuleBase: Pointer);
  const
    comdlg32 = 'comdlg32.dll';
  begin
    if ModuleBase <> nil then
    begin
      FHooks.HookImport(ModuleBase, comdlg32, 'GetOpenFileNameA', @NewGetOpenFileName, @OldGetOpenFileName);
      FHooks.HookImport(ModuleBase, comdlg32, 'GetSaveFileNameA', @NewGetSaveFileName, @OldGetSaveFileName);
    end;
  end;
var
  Pe: TJclPeImage;
  I: Integer;
  HookedModule: LongWord;
begin
  { TODO : Hook all loaded modules }
  Pe := TJclPeImage.Create(True);
  try
    HookedModule := FindClassHInstance(ClassType);
    Pe.AttachLoadedModule(HookedModule);
    if Pe.StatusOK then
    begin
      HookImportsForModule(Pointer(HookedModule));
      for I := 0 to Pe.ImportList.UniqueLibItemCount - 1 do
        HookImportsForModule(Pointer(GetModuleHandle(PChar(Pe.ImportList.UniqueLibItems[I].FileName))));
    end;
  finally
    Pe.Free;
  end;
end;

procedure TFavOpenDialog.LoadFavorites(const FileName: string);
begin
  if FileExists(FileName) then
    FavoriteFolders.LoadFromFile(FileName)
  else
    FavoriteFolders.Clear;
end;

procedure TFavOpenDialog.ParentWndProc(var Message: TMessage);
begin
  with Message do
  begin
    Result := CallWindowProc(FOldParentWndInstance, FParentWnd, Msg, WParam, LParam);
    if Msg = WM_SIZE then
      AdjustControlPos;
  end;
end;

procedure TFavOpenDialog.SetCurrentFolder(const Value: string);
var
  LastFocus: HWND;
  FileNameBuffer: string;
begin
  if (FParentWnd <> 0) and DirectoryExists(Value) then
  begin
    LastFocus := GetFocus;
    FileNameBuffer := GetWindowCaption(FileNameEditWnd);
    SendMessage(FParentWnd, CDM_SETCONTROLTEXT, edt1, LPARAM(PChar(Value)));
    SendMessage(GetDlgItem(FParentWnd, 1), BM_CLICK, 0, 0);
    SendMessage(FParentWnd, CDM_SETCONTROLTEXT, edt1, LPARAM(PChar(FileNameBuffer)));
    SetFocus(LastFocus);
  end;
end;

procedure TFavOpenDialog.SetDeleteMode(const Value: Boolean);
begin
  if FDeleteMode <> Value then
  begin
    FDeleteMode := Value;
    if FDeleteMode then
      FAddButton.Caption := RsDelete
    else
      FAddButton.Caption := RsAdd;
    FFavoriteComboBox.Invalidate;
  end;
end;

procedure TFavOpenDialog.UnhookDialogs;
var
  I: Integer;
begin
  I := 0;
  while I < FHooks.Count do
    if not FHooks[I].Unhook then
      Inc(I);
end;

procedure TFavOpenDialog.WndProc(var Message: TMessage);

  procedure Default;
  begin
    with Message do
      Result := CallWindowProc(FOldWndInstance, FHandle, Msg, WParam, LParam);
  end;

begin
  if FHandle <> 0 then
  begin
    case Message.Msg of
      WM_NOTIFY:
        begin
          case (POFNotify(Message.LParam)^.hdr.code) of
            CDN_INITDONE:
              DialogShow;
            CDN_FOLDERCHANGE:
              if not IsOpenPictDialog then
                DialogFolderChange;
            CDN_FILEOK:
              if IsOpenPictDialog then
                FPictureDialogLastFolder := CurrentFolder;
          end;
          Default;
        end;
      WM_DESTROY:
        begin
          if not IsOpenPictDialog then
            FavoriteFolders.Assign(FFavoriteComboBox.Items);
          try
            DoClose;
            Default;
          finally
            if not IsOpenPictDialog then
              FFavoritePanel.ParentWindow := 0;
            FParentWnd := 0;
          end;
        end;
      WM_NCDESTROY:
        begin
          Default;
          FHandle := 0;
        end;
    else
      Default;
    end;
  end;
end;

initialization

finalization

try
  FreeAndNil(FavOpenDialog);
except
  on ExceptionObj: TObject do
  begin
    JclExpertShowExceptionDialog(ExceptionObj);
    raise;
  end;
end;


// History:

// $Log: OpenDlgFavAdapter.pas,v $
// Revision 1.4  2005/12/26 18:03:41  outchy
// Enhanced bds support (including C#1 and D8)
// Introduction of dll experts
// Project types in templates
//
// Revision 1.3  2005/12/16 23:46:25  outchy
// Added expert stack form.
// Added code to display call stack on expert exception.
// Fixed package extension for D2006.
//
// Revision 1.2  2005/10/21 12:24:41  marquardt
// experts reorganized with new directory common
//
// Revision 1.1  2005/10/03 16:27:37  rrossmair
// - moved over from jcl\examples\vcl\idefavopendialogs
//
// Revision 1.5  2005/02/26 17:36:01  rrossmair
// - applied Salvatore Besso's fix for truncation of Add button when using large fonts.
// - some cleaning, module header updated.
//

end.
