unit LMDFileSaveEdit;
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

LMDFileSaveEdit unit (RM)
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
  { ----------------------- TLMDFileSaveEdit --------------------------------- }
  TLMDFileSaveEdit = class(TLMDCustomFileEdit)
  private
    FOptions     : TOpenOptions;
    FPath,
    FTitle,
    FInitialDir,
    FFilter,
    FDefaultExt  : String;

  protected
    procedure DoBrowse; override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure SetFile (fileWithPath: String);
  public
    constructor Create (aOwner : TComponent); override;
    function GetFilePath: String;
  published
    property Options : TOpenOptions read FOptions write FOptions default [ofHideReadOnly];
    property Title : String read FTitle write FTitle;
    property InitialDir : String read FInitialDir write FInitialDir;
    property Filter : String read FFilter write FFilter;
    property Filename;
    property FilenameOnly;
    property DefaultExt : String read FDefaultExt write FDefaultExt;
    property ReadOnly;
    property MinimizeName;
    // 7.12
    property StartWithLastName;
    property StartWithLastPath;
    // ---
  end;

  TLMDLabeledFileSaveEdit = class(TLMDFileSaveEdit)
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
procedure TLMDFileSaveEdit.DoBrowse;
var
  sd : TSaveDialog;
begin
  if not Focused then SetFocus; //added May 02, JH
  sd := TSaveDialog.Create (Application);
  try
    sd.Options := FOptions;

    sd.Title := FTitle;
    // 7.12
    if StartWithLastPath and (FullText <> '') and DirectoryExists(ExtractFilePath(FullText)) then
      sd.InitialDir := ExtractFilePath(FullText)
    else
      sd.InitialDir := FInitialDir;

    if StartWithLastName and (FullText <> '') then
      sd.FileName := ExtractFileName(FullText)
    else
      sd.FileName := self.FileName;
    // ---
    sd.Filter := FFilter;
    sd.DefaultExt := FDefaultExt;
    if Assigned (OnBeforeBrowse) then OnBeforeBrowse (sd);
    if sd.Execute then
      begin
        SetFile (sd.FileName);
        if Assigned(OnDlgChange) then OnDlgChange(self);
      end;
    if Assigned(OnBrowse) then OnBrowse(sd);
  finally
    sd.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileSaveEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin
  inherited GetCommandKey (KeyCode, Shift);
  if KeyCode = VK_RETURN then
    SetFile (Text)
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFileSaveEdit.SetFile (fileWithPath: String);
begin
  FPath := ExtractFilePath (fileWithPath);
  Filename := ExtractFilename (fileWithPath);
  if FilenameOnly then
    Text := Filename
  else
    Text := fileWithPath;
end;

{ ---------------------------------- public ---------------------------------- }
constructor TLMDFileSaveEdit.Create (aOwner : TComponent);
var
  bmp : TBitmap;
begin
  inherited Create (aOwner);
  FOptions:=[ofHideReadOnly];
  FPath := '';
  bmp := TBitmap.Create;
  try
    bmp.LoadFromResourceName(HInstance, IDB_FILEBMP);
    bmp.Canvas.CopyRect (Rect (0, 0, bmp.Width div 2, bmp.Height), bmp.Canvas, Rect (bmp.Width div 2,0, bmp.Width, bmp.Height));
    bmp.Width := bmp.Width div 2;
    CustomButtons.Items[0].Glyph.Assign (bmp);
  finally
    bmp.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFileSaveEdit.GetFilePath: String;
begin
  //note: FPath will only be set by selecting a file with the dialog
  //or by pressing enter after a filename has been entered manually
  //if only the filename shall be displayed
  if FilenameOnly then
    result := FPath
  else
    result := ExtractFilePath (Text);
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledFileSaveEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
