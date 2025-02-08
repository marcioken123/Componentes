unit LMDPrintToolBar;
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

LMDPrintToolBar unit (RM)
-------------------------
A predefined toolbar for use with Preview Panel (for printing tasks).

Changes
-------
Release 1.05 (February 2008)
[+] BorderWith property added

Release 1.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, ComCtrls, Messages, SysUtils, Classes, Graphics, Controls,
  StdCtrls, Buttons, ExtCtrls, Dialogs, Forms,
  LMDCustomBevelPanel, LMDPrintPreviewPanel, LMDSHSpinEdit, intfLMDBase, LMDTypes;

type
  TLMDPrintToolBarItem=(// Printing / Setup
                        tbPrint, tbPrintSetup, tbPageSettings, tbSave,
                        // Dimensions
                        tbZoom100, tbZoomTextWidth, tbWholePage, tbTwoPages,
                        tbMultiPages, tbZoomOut, tbZoomIn,
                        // Navigation
                        tbPageFirst, tbPagePrev, tbPageNext, tbPageLast,
                        // rest
                        tbPageSpin, tbScaleCombo, tbClose);

  TLMDPrintToolBarItems = set of TLMDPrintToolBarItem;

const
  def_LMDPrintToolBarItems=[tbPrint, tbPrintSetup, tbPageSettings, tbSave,
                            tbZoom100, tbWholePage,
                            tbTwoPages, tbMultiPages, tbZoomIn, tbZoomOut,
                            tbPageFirst, tbPagePrev, tbPageNext, tbPageLast,
                            tbPageSpin, tbScaleCombo,
                            tbClose
                            ];

type
  TLMDPrintToolBar = class(TPanel, ILMDComponent )
  private
    FAbout    : TLMDAboutVar;
    FItems: TLMDPrintToolBarItems;
    FChangeLink: TLMDPrintChangeLink;
    FPreviewPanel: TLMDPrintPreviewPanel;
    FFlat: Boolean;
    FBtnList: TList;
    FPageSpin: TLMDShSpinEdit;
    FScaleCombo: TComboBox;

    FComboCmdStart: Integer;
    FComboCmdEnd: Integer;
    FComboCmd: array of TLMDPrintToolBarItem;

    FSaveDlg: TSaveDialog;

    FImgList: TImageList;
    FToolBar: TToolBar;

    procedure SetPreviewPanel(AValue: TLMDPrintPreviewPanel);
    procedure SetItems(AValue: TLMDPrintToolBarItems);
    procedure SetFlat(AValue: Boolean);
    procedure GetUpdateBar(Sender: TObject);
    function  GetButton(AIndex: TLMDPrintToolBarItem): TToolButton;

    procedure BuildScaleComboStrings;
    procedure DoClick(Sender: TObject);
    procedure DoScaleComboExit(Sender: TObject);
    procedure DoScaleComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    function ModeToComboIdx(AMode: LMDPrintPreviewPanel.TLMDPrintPreviewMode): Integer;
  protected
    procedure CreateHandle; override;
    procedure GetChange(Sender: TObject);
    procedure InitToolBar;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    property  Buttons: TList read FBtnList;
  public
    constructor Create(AOwner: TComponent);override;
    destructor  Destroy; override;
    function getLMDPackage:TLMDPackageID;
    procedure   UpdateBar;
    property    ButtonKind[AIndex: TLMDPrintToolBarItem]: TToolButton read GetButton;
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;

    // custom properties
    property DisplayItems: TLMDPrintToolBarItems read FItems write SetItems
                                                 default def_LMDPrintToolBarItems;
    property Flat: Boolean read FFlat write SetFlat default True;
    property PreviewPanel: TLMDPrintPreviewPanel read FPreviewPanel write SetPreviewPanel;

    //
    // standard properties
    property Align;
    property BorderWidth;
    property Color;
    property ParentColor;
    property ShowHint;
    property ParentShowHint;
    property Visible;
  end;

