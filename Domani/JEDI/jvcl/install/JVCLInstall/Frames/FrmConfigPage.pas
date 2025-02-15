{-----------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/MPL-1.1.html

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either expressed or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: FrmConfigPage.pas, released on 2004-03-29.

The Initial Developer of the Original Code is Andreas Hausladen
(Andreas dott Hausladen att gmx dott de)
Portions created by Andreas Hausladen are Copyright (C) 2004 Andreas Hausladen.
All Rights Reserved.

Contributor(s): -

You may retrieve the latest version of this file at the Project JEDI's JVCL
home page, located at http://jvcl.sourceforge.net

Known Issues:
-----------------------------------------------------------------------------}
// $Id: FrmConfigPage.pas,v 1.21 2006/01/26 23:24:38 ahuser Exp $

unit FrmConfigPage;

{$I jvcl.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  ShellAPI, CommCtrl,
  JvConsts,
  JVCL3Install, JvExStdCtrls, JVCLData, ImgList, FrmDirEditBrowse;

type
  TFrameConfigPage = class(TFrame)
    GroupBoxJvclInc: TGroupBox;
    CheckBoxXPTheming: TCheckBox;
    CheckBoxRegisterGlobalDesignEditors: TCheckBox;
    CheckBoxDxgettextSupport: TCheckBox;
    CheckBoxRegisterJvGif: TCheckBox;
    CheckBoxUseJVCL: TCheckBox;
    GroupBoxInstallOptions: TGroupBox;
    CheckBoxDeveloperInstall: TCheckBox;
    CheckBoxCleanPalettes: TCheckBox;
    ImageListTargets: TImageList;
    CheckBoxBuild: TCheckBox;
    CheckBoxIDERegister: TCheckBox;
    FrameDirEditBrowseBPL: TFrameDirEditBrowse;
    FrameDirEditBrowseDCP: TFrameDirEditBrowse;
    FrameDirEditBrowseHPP: TFrameDirEditBrowse;
    LblBCBGuide: TLabel;
    CheckBoxVerbose: TCheckBox;
    CheckBoxGenerateMapFiles: TCheckBox;
    CheckBoxUnitVersioning: TCheckBox;
    CheckBoxIgnoreMakeErrors: TCheckBox;
    ComboBoxTargetIDE: TComboBox;
    BtnEditJvclInc: TButton;
    PanelBk: TPanel;
    LblOptionsFor: TLabel;
    CheckBoxDebugUnits: TCheckBox;
    procedure CheckBoxDeveloperInstallClick(Sender: TObject);
    procedure CheckBoxXPThemingClick(Sender: TObject);
    procedure ComboBoxTargetIDEChange(Sender: TObject);
    procedure ComboBoxTargetIDEDrawItem(Control: TWinControl;
      Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure BtnEditJvclIncClick(Sender: TObject);
    procedure LblDxgettextHomepageClick(Sender: TObject);
    procedure LblBCBGuideClick(Sender: TObject);
    procedure CheckBoxCompileJclDcpClick(Sender: TObject);
    procedure FrameDirEditBrowseHPPBtnJCLDirBrowseClick(Sender: TObject);
  private
    FInitializing: Integer;
    FInstaller: TInstaller;
    procedure Init;
    procedure UpdateJvclIncSettings;
    function GetSelTargetConfig: TTargetConfig;
    procedure BplDirChanged(Sender: TObject; UserData: TObject; var Dir: string);
    procedure DcpDirChanged(Sender: TObject; UserData: TObject; var Dir: string);
    procedure HppDirChanged(Sender: TObject; UserData: TObject; var Dir: string);
    procedure SetJVCLConfig(const Id: string; CheckBox: TCheckBox);
    procedure GetJVCLConfig(const Id: string; CheckBox: TCheckBox);
  protected
    property Installer: TInstaller read FInstaller;

    property SelTargetConfig: TTargetConfig read GetSelTargetConfig;
  public
    class function Build(Installer: TInstaller; Client: TWinControl): TFrameConfigPage;
  end;

implementation

uses
  InstallerConsts, Core, MainConfig, Main, Utils, Math, JVCLConfiguration,
  DelphiData;

{$R *.dfm}

{ TFrameConfigPage }

class function TFrameConfigPage.Build(Installer: TInstaller;
  Client: TWinControl): TFrameConfigPage;
begin
  Result := TFrameConfigPage.Create(Client);
  Installer.PackageInstaller.Translate(Result);
  Result.FInstaller := Installer;
  Result.Parent := Client;
  Result.Align := alClient;
  Result.Init;
end;

procedure TFrameConfigPage.BplDirChanged(Sender: TObject; UserData: TObject;
  var Dir: string);
begin
  SelTargetConfig.BplDir := Dir;
end;

procedure TFrameConfigPage.DcpDirChanged(Sender: TObject; UserData: TObject;
  var Dir: string);
begin
  SelTargetConfig.DcpDir := Dir;
end;

procedure TFrameConfigPage.HppDirChanged(Sender, UserData: TObject;
  var Dir: string);
begin
  SelTargetConfig.HppDir := Dir;
end;

function TFrameConfigPage.GetSelTargetConfig: TTargetConfig;
begin
  with ComboBoxTargetIDE do
  begin
    if ItemIndex <= 0 then
      Result := nil
    else
      Result := TTargetConfig(Items.Objects[ItemIndex]);
  end;
end;

procedure TFrameConfigPage.Init;
var
  i: Integer;
  x: Integer;
begin
  Inc(FInitializing);
  try
    x := BtnEditJvclInc.BoundsRect.Right;
    BtnEditJvclInc.Width := Max(BtnEditJvclInc.Width, LblOptionsFor.Canvas.TextWidth(BtnEditJvclInc.Caption) + 16);
    BtnEditJvclInc.Left := BtnEditJvclInc.Left - (BtnEditJvclInc.BoundsRect.Right - x);


    ImageListTargets.Clear;

    FrameDirEditBrowseBPL.OnChange := BplDirChanged;
    FrameDirEditBrowseDCP.OnChange := DcpDirChanged;
    FrameDirEditBrowseHPP.OnChange := HppDirChanged;
    FrameDirEditBrowseHPP.AllowEmpty := True;

    with ComboBoxTargetIDE do
    begin
      Items.Clear;
      Items.Add(RsAllTargets);
      for i := 0 to Installer.SelTargetCount - 1 do
      begin
        with Installer.SelTargets[i] do
        begin
          if InstallJVCL then
          begin
            Items.AddObject(Target.DisplayName, Installer.SelTargets[i]);
            AddIconFileToImageList(ImageListTargets, Target.Executable);
          end;
        end;
      end;
      if Items.Count = 2 then
      begin
        ItemIndex := 1;
        ComboBoxTargetIDE.Enabled := False;
      end
      else
      begin
        ComboBoxTargetIDE.Enabled := True;
        ItemIndex := 0;
      end;
    end;
    ComboBoxTargetIDEChange(ComboBoxTargetIDE);

    CheckBoxVerbose.Checked := Installer.Data.Verbose;
    CheckBoxIgnoreMakeErrors.Checked := Installer.Data.IgnoreMakeErrors;

    UpdateJvclIncSettings;
  finally
    Dec(FInitializing);
  end;
end;

procedure TFrameConfigPage.CheckBoxDeveloperInstallClick(Sender: TObject);
var
  TargetConfig: TTargetConfig;
begin
  if FInitializing > 0 then
    Exit;
  if TCheckBox(Sender).State = cbGrayed then
    TCheckBox(Sender).State := cbChecked;

  CheckBoxDebugUnits.Enabled := not CheckBoxDeveloperInstall.Checked;
  CheckBoxCleanPalettes.Enabled := CheckBoxIDERegister.Checked;

  if ComboBoxTargetIDE.ItemIndex <= 0 then
  begin
    if Sender = CheckBoxDeveloperInstall then
      Installer.Data.DeveloperInstall := Integer(CheckBoxDeveloperInstall.Checked)
    else if Sender = CheckBoxDebugUnits then
      Installer.Data.DebugUnits := Integer(CheckBoxDebugUnits.Checked)
    else if Sender = CheckBoxCleanPalettes then
      Installer.Data.CleanPalettes := Integer(CheckBoxCleanPalettes.Checked)
    else if Sender = CheckBoxBuild then
      Installer.Data.Build := Integer(CheckBoxBuild.Checked)
    else if Sender = CheckBoxIDERegister then
      Installer.Data.CompileOnly := Integer(not CheckBoxIDERegister.Checked)
    else if Sender = CheckBoxGenerateMapFiles then
      Installer.Data.GenerateMapFiles := Integer(CheckBoxGenerateMapFiles.Checked)
    ;
  end
  else
  begin
    TargetConfig := SelTargetConfig;
    if Sender = CheckBoxDeveloperInstall then
      TargetConfig.DeveloperInstall := CheckBoxDeveloperInstall.Checked
    else if Sender = CheckBoxDebugUnits then
      TargetConfig.DebugUnits := CheckBoxDebugUnits.Checked
    else if Sender = CheckBoxCleanPalettes then
      TargetConfig.CleanPalettes := CheckBoxCleanPalettes.Checked
    else if Sender = CheckBoxBuild then
      TargetConfig.Build := CheckBoxBuild.Checked
    else if Sender = CheckBoxIDERegister then
      TargetConfig.CompileOnly := not CheckBoxIDERegister.Checked
    else if Sender = CheckBoxGenerateMapFiles then
      TargetConfig.GenerateMapFiles := CheckBoxGenerateMapFiles.Checked
    ;
  end;

  PackageInstaller.UpdatePages;
end;

procedure TFrameConfigPage.CheckBoxCompileJclDcpClick(Sender: TObject);
begin
  if FInitializing > 0 then
    Exit;
  if Sender = CheckBoxVerbose then
    Installer.Data.Verbose := CheckBoxVerbose.Checked
  else if Sender = CheckBoxIgnoreMakeErrors then
    Installer.Data.IgnoreMakeErrors := CheckBoxIgnoreMakeErrors.Checked
  ;
end;

procedure TFrameConfigPage.GetJVCLConfig(const Id: string; CheckBox: TCheckBox);
var
  i, e, Count: Integer;
begin
  CheckBox.AllowGrayed := False;

  if SelTargetConfig = nil then
  begin
    // for all
    e := 0;
    Count := 0;
    for i := 0 to Installer.SelTargetCount - 1 do
      if Installer.SelTargets[i].InstallJVCL then
      begin
        Inc(Count);
        if Installer.SelTargets[i].JVCLConfig.Enabled[Id] then
          Inc(e);
      end;

    if e = 0 then
      CheckBox.Checked := False
    else if e = Count then
      CheckBox.Checked := True
    else
    begin
      CheckBox.AllowGrayed := True;
      CheckBox.State := cbGrayed;
    end;
  end
  else
    CheckBox.Checked := SelTargetConfig.JVCLConfig.Enabled[Id];
end;

procedure TFrameConfigPage.SetJVCLConfig(const Id: string; CheckBox: TCheckBox);
var
  i: Integer;
begin
  if SelTargetConfig = nil then
  begin
    // for all
    for i := 0 to Installer.SelTargetCount - 1 do
    begin
      if Installer.SelTargets[i].InstallJVCL and (CheckBox.State <> cbGrayed) then
      begin
        Installer.SelTargets[i].JVCLConfig.Enabled[Id] := CheckBox.Checked;
        CheckBox.AllowGrayed := False;
      end;
    end;
  end
  else
    SelTargetConfig.JVCLConfig.Enabled[Id] := CheckBox.Checked;
end;

procedure TFrameConfigPage.UpdateJvclIncSettings;
begin
  GetJVCLConfig('JVCLThemesEnabled', CheckBoxXPTheming);
  GetJVCLConfig('JVCL_REGISTER_GLOBAL_DESIGNEDITORS', CheckBoxRegisterGlobalDesignEditors);
  GetJVCLConfig('USE_DXGETTEXT', CheckBoxDxgettextSupport);
  GetJVCLConfig('USE_JV_GIF', CheckBoxRegisterJvGif);
  GetJVCLConfig('USEJVCL', CheckBoxUseJVCL);
  GetJVCLConfig('UNITVERSIONING', CheckBoxUnitVersioning);
end;

procedure TFrameConfigPage.CheckBoxXPThemingClick(Sender: TObject);
var
  i: Integer;
begin
  if FInitializing > 0 then
    Exit;

  if (Sender = CheckBoxXPTheming) and (CheckBoxXPTheming.Tag = 0) then
  begin
    CheckBoxXPTheming.Tag := 1;
    // Is a Delphi/BCB version below 7 installed
    for i := 0 to Installer.SelTargetCount - 1 do
    begin
      if Installer.SelTargets[i].InstallJVCL then
      begin
        if Installer.SelTargets[i].Target.Version < 7 then
        begin
          // give the user a hint to the readme.htm
          if FileExists(Installer.Data.JVCLDir + PathDelim + SReadmeHTM) then
          begin
            if MessageDlg(RsReadReadmeForXPThemingInfo, mtInformation,
              [mbYes, mbNo], 0) = mrYes then
              if not OpenAtAnchor(Installer.Data.JVCLDir + PathDelim + SReadmeHTM, 'Theming') then
                MessageDlg(RsErrorOpeningReadmeHTM, mtError, [mbOk], 0);
          end;
          Break;
        end;
      end;
    end;
  end;

  try
    SetJVCLConfig('JVCLThemesEnabled', CheckBoxXPTheming);
    SetJVCLConfig('JVCL_REGISTER_GLOBAL_DESIGNEDITORS', CheckBoxRegisterGlobalDesignEditors);
    SetJVCLConfig('USE_DXGETTEXT', CheckBoxDxgettextSupport);
    SetJVCLConfig('USE_JV_GIF', CheckBoxRegisterJvGif);
    SetJVCLConfig('USEJVCL', CheckBoxUseJVCL);
    SetJVCLConfig('UNITVERSIONING', CheckBoxUnitVersioning);
  except
    on E: Exception do
      MessageDlg(RsJVCLConfigurationError, mtError, [mbOk], 0);
  end;
end;

procedure TFrameConfigPage.ComboBoxTargetIDEChange(Sender: TObject);
var
  TargetConfig: TTargetConfig;
  ItemIndex: Integer;
begin
  Inc(FInitializing);
  try
    ItemIndex := ComboBoxTargetIDE.ItemIndex;

    if ItemIndex <= 0 then
    begin
      // for all
      CheckBoxDeveloperInstall.State := TCheckBoxState(Installer.Data.DeveloperInstall);
      CheckBoxCleanPalettes.State := TCheckBoxState(Installer.Data.CleanPalettes);
      CheckBoxBuild.State := TCheckBoxState(Installer.Data.Build);
      case TCheckBoxState(Installer.Data.CompileOnly) of
        cbUnchecked:
          CheckBoxIDERegister.State := cbChecked; // invert
        cbChecked:
          CheckBoxIDERegister.State := cbUnchecked; // invert
      else
        CheckBoxIDERegister.State := cbGrayed;
      end;
      CheckBoxGenerateMapFiles.State := TCheckBoxState(Installer.Data.GenerateMapFiles);
      BtnEditJvclInc.Caption := RsEditJvclIncAll;

      CheckBoxDebugUnits.State := TCheckBoxState(Installer.Data.DebugUnits);
    end
    else
    begin
      // for selected
      TargetConfig := SelTargetConfig;
      BtnEditJvclInc.Caption := Format(RsEditJvclInc, [LowerCase(TargetConfig.Target.TargetType), TargetConfig.Target.Version]);

      CheckBoxDeveloperInstall.Checked := TargetConfig.DeveloperInstall;
      CheckBoxDebugUnits.Checked := TargetConfig.DebugUnits;
      CheckBoxCleanPalettes.Checked := TargetConfig.CleanPalettes;
      CheckBoxBuild.Checked := TargetConfig.Build;
      CheckBoxIDERegister.Checked := not TargetConfig.CompileOnly;
      CheckBoxGenerateMapFiles.Checked := TargetConfig.GenerateMapFiles;

      FrameDirEditBrowseBPL.EditDirectory.Text := TargetConfig.BplDir;
      FrameDirEditBrowseDCP.EditDirectory.Text := TargetConfig.DcpDir;
      if TargetConfig.Target.SupportsPersonalities([persBCB]) then
        FrameDirEditBrowseHPP.EditDirectory.Text := TargetConfig.HppDir;
    end;

    CheckBoxCleanPalettes.Enabled := CheckBoxIDERegister.Checked;
    CheckBoxDebugUnits.Enabled := not CheckBoxDeveloperInstall.Checked;
    FrameDirEditBrowseBPL.Visible := ItemIndex > 0;
    FrameDirEditBrowseDCP.Visible := ItemIndex > 0;
    FrameDirEditBrowseHPP.Visible := (ItemIndex > 0) and SelTargetConfig.Target.SupportsPersonalities([persBCB]);
    LblBCBGuide.Visible := FrameDirEditBrowseHPP.Visible;

    UpdateJvclIncSettings;
  finally
    Dec(FInitializing);
  end;
end;

procedure TFrameConfigPage.ComboBoxTargetIDEDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  i: Integer;
begin
  with TComboBox(Control), TComboBox(Control).Canvas do
  begin
    FillRect(Rect);
    if Index > 0 then
    begin
      ImageListTargets.Draw(TComboBox(Control).Canvas, Rect.Left + 1, Rect.Top, Index - 1);
      Inc(Rect.Left, ImageListTargets.Width + 3);
    end
    else
      Inc(Rect.Left, 3);
    TextRect(Rect, Rect.Left, Rect.Top + 1, Items[Index]);
    if Index = 0 then
    begin
      Inc(Rect.Left, TextWidth(Items[Index]) + 2);
      for i := 0 to ImageListTargets.Count - 1 do
      begin
        ImageListTargets.Draw(TComboBox(Control).Canvas, Rect.Left + 1, Rect.Top, i);
        Inc(Rect.Left, ImageListTargets.Width + 3);
      end;
    end;
  end;
end;

procedure TFrameConfigPage.BtnEditJvclIncClick(Sender: TObject);
begin
  if SelTargetConfig = nil then
  begin
    MessageDlg(RsEditJvclIncAllError, mtError, [mbOk], 0);
    Exit;
  end;

  if FormJvclIncConfig.imgProjectJEDI.Picture.Graphic = nil then
    FormJvclIncConfig.imgProjectJEDI.Picture.Assign(FormMain.ImageLogo.Picture);

  FormJvclIncConfig.Config.Assign(SelTargetConfig.JVCLConfig);
  if FormJvclIncConfig.Execute(SelTargetConfig.Target.Name + ' ' + SelTargetConfig.Target.VersionStr) then
  begin
    if FormJvclIncConfig.Config.Modified then
    begin
      SelTargetConfig.JVCLConfig.Assign(FormJvclIncConfig.Config);
      SelTargetConfig.JVCLConfig.Modified := True;
    end;
  end;
  UpdateJvclIncSettings;
end;

procedure TFrameConfigPage.LblDxgettextHomepageClick(Sender: TObject);
begin
  Installer.DoHomepageClick(Sender);
end;

procedure TFrameConfigPage.LblBCBGuideClick(Sender: TObject);
var
  Filename: string;
begin
  Filename := Installer.Data.JVCLDir + '\' + SInstallHTM;
  if not OpenAtAnchor(Filename, SBCBGuideAnchor) then
    MessageDlg(Format(RsCannotOpen, [Filename]), mtError, [mbOk], 0);
end;

procedure TFrameConfigPage.FrameDirEditBrowseHPPBtnJCLDirBrowseClick(
  Sender: TObject);
begin
  FrameDirEditBrowseHPP.BtnDirBrowseClick(Sender);
end;

end.
