unit LMDBrowseEdit;
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

LMDBrowseEdit unit (JH)
-----------------------

Edit control with integrated button for calling a directory selection dialog

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  LMDBrowseDlg, LMDCustomBrowseEdit;

type
  TLMDBrowseExecuteEvent = procedure (Sender : TObject; bDlg : TLMDBrowseDlg) of object;
  { ----------------------- TLMDBrowseEdit ----------------------------------- }
  TLMDBrowseEdit = class(TLMDCustomBrowseEdit)
  private
    FOptions     : TLMDBrowseDlgOptions;
    FStartFolder : TLMDSystemFolders;
    FEllipse,
    FStartWithLast : Boolean;
    FOnExecute   : TLMDBrowseExecuteEvent;
    FFullText    : String;

    procedure SetPath (const aValue : String);
    function GetPath : String;
    procedure SetEllipse(const Value: Boolean);
  protected
    procedure DoBrowse; override;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure UpdateText;
    procedure SetNewText; override;
    public
    constructor Create (aOwner : TComponent); override;
    procedure Loaded; override;
    property FullText: String read FFullText;
  published
    property Options : TLMDBrowseDlgOptions read FOptions write FOptions default [doReturnFileSysDirs, doShowPath];
    property Path : String read GetPath write SetPath;
    property StartFolder : TLMDSystemFolders read FStartFolder write FStartFolder default bfoDesktopExpanded;
    property StartWithLast : Boolean read FStartWithLast write FStartWithLast default false;
    property MinimizeName: Boolean read FEllipse write SetEllipse default false;
    property ReadOnly;
    property OnExecute : TLMDBrowseExecuteEvent read FOnExecute write FOnExecute;
  end;

  TLMDLabeledBrowseEdit = class(TLMDBrowseEdit)
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
  FileCtrl, LMDBase, LMDButtonBase;

{ ---------------------------------- public ---------------------------------- }
procedure TLMDBrowseEdit.SetPath (const aValue : String);
begin
  Text := aValue;
  if not Focused then UpdateText;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBrowseEdit.GetPath : String;
begin
  if Focused or not MinimizeName then
    result := Text
  else
    result := FFullText;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrowseEdit.SetEllipse(const Value: Boolean);
begin
  if FEllipse<>Value then
    begin
      if FEllipse then
        Text:=FFullText;
      FEllipse := Value;
      if FEllipse then
        UpdateText;
    end;
end;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDBrowseEdit.DoBrowse;
var
  bd : TLMDBrowseDlg;
begin
  if not Focused then SetFocus; //added May 02, JH
  bd := TLMDBrowseDlg.Create(Owner);
  try
    bd.StartFolder := FStartFolder;
    bd.Options := FOptions;
    if FStartWithLast and (Text <> '') then
      bd.SelectedFolder := Text;
    if Assigned (FOnExecute) then FOnExecute (self, bd);
    if Assigned (OnBeforeBrowse) then OnBeforeBrowse (bd);
    if bd.Execute then
      begin
        Text := bd.SelectedFolder;
        if Assigned(OnDlgChange) then OnDlgChange(self);
      end;
    if Assigned(OnBrowse) then OnBrowse(bd);
  finally
    bd.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrowseEdit.DoEnter;
begin
  inherited DoEnter;
  if FEllipse then
    Text := FFullText;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrowseEdit.DoExit;
begin
  //force control to scroll to the beginning of the text
  FHiddenLeft := 0;
  CurrentChar := 1;
  //update Ffulltext variable and minimize the path if wanted
  UpdateText;
  inherited DoExit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrowseEdit.UpdateText;
begin
  //remember the FullText (full filename)
  FFullText := Text;
  //if we shall minimize the name we'll do that now
  if FEllipse then
    begin
      //assign the minimized version of the filename
      Text := FileCtrl.MinimizeName (Text, Canvas, FTextRect.Right - FTextRect.Left);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrowseEdit.SetNewText;
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

{ ---------------------------------- public ---------------------------------- }
constructor TLMDBrowseEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  LMDGetGlyphKind(CustomButtons.Items[0].Glyph, gkFolder);
  FOptions := [doReturnFileSysDirs, doShowPath];
  FStartFolder := bfoDesktopExpanded;
  FStartWithLast := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBrowseEdit.Loaded;
begin
  inherited Loaded;
  //FFullText := Text;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledBrowseEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