implementation
uses
  Printers, ImgList,
  LMDPrintPreviewModeDlg, LMDPrintPageDialog, LMDPrinter,
  LMDPrintConst, LMDCustomControl, LMDPrintResModule
  ;

const TOOLBAR_HEIGHT =  22;

var
    CmdDescrs: array[Low(TLMDPrintToolBarItem)..
                     High(TLMDPrintToolBarItem)] of TLMDString;

{------------------------------------------------------------------------------}
function ModeToCmd(AMode: LMDPrintPreviewPanel.TLMDPrintPreviewMode): TLMDPrintToolBarItem;
begin
  Result := tbClose;

  case AMode of
    pmWholePage:  Result := tbWholePage;
    pmTextWidth:  Result := tbZoomTextWidth;
    pmTwoPages:   Result := tbTwoPages;
    pmExactMultiPages: Result := tbMultiPages;
  else
    Assert(false);
  end;
end;

{------------------------------------------------------------------------------}
function ModeToStr(AMode: LMDPrintPreviewPanel.TLMDPrintPreviewMode): TLMDString;
begin
  Result := '';

  case AMode of
    pmWholePage:  Result := SLMDPrintTbWholePage;
    pmTextWidth:  Result := SLMDPrintTbTextWidth;
    pmTwoPages:   Result := SLMDPrintTbTwoPages;
    pmExactMultiPages: Result := SLMDPrintTbMultiplePages;
  else
    Assert(false);
  end;
end;

{*********************** TLMDPrintToolBar *************************************}
{-------------------------- private -------------------------------------------}
procedure TLMDPrintToolBar.SetFlat(AValue: Boolean);
var
  i: Integer;
begin
  if Flat<>AValue then
  begin
    FFlat := AValue;
    if not (csLoading in ComponentState) then
      for i:=0 to FBtnList.Count-1 do
        TSpeedButton(FBtnList[i]).Flat := self.FFlat;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.SetItems(AValue: TLMDPrintToolBarItems);
begin
  if FItems<>AValue then
    begin
      FItems := AValue;
      if not (csLoading in ComponentState) then
        InitToolBar;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.SetPreviewPanel(AValue: TLMDPrintPreviewPanel);
begin
  if FPreviewPanel<>nil then
    FPreviewPanel.UnRegisterChanges(FChangeLink);

  FPreviewPanel := AValue;

  if FPreviewPanel<>nil then
  begin
    FPreviewPanel.RegisterChanges(FChangeLink);
    FPreviewPanel.FreeNotification(Self);
  end;

  GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.BuildScaleComboStrings;
var
  i:Integer;
begin
  if Assigned(FScaleCombo) then
    with FScaleCombo do
    begin
      FScaleCombo.Clear;

      // Add items
      for i := Low(LMDPrintZoomValues) to High(LMDPrintZoomValues) do
        Items.Add(IntTostr(LMDPrintZoomValues[i])+'%');

      FComboCmdStart := Items.Count;

      SetLength(FComboCmd, Items.Count+1);
      i := Items.Add(SLMDPrintTbTextWidth);
      FComboCmd[i] := tbZoomTextWidth;

      SetLength(FComboCmd, Items.Count+1);
      i := Items.Add(SLMDPrintTbWholePage);
      FComboCmd[i] := tbWholePage;

      SetLength(FComboCmd, Items.Count+1);
      i := Items.Add(SLMDPrintTbTwoPages);
      FComboCmd[i] := tbTwoPages;

      FComboCmdEnd := Items.Count-1;

      ItemIndex := 3;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.DoClick(Sender: TObject);
var
  P: TPoint;
  tmpBtn: TToolButton;
  DoSave: Boolean;
