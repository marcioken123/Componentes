unit LMDCustomFileEdit;
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

LMDCustomFileEdit unit (JH)
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDCustomBrowseEdit;

type
  TLMDCustomFileEdit = class (TLMDCustomBrowseEdit)
  private
    FFilenameOnly,
    FLastPath,
    FLastFile,
    FEllipse      : Boolean;
    FFullText     : String;

    procedure SetFilenameOnly (aValue: Boolean);
    procedure SetFilename (const aValue : String);
    function GetFileName : String;
  protected
    procedure Loaded; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure UpdateText;
    procedure SetNewText; override;
    property FullText: String read FFullText;
    property Filename : String read GetFilename write SetFilename;
    property StartWithLastPath:Boolean read FLastPath write FLastPath default false;
    property StartWithLastName:Boolean read FLastFile write FLastFile default false;
  public
    constructor Create (aOwner : TComponent); override;
    property MinimizeName: Boolean read FEllipse write FEllipse default false;
    property FilenameOnly: Boolean read FFilenameOnly write SetFilenameOnly;
  end;

implementation

uses
  SysUtils,
  FileCtrl;

{ ---------------------------------- private --------------------------------- }
procedure TLMDCustomFileEdit.SetFilenameOnly (aValue: Boolean);
begin
  if aValue <> FFilenameOnly then
    begin
      FFilenameOnly := aValue;
      UpdateText;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFileEdit.SetFilename (const aValue : String);
begin
  Text := aValue;
  if not Focused then //comparable to DoExit
    UpdateText;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomFileEdit.GetFileName : String;
begin
  if Focused or not MinimizeName then
    result := Text
  else
    result := FullText;
end;

{ -------------------------------- protected --------------------------------- }
procedure TLMDCustomFileEdit.DoEnter;
begin
  inherited DoEnter;
  //restore any previously minimized filename to full length for editing
  if FEllipse then
    begin
      Text := FFullText;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFileEdit.DoExit;
begin
  //force control to scroll to the beginning of the text
  FHiddenLeft := 0;
  CurrentChar := 1;
  UpdateText; //minimize filename if wanted
  inherited DoExit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFileEdit.UpdateText;
begin
  //remember the FullText (full filename)
  FFullText := Text;

  //only disply the filename (no path)
  if FFilenameOnly then
    Text := ExtractFilename (Text);

  //if we shall minimize the name we'll do that now
  if FEllipse then
    begin
      //assign the minimized version of the filename
      Text := FileCtrl.MinimizeName (Text, Canvas, FTextRect.Right - FTextRect.Left);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFileEdit.SetNewText;
begin
  //The assignment of Text to FFullText here does only prevent the control
  //from loosing a value which has been assigned directly to the Text property
  //while it did not have the input focus
  //however: it is better to use the filename property for setting a filename!
  if not Focused and
    ((FFullText = '') or //we do not yet have any FullText set
    ((FFullText <> Text) and //Text is not equal to FullText (could mean that a new text has been set)
     (Text <> FileCtrl.MinimizeName (FullText, Canvas, FTextRect.Right - FTextRect.Left)))) then
      //and Text is not minimized version of FullText then we have a new text value set
      //and should update the FullText variable
    begin
      FFullText := Text;
    end;
  inherited;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDCustomFileEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FEllipse := false;
  FFullText := '';
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomFileEdit.Loaded;
begin
  inherited Loaded;
  FFullText := Text;
end;

end.
