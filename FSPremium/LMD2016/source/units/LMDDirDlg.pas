unit LMDDirDlg;
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

LMDDirDlg unit ()
-----------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, FileCtrl, Forms,
  LMDClass, LMDBaseDialog;

type
  TLMDDirDlg = class(TLMDBaseDialog)
  private
    FOnError:TNotifyEvent;
    FInitialDir,
    FPath:String;
    FAllowDir,
    FShowDir:Boolean;
    FCharCase:TLMDCharCase;
    dirlistbox: TDirectoryListBox;
    drivecombo: TDriveComboBox;
    procedure drivecomboChange(Sender: TObject);
    procedure newPathClick(Sender: TObject);
  public
    constructor Create(AOwner:TComponent);override;
    procedure RaiseError;
    function Execute:Boolean;override;
    function ExecuteEnh(Main:TForm):Boolean;
    procedure GetDir(const title:String; var aPath:String);
    property CtlXP;  // compatiblity
  published
    property About;
    property AllowNewDir:Boolean read FAllowDir write FAllowDir default false;
    property CaptionFill;
    property CaptionTitle;
    property CharCase:TLMDCharCase read FCharCase write FCharCase default ccNormal;
    property CustomButton;
    property Colors;
    property Effect;
    property Hints;
    property ImageList;
    property ImageIndex;
    Property InitialDir:String read FInitialDir write FInitialDir;
    property ListIndex;
    Property Path:String read FPath write FPath stored false;
    property Position;
    property RelatePos;
    property ShowHints;
    property ShowLabelDir:Boolean read FShowDir write FShowDir default false;
    property ThemeMode;
    property ThemeGlobalMode;    
    {Events}
    property OnCustomize;
    property OnCustomClick;
    property OnFolderError:TNotifyEvent read FOnError write FOnError;
  end;

implementation

uses
  StdCtrls,
  SysUtils,
  Graphics,
  Controls,
  Dialogs,
  Consts,
  LMDConst,
  LMDBack,
  LMDFormStyler,
  LMDSimpleLabel,
  LMDButton,
  LMDProcs,
  LMDStrings;

{-------------------------- private -------------------------------------------}
procedure TLMDDirDlg.drivecomboChange(Sender: TObject);
begin
  if (dirlistbox=nil) or (drivecombo=nil) then exit;
  try
    dirListBox.Drive := DriveCombo.Drive;
  except
    On Exception do ;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDirDlg.newPathClick(Sender: TObject);
var
  value, tmp:String;

begin
  if (dirlistbox=nil) or (drivecombo=nil) then exit;
  if dirListBox.ItemIndex=-1 then exit;
  value:='';

  try
    tmp:=dirListBox.GetItemPath(dirListBox.ItemIndex);
  except
    On Exception do exit;
  end;

  if InputQuery(LMDAnsiTrim(LMDAnsiReplaceChar(IDS_NEWPATH, '&', ' ')), 'Name: ('+
                LMDShrunkFileName(tmp, 36)+')', value) then
    if not LMDAnsiEmpty(value) then
      begin
        value:=LMDAnsiSlashAdd(dirListBox.Directory)+value;
        {$I-}
        MkDir(value);
        if IOResult<>0 then
          RaiseError
        else
          begin
            dirListBox.Directory:=value;
            dirListbox.Update;
          end;
        {$I+}
      end;
end;

{------------------------------- Public ---------------------------------------}
constructor TLMDDirDlg.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FShowDir:=False;
  FAllowDir:=False;
  FCharCase:=ccNormal;
  dirlistbox:=nil;
  drivecombo:=nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDDirDlg.RaiseError;