begin
  if (not Assigned(FPreviewPanel)) or
     (csLoading in ComponentState)
  then
    Exit;

  case Integer(TControl(Sender).Tag) of
    // print
    Ord(tbPrint): FPreviewPanel.PrinterHelper.ExecPrintDlg;

    // print setup
    Ord(tbPrintSetup): FPreviewPanel.PrinterHelper.ExecPrintSetupDlg;

    // page settings
    Ord(tbPageSettings): FPreviewPanel.PrinterHelper.ExecPageSetupDlg;

    // save
    Ord(tbSave):
    begin
      if FSaveDlg.Execute then
      begin
        DoSave := not FileExists(FSaveDlg.FileName);
        if not DoSave then
        begin
          DoSave := MessageDlg(Format(SLMDPrintToolbarSaveOverwrite,
                                      [FSaveDlg.FileName]),
                               mtConfirmation, [mbYes, mbNo],  -1)=mrYes;
        end;

        if DoSave then
          FPreviewPanel.PrinterHelper.SavePage(orAll, FPreviewPanel.CurrentPage,
                                               FSaveDlg.FileName);
      end;
    end;

    Ord(tbZoom100):
    begin
      FPreviewPanel.Scale := 100;
      FPreviewPanel.Mode := pmExactScale;
    end;

    Ord(tbZoomTextWidth): FPreviewPanel.Mode := pmTextWidth;

    Ord(tbWholePage): FPreviewPanel.Mode := pmWholePage;

    Ord(tbTwoPages): FPreviewPanel.Mode := pmTwoPages;

    Ord(tbMultiPages):
    begin
      // tbMultiPages
      tmpBtn := ButtonKind[tbMultiPages];

      with TLMDPrintPreviewModeDialog.Create(nil) do
        try
          P := Point(tmpBtn.Left, tmpBtn.Top + tmpBtn.Height);
          P := self.ClientToScreen(P);
          Left := P.x;
          Top := P.y;

          if ShowModal = mrOk then
            FPreviewPanel.SetMultiPages(ColCount, RowCount, true);
        finally
          Free;
        end;
    end;

    Ord(tbZoomIn):
    begin
      FPreviewPanel.Scale := FPreviewPanel.RealScale;
      FPreviewPanel.Mode := pmExactScale;
      FPreviewPanel.Zoom(true);
    end;

    Ord(tbZoomOut):
    begin
      FPreviewPanel.Scale := FPreviewPanel.RealScale;    
      FPreviewPanel.Mode := pmExactScale;
      FPreviewPanel.Zoom(false);
    end;

    Ord(tbPageFirst): FPreviewPanel.CurrentPage := 0;

    Ord(tbPagePrev):
      if FPreviewPanel.CurrentPage > 0 then
        FPreviewPanel.CurrentPage := FPreviewPanel.CurrentPage-1;

    Ord(tbPageNext):
      if FPreviewPanel.CurrentPage < FPreviewPanel.TotalPages-1 then
        FPreviewPanel.CurrentPage := FPreviewPanel.CurrentPage + 1;

    Ord(tbPageLast): FPreviewPanel.CurrentPage := FPreviewPanel.TotalPages-1;

    // SpinEdit
    Ord(tbPageSpin): FPreviewPanel.CurrentPage := FPageSpin.Value-1;

    // ScaleCombo
    Ord(tbScaleCombo): DoScaleComboExit(Sender);

    Ord(tbClose):
      if Owner is TCustomForm then
        TCustomForm(Owner).Close;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.DoScaleComboExit(Sender:TObject);
var
  Text : TLMDString;
  i    : integer;
  cmd  : TLMDPrintToolBarItem;
begin
  if FScaleCombo.ItemIndex <> -1 then
    Text := FScaleCombo.Items[FScaleCombo.ItemIndex]
  else
    Text := FScaleCombo.Text;

  if (FScaleCombo.ItemIndex < FComboCmdStart) or
     (StrToIntDef(Text, -1) <> -1)
  then
  begin
    if (Pos('%', Text) = Length(Text)) then
      Delete(Text, Length(Text), 1);

    i := StrToIntDef(Text, -1);

    if i = -1 then
    begin
      if FPreviewPanel.Mode=pmExactScale then
        FScaleCombo.Text := IntToStr(FPreviewPanel.Scale) + '%'
      else
        FScaleCombo.Text := ModeToStr(FPreviewPanel.Mode);
    end
    else
    begin
      FPreviewPanel.Mode := pmExactScale;
      FPreviewPanel.Scale := i;
    end;
  end
  else
  begin
    cmd := FComboCmd[FScaleCombo.ItemIndex];

    case cmd of
      tbZoomTextWidth:  FPreviewPanel.Mode := pmTextWidth;
      tbWholePage:      FPreviewPanel.Mode := pmWholePage;
      tbTwoPages:       FPreviewPanel.Mode := pmTwoPages;
    else
      Assert(false);
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.DoScaleComboKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  AText : string;
begin
  if (Key = VK_RETURN) and (Shift = []) then
  begin
    AText := FScaleCombo.Text;
    FScaleCombo.ItemIndex := -1;
    FScaleCombo.Text := AText;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDPrintToolBar.GetButton(AIndex: TLMDPrintToolBarItem): TToolButton;
