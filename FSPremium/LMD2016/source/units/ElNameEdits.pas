unit ElNameEdits;
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

ElNameEdits unit
----------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, ElPopBtn, ElFolderDlg, Classes, ElShellUtils, ElBtnEdit, Forms,
  Menus, Controls, Windows, CommDlg, Graphics, Types, Dialogs, LMDTypes,
  LMDUnicodeDialogs, ElVCLUtils;

type
     TBeforeFileDialogEvent = procedure(Sender : TObject; Dialog : TOpenDialog) of object;
     TBeforeFolderDialogEvent = procedure(Sender : TObject; Dialog : TElFolderDialog) of object;

     TElFolderNameEdit = class(TCustomElButtonEdit)
     private
       FileDlg : TElFolderDialog;
       function GetOptions: TBrowseForFolderOptions;
     function GetTitle: TLMDString;
       procedure SetOptions(Value: TBrowseForFolderOptions);
     procedure SetTitle(const Value: TLMDString);
       procedure SetRootFolder(Value: TShellFolders);
       function GetRootFolder: TShellFolders;
     protected
     FDialogTitle: TLMDString;
       FOnDialogExecute: TNotifyEvent;
       FOnBeforeDialogExecute: TBeforeFolderDialogEvent;
     FPrompt: TLMDString;
       procedure BtnClick(Sender : TObject);
       procedure CreateHandle; override;
       procedure Loaded; override;
     procedure SetStatusText(const Value: TLMDString);
     function GetStatusText: TLMDString;
     function GetCustomRootFolder: TLMDString;
     procedure SetCustomRootFolder(const Value: TLMDString);
       procedure TriggerBeforeDialogExecute(Dialog : TElFolderDialog); virtual;
       procedure TriggerDialogExecute; virtual;
     procedure SetPrompt(const Value: TLMDString);
       procedure SetReadOnly(newValue : Boolean);override;
     public
       constructor Create(AOwner : TComponent); override;
       destructor Destroy; override;
     published
       property Options: TBrowseForFolderOptions read GetOptions write SetOptions;
     property Title: TLMDString read GetTitle write SetTitle stored false;
       property RootFolder: TShellFolders read GetRootFolder write SetRootFolder;
     property DialogTitle: TLMDString read GetTitle write SetTitle;
     property StatusText: TLMDString read GetStatusText write SetStatusText;
     property CustomRootFolder: TLMDString read GetCustomRootFolder write
           SetCustomRootFolder;
       property OnBeforeDialogExecute: TBeforeFolderDialogEvent read
           FOnBeforeDialogExecute write FOnBeforeDialogExecute;
       property OnDialogExecute: TNotifyEvent read FOnDialogExecute write
           FOnDialogExecute;
     property Prompt: TLMDString read FPrompt write SetPrompt;

       property VertScrollBarStyles;
       property HorzScrollBarStyles;
       property UseCustomScrollBars;

       property ButtonVisible;
       property TopMargin;
       property LeftMargin;
       property RightMargin;
       property BorderSides;
       property MaxLength;
       property Transparent;
       property HandleDialogKeys;
       property FocusedSelectColor;
       property FocusedSelectTextColor;
       property HideSelection;
       property HideSelectColor;
       property HideSelectTextColor;
       property HighlightAlphaLevel;
       property LineBorderActiveColor;
       property LineBorderInactiveColor;
       property ImageForm;
       property OnMouseEnter;
       property OnMouseLeave;
       property OnResize;
       property OnChange;
       property OnSelectionChange;
       property LinkedControl;
       property LinkedControlPosition;
       property LinkedControlSpacing;
       property UseDisabledColors;
       property DisabledColor;
       property DisabledFontColor;

       property Text;

       // inherited
       property Flat;
       property ActiveBorderType;
       property InactiveBorderType;
       property UseBackground;
       property UseSystemMenu;
       property Alignment;
       property AutoSelect;

       property Background;
       property ButtonClickSound;
       property ButtonDownSound;
       property ButtonUpSound;
       property ButtonSoundMap;
       property ButtonColor;
       property ButtonFlat;
       property ButtonHint;
       property ButtonShortcut default 32808;
       property ButtonGlyph;
       property ButtonIcon;
       property ButtonUseIcon;
       property ButtonNumGlyphs;
       property ButtonWidth;
       property ButtonShowBorder;
       property ButtonThinFrame;
       property ButtonOldStyled;

       property AltButtonCaption;
       property AltButtonClickSound;
       property AltButtonDownSound;
       property AltButtonUpSound;
       property AltButtonSoundMap;
       property AltButtonDown;
       property AltButtonEnabled;
       property AltButtonFlat;
       property AltButtonGlyph;
       property AltButtonHint;
       property AltButtonIcon;
       property AltButtonUseIcon;
       property AltButtonNumGlyphs;
       property AltButtonPopupPlace;
       property AltButtonPosition;
       property AltButtonPullDownMenu;
       property AltButtonShortcut;
       property AltButtonVisible;
       property AltButtonWidth;
       property AltButtonShowBorder;
       property AltButtonThinFrame;
       property AltButtonOldStyled;
       property AltButtonPngGlyph;
       property AltButtonUsePng;

       property OnAltButtonClick;

       // VCL properties
       property AutoSize;
       property BorderStyle;
       property Ctl3D default True;
       property ParentCtl3D default False;
       property Enabled;
       property TabStop default True;
       property TabOrder;
       property PopupMenu;
       property Color;
       property ParentColor default False;
       property Align;
       property Font;
       property ParentFont;
       property ParentShowHint;
       property ShowHint;
       property Visible;
       property ReadOnly;

       property OnEnter;
       property OnExit;
       property OnClick;
       property OnDblClick;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnStartDrag;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDock;
       property OnEndDrag;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
       property OnStartDock;
       property Anchors;

       property Constraints;
       property DockOrientation;
       property Floating;
       property DoubleBuffered;
       property DragKind;
   end;

     TElFileDialogType = (fdtOpen, fdtSave);

     TElFileNameEdit = class(TCustomElButtonEdit)
     private
       FileDlg : TOpenDialog;
       function GetFilterIndex: Integer;
       procedure SetHistoryList(Value: TStrings);
     procedure SetInitialDir(const Value: TLMDString);
     function GetDefaultExt: TLMDString;
     procedure SetDefaultExt(const Value: TLMDString);
       function GetFiles: TStrings;
       function GetHistoryList: TStrings;
     function GetInitialDir: TLMDString;
       function GetOptions: TOpenOptions;
       procedure SetOptions(Value: TOpenOptions);
       procedure SetFilterIndex(Value: Integer);
     function GetTitle: TLMDString;
     procedure SetTitle(const Value: TLMDString);
     function GetFilter: TLMDString;
     procedure SetFilter(const Value: TLMDString);
     protected
       OwnGlyphs : boolean;
     FDialogTitle: TLMDString;
       FDialogType: TElFileDialogType;
       FOnDialogExecute: TNotifyEvent;
       FParseParameters: Boolean;
       FOnBeforeDialogExecute: TBeforeFileDialogEvent;
       procedure BtnClick(Sender : TObject);
       procedure CreateHandle; override;
       procedure Loaded; override;
       procedure TriggerDialogExecute; virtual;
       procedure TriggerBeforeDialogExecute(Dialog : TOpenDialog); virtual;
       procedure UpdateGlyph;
       procedure SetDialogType(Value: TElFileDialogType);
       procedure SetButtonGlyph(newValue : TBitmap); override;
       procedure DefineProperties(Filer: TFiler); override;
       procedure SetReadOnly(newValue : Boolean);override;
     public
       constructor Create(AOwner : TComponent); override;
       destructor Destroy; override;
       property Files: TStrings read GetFiles;
       property HistoryList: TStrings read GetHistoryList write SetHistoryList;
     published
     property DefaultExt: TLMDString read GetDefaultExt write SetDefaultExt;
     property Filter: TLMDString read GetFilter write SetFilter;
       property FilterIndex: Integer read GetFilterIndex write SetFilterIndex default
           1;
     property InitialDir: TLMDString read GetInitialDir write SetInitialDir;
       property Options: TOpenOptions read GetOptions write SetOptions
         default [ofHideReadOnly, ofEnableSizing];
     property Title: TLMDString read GetTitle write SetTitle stored false;
     property DialogTitle: TLMDString read GetTitle write SetTitle;
       property DialogType: TElFileDialogType read FDialogType write SetDialogType
           default fdtOpen;
       property ParseParameters: Boolean read FParseParameters write FParseParameters default true;

       property OnDialogExecute: TNotifyEvent read FOnDialogExecute write FOnDialogExecute;
       property OnBeforeDialogExecute: TBeforeFileDialogEvent read
           FOnBeforeDialogExecute write FOnBeforeDialogExecute;

       property VertScrollBarStyles;
       property HorzScrollBarStyles;
       property UseCustomScrollBars;

       property ButtonVisible;
       property TopMargin;
       property LeftMargin;
       property RightMargin;
       property BorderSides;
       property MaxLength;
       property Transparent;
       property HandleDialogKeys;
       property FocusedSelectColor;
       property FocusedSelectTextColor;
       property HideSelection;
       property HideSelectColor;
       property HideSelectTextColor;
       property HighlightAlphaLevel;
       property LineBorderActiveColor;
       property LineBorderInactiveColor;
       property ImageForm;
       property OnMouseEnter;
       property OnMouseLeave;
       property OnResize;
       property OnChange;
       property OnSelectionChange;
       property LinkedControl;
       property LinkedControlPosition;
       property LinkedControlSpacing;
       property Text;
       property UseDisabledColors;
       property DisabledColor;
       property DisabledFontColor;

       // inherited
       property Flat;
       property ActiveBorderType;
       property InactiveBorderType;
       property UseSystemMenu;

       property UseBackground;
       property Alignment;
       property AutoSelect;

       property Background;
       property ButtonClickSound;
       property ButtonDownSound;
       property ButtonUpSound;
       property ButtonSoundMap;
       property ButtonColor;
       property ButtonFlat;
       property ButtonHint;
       property ButtonShortcut default 32808;
       property ButtonGlyph;
       property ButtonIcon;
       property ButtonUseIcon;
       property ButtonNumGlyphs;
       property ButtonWidth;
       property ButtonShowBorder;
       property ButtonThinFrame;
       property ButtonOldStyled;

       property AltButtonCaption;
       property AltButtonClickSound;

       property AltButtonDownSound;
       property AltButtonUpSound;
       property AltButtonSoundMap;
       property AltButtonDown;
       property AltButtonEnabled;
       property AltButtonFlat;
       property AltButtonGlyph;
       property AltButtonHint;
       property AltButtonIcon;
       property AltButtonNumGlyphs;
       property AltButtonPopupPlace;
       property AltButtonPosition;
       property AltButtonPullDownMenu;
       property AltButtonShortcut;
       property AltButtonUseIcon;
       property AltButtonVisible;
       property AltButtonWidth;
       property AltButtonShowBorder;
       property AltButtonThinFrame;
       property AltButtonOldStyled;
       property OnAltButtonClick;

       // VCL properties
       property AutoSize;
       property BorderStyle;
       property Ctl3D;
       property ParentCtl3D;
       property Enabled;
       property TabStop default True;
       property TabOrder;
       property PopupMenu;
       property Color;
       property ParentColor;
       property Align;
       property Font;
       property ParentFont;
       property ParentShowHint;
       property ShowHint;
       property Visible;
       property ReadOnly;

       property OnEnter;
       property OnExit;
       property OnClick;
       property OnDblClick;
       property OnKeyDown;
       property OnKeyPress;
       property OnKeyUp;
       property OnStartDrag;
       property OnDragDrop;
       property OnDragOver;
       property OnEndDock;
       property OnEndDrag;
       property OnMouseDown;
       property OnMouseMove;
       property OnMouseUp;
   property OnStartDock;
   property Anchors;
       property Constraints;
       property DockOrientation;
       property Floating;
       property DoubleBuffered;
       property DragKind;
   end;

