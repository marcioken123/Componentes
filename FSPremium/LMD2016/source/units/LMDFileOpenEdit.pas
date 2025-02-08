unit LMDFileOpenEdit;
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

LMDFileOpenEdit unit (RM)
-------------------------


Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Dialogs,
  LMDCustomFileEdit;

type
  { ----------------------- TLMDFileOpenEdit --------------------------------- }
  TLMDFileOpenEdit = class(TLMDCustomFileEdit)
  private
    FOptions     : TOpenOptions;

    FTitle,
    FInitialDir,
    FFilter,
    FDefaultExt  : String;
  protected
    procedure DoBrowse; override;
  public
    constructor Create (aOwner : TComponent); override;
  published
    property Options : TOpenOptions read FOptions write FOptions default [ofHideReadOnly];
    property Title : String read FTitle write FTitle;
    property InitialDir : String read FInitialDir write FInitialDir;
    property Filter : String read FFilter write FFilter;
    property Filename;
    property DefaultExt : String read FDefaultExt write FDefaultExt;
    property MinimizeName;
    property FilenameOnly;
    property ReadOnly;
    // 7.12
    property StartWithLastName;
    property StartWithLastPath;
    // ---
  end;

  TLMDLabeledFileOpenEdit = class(TLMDFileOpenEdit)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation
uses
  Windows, Forms, Graphics, FileCtrl, SysUtils,
  LMDBase;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDFileOpenEdit.DoBrowse;
var
  fod : TOpenDialog;
begin
  if not Focused then
    SetFocus; //added May 02, JH
  fod := TOpenDialog.Create (Application);
  try
    fod.Options := FOptions;
    fod.Title := FTitle;
    // 7.12
    if StartWithLastPath and (FullText <> '') and DirectoryExists(ExtractFilePath(FullText)) then
      fod.InitialDir := ExtractFilePath(FullText)
    else
      fod.InitialDir := FInitialDir;

    if StartWithLastName and (FullText <> '') then
      fod.FileName := ExtractFileName(FullText)
    else
      fod.FileName := self.FileName;

    // ---
    fod.Filter := FFilter;
    fod.DefaultExt := FDefaultExt;
    if Assigned (OnBeforeBrowse) then
      OnBeforeBrowse (fod);
    if fod.Execute then
      begin
        Text := fod.Filename;
        if Assigned(OnDlgChange) then OnDlgChange(self);
      end;
    if Assigned(OnBrowse) then OnBrowse(fod);
  finally
    fod.Free;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
constructor TLMDFileOpenEdit.Create (aOwner : TComponent);
var
  bmp : TBitmap;
begin
  inherited Create (aOwner);
  FOptions:=[ofHideReadOnly];
  bmp := TBitmap.Create;
  try
    bmp.LoadFromResourceName(HInstance, IDB_FILEBMP);
    bmp.Width := bmp.Width div 2;
    CustomButtons.Items[0].Glyph.Assign (bmp);
  finally
    bmp.Free;
  end;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledFileOpenEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