var
  i:Integer;
begin
  Result := nil;

  for i:=0 to FBtnList.Count-1 do
    if Integer(TToolButton(FBtnList[i]).Tag)=Ord(AIndex) then
    begin
      Result := TToolButton(FBtnList[i]);
      Break;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.GetUpdateBar(Sender: TObject);
begin
  if ([csLoading, csReading, csDestroying]*ComponentState<>[]) then
    Exit;

  UpdateBar;
end;

{------------------------------------------------------------------------------}
function TLMDPrintToolBar.ModeToComboIdx(AMode: LMDPrintPreviewPanel.TLMDPrintPreviewMode): Integer;
var
  Cmd: TLMDPrintToolBarItem;
begin
  Cmd := ModeToCmd(AMode);

  Result := FComboCmdStart;

  while (Result<=FComboCmdEnd) and (FComboCmd[Result]<>Cmd) do
    Inc(Result);

  if Result > FComboCmdEnd then
    Result := -1;
end;

{--------------------------- protected ----------------------------------------}
procedure TLMDPrintToolBar.CreateHandle;
begin
  inherited;
  FToolBar.Images := FImgList;
  InitToolBar;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.GetChange(Sender: TObject);
begin
  GetUpdateBar(Sender);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.InitToolBar;
var
  i: TLMDPrintToolBarItem;
  Cmd: TLMDPrintToolBarItem;
  Added: Boolean;

  function CreateButton(AIndex: Integer): TToolButton;
  var
    btn: TToolButton;
  begin
    btn := TToolButton.Create(FToolBar);
    FBtnList.Add(btn);

    btn.Parent := FToolBar;
    btn.OnClick := DoClick;
    btn.Tag := AIndex;
    btn.ImageIndex := AIndex;

    Cmd := Low(TLMDPrintToolBarItem);
    Inc(Cmd, AIndex);
    btn.ShowHint := true;
    btn.Hint  := CmdDescrs[Cmd];
    Result := btn;
    Added := true;
  end;

  procedure InsertSpacer;
  var
      btn: TToolButton;
  begin
    if Added then
    begin
      btn := TToolButton.Create(FToolBar);
      btn.Parent := FToolBar;
      btn.Style := tbsSeparator;
      Added := false;
    end;
  end;

  procedure InsertPageSpin;
  begin
    FPageSpin := TLMDShSpinEdit.Create(FToolBar);
    FPageSpin.Parent := FToolBar;
    FPageSpin.Height := TOOLBAR_HEIGHT;
    FPageSpin.Width := 50;
    FPageSpin.Tag := 
                                 Ord(tbPageSpin);
    FPageSpin.MinValue := 1;
    FPageSpin.OnChange := DoClick;

    Added := true;
  end;

  procedure InsertScaleCombo;
  begin
    FScaleCombo := TComboBox.Create(FToolBar);
    FScaleCombo.Parent := FToolBar;
    FScaleCombo.Tag := Ord(tbScaleCombo);
    FScaleCombo.Height := TOOLBAR_HEIGHT;
    FScaleCombo.Width := 90;

    FScaleCombo.OnChange := DoClick;
    FScaleCombo.OnExit := DoScaleComboExit;
    FScaleCombo.OnKeyDown := DoScaleComboKeyDown;

    Added := true;
  end;

  procedure InsertCloseButton;
  var
      btn: TToolButton;
  begin
    btn := CreateButton(Ord(tbClose));
    btn.Hint := SLMDPrintTbClose;
    btn.ImageIndex := Ord(tbClose) - 2;

    Added := true;
  end;