implementation

type
  THackElEditBtn = class(TCustomElGraphicButton)
  public
    property OnClick;
  end;

  TElFileNameDialog = class(TLMDSaveDialog)
    function Execute: Boolean; override;
  end;

constructor TElFileNameEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FParseParameters := true;
  FileDlg := TElFileNameDialog.Create(Self);
  THackElEditBtn(FButton).OnClick := BtnClick;
  ButtonShortCut := Shortcut(VK_DOWN, [ssAlt]);
end; { Create }

function GetParamStr(P: PLMDChar; var Param: TLMDString): PLMDChar;

var
  Len: Integer;
  Buffer: array[0..4095] of TLMDChar;
begin
  while True do
  begin
    while (P[0] <> #0) and (P[0] <= ' ') do
      Inc(P);
    if (P[0] = '"') and (P[1] = '"') then
      Inc(P, 2)
    else
      Break;
  end;
  Len := 0;
  while (P[0] > ' ') and (Len < SizeOf(Buffer)) do
    if P[0] = '"' then
    begin
      Inc(P);
      while (P[0] <> #0) and (P[0] <> '"') do
      begin
        Buffer[Len] := P[0];
        Inc(Len);
        Inc(P);
      end;
      if P[0] <> #0 then
        Inc(P);
    end
    else
    begin
      Buffer[Len] := P[0];
      Inc(Len);
      Inc(P);
    end;
  SetString(Param, Buffer, Len);
  Result := P;
  end;

procedure TElFileNameEdit.BtnClick(Sender : TObject);
var AFileName : TLMDString;
    APath,
    AParams   : TLMDString;

begin
  if not ReadOnly then
  begin
    AParams := '';
    AFileName := Text;
    if ((not FileExists(AFileName)) and (Trim(AFilename) <> '')) then
    begin
      if ParseParameters then
      begin

        GetParamStr(PLMDChar(Text), AFileName);

        if (Pos('"', Text) > 1) and (Length(Text) - Length(AFileName) > 2) then
          AParams := Copy(Text, Length(AFileName) + 1, Length(Text));
      end
      else
      begin
        AParams := '';
      end;
      APath := ExtractFilePath(AFileName);
      //if DirExists(APath) and (InitialDir = '') then
      if DirectoryExists(APath) then
        SetInitialDir(APath);
    end
    else
    if (InitialDir = '') then
      SetInitialDir(ExtractFilePath(AFileName));

    if InitialDir <> '' then
      SetInitialDir(InitialDir);

    AFileName := ExtractFileName(AFileName);
    FileDlg.FileName := AFileName;
    FileDlg.Title := DialogTitle;

    TriggerBeforeDialogExecute(FileDlg);

    if FileDlg.Execute then
    begin
      Text := FileDlg.FileName + AParams;
      Modified := true;
      TriggerDialogExecute;
      Change;
    end;
  end;
end;

destructor TElFileNameEdit.Destroy;
begin
  FileDlg.Free;
  inherited;
end;

function TElFileNameEdit.GetFilterIndex: Integer;
begin
  Result := FileDlg.FilterIndex;
end;

procedure TElFileNameEdit.SetHistoryList(Value: TStrings);
begin
  FileDlg.HistoryList := Value;
end;

procedure TElFileNameEdit.SetInitialDir(const Value: TLMDString);
begin
  FileDlg.InitialDir := Value;
end;

function TElFileNameEdit.GetDefaultExt: TLMDString;
begin
  Result := FileDlg.DefaultExt;
end;

procedure TElFileNameEdit.SetDefaultExt(const Value: TLMDString);
begin
  FileDlg.DefaultExt := Value;
end;

function TElFileNameEdit.GetFiles: TStrings;
begin
  Result := FileDlg.Files;
  if (FileDlg.Files.IndexOf(Text) < 0) and (Text <> '') then
    FileDlg.Files.Add(Text);
end;

function TElFileNameEdit.GetHistoryList: TStrings;
begin
  Result := FileDlg.HistoryList;
end;

function TElFileNameEdit.GetInitialDir: TLMDString;
begin
  Result := FileDlg.InitialDir;
end;

function TElFileNameEdit.GetOptions: TOpenOptions;
begin
  Result := FileDlg.Options;
end;

procedure TElFileNameEdit.SetOptions(Value: TOpenOptions);
begin
  FileDlg.Options := Value;
end;

procedure TElFileNameEdit.SetFilterIndex(Value: Integer);
begin
  FileDlg.FilterIndex := Value;
end;

function TElFileNameEdit.GetTitle: TLMDString;
begin
  Result := FDialogTitle;
end;

procedure TElFileNameEdit.SetTitle(const Value: TLMDString);
begin
  FileDlg.Title := Value;
  FDialogTitle := Value;
end;

function TElFileNameEdit.GetFilter: TLMDString;
begin
  Result := FileDlg.Filter;
end;

procedure TElFileNameEdit.SetFilter(const Value: TLMDString);
begin
  FileDlg.Filter := Value;
end;

procedure TElFileNameEdit.CreateHandle;
begin
  inherited;
  if not (csLoading in ComponentState) then
    UpdateGlyph;
  if (THackElEditBtn(FButton).Width <> 0) and (THackElEditBtn(FButton).Width < ButtonGlyph.Width + 2) then
    THackElEditBtn(FButton).Width := ClientHeight;
  SetEditRect(ClientRect);
end;

procedure TElFileNameEdit.UpdateGlyph;
var
  s: TLMDString;
begin
  if THackElEditBtn(FButton).Glyph.Empty then
  begin
    OwnGlyphs := true;
    if Self.FDialogType = fdtSave then
      s := 'ELFILESAVEEDITBUTTON'
    else
      s := 'ELFILENAMEEDITBUTTON';
    THackElEditBtn(FButton).Glyph.LoadFromResourceName(HInstance, s);
    end;
end;

procedure TElFileNameEdit.SetDialogType(Value: TElFileDialogType);
begin
  if FDialogType <> Value then
  begin
    FDialogType := Value;
    if (not (csLoading in ComponentState)) and OwnGlyphs then
    begin
      THackElEditBtn(FButton).Glyph.Width := 0;
      UpdateGlyph;
    end;
  end;
end;

procedure TElFileNameEdit.Loaded;
begin
  inherited;
  UpdateGlyph;
end;

procedure TElFileNameEdit.TriggerDialogExecute;
begin
  if Assigned(FOnDialogExecute) then
    FOnDialogExecute(Self);
end;

procedure TElFileNameEdit.TriggerBeforeDialogExecute(Dialog : TOpenDialog);
begin
  if assigned(FOnBeforeDialogExecute) then
    FOnBeforeDialogExecute(Self, Dialog);
end;

procedure TElFileNameEdit.SetButtonGlyph(newValue : TBitmap);
{ Sets the FButton subcomponent's Glyph property to newValue. }
begin
  inherited;
  OwnGlyphs := false;
end; { SetButtonGlyph }

procedure TElFileNameEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  with GetElReader do
    Filer.DefineProperty('Multiline', FakeBoolean, nil, false);
end;

constructor TElFolderNameEdit.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);
  FileDlg := TElFolderDialog.Create(nil);
  THackElEditBtn(FButton).Glyph.LoadfromResourceName(HInstance, 'ELFOLDERNAMEEDITBUTTON');
  THackElEditBtn(FButton).OnClick := BtnClick;
  ButtonShortCut := Shortcut(VK_DOWN, [ssAlt]);
end; { Create }

destructor TElFolderNameEdit.Destroy;
begin
  FileDlg.Free;
  inherited;
end;

procedure TElFolderNameEdit.BtnClick(Sender : TObject);
var AForm : TCustomForm;
begin
  if not ReadOnly then
  begin
    FileDlg.Folder := Text;
    FileDlg.DialogTitle := DialogTitle;
    FileDlg.Parent := GetParentForm(Self);
    TriggerBeforeDialogExecute(FileDlg);
    if FileDlg.ExecuteModal then
    begin
      Text := FileDlg.Folder;
      Modified := true;
      TriggerDialogExecute;
      AForm := GetParentForm(Self);
      if AForm <> nil then AForm.BringToFront;
      Change;
    end;
  end;
end;

function TElFolderNameEdit.GetOptions: TBrowseForFolderOptions;
begin
  Result := FileDlg.Options;
end;

function TElFolderNameEdit.GetTitle: TLMDString;
begin
  Result := FDialogTitle;
end;

procedure TElFolderNameEdit.SetOptions(Value: TBrowseForFolderOptions);
begin
  FileDlg.Options := Value;
end;

procedure TElFolderNameEdit.SetTitle(const Value: TLMDString);
begin
  FileDlg.DialogTitle := Value;
  FDialogTitle := Value;
end;

procedure TElFolderNameEdit.SetRootFolder(Value: TShellFolders);
begin
  FileDlg.RootFolder := Value;
end;

function TElFolderNameEdit.GetRootFolder: TShellFolders;
begin
  Result := FileDlg.RootFolder;
end;

procedure TElFolderNameEdit.CreateHandle;
begin
  inherited;
  if (THackElEditBtn(FButton).Width <> 0) and (THackElEditBtn(FButton).Width < ButtonGlyph.Width + 2) then
    THackElEditBtn(FButton).Width := ClientHeight;
  SetEditRect(ClientRect);
end;

procedure TElFolderNameEdit.Loaded;
begin
  inherited;
  if THackElEditBtn(FButton).Glyph.Empty then
    THackElEditBtn(FButton).Glyph.LoadFromResourceName(HInstance, 'ELFOLDERNAMEEDITBUTTON');
end;

procedure TElFolderNameEdit.SetStatusText(const Value: TLMDString);
begin
  FileDlg.StatusText := Value;
end;

function TElFolderNameEdit.GetStatusText: TLMDString;
begin
  Result := FileDlg.StatusText;
end;

function TElFolderNameEdit.GetCustomRootFolder: TLMDString;
begin
  Result := FileDlg.CustomRootFolder;
end;

procedure TElFolderNameEdit.SetCustomRootFolder(const Value: TLMDString);
begin
  FileDlg.CustomRootFolder := Value;
end;

procedure TElFolderNameEdit.TriggerBeforeDialogExecute(Dialog :
    TElFolderDialog);
begin
  if assigned(FOnBeforeDialogExecute) then
    FOnBeforeDialogExecute(Self, Dialog);
end;

procedure TElFolderNameEdit.TriggerDialogExecute;
begin
  if Assigned(FOnDialogExecute) then
    FOnDialogExecute(Self);
end;

procedure TElFolderNameEdit.SetPrompt(const Value: TLMDString);
begin
  if FPrompt <> Value then
  begin
    FPrompt := Value;
    FileDlg.Prompt := Value;
  end;
end;

function TElFileNameDialog.Execute: Boolean;
begin
  if TElFileNameEdit(Owner).DialogType = fdtOpen then
    Result := DoExecute(@GetOpenFileName)
  else
    Result := DoExecute(@GetSaveFileName);
end;

procedure TElFolderNameEdit.SetReadOnly(newValue: Boolean);
begin
  inherited;
  ButtonEnabled := not ReadOnly;
end;

procedure TElFileNameEdit.SetReadOnly(newValue: Boolean);
begin
  inherited;
  ButtonEnabled := not ReadOnly;
end;

end.