begin
  if Assigned(FOnError) then
    FOnError(Self)
  else
    MessageDlg('IO-Error!'#13'Could not create folder.', mtWarning, [mbOk], 0);
end;

{------------------------------------------------------------------------------}
function TLMDDirDlg.ExecuteEnh(main:TForm):Boolean;
var
  DirBox    : TForm;
  ok,
  newPath,
  custom,
  cancel    : TLMDButton;
  pathlabel : TLMDSimpleLabel;
  drivelabel: TLabel;
  Label2    : TLabel;
  fs        : TLMDFormStyler;
  b: TLMDBack;
  tmp:String;

begin
  Result:=False;

  Dirbox:=TForm.Create(nil);
  with DirBox do
  try

    BorderStyle:=bsDialog;
    Font.Color:=clWindowText;
    Font.Name:='MS Sans Serif';
    Font.Height:=-12;
    Position:=poDefault;
    PixelsPerInch:=96;

    ok:=TLMDButton.Create(DirBox);
    with ok do
      begin
        Parent:=DirBox;
        Left:=302;
        Top:=20;
        Width:=86;
        Height:=24;
        ModalResult:=1;
        Caption:='OK';
        Default:=True;
        TabOrder:=2;
      end;

    cancel:=TLMDButton.Create(DirBox);
    with cancel do
      begin
        Left:=302;
        Top:=47;
        Width:=86;
        Height:=24;
        Parent:=DirBox;
        ModalResult:=2;
        {Caption:='OK';}
        Cancel:=True;
        TabOrder:=3;
      end;

    custom:=TLMDButton.Create(DirBox);
    with custom do
      begin
        Parent:=DirBox;
        Left:=302;
        Top:=81;
        Width:=86;
        Height:=24;
        TabOrder:=4;
        Visible:=False;
      end;

    newPath:=TLMDButton.Create(DirBox);
    with newPath do
      begin
        Parent:=dirBox;
        Left:=302;
        Top:=225;
        Width:=86;
        Height:=24;
        TabOrder:=5;
        Visible:=False;
      end;

    label2:=TLabel.Create(DirBox);
    with label2 do
      begin
        Parent:=dirBox;
        Left:=35;
        Top:=5;
        Width:=186;
        Height:=13;
        AutoSize:=False;
        Font.Color:=clNavy;
        Transparent:=True;
      end;

    drivecombo:=TDriveComboBox.Create(DirBox);
    with drivecombo do
      begin
        Parent:=DirBox;
        Left:=6;
        Top:=267;
        Width:=290;
        Height:=19;
        DirList:=dirlistbox;
        TabOrder:=1;
      end;

    drivelabel:=TLabel.Create(DirBox);
    with drivelabel do
      begin
        Parent:=DirBox;
        Left:=8;
        Top:=253;
        Width:=3;
        Height:=10;
        Transparent:=True;
      end;

    dirlistbox:=TDirectoryListBox.Create(DirBox);
    with dirlistbox do
      begin
        Parent:=DirBox;
        Left:=6;
        Top:=20;
        Width:=290;
        Height:=229;
        ItemHeight:=17;
        TabOrder:=0;
      end;

    pathlabel:=TLMDSimpleLabel.Create(DirBox);
    with pathlabel do
      begin
        Parent:=DirBox;
        Left:=6;
        Top:=5;
        Width:=3;
        Height:=10;
      end;

    fs:=TLMDFormStyler.Create(DirBox);
    fs.Enabled:=False;
    fs.Options:=[fsAdjustRect, fsUseDefaultFont, fsUseFormCaption];

    b:=TLMDBack.Create(DirBox);
    b.Enabled:=False;
    {---}

    {needed because of minor quirk in Delphi 2.01}
    ClientWidth:=ok.Left+ok.Width+7;
    ClientHeight:=driveCombo.Top+driveCombo.Height+6{318};
    {----}
    pathlabel.Caption:=IDS_DIRPATH;
    drivelabel.Caption:=IDS_DIRDRIVE;
    cancel.caption:=SCancelButton;
    if FAllowDir then
      begin
        newPath.Caption:=IDS_NEWPATH;
        newPath.Visible:=True;
      end;
    if FShowdir then label2.visible:=true else label2.visible:=false;

    if ShowHints and (Hints.Count>0) then
      begin
        ShowHint:=True;
        ok.Hint:=Hints[0];
        if Hints.Count>1 then custom.Hint:=Hints[1];
        if Hints.Count>2 then cancel.Hint:=Hints[2];
        if Hints.Count>3 then DirListBox.Hint:=Hints[3];
        if Hints.Count>4 then driveCombo.Hint:=Hints[4];
        if Hints.Count>5 then newPath.Hint:=Hints[5];
      end;

    ActiveControl:=dirListBox;

    if FInitialDir<>'' then
      tmp:=FInitialDir
    else
      tmp:=FPath;

    DirListBox.Directory:=tmp;
    if Length(tmp) > 2 then
      if tmp[2] = ':' then
        DriveCombo.Drive := tmp[1];

    driveLabel.FocusControl:=driveCombo;
    DirListBox.DirLabel:=Label2;
    pathlabel.FocusControl:=dirlistbox;
    drivecombo.OnChange:=driveComboChange;
    newpath.OnClick:=newPathClick;

    if BaseExecute(DirBox, Main, Custom,  fs, b, IDS_DIRCAPTION)=mrOK then
      begin
        if (csDesigning in ComponentState) then
          FPath:=''
        else
          case FCharCase of
            ccNormal:FPath:=DirListBox.Directory;
            ccUpperCase:FPath:=AnsiUpperCase(DirListBox.Directory);
            ccLowerCase:FPath:=AnsiLowerCase(DirListBox.Directory);
          end;
        Result:=true;
      end;
  finally
    dirbox.free;
    dirlistbox:=nil;
    drivecombo:=nil;
  end;

end;

{------------------------------------------------------------------------------}
Function TLMDDirDlg.Execute:Boolean;
begin
  result:=ExecuteEnh(nil);
end;

{------------------------------------------------------------------------------}
Procedure TLMDDirDlg.GetDir(const title:String; var aPath:String);
begin
  CaptionTitle:=title;
  FPath:=aPath;
  if ExecuteEnh(nil) then aPath:=FPath;
end;

end.
