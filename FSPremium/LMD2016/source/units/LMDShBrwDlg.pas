unit LMDShBrwDlg;
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

LMDShBrwDlg unit (DS)
------------------------

Changes
-------
Release 4.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Forms, Messages, SysUtils, ComCtrls, StdCtrls, Controls,
  Buttons, ExtCtrls, Classes,
  LMDShBase, LMDShMisc, LMDShController, LMDShTree, LMDShFolder, LMDShUtils;

type

  TLMDShellfrmBrowseDialog = class;

  TLMDShellBrowseDialogEvent = procedure(Sender: TObject;
    aForm: TLMDShellfrmBrowseDialog) of object;

  TLMDShellBrowseDialogOption = (doSizeable, doSizeGrip, doInstructionField,
    doCreateButton, doCreateSpeedButton,
    doDeleteSpeedButton, doStatusBar, doShowHidden, doShowHints, doReadOnly,
      doShowContextMenu);
  TLMDShellBrowseDialogOptions = set of TLMDShellBrowseDialogOption;

  {-------------------- TLMDShellBrowseDialog ---------------------------------}
  TLMDShellBrowseDialog = class(TLMDShellBaseDialog)
  private
    FDialog: TLMDShellfrmBrowseDialog;
    FCaption: String;
    FDescription: String;
    FDisplayName: String;
    FInstructionText: String;
    FStatusText: String;
    FImageIndex: DWORD;
    FImageLarge: TBitmap;
    FImageSmall: TBitmap;
    FSelectedPath: TFileName;
    FOptions: TLMDShellBrowseDialogOptions;
    FOnInit,
    FOnResize: TLMDShellBrowseDialogEvent;
    FRootFolder: TLMDRoot;
    procedure SetCaption(const aValue: string);
    procedure SetStatusText(const aValue: string);
    function GetImage(Index: Integer): TBitmap;
    procedure SetOptions(aValue: TLMDShellBrowseDialogOptions);
  protected
    procedure DoInit(aForm: TLMDShellfrmBrowseDialog); dynamic;
    procedure DoResize(aForm: TLMDShellfrmBrowseDialog); dynamic;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    function Execute(aHWND:HWND=0):Boolean; override;
    property Description: string read FDescription;
    property DisplayName: string read FDisplayName;
    property ImageIndex: DWORD read FImageIndex;
    property ImageLarge: TBitmap index 1 read GetImage;
    property ImageSmall: TBitmap index 2 read GetImage;
  published
    property Caption: string read FCaption write SetCaption;
    property InstructionText: string read FInstructionText write
      FInstructionText;
    property Options: TLMDShellBrowseDialogOptions read FOptions write SetOptions;
    property RootFolder: TLMDRoot read FRootFolder write FRootFolder;
    property SelectedPath: TFilename read FSelectedPath write FSelectedPath
      stored false;
    property StatusText: string read FStatusText write SetStatusText;
    property OnInitialize: TLMDShellBrowseDialogEvent read FOnInit write
      FOnInit;
    property OnResize: TLMDShellBrowseDialogEvent read FOnResize write
      FOnResize;
  end;

  {-------------------- TLMDShellfrmBrowseDialog ------------------------------}
  TLMDShellfrmBrowseDialog = class(TForm)
    StatusBar: TStatusBar;
    ShellFolder: TLMDShellFolder;
    pnlBottom: TPanel;
    btnCreateFolder: TButton;
    btnOK: TButton;
    btnCancel: TButton;
    pnlTop: TPanel;
    sbtnDeleteFolder: TSpeedButton;
    sbtnCreateFolder: TSpeedButton;
    pnlTree: TPanel;
    ShellTree: TLMDShellTree;
    lblInstruction: TLabel;
    procedure sbtnDeleteFolderClick(Sender: TObject);
    procedure ShellFolderChange(Sender: TObject);
    procedure sbtnCreateFolderClick(Sender: TObject);
    procedure ShellTreeItemSelected(Sender: TObject; Item: TLMDCustomShellItem);
  private
    FComponent: TLMDShellBrowseDialog;
    procedure WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo); message WM_GETMINMAXINFO;
  protected
    procedure Resize; override;
  public
    procedure CMDialogKey(var Msg: TCMDialogKey); message CM_DIALOGKEY;
  end;

