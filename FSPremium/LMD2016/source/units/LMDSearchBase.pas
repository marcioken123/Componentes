unit LMDSearchBase;
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

LMDSearchBase unit (DD)
----------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Forms, LMDSearchConsts, LMDRVEFormUnit, LMDCustomComponent, LMDTypes;

type
  TLMDSearchTemplate = type string;

  TLMDSPDialogOptions = set of (vboShowEvaluateButton, vboShowCancelButton, vboShowHelpButton,
                                vboShowGlyphs, vboShowOptionsPage, vboAutoSelect, vboCenterDialog, vboCenterOwnerForm,
                                vboSimpleInterface);

const
  def_SPDialogOptions=[vboShowEvaluateButton, vboShowCancelButton, vboShowOptionsPage, vboCenterDialog, vboSimpleInterface];

type

  {-------------------- TLMDSearchOptions -------------------------------------}
  TLMDSearchOptions = class(TPersistent)
  private
    FNearestLength: Integer;
    FMatchCase: Boolean;
    FWholeWordsOnly: Boolean;
    FUpdate:Byte;
    FOnChange: TNotifyEvent;
    procedure SetNearestLength(const Value: Integer);
    procedure SetMatchCase(const Value: Boolean);
    procedure SetWholeWordsOnly(const Value: Boolean);
  public
    procedure BeginUpdate;
    procedure EndUpdate(Update:Boolean=True);
    procedure Change;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
  published
    constructor Create(AOwner: TComponent); virtual;
    property NearestLength: Integer read FNearestLength write SetNearestLength default 50;
    property MatchCase: Boolean read FMatchCase write SetMatchCase default false;
    property WholeWordsOnly: Boolean read FWholeWordsOnly write SetWholeWordsOnly default false;
  end;

  {-------------------- TLMDSearchBaseComponent -------------------------------}
  TLMDSearchBaseDlgComponent = class(TLMDCustomComponent)
  private
    FOptions: TLMDSPDialogOptions;
    FOnCustomize,
    FOnHelp: TNotifyEvent;
    FSearchOptions: TLMDSearchOptions;
    FAnySingleCharacter, FAnySequenceCharacter: Char;
    procedure SetSearchOptions(const Value: TLMDSearchOptions);
    procedure SetAnySingleCharacter(const Value: Char);
    procedure SetAnySequenceCharacter(const Value: Char);
    protected
    procedure SetTemplate(const Value: TLMDSearchTemplate);virtual;
    function GetTemplate: TLMDSearchTemplate; virtual;
    procedure GetChange(Sender: TObject); override;

    property OnDlgHelpClick: TNotifyEvent read FOnHelp write FOnHelp;
    property OnDlgCustomize: TNotifyEvent read FOnCustomize write FOnCustomize;

    property DlgBuilderOptions: TLMDSPDialogOptions read FOptions write FOptions default def_SPDialogOptions;
    property SearchOptions: TLMDSearchOptions read FSearchOptions write SetSearchOptions;
    property SearchString: TLMDSearchTemplate read GetTemplate write SetTemplate;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    function getLMDPackage:TLMDPackageID;override;
  published
    property    About;
    property    AnySingleCharacter: Char read FAnySingleCharacter write SetAnySingleCharacter;
    property    AnySequenceCharacter: Char read FAnySequenceCharacter write SetAnySequenceCharacter;
    end;

  procedure LMDSPSetUpDialog(VisualBuilderForm: TLMDRVEForm; aComponent:TLMDSearchBaseDlgComponent);
  procedure LMDSPAssignDialogValues(VisualBuilderForm: TLMDRVEForm; aComponent:TLMDSearchBaseDlgComponent);

implementation
uses
  LMDRefineUnit, Buttons, SysUtils
  {$IFDEF LMD_DEBUGTRACE}
  , dialogs, Windows;
  {$I C2.INC}
  {$ELSE};{$ENDIF}

{------------------------------------------------------------------------------}
procedure LMDSPSetUpDialog(VisualBuilderForm: TLMDRVEForm; aComponent:TLMDSearchBaseDlgComponent);
begin
  if not Assigned(VisualBuilderForm) then exit;
  with VisualBuilderForm do
    begin
      VisualBuilderForm.AnySingleCharacter := aComponent.AnySingleCharacter;
      VisualBuilderForm.AnySequenceCharacter := aComponent.AnySequenceCharacter;
      AsteriskButton.Caption := AnySequenceCharacter;
      QuestButton.Caption := AnySingleCharacter;

      // DlgOptions
      EvaluateButton.Visible:=vboShowEvaluateButton in aComponent.DlgBuilderOptions;
      CancelButton.Visible:=vboShowCancelButton in aComponent.DlgBuilderOptions;
      HelpButton.Visible:=vboShowHelpButton in aComponent.DlgBuilderOptions;

      if vboShowGlyphs in aComponent.DlgBuilderOptions then
        begin
          if HelpButton.Visible then HelpButton.Kind:=bkHelp;
          if CancelButton.Visible then CancelButton.Kind:=bkCancel;
          okButton.Kind:=bkOk;
        end;

      if HelpButton.Visible and Assigned(aComponent.OnDlgHelpClick) then
        HelpButton.OnClick:=aComponent.OnDlgHelpClick;

      OptionsPage.TabVisible:=vboShowOptionsPage in aComponent.DlgBuilderOptions;

      if vboSimpleInterface in aComponent.DlgBuilderOptions then
       Pages.ActivePage := 'SimplePage' else
       Pages.ActivePage := 'ExtPage';
      SimpleInterface := vboSimpleInterface in aComponent.DlgBuilderOptions;

      // internal options
      if aComponent is TLMDRefine then
        begin
          SearchMemo.Text := TLMDRefine(aComponent).Template;
          MCCheck.Checked := TLMDRefine(aComponent).MatchCase;
          WWCheck.Checked := TLMDRefine(aComponent).WholeWordsOnly;
        end
      else
        with aComponent do
          begin
            SearchMemo.Text := SearchString;
            MCCheck.Checked := SearchOptions.MatchCase;
            WWCheck.Checked := SearchOptions.WholeWordsOnly;
          end;

      UpdateBuilder;
      if SimpleInterface then
        begin
          if vboAutoSelect in aComponent.DlgBuilderOptions then
            begin
              SearchMemo.SelStart:=0;
              SearchMemo.SelLength:=Length(SearchMemo.Text);
            end
          else
            SearchMemo.SelStart:=Length(SearchMemo.Text);
          ActiveControl:=SearchMemo;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDSPAssignDialogValues(VisualBuilderForm: TLMDRVEForm; aComponent:TLMDSearchBaseDlgComponent);