begin
  if not HandleAllocated then
    Exit;

  // clear existing controls
  FBtnList.Clear;

  while FToolBar.ControlCount > 0 do
    FToolBar.Controls[0].Free;
  FToolBar.Height := TOOLBAR_HEIGHT;

  FPageSpin := nil;

  Added := false;

  // Close Button
  if tbClose in FItems then
    InsertCloseButton;

  InsertSpacer;

  if tbPageLast in FItems then
    CreateButton(Ord(tbPageLast));

  if tbPageNext in FItems then
    CreateButton(Ord(tbPageNext));

  if tbPageSpin in FItems then
    InsertPageSpin;

  if tbPagePrev in FItems then
    CreateButton(Ord(tbPagePrev));

  if tbPageFirst in FItems then
    CreateButton(Ord(tbPageFirst));

  InsertSpacer;

  if tbZoomIn in FItems then
    CreateButton(Ord(tbZoomIn));

  InsertScaleCombo;

  if tbZoomOut in FItems then
    CreateButton(Ord(tbZoomOut));

  InsertSpacer;

  for i:=tbMultiPages downto tbZoom100 do
    if i in FItems then
      CreateButton(Ord(i));

  InsertSpacer;

  for i:=tbSave downto tbPrint do
    if i in FItems then
      CreateButton(Ord(i));

  BuildScaleComboStrings;

  FSaveDlg.Filter := SLMDPrintToolbarSaveFilter;
  FSaveDlg.DefaultExt := 'wmf';

  UpdateBar;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.Loaded;
begin
  inherited;
  InitToolBar;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (aComponent = FPreviewPanel) then
    SetPreviewPanel(nil);
end;

{--------------------------- public -------------------------------------------}
constructor TLMDPrintToolBar.Create(AOwner: TComponent);
var
    SrcList: TImageList;
begin
  inherited;

  Height := TOOLBAR_HEIGHT;

  FChangeLink := TLMDPrintChangeLink.Create;
  FChangeLink.OnChange := GetUpdateBar;

  FItems := def_LMDPrintToolBarItems;
  FFlat := True;
  FBtnList := TList.Create;

  FSaveDlg := TSaveDialog.Create(nil);

  FImgList := TImageList.Create(nil);
  Assert(LMDPrintResDataModule<>nil);
  SrcList := LMDPrintResDataModule.PrintToolbarImgList;
  Assert(SrcList<>nil);

  FImgList.Assign(SrcList);
  Assert(FImgList.Count>0);

  FToolBar := TToolBar.Create(self);
  FToolBar.Parent := self;
  FToolBar.EdgeBorders := [];
  FToolBar.Align := alClient;
  FToolBar.Transparent := true;
  FToolBar.Flat := true;
end;

{------------------------------------------------------------------------------}
destructor TLMDPrintToolBar.Destroy;
begin
  FBtnList.Clear;
  FreeAndNil(FBtnList);

  FToolBar.Free;

  FChangeLink.OnChange := nil;
  FreeAndNil(FChangeLink);
  FreeAndNil(FSaveDlg);

  FreeAndNil(FImgList);

  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDPrintToolBar.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintToolBar.UpdateBar;
var
    EnZoom: Boolean; PvOk: Boolean;
    Itm: TLMDPrintToolBarItem;
