unit LMDDBRefine;
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

LMDDBRefine unit (DD)
---------------------


Changes
-------
Release 3.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  DB, DBCtrls, Dialogs, Forms, Classes, LMDSearchBase, LMDRefineUnit, LMDSearchConsts,
  LMDDBRefineDialog, StdCtrls, Windows;

type

  TLMDSearchDirection = (sdUp, sdDown);
  TLMDSearchFindDialogOptions = set of (fdoAutoSelect, fdoShowBuildButton, fdoCenterDialog, fdoCenterOwnerForm,
                                        fdoDefaultNotFoundMessage, fdoUseBookMark);

const
  def_LMDSPFindOptions=[fdoShowBuildButton, fdoDefaultNotFoundMessage, fdoUseBookMark];

type
  TLMDDBRefine = class(TLMDSearchBaseDlgComponent)
  private
    FOffset: Boolean;
    FDataLink: TFieldDataLink;
    FSearchDirection: TLMDSearchDirection;
    FRefine: TLMDRefine;
    FSearchString:String;
    FFindDialog:TLMDDBSearchFindForm;
    FFindOptions:TLMDSearchFindDialogOptions;
    FOnStartSearch,
    FOnNotFound,
    FOnFound,
    FOnFindDlgCustomize:TNotifyEvent;

    procedure DataChange(Sender: TObject);
    procedure UpdateData(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetSearchDirection(const Value: TLMDSearchDirection);
    procedure ShowBuildDialog(Sender: TObject);
    procedure FindNextButtonClick(Sender: TObject);
    function InternalFind(Direction:TLMDSearchDirection=sdDown; UpdateSettings:Boolean=True):Boolean;
  protected
    procedure GetChange(Sender: TObject);override;
    procedure SetTemplate(const Value: TLMDSearchTemplate);override;
    function GetTemplate:TLMDSearchTemplate;override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function FindNext: Boolean;
    procedure FreeFindDialogResources;
    procedure ShowFindDialog(AOwner: TCustomForm=nil;X: Integer = -1; Y: Integer = -1);
    function ShowBuilderDialog(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property SearchDirection: TLMDSearchDirection read FSearchDirection write SetSearchDirection default sdDown;

    property DlgFindOptions: TLMDSearchFindDialogOptions read FFindOptions write FFindOptions default def_LMDSPFindOptions;
    property OnDlgFindCustomize:TNotifyEvent read FOnFindDlgCustomize write FOnFindDlgCustomize;
    property OnStartSearch:TNotifyEvent read FOnStartSearch write FOnStartSearch;
    property OnFound:TNotifyEvent read FOnFound write FOnFound;
    property OnNotFound:TNotifyEvent read FOnNotFound write FOnNotFound;

    // derived
    property DlgBuilderOptions;
    property SearchString;
    property SearchOptions;
    property OnDlgCustomize;
    property OnDlgHelpClick;

  end;

implementation
uses
  SysUtils, Controls, LMDUtils;
{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

{ ----------------------------- private -------------------------------------- }
procedure TLMDDBRefine.DataChange(Sender: TObject);
begin
;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.UpdateData(Sender: TObject);
begin
;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRefine.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRefine.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.SetSearchDirection(const Value: TLMDSearchDirection);
begin
  if Value <> FSearchDirection then FSearchDirection := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.ShowBuildDialog(Sender: TObject);
begin
  with FFindDialog do
    begin
      FRefine.Template:=FindEdit.Text;
      FRefine.WholeWordsOnly:=MathWholeCheckBox.Checked;
      FRefine.MatchCase:=MathCaseCheckBox.Checked;
      FRefine.DlgBuilderOptions:=self.DlgBuilderOptions;
      FRefine.OnDlgCustomIze:=self.OnDlgCustomize;
      FRefine.OnDlgHelpClick:=self.OnDlgHelpClick;
      FRefine.AnySingleCharacter := AnySingleCharacter;
      FRefine.AnySequenceCharacter := AnySequenceCharacter;
    end;

  if FRefine.ShowDialog(TForm(TButton(Sender).Owner)) then
    with FFindDialog do
      begin
        FindEdit.Text := FRefine.Template;
        MathWholeCheckBox.Checked := Frefine.WholeWordsOnly;
        MathCaseCheckBox.Checked := Frefine.MatchCase;
      end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.FindNextButtonClick(Sender: TObject);
begin
  with FFindDialog do
    begin
      FRefine.Template := FindEdit.Text;
      FRefine.MatchCase := MathCaseCheckBox.Checked;
      FRefine.WholeWordsOnly := MathWholeCheckBox.Checked;
      if  UpRadioButton.Checked then
        InternalFind(sdUp, false)
      else
        InternalFind(sdDown, false);
    end;
  FOffset := True;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRefine.InternalFind(Direction:TLMDSearchDirection=sdDown; UpdateSettings:Boolean=True):Boolean;
var
  Found: Boolean;
  SavePlace: TBookmark;

begin
  SavePlace:=nil;
  Found:=False;
  Result:=false;
  if (FDataLink.Field=nil) or not  FDataLink.Active then exit;

  // update settings
  if UpdateSettings then
    begin
      FRefine.Template:=SearchString;
      FRefine.NearestLength := SearchOptions.NearestLength;
      FRefine.WholeWordsOnly := SearchOptions.WholeWordsOnly;
      FRefine.MatchCase := SearchOptions.MatchCase;
      Direction:=FSearchDirection;
    end;

  if Assigned(FOnStartSearch) then FOnStartSearch(self);

  FDataLink.DataSet.DisableControls;
  try
    if fdoUseBookMark in FFindOptions then
      SavePlace := FDataLink.DataSet.GetBookmark;
    try
      if FOffset then
        begin
          if (Direction = sdUp) and not FDataLink.DataSet.BOF then
            FDataLink.DataSet.Prior;
          if (Direction = sdDown) and not FDataLink.DataSet.Eof then
            FDataLink.DataSet.Next;
          FOffset := False;
        end;
      Result := True;
      if Direction = sdDown then
        while not FDataLink.DataSet.Eof do
          begin
            if FRefine.SearchTemplate(' ' + FDataLink.Field.AsString + ' ') then
              begin
                Found := True;
                if Assigned(FOnFound) then FOnFound(self);
                break;
              end;
            FDataLink.DataSet.Next;
          end
      else
        while not FDataLink.DataSet.BOF do
          begin
            if FRefine.SearchTemplate(' ' + FDataLink.Field.AsString + ' ') then
              begin
                Found := True;
                if Assigned(FOnFound) then FOnFound(self);
                break;
              end;
            FDataLink.DataSet.Prior;
          end;

      if (FDataLink.DataSet.Eof or FDataLink.DataSet.BOF) and not FOffset and not Found then
        begin
          if fdoUseBookMark in FFindOptions then
            FDataLink.DataSet.GotoBookmark(SavePlace);
          if fdoDefaultNotFoundMessage in FFindOptions then
            MessageDlg(LMDSP_FinishedSearchingDocument, mtInformation, [mbOK], 0);
          if Assigned(FOnNotFound) then FOnNotFound(self);
          Result := False;
        end;
    finally
      if fdoUseBookMark in FFindOptions then
        FDataLink.DataSet.FreeBookmark(SavePlace)
    end;
  finally
    FDataLink.DataSet.EnableControls;
  end;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDDBRefine.GetChange(Sender: TObject);
begin
  if csLoading in ComponentState then exit;
  FRefine.NearestLength := SearchOptions.NearestLength;
  FRefine.WholeWordsOnly := SearchOptions.WholeWordsOnly;
  FRefine.MatchCase := SearchOptions.MatchCase;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRefine.GetTemplate: TLMDSearchTemplate;
begin
  result:=FSearchString;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.SetTemplate(const Value: TLMDSearchTemplate);
begin
  if Value <> FSearchString then
    if FRefine.ParseTemplate(Value) then
      FSearchString:=Value
    else
      MessageDlg(LMDSP_InvalidTemplate, mtError, [mbYes], 0);
end;

{----------------------------- public -----------------------------------------}
constructor TLMDDBRefine.Create(AOwner: TComponent);
begin
  inherited;
  FRefine := TLMDRefine.Create(nil);

  FFindDialog:=TLMDDBSearchFindForm.Create(nil);
  FFindDialog.BuildButton.OnClick := ShowBuildDialog;
  FFindDialog.FindNextButton.OnClick := FindNextButtonClick;

  FSearchDirection := sdDown;
  FFindOptions:=def_LMDSPFindOptions;

  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FOffset := False;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDDBRefine.Destroy;
begin
  FreeAndNil(FDataLink);
  FreeAndNil(FRefine);
  FreeAndNil(FFindDialog);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRefine.FindNext: Boolean;
begin
  result:=InternalFind;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.ShowFindDialog(AOwner: TCustomForm; X, Y: Integer);

begin
  try
    FFindDialog.HandleNeeded;
    with FFindDialog do
      begin
        FindEdit.Text := FSearchString; //FRefine.Template;
        FindEdit.AutoSelect:=fdoAutoSelect in FFindOptions;
        FindEdit.SelStart:=Length(FindEdit.Text);
        ActiveControl:=FindEdit;

        MathWholeCheckBox.Checked := SearchOptions.WholeWordsOnly;
        MathCaseCheckBox.Checked := SearchOptions.MatchCase;
        UpRadioButton.Checked := SearchDirection = sdUp;
        DownRadioButton.Checked := SearchDirection = sdDown;

        BuildButton.Visible:=fdoShowBuildButton in FFindOptions;
        if BuildButton.Visible then
          FindNextButton.Top:=DirectionGroupBox.Top+5
        else
          FindNextButton.Top:=FindEdit.Top-2;
        FindNextButton.Enabled:=(FDataLink.Field<>nil) and FDataLink.Active;
        CloseButton.Top:=FindNextButton.BoundsRect.Bottom+5;

        // Position
        if AOwner<>nil then
          LMDCenterChild(TCustomForm(AOwner), FFindDialog)
        else
          if fdoCenterDialog in DlgFindOptions then
            begin
              if not (fdoCenterOwnerForm in DlgFindOptions) then
                LMDCenterForm(FFindDialog)
              else
                if self.Owner is TCustomForm then
                  LMDCenterChild(TCustomForm(self.Owner), FFindDialog);
            end
          else
            begin
              if X <> -1 then FFindDialog.Left := X;
              if Y <> -1 then FFindDialog.Top := Y;
            end;

        if Assigned(FOnFindDlgCustomize) then FOnFindDlgCustomize(FFindDialog);

        if ShowModal=mrOK then
          begin
            FSearchString := FRefine.Template;
            SearchOptions.MatchCase := FRefine.MatchCase;
            SearchOptions.WholeWordsOnly := FRefine.WholeWordsOnly;
            if UpRadioButton.Checked then FSearchDirection := sdUp else FSearchDirection := sdDown;
          end;
      end;
  finally
    FOffset := False;
  end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDDBRefine.FreeFindDialogResources;
begin
  FFindDialog.Release;
end;

{ ---------------------------------------------------------------------------- }
function TLMDDBRefine.ShowBuilderDialog(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;
begin
  Result:=False;

  FRefine.NearestLength := SearchOptions.NearestLength;
  FRefine.WholeWordsOnly := SearchOptions.WholeWordsOnly;
  FRefine.MatchCase := SearchOptions.MatchCase;
  FRefine.Template:=FSearchString;

  FRefine.DlgBuilderOptions:=self.DlgBuilderOptions;
  FRefine.OnDlgCustomize:=self.OnDlgCustomize;
  FRefine.OnDlgHelpClick:=self.OnDlgHelpClick;

  if FRefine.ShowDialog(AOwner, X,Y) then
    // update settings only when user clicked on OK
    begin
      Result:=true;
      SearchString:=FRefine.Template;
      SearchOptions.BeginUpdate;
      SearchOptions.NearestLength := FRefine.NearestLength;
      SearchOptions.WholeWordsOnly := FRefine.WholeWordsOnly;
      SearchOptions.MatchCase := FRefine.MatchCase;
      SearchOptions.EndUpdate;
    end;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}

end.