begin
  if not Assigned(VisualBuilderForm) then exit;
  with VisualBuilderForm do
    begin
      // internal options
      if aComponent is TLMDRefine then
        begin
          TLMDRefine(aComponent).Template:=SearchMemo.Text;
          TLMDRefine(aComponent).MatchCase:=MCCheck.Checked;
          TLMDRefine(aComponent).WholeWordsOnly:=WWCheck.Checked;
        end
      else
        with aComponent do
          begin
            SearchString:=SearchMemo.Text;
            SearchOptions.MatchCase:=MCCheck.Checked;
            SearchOptions.WholeWordsOnly:=WWCheck.Checked;
          end;
    end;
end;

{************************* TLMDSearchOptions **********************************}
{------------------------------- private---------------------------------------}
procedure TLMDSearchOptions.SetMatchCase(const Value: Boolean);
begin
  if FMatchCase <> Value then
    begin
      FMatchCase := Value;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSearchOptions.SetNearestLength(const Value: Integer);
begin
  if FNearestLength <> Value then
    begin
      FNearestLength := Value;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSearchOptions.SetWholeWordsOnly(const Value: Boolean);
begin
  if FWholeWordsOnly <> Value then
    begin
      FWholeWordsOnly := Value;
      Change;
    end;
end;

{------------------------------- public ---------------------------------------}
constructor TLMDSearchOptions.Create;
begin
  inherited Create;
  FNearestLength := 50;
  FMatchCase := False;
  FWholeWordsOnly := False;
end;

{------------------------------------------------------------------------------}
procedure TLMDSearchOptions.BeginUpdate;
begin
  FUpdate:=1;
end;

{------------------------------------------------------------------------------}
procedure TLMDSearchOptions.EndUpdate(Update: Boolean);
begin
  FUpdate:=0;
  If Update then Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDSearchOptions.Change;
begin
  if FUpdate>0 then exit;
  if Assigned(FOnChange) then FOnChange(self);
end;

{*********************** TLMDSearchBaseDlgComponent ***************************}
{ ----------------------------- private -------------------------------------- }
procedure TLMDSearchBaseDlgComponent.SetSearchOptions(const Value: TLMDSearchOptions);
begin
  FSearchOptions.Assign(Value);
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDSearchBaseDlgComponent.GetChange(Sender: TObject);
begin
end;

{------------------------------------------------------------------------------}
function TLMDSearchBaseDlgComponent.GetTemplate: TLMDSearchTemplate;
begin
  result:='';
end;

{------------------------------------------------------------------------------}
procedure TLMDSearchBaseDlgComponent.SetTemplate(const Value: TLMDSearchTemplate);
begin
end;

{----------------------------- public -----------------------------------------}
constructor TLMDSearchBaseDlgComponent.Create(aOwner: TComponent);
begin
  inherited;
  FOptions:=def_SPDialogOptions;
  FSearchOptions:=TLMDSearchOptions.Create(self);
  FSearchOptions.OnChange:=GetChange;
  FAnySingleCharacter := '?';
  FAnySequenceCharacter := '*';
end;

{------------------------------------------------------------------------------}
destructor TLMDSearchBaseDlgComponent.Destroy;
begin
  FSearchOptions.OnChange:=nil;
  FreeAndNil(FSearchOptions);
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDSearchBaseDlgComponent.getLMDPackage:TLMDPackageID;
begin
  result:=pi_LMD_SEARCH;
end;

{------------------------------------------------------------------------------}

procedure TLMDSearchBaseDlgComponent.SetAnySingleCharacter(const Value: Char);

begin
  if Value <> FAnySingleCharacter then FAnySingleCharacter := Value;
end;

{------------------------------------------------------------------------------}

procedure TLMDSearchBaseDlgComponent.SetAnySequenceCharacter(const Value: Char);

begin
  if Value <> FAnySequenceCharacter then FAnySequenceCharacter := Value;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