implementation

uses
  ShellAPI, 
  LMDShConsts;

{$R *.DFM}
{******************** class TLMDShellBroweDialog ******************************}
{----------------------------- Private ----------------------------------------}

procedure TLMDShellBrowseDialog.SetCaption(const aValue: string);
begin
  if Assigned(FDialog) then
    FDialog.Caption:= aValue;
  FCaption:= aValue;
end;

{------------------------------------------------------------------------------}

procedure TLMDShellBrowseDialog.SetStatusText(const aValue: string);
begin
  if Assigned(FDialog) and (doStatusBar in FOptions) then
    FDialog.StatusBar.SimpleText:= aValue;
  FStatusText:= aValue;
end;

{------------------------------------------------------------------------------}

function TLMDShellBrowseDialog.GetImage(Index: Integer): TBitmap;
var
  Flags: DWORD;
  Unused: TSHFileInfo;
begin
  Result:= nil;
  with TImageList.Create(Self) do
    try
      case Index of
        1:
          begin
            Result:= FImageLarge;
            Flags:= SHGFI_SYSICONINDEX or SHGFI_LARGEICON;
          end;
        2:
          begin
            Result:= FImageSmall;
            Flags:= SHGFI_SYSICONINDEX or SHGFI_SMALLICON;
          end;
      else
        Exit;
      end;

      Handle:= SHGetFileInfo(PChar(EmptyStr), 0, Unused, SizeOf(Unused), Flags);

      ShareImages:= true;
      GetBitmap(ImageIndex, Result);
    finally
      Free;
    end;
end;

procedure TLMDShellBrowseDialog.SetOptions(aValue: TLMDShellBrowseDialogOptions);
begin
  if  FOptions <> aValue  then
    begin
      FOptions := aValue;

      if  doReadOnly in FOptions  then
        FOptions := FOptions - [doCreateButton, doCreateSpeedButton, doDeleteSpeedButton];

      if  not (doSizeable in FOptions)  then
        FOptions := FOptions - [doSizeGrip];
    end;
end;

{----------------------------- Protected --------------------------------------}
procedure TLMDShellBrowseDialog.DoInit;
begin
  if Assigned(FDialog) then
    with FDialog do
      begin
        // Strings
        btnCreateFolder.Caption:= sNewFolderName;
        btnCancel.Caption:= IDSHELL_CANCEL;
        btnOK.Caption:= IDSHELL_OK;
        if FCaption = '' then
          Caption:= sBrowseForFolder
        else
          Caption:= FCaption;
        if doShowHints in FOptions then
          begin
            btnCreateFolder.Hint:= sCreateFolderHint;
            sbtnCreateFolder.Hint:= sCreateFolderHint;
            sbtnDeleteFolder.Hint:= sDeleteFolderHint;
          end;

        StatusBar.Visible:= (doStatusBar in FOptions) or (doSizeGrip in FOptions);

        StatusBar.SizeGrip:= (doSizeGrip in FOptions) and (BorderStyle <>
          bsDialog);

        if doStatusBar in FOptions then
          begin
            StatusBar.SimplePanel:= True;
            StatusBar.SimpleText:= FStatusText;
//            StatusBar.Visible:= true;
          end;

        btnCreateFolder.Visible:= (doCreateButton in FOptions) and (not
          (doReadOnly in FOptions));
        sbtnCreateFolder.Visible:= (doCreateSpeedButton in FOptions) and (not
          (doReadOnly in FOptions));
        sbtnDeleteFolder.Visible:= (doDeleteSpeedButton in FOptions) and (not
          (doReadOnly in FOptions));

        if FInstructionText = EmptyStr then
          lblInstruction.Caption:= sBrowseInstruction
        else
          lblInstruction.Caption:= FInstructionText;

        pnlTop.Visible:= (doInstructionField in FOptions) or
          (doDeleteSpeedButton in FOptions) or
          (doCreateSpeedButton in FOptions);

        if Assigned(FOnInit) then FOnInit(self, aForm);

        ShellTree.ReadOnly := (doReadOnly in FOptions);
      end;

end;

{----------------------------- Public -----------------------------------------}

