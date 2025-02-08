unit LMDDBSpeedButton;
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

LMDDBSpeedButton unit ()
------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  DB,
  LMDCustomSpeedButton,
  LMDBookmarkCont,
  lmddbbtn;

type
  { --------------------- TLMDDBSpeedButton ---------------------------------- }
  TLMDDBSpeedButton = class(TLMDCustomSpeedButton)
  private
    FDataLink : TLMDButtonDataLink;
    FKind     : TLMDNavigateBtn;
    FBookmark : TLMDBookmarkCont;
    FConfirmDelete : Boolean;
    FOnSearch : TNotifyEvent;
    //RM
    FSet      : TLMDNavGlyphSet;
    FOnNavClick,
    FBeforeAction: TLMDNavClick;
    procedure SetKind (aValue:TLMDNavigateBtn);
    procedure SetDataSource(aValue:TDataSource);
    function GetDatasource:TDataSource;
    procedure SetBookmark (aValue : TLMDBookmarkCont);
    procedure SetSet(aValue:TLMDNavGlyphSet);
    procedure LoadGlyph;
  protected
    procedure Notification(aComponent:TComponent;Operation:TOperation); override;
    procedure Loaded; override;
  public
    procedure EditingChanged;
    procedure DataChanged;
    procedure ActiveChanged;
    procedure Click; override;
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    property Style;
  published
    property About;
    property Align;
    property ButtonStyle;
    property DataSource : TDataSource read GetDataSource write SetDataSource;
    property Kind : TLMDNavigateBtn read FKind write SetKind;
    property Bookmark : TLMDBookmarkCont read FBookmark write SetBookmark;
    property ConfirmDelete : Boolean read FConfirmDelete write FConfirmDelete default true;
    property GlyphSet:TLMDNavGlyphSet read FSet write SetSet default ngBlack;
    property MultiLine;
    property OnSearch : TNotifyEvent read FOnSearch write FOnSearch;
    property OnBeforeNavBtnAction: TLMDNavClick read FBeforeAction write FBeforeAction;
    property OnNavBtnClick:TLMDNavClick read FOnNavClick write FOnNavClick;
  end;

implementation

uses
  Types,
  Windows, Dialogs, Controls, Graphics, SysUtils,
  LMDDBConst;

{ *********************** TLMDDBSpeedButton ********************************** }
{ ------------------------------- private ------------------------------------ }
procedure TLMDDBSpeedButton.SetKind (aValue : TLMDNavigateBtn);
begin
  if aValue <> FKind then
    begin
      FKind := aValue;
      LoadGlyph;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.SetSet(aValue:TLMDNavGlyphSet);
begin
  if aValue <> FSet then
    begin
      FSet:=aValue;
      LoadGlyph;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.SetDataSource(aValue:TDataSource);
begin
  if aValue<>FDataLink.DataSource then
    FDataLink.DataSource:=aValue;
  if (FBookmark <> nil) and (FBookmark.DataSource <> FDataLink.DataSource) then
    begin
      ShowMessage ('The DataSource of the Bookmark Container and the Button must be identical. Connection will be removed.');
      Bookmark := nil;
    end;
  if not (csLoading in ComponentState) then
    ActiveChanged;
  if aValue <> nil then aValue.FreeNotification(Self);
end;

{------------------------------------------------------------------------------}
function TLMDDBSpeedButton.GetDataSource:TDataSource;
begin
  result:=FDataLink.DataSource
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.SetBookmark (aValue : TLMDBookmarkCont);
begin
  if (aValue <> nil) and (aValue.DataSource <> nil) and (FDataLink.DataSource <> nil) and (aValue.DataSource <> FDataLink.DataSource) then
    begin
      FBookmark := nil;
      ShowMessage ('Button and Bookmark container must have the same DataSource!!');
    end
  else
    FBookmark := aValue;
  ActiveChanged;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.LoadGlyph;
var
  FEn,
  FBBmp : TBitmap;