begin
  if not HandleAllocated then
    Exit;

  PvOk := (not (csLoading in ComponentState)) and
          (FPreviewPanel<>nil) and
          (FPreviewPanel.PrinterHelper<>nil);

  for itm := Low(TLMDPrintToolBarItem) to High(TLMDPrintToolBarItem) do
    if (itm in [tbPrint, tbPrintSetup, tbPageSettings, tbSave,
                tbZoom100,  tbZoomTextWidth, tbWholePage, tbTwoPages,
                tbMultiPages, tbZoomIn, tbZoomOut]) and
       (itm in FItems)
    then
      ButtonKind[itm].Enabled := PvOk;

  if tbPageFirst in FItems then
    ButtonKind[tbPageFirst].Enabled := PvOk and (FPreviewPanel.CurrentPage > 0);

  if tbPagePrev in FItems then
    ButtonKind[tbPagePrev].Enabled := PvOk and (FPreviewPanel.CurrentPage > 0);

  if tbPageNext in FItems then
    ButtonKind[tbPageNext].Enabled := PvOk and
                                      (FPreviewPanel.CurrentPage <
                                       FPreviewPanel.TotalPages-1);

  if tbPageLast in FItems then
    ButtonKind[tbPageLast].Enabled := PvOk and
                                      (FPreviewPanel.CurrentPage <
                                       FPreviewPanel.TotalPages-1);

  if tbPageSpin in FItems then
  begin
    Assert( Assigned(FPageSpin) );

    if PvOk then
    begin
      FPageSpin.Enabled := FPreviewPanel.TotalPages > 1;
      FPageSpin.MaxValue := FPreviewPanel.TotalPages;
      FPageSpin.MinValue := 1;
      FPageSpin.Value := FPreviewPanel.CurrentPage + 1;
    end
    else
      FPageSpin.Enabled := false;
  end;

  EnZoom := PvOk and (FPreviewPanel.Mode<>pmExactMultiPages) and
                     (FPreviewPanel.Mode<>pmTwoPages);

  if tbZoomIn in FItems then
    ButtonKind[tbZoomIn].Enabled := EnZoom and
                                    (FPreviewPanel.Scale <
                                     LMDPrintZoomValues[Low(LMDPrintZoomValues)]);

  if tbZoomOut in FItems then
    ButtonKind[tbZoomOut].Enabled := EnZoom and
                                    (FPreviewPanel.Scale >
                                     LMDPrintZoomValues[High(LMDPrintZoomValues)]);

  if Assigned(FScaleCombo) then
  begin
    FScaleCombo.Enabled := PvOk;

    if FScaleCombo.Enabled then
    begin
      if FPreviewPanel.Mode=pmExactScale then
        FScaleCombo.Text := IntToStr(FPreviewPanel.Scale)+'%'
      else
        FScaleCombo.ItemIndex := ModeToComboIdx(FPreviewPanel.Mode);
    end;
  end;
end;

initialization

  CmdDescrs[tbPrint]          := SLMDPrintTbPrint;
  CmdDescrs[tbPrintSetup]     := SLMDPrintTbPrintSetup;
  CmdDescrs[tbPageSettings]   := SLMDPrintTbPageSettings;
  CmdDescrs[tbSave]           := SLMDPrintTbSave;
  CmdDescrs[tbZoom100]        := SLMDPrintTbZoom100;
  CmdDescrs[tbZoomTextWidth]  := SLMDPrintTbTextWidth;
  CmdDescrs[tbWholePage]      := SLMDPrintTbWholePage;
  CmdDescrs[tbTwoPages]       := SLMDPrintTbTwoPages;
  CmdDescrs[tbMultiPages]     := SLMDPrintTbMultiplePages;
  CmdDescrs[tbZoomIn]         := SLMDPrintTbZoomIn;
  CmdDescrs[tbZoomOut]        := SLMDPrintTbZoomOut;
  CmdDescrs[tbPageFirst]      := SLMDPrintTbPageFirst;
  CmdDescrs[tbPagePrev]       := SLMDPrintTbPagePrev;
  CmdDescrs[tbPageNext]       := SLMDPrintTbPageNext;
  CmdDescrs[tbPageLast]       := SLMDPrintTbPageLast;
  CmdDescrs[tbPageSpin]       := SLMDPrintTbPageSpin;
  CmdDescrs[tbScaleCombo]     := SLMDPrintTbScaleCombo;
  CmdDescrs[tbClose]          := SLMDPrintTbClose;

end.