constructor TLMDShellBrowseDialog.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FDialog:= nil;
  FCaption:= EmptyStr;
  FDisplayName:= EmptyStr;
  FImageIndex:= 0;
  FRootFolder:= sRFDesktop;
  FStatusText:= '';
  FImageLarge:= TBitmap.Create;
  FImageSmall:= TBitmap.Create;
  FOptions:= [doSizeable];
  //FFilter:=bfBrowseForDirectories;

end;

{------------------------------------------------------------------------------}

destructor TLMDShellBrowseDialog.Destroy;
begin
  FImageLarge.Free;
  FImageSmall.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

function TLMDShellBrowseDialog.Execute;
begin
  FSelectedPath:= '';

  if ((OwnerHandle=pwOwnerForm) and (Owner is TCustomForm)) and not (csDesigning in ComponentState) then
    FDialog:=TLMDShellfrmBrowseDialog.Create(Owner)
  else
    FDialog:=TLMDShellfrmBrowseDialog.Create(Application);
  try

    if not (doSizeable in FOptions) then
      FDialog.BorderStyle:= bsDialog;

    FDialog.FComponent:= Self;
    FDialog.ShellFolder.RootFolder:= FRootFolder;

{
    if doShowHidden in FOptions then
      FDialog.ShellFolder.Options:= FDialog.ShellFolder.Options + [foIncludeHidden]
    else
      FDialog.ShellFolder.Options:= FDialog.ShellFolder.Options -
        [foIncludeHidden];
}
//    FDialog.ShellTree.RightClickSelect:= doShowContextMenu in FOptions;

    DoInit(FDialog);
    Result:= FDialog.ShowModal = mrOk;
    if Result then
      FSelectedPath:= FDialog.ShellFolder.ActiveFolder.Path;
    FImageIndex:= FDialog.ShellFolder.ActiveFolder.IconIndex;
  finally
    FreeAndNil(FDialog);
  end;
end;
{****************** Form TLMDShellfrmBroweDialog ******************************}
{----------------------------- Private ----------------------------------------}

{----------------------------- Protected --------------------------------------}

procedure TLMDShellfrmBrowseDialog.Resize;
begin
  inherited Resize;
  FComponent.DoResize(self);
end;

procedure TLMDShellfrmBrowseDialog.sbtnDeleteFolderClick(Sender: TObject);
begin
  if ShellTree.Selected <> nil then
    ShellFolder.DeleteItem(ShellTree.SelectedItem);
end;

procedure TLMDShellBrowseDialog.DoResize(aForm: TLMDShellfrmBrowseDialog);
begin
  if Assigned(FOnResize) then
    FOnResize(Self, aForm);
end;

procedure TLMDShellfrmBrowseDialog.ShellFolderChange(Sender: TObject);
begin
  StatusBar.SimpleText := ShellFolder.ActiveFolder.Path;
end;

procedure TLMDShellfrmBrowseDialog.sbtnCreateFolderClick(Sender: TObject);
begin
  ShellTree.SetFocus;
  if Assigned(ShellTree.Selected) then
      ShellTree.NewFolder;
end;

procedure TLMDShellfrmBrowseDialog.ShellTreeItemSelected(Sender: TObject;
  Item: TLMDCustomShellItem);
var
  Txt: string;
begin
  if  Assigned(Item)  then
    Txt := Item.Path
  else
    Txt := '';
  Statusbar.Panels.BeginUpdate;
  Statusbar.Panels[0].Text := Txt;
  Statusbar.Panels.EndUpdate;
end;

procedure TLMDShellfrmBrowseDialog.WMGetMinMaxInfo(var Msg: TWMGetMinMaxInfo);
begin
  inherited;

  with Msg.MinMaxInfo.ptMinTrackSize do
  begin
    x := self.Constraints.MinWidth;
    y := self.Constraints.MinHeight;
  end;
end;

procedure TLMDShellfrmBrowseDialog.CMDialogKey(var Msg: TCMDialogKey);
begin
  if  ShellTree.IsEditing
      and (Msg.CharCode in [VK_RETURN, VK_ESCAPE])
      and (KeyDataToShiftState(Msg.KeyData) = []) then
    begin
      Msg.Result := 1;
      ShellTree.Selected.EndEdit((TWMKey(Msg).CharCode = VK_ESCAPE));
    end
  else
    inherited ;
end;

end.