begin
  if FSet = ngNone then
    Glyph := nil;
  FEn := TBitmap.Create;
  FBBmp := TBitmap.Create;
  try
    FEn.Handle := LoadBitmap (HInstance, MakeIntResource(IDB_NAVBMP+Ord(FSet)));
    FBBmp.Width := FEn.Width Div (LMDNAVBTNS);
    FBBmp.Height := FEn.Height;
    FBBmp.Canvas.CopyRect (Rect (0 , 0, FBBmp.Width, FBBmp.Height),
                           FEn.Canvas,
                           Rect (Ord(FKind)*FBBmp.Width, 0,
                                (Ord(FKind) + 1)*FBBmp.Width, FBBmp.Height));

    NumGlyphs:=Ord(FSet)+1;
    Glyph := FBBmp;
  finally
    FEn.Free;
    FBBmp.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.DataChanged;
var
  UpEnable, DnEnable : Boolean;
begin
  if not Assigned(FDataLink) then exit;
  UpEnable := FDataLink.Active and not FDataLink.DataSet.BOF;
  DnEnable := FDataLink.Active and not FDataLink.DataSet.EOF;
  case FKind of
    nbFirst : Enabled := UpEnable;
    nbPrior : Enabled := UpEnable;
    nbNext : Enabled :=  DnEnable;
    nbLast : Enabled :=  DnEnable;
    nbRemoveFilter : Enabled := FDataLink.DataSource.DataSet.Filtered;
    nbDelete : Enabled := FDataLink.Active and FDataLink.DataSet.CanModify and
               not (FDataLink.DataSet.BOF and FDataLink.DataSet.EOF);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.EditingChanged;
var
  CanModify: Boolean;
begin
  CanModify := FDataLink.Active and FDataLink.DataSet.CanModify;
  case FKind of
    nbInsert : Enabled := CanModify;
    nbEdit : Enabled := CanModify and not FDataLink.Editing;
    nbPost : Enabled := CanModify and FDataLink.Editing;
    nbCancel : Enabled := CanModify and FDataLink.Editing;
    nbRefresh : Enabled := CanModify;
    nbClear : Enabled := CanModify and FDataLink.Editing;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.ActiveChanged;
begin
  if not Assigned(FDataLink) then exit;
  if not (FDataLink.Active) then
    if FKind <> nbOpen then
      Enabled := false
    else
      Enabled := true
  else
    begin
      case FKind of
        nbDeleteBookmark: Enabled := (FBookmark <> nil);
        nbGotoBookmark: Enabled := (FBookmark <> nil);
        nbSetBookmark : Enabled := (FBookmark <> nil);
        nbSearch : Enabled := true;
        nbSetFilter : Enabled := true;
        nbClose : Enabled := true;
        nbOpen : Enabled := false;
        nbFindFirst : Enabled := true;
        nbFindNext : Enabled := true;
        nbFindPrior : Enabled := true;
        nbFindLast : Enabled := true;
      end;
      DataChanged;
      EditingChanged;
    end;
end;

{ ------------------------------- protected ---------------------------------- }
procedure TLMDDBSpeedButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation=opRemove) and (FDataLink<>nil) and (AComponent=DataSource) then
    DataSource := nil;
  if (Operation=opRemove) and (AComponent=FBookmark) then
    begin
      FBookmark := nil;
      ActiveChanged;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.Click;
begin
  inherited Click;
  if (DataSource <> nil) and (DataSource.State <> dsInactive) then
    begin
      if not (csDesigning in ComponentState) and Assigned(FBeforeAction) then
        FBeforeAction(Self, FKind);
      LMDDBNavAction(self, DataSource.DataSet, FKind, FBookMark, FConfirmDelete);
     end; // end of if
  if not (csDesigning in ComponentState) and Assigned(FOnNavClick) then FOnNavClick(Self, FKind);
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDDBSpeedButton.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  ControlStyle:=ControlStyle-[csReplicatable];
  FDataLink := TLMDButtonDataLink.Create(self);
  FKind := nbFirst;
  FBookmark := nil;
  FConfirmDelete := true;
  Enabled := false;
  LoadGlyph;
end;

{------------------------------------------------------------------------------}
destructor TLMDDBSpeedButton.Destroy;
begin
  FBookmark := nil;
  FDataLink.DataSource := nil;
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDDBSpeedButton.Loaded;
begin
  inherited Loaded;
  ActiveChanged;
end;

end.
