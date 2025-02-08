unit ElPictPropDlg;
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

ElPictPropDlg unit
------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Clipbrd,
  Forms,
  //JPEG,
  Dialogs,
  ElCheckCtl,
  ElXPThemedControl,
  ElBtnCtl,
  ElPopBtn,
  ExtDlgs,
  ExtCtrls,
  ElPanel;

type
  TElPicturePropDialog = class(TForm)
    pnlBottom: TElPanel;
    pnlImage: TElPanel;
    pnlControl: TElPanel;
    Image: TImage;
    btnLoad: TElPopupButton;
    btnSave: TElPopupButton;
    btnCopy: TElPopupButton;
    btnPaste: TElPopupButton;
    btnClear: TElPopupButton;
    chbUsePreview: TElCheckBox;
    btnOK: TElPopupButton;
    btnCancel: TElPopupButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    OpenPictureDialog: TOpenPictureDialog;
    procedure btnLoadClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure btnPasteClick(Sender: TObject);
    procedure DoPictureChange(Sender: TObject);
  private
    FIsIcon: boolean;
    function HasImage: Boolean;
    procedure SetCaption;
    function GetPicture: TPicture;
    procedure SetPicture(const Value: TPicture);
    procedure SetIsIcon(const Value: boolean);
  public
    constructor Create(AOwner: TComponent); override;
    property IsIcon: boolean read FIsIcon write SetIsIcon;
    property Value: TPicture read GetPicture write SetPicture;
  end;

var
  ElPicturePropDialog: TElPicturePropDialog;

implementation

{$R *.dfm}

procedure TElPicturePropDialog.btnLoadClick(Sender: TObject);
var
  LResult: Boolean;
  LFName: String;
begin
  if chbUsePreview.Checked then
  begin
    LResult := OpenPictureDialog.Execute;
    LFName := OpenPictureDialog.FileName;
  end
  else
  begin
    OpenDialog.Filter := OpenPictureDialog.Filter;
    LResult := OpenDialog.Execute;
    LFName := OpenDialog.FileName;
  end;
  if LResult then
  begin
    Image.Picture.LoadFromFile(LFName);
    Image.Refresh;
  end;
  SetCaption;
end;

function TElPicturePropDialog.HasImage: Boolean;
begin
  Result := false;
  if Assigned(Image.Picture.Graphic) then
    if not Image.Picture.Graphic.Empty then
      Result := True;
end;

procedure TElPicturePropDialog.SetCaption;
begin
  if HasImage then
    pnlImage.Caption := ''
  else
    pnlImage.Caption := '(None)';
end;

procedure TElPicturePropDialog.btnClearClick(Sender: TObject);
begin
  Image.Picture := nil;
  SetCaption;
end;

procedure TElPicturePropDialog.btnSaveClick(Sender: TObject);
begin
  if SaveDialog.Execute then
    Image.Picture.Graphic.SaveToFile(SaveDialog.FileName);
end;

procedure TElPicturePropDialog.btnCopyClick(Sender: TObject);
begin
  Clipboard.Assign(Image.Picture.Graphic);
  SetCaption;
end;

procedure TElPicturePropDialog.btnPasteClick(Sender: TObject);
begin
  Image.Picture.Assign(Clipboard);
  SetCaption;
end;

function TElPicturePropDialog.GetPicture: TPicture;
begin
  Result := Image.Picture;
end;

procedure TElPicturePropDialog.SetPicture(const Value: TPicture);
begin
  Image.Picture := Value;
  SetCaption;
end;

procedure TElPicturePropDialog.DoPictureChange(Sender: TObject);
begin
  SetCaption;
end;

constructor TElPicturePropDialog.Create(AOwner: TComponent);
begin
  inherited;
  Image.Picture.OnChange := DoPictureChange;
end;

procedure TElPicturePropDialog.SetIsIcon(const Value: boolean);
begin
  FIsIcon := Value;
  if Value then
    OpenPictureDialog.Filter := 'Icon files (*.ico)|*.ICO'
  else
    OpenPictureDialog.Filter := GraphicFilter(TGraphic);
end;

end.
