unit LMDExtDialogs;
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

LMD Extended Open/Save Dialogs (RM)
----------------------------------
Common dialogs specialized for
* loading/storing waves

Changes
-------
Release 8.0 (May 2007)
 - Initial Release

###############################################################################}

interface

uses
  Messages, Windows, SysUtils, Classes, Controls, StdCtrls, Graphics,
  ExtCtrls, Buttons, Dialogs,
  LMDWave, intfLMDBase, LMDTypes;

const
  WaveFormats: array[TLMDWaveFormat] of string = ('Unknown', 'PCM');
  ChannelModes: array[TLMDChannelMode] of string = ('Unknown', 'Mono', 'Stereo');

type
  TLMDBaseOpenDialog=class(TOpenDialog, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
  protected
    function getLMDPackage:TLMDPackageID;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored False;
  end;

  {******************* Object TLMDOpenWaveDialog*******************************}
  TLMDOpenWaveDialog = class(TLMDBaseOpenDialog)
  private
    FWave: TLMDWave;
    FWavePanel: TPanel;
    FHeaderLabel, FInfoLabel: TLabel;
    FPlayButton: TSpeedButton;
    FInfoPanel: TPanel;
    procedure SetWave(aValue:TLMDWave);
    function  IsFilterStored: Boolean;
    procedure PlayClick(Sender: TObject);
  protected
    procedure DoClose; override;
    procedure DoSelectionChange; override;
    procedure DoShow; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean; override;
    property Wave:TLMDWave read FWave write SetWave;
  published
    property Filter stored IsFilterStored;
  end;

  {******************* Object TLMDSaveWaveDialog ******************************}
  TLMDSaveWaveDialog = class(TLMDOpenWaveDialog)
  public
    function Execute: Boolean; override;
  end;

implementation

uses
  Consts, Forms, CommDlg, Dlgs,
  LMDSysIn, LMDRTLXConst, LMDBmp;

{******************* Object TLMDBaseOpenDialog ********************************}
{----------------------- protected --------------------------------------------}
function TLMDBaseOpenDialog.getLMDPackage: TLMDPackageID;
begin
  result:= pi_LMD_RTLX;
end;

{******************* Object TLMDOpenWaveDialog ********************************}
{----------------------- private ----------------------------------------------}
procedure TLMDOpenWaveDialog.SetWave(aValue:TLMDWave);
begin
  FWave.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDOpenWaveDialog.IsFilterStored: Boolean;
begin
  Result := not (Filter = IDS_WAVEFILTER);
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenWaveDialog.PlayClick(Sender: TObject);
begin
  FWave.LoadFromFile(FileName);
  FWave.Play;
end;

{----------------------- protected --------------------------------------------}
procedure TLMDOpenWaveDialog.DoSelectionChange;
var
  FullName: string;
  ValidWave: Boolean;

  function ValidFile(const AFileName: string): Boolean;
  begin
    Result := GetFileAttributes(PChar(AFileName)) <> $FFFFFFFF;
    end;

begin
  FullName := FileName;
  ValidWave := FileExists(FullName) and ValidFile(FullName);
  if ValidWave then
  try
    FWave.LoadFromFile(FullName);
    FInfoLabel.Caption := Format('Size: %d'#13#10'Bits: %d'#13#10'Sample rate: %d'#13#10'Channel mode: %s'#13#10'Format: %s', [FWave.Size, FWave.Bits, FWave.SampleRate, ChannelModes[FWave.ChannelMode], WaveFormats[FWave.Format]]);
    FPlayButton.Enabled := True;
  except
    ValidWave := False;
  end;
  if not ValidWave then
    begin
      FInfoLabel.Caption := '';
      FPlayButton.Enabled := False;
      FWave.Assign(nil);
    end;
  inherited DoSelectionChange;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenWaveDialog.DoClose;
begin
  inherited DoClose;
  Application.HideHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDOpenWaveDialog.DoShow;
var
  PlayRect, StaticRect: TRect;
begin
  GetClientRect(Handle, PlayRect);
  StaticRect := GetStaticRect;
  PlayRect.Left := StaticRect.Left + (StaticRect.Right - StaticRect.Left);
  Inc(PlayRect.Top, 4);
  FWavePanel.BoundsRect := PlayRect;
  FPlayButton.Left := FInfoPanel.BoundsRect.Right - FPlayButton.Width - 2;
  FWavePanel.ParentWindow := Handle;
  inherited DoShow;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDOpenWaveDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Filter := IDS_WAVEFILTER;
  FWave := TLMDWave.Create;
  FWavePanel := TPanel.Create(Self);
  with FWavePanel do
  begin
    Name := 'WavePanel';
    Caption := '';
    SetBounds(204, 5, 169, 200);
    BevelOuter := bvNone;
    BorderWidth := 6;
    TabOrder := 1;
    FHeaderLabel := TLabel.Create(Self);
    with FHeaderLabel do
    begin
      Name := 'HeaderLabel';
      Caption := '';
      SetBounds(6, 6, 157, 23);
      Align := alTop;
      AutoSize := False;
      Parent := FWavePanel;
    end;
    FPlayButton := TSpeedButton.Create(Self);
    with FPlayButton do
      begin
        Name := 'PlayButton';
        SetBounds(77, 1, 23, 22);
        Enabled := False;
        NumGlyphs:=2;
        Glyph.LoadFromResourceName(HInstance, 'LMDBMPPLAYGLYPH');
        Hint := 'Play wave file';
        ParentShowHint := False;
        ShowHint := True;
        OnClick := PlayClick;
        Parent := FWavePanel;
      end;
    FInfoPanel := TPanel.Create(Self);
    with FInfoPanel do
    begin
      Name := 'InfoPanel';
      Caption := '';
      SetBounds(6, 29, 157, 145);
      Align := alClient;
      BevelInner := bvRaised;
      BevelOuter := bvLowered;
      TabOrder := 0;
      Parent := FWavePanel;
    end;
    FInfoLabel := TLabel.Create(Self);
    with FInfoLabel do
    begin
      Name := 'WaveLabel';
      Parent := FInfoPanel;
      Caption := '';
      Align := alClient;
      AutoSize := False;
      WordWrap := true;
      Font.Size := 10;
    end;
  end;
end;

{------------------------------------------------------------------------------}
destructor TLMDOpenWaveDialog.Destroy;
begin
  FHeaderLabel.Free;
  FInfoLabel.Free;
  FInfoPanel.Free;
  FPlayButton.Free;
  FWavePanel.Free;
  FWave.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}

function TLMDOpenWaveDialog.Execute:Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options) then
    Template := 'DLGTEMPLATE' else
    Template := nil;
  Result := inherited Execute;
end;

{******************* Object TLMDSaveWaveDialog ********************************}

function TLMDSaveWaveDialog.Execute: Boolean;
begin
  if NewStyleControls and not (ofOldStyleDialog in Options)
  {$IFDEF LMDCOMP11}and not ((LMDSIWindowsVistaUp) and UseLatestCommonDialogs){$ENDIF} then
    Template := 'DLGTEMPLATE'
  else
    Template := nil;
  Result := DoExecute(@GetSaveFileName);
end;

end.
