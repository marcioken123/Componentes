unit ElDBTreeNavigator;
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

ElDBTreeNavigator unit
----------------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
   LMDDebugUnit,
   ElPanel,
   ElDBXTree,
   ImgList,
   ElToolbar,
   ElPopBtn,
   ElACtrls,
   ElMaskEdit,
   ElCheckCtl,
   ElCheckItemGrp,
{$ifdef LMD_UNICODE}
   LMDUnicodeStrings,
   LMDUtils,
{$endif}

   Forms,
   Windows,
   Controls,
   StdCtrls,
   Graphics,
   Messages,
   Dialogs,

   ElPromptDlg,
   ElEdits,

   Types,
   LMDThemes,
   Themes, UxTheme,
   LMDGlyphs,
   Classes,
   SysUtils,
   LMDElDBConst,
   ElVCLUtils,
   LMDGraph;

type
  THElXDBTree =  class(TCustomElDBXTree);
  THElXDBTreeItem =  class(TElDBXTreeItem);

  TElDBTreeNavButtonRole = (tnbrFirstRootItem, tnbrFirst, tnbrPrior, tnbrNext, tnbrLast, tnbrLastRootItem,
                      tnbrInsert, tnbrInsertChild, tnbrDelete, tnbrEdit, {tnbrPost,
                      tnbrCancel,} tnbrRefresh, tnbrCustom);

  TElDBTreeNavButton = class(TCustomElToolButton)
  protected
    FRole: TElDBTreeNavButtonRole;

    FCustomAction: Boolean;
    FUseCustomImages: Boolean;

    procedure SetRole(Value: TElDBTreeNavButtonRole);

    function GetDetails: TThemedElementDetails; override;
    procedure FillStateForDetails(var ADetails: TThemedElementDetails);
    function GetArrowDetails: TThemedElementDetails; override;

    procedure SetUseImageList(newValue : Boolean); override;
    procedure SetUseCustomImage(Value : Boolean);
    procedure Loaded; override;
    procedure SetImageList(newValue : TCustomImageList); override;
    procedure SetImageIndex(newValue : Integer); override;

    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    public
    procedure AClick(Arrow : boolean); override;
    constructor Create(AOwner : TComponent); override;
  published
    property Role: TElDBTreeNavButtonRole read FRole write SetRole default tnbrCustom;
    property UseCustomImage:Boolean read FUseCustomImages write SetUseCustomImage default False;
    property Wrap;
    property LargeGlyph;
    property NumLargeGlyphs;
    property Glyph;
    property NumGlyphs;
    property OwnerSettings;

    property PullDownMenu;
    property PopupPlace;
    property DisableAutoPopup;
    property Flat;
    property Layout;
    property Margin;
    property Spacing;
    property UseArrow;
    property ShadowFollowsColor;
    property ShowGlyph;
    property ShowText ;
    property OnArrowClick;
    property Icon;
    property TextDrawType;
    property ThinFrame;

    property DownSound;
    property UpSound;
    property ClickSound;
    property ArrowClickSound;
    property SoundMap;

    property UseIcon;
    property ImageIndex;
    property UseImageList;
    property OldStyled;
    property Background;
    property DownBackground;
    property BackgroundDrawBorder;
    property ThemeMode;
    property ThemeGlobalMode;
    // VCL properties
    property Caption;
    property Enabled;
    property PopupMenu;
    property Color;
    property ParentColor;
    property Align;
    property Font;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnStartDrag;

    property Action;
    property Constraints;

    property OnContextPopup;
    property CustomAction: Boolean read FCustomAction write FCustomAction default
        false;

  end;

  {$warnings off}
  TElDBTreeNavigator = class(TElToolbar)
  private
    FDeleteRecordQuestion : string;
    FTree: TCustomElDBXTree;
    function GetTree: TCustomElDBXTree;
    procedure SetTree(Value: TCustomElDBXTree);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    protected
    FConfirmDelete: Boolean;
    FIsToolbar: Boolean;
    FIntImageList: TCustomImageList;
    function GetButtonClass: TElToolButtonClass; override;
    procedure SetIsToolbar(Value: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Loaded; override;
    procedure CheckButtonsState;

    procedure CMControlChange(var Msg : TCMControlChange); message CM_CONTROLCHANGE;

    procedure ScrollTree;
  public
    constructor Create(AOwner : TComponent); override;
    function FindButtonByRole(Role : TElDBTreeNavButtonRole): TElDBTreeNavButton;
    function AddButton(Role : TElDBTreeNavButtonRole): TElDBTreeNavButton;
    procedure AddButtons(const Roles : array of TElDBTreeNavButtonRole);
    destructor Destroy; override;
    published
    property DeleteRecordQuestion : string read FDeleteRecordQuestion write FDeleteRecordQuestion;
    property ElDBXTree: TCustomElDBXTree read GetTree write SetTree;
    property ConfirmDelete: Boolean read FConfirmDelete write FConfirmDelete
        default true;
    property IsToolbar: Boolean read FIsToolbar write SetIsToolbar default false;
    property BtnOffsHorz default 0;
    property BtnOffsVert default 0;
    property BevelOuter default bvNone;
    property UseImageList default True;
  end;
  {$warnings on}

Var

  ElDBTreeNavButtonsHint :array[Low(TElDBTreeNavButtonRole)..Pred(tnbrCustom)] of PResStringRec =
  (
    @SLMDTnbrFirstRoot, @SLMDTnbrFirst, @SLMDTnbrPrior, @SLMDTnbrNext, @SLMDTnbrLast, @SLMDTnbrLastRoot,
    @SLMDTnbrInsert, @SLMDTnbrInsertSubItem, @SLMDTnbrDelete, @SLMDTnbrEdit,{ @SLMDTnbrPost,
    @SLMDTnbrCancel,} @SLMDTnbrRefresh
  );
  implementation

uses
  ElTree;

var FGlyphBitmap : TBitmap;

procedure TElDBTreeNavButton.SetRole(Value: TElDBTreeNavButtonRole);
begin
  FRole := Value;
  if (FRole = tnbrCustom) or (FUseCustomImages) then
    Images := TElDBTreeNavigator(Parent).Images
  else
  begin
    inherited SetImageIndex(integer(FRole));
    inherited SetImageList(TElDBTreeNavigator(Parent).FIntImageList);
    inherited SetUseImageList(true);
  end;
end;

procedure TElDBTreeNavButton.AClick(Arrow : boolean);
var
  it, pr : TElDBXTreeItem;

begin
  if (not Arrow) and Assigned(TElDBTreeNavigator(Parent).FTree) and (not CustomAction)  then
  begin
    with TElDBTreeNavigator(Parent).FTree do
    begin
      it := Selected;
      case Role of
        tnbrPrior:begin
                    if Assigned(it) then
                    begin
                      pr := it.GetPrevSibling;
                      if Assigned(pr) then
                      begin
                        if pr.Expanded and pr.HasChildren then
                        begin
                          it := pr.GetLastChild;
                          if Assigned(it) then
                            pr := it;
                        end;
                      end
                      else
                      begin
                        pr := it.Parent;
                        if Assigned(pr) then
                        begin
                          it := pr.GetPrevSibling;
                          if Assigned(it) and (it.HasChildren) and it.Expanded then
                          begin
                            it := it.GetLastChild;
                            if Assigned(it) then
                              pr := it;
                          end;
                        end;
                      end;
                      if Assigned(pr) then
                      begin
                        Selected := pr;
//                        i := IndexInView(pr);
//                        if (i<0) then
//                          VScrollBar.Position := max(0,MSender.VScrollBar.Position - 1);
                      end;
                    end;
                  end;
        tnbrNext: begin
                    if not Assigned(it) then
                    begin
                      if Assigned(Items[0]) then
                      begin
                        Selected := Items[0];
                        it := Selected;
                      end
                      else
                        exit;
                    end;
                    if (it.HasChildren) and (it.expanded) then
                      pr := it.GetFirstChild
                    else
                      pr := it.GetNextSibling;
                    if not Assigned(pr) then
                    begin
                      pr := it.Parent;
                      if Assigned(pr) then
                        pr := pr.GetNextSibling;
                    end;
                    if Assigned(pr) then
                    begin
                      Selected := pr;
  //                    i := MSender.IndexInView(pr);
  //                    if (i<0) then
  //                      MSender.VScrollBar.Position := min(MSender.VScrollBar.Max,MSender.VScrollBar.Position + 1);
                    end;
                  end;
        tnbrFirst:begin
                    if Assigned(it) then
                    begin
                      Selected := it.GetFirstSibling;
                    end
                    else
                    begin
                      it := Items.GetFirstNode;
                      if Assigned(it) then
                      begin
                        Selected := it;
                      end;
                    end;
                  end;
        tnbrLast: begin
                    if Assigned(it) then
                    begin
                      pr := it.GetLastSibling;
                      Selected := pr;
                    end
                    else if VScrollBar.Max > 0 then
                    begin
                      it := Items.GetFirstNode;
                      pr := it.GetLastSibling;
                      Selected := pr;
                    end;
                  end;
        tnbrEdit: begin
                    if Assigned(it) then
                      it.EditText;
                  end;
//        tnbrCancel:begin
//                    if Assigned(it) and IsEditing then
//                      it.EndEdit(True);
//                   end;
//        tnbrPost:  begin
//                    if Assigned(it) and IsEditing then
//                      it.EndEdit(False);
//                   end;
        tnbrRefresh: Refresh;
        tnbrFirstRootItem :
                      begin
                        begin
                          it := Items.GetFirstNode;
                          if Assigned(it) then
                          begin
                            Selected := it;
                          end;
                        end;
                      end;
        tnbrLastRootItem:
                      begin
                        if Items.Count > 0 then
                        begin
                          it := Items.GetFirstNode;
                          pr := it.GetLastSibling;
                          Selected := pr;
                        end;
                      end;
        tnbrDelete: if Assigned(it) then
                      THElXDBTreeItem(it).DeleteFromDataSet;
        tnbrInsert: if Assigned(it) then
                    begin
                      THElXDBTreeItem(it).InsertSiblingToDataSet;
                      pr := it.GetLastSibling;
                      if Assigned(pr) then
                        selected := pr;
                    end
                    else
                    begin
                      THElXDBTree(TElDBTreeNavigator(Self.Parent).FTree).InsertToRootDataSet;
                      it := Items.GetFirstNode;
                      pr := it.GetLastSibling;
                      if Assigned(pr) then
                        selected := pr;
                    end;
        tnbrInsertChild: if Assigned(it) then
                         begin
                           THElXDBTreeItem(it).InsertChildToDataSet;
                           if not it.Expanded then
                             it.Expand(false);
                           pr := it.GetLastChild;
                           if Assigned(pr) then
                             selected := pr;
                         end
                         else
                         begin
                           THElXDBTree(TElDBTreeNavigator(Self.Parent).FTree).InsertToRootDataSet;
                           it := Items.GetFirstNode;
                           pr := it.GetLastSibling;
                           if Assigned(pr) then
                             selected := pr;
                         end;
      end;
    end;
    TElDBTreeNavigator(Parent).ScrollTree;
  end;
  inherited;
end;

function TElDBTreeNavButton.GetDetails: TThemedElementDetails;
begin
  if Assigned(Parent) and TElDBTreeNavigator(Parent).FIsToolbar then
  begin
    Result.Element := teToolBar;
    case ButtonType of
      ebtSeparator:
        begin
          Result.Part := TP_SPLITBUTTON;
        end;
      ebtDivider:
        begin
          if (Parent as TElToolbar).Orientation = eboVert then
            Result.Part := TP_SEPARATORVERT
          else
            Result.Part := TP_SEPARATOR;
        end;
      else
        begin
          if (not UseArrow) and (PulldownMenu <> nil) then
            Result.Part := TP_DROPDOWNBUTTON
          else
          if UseArrow then
            Result.Part := TP_SPLITBUTTON
          else
            Result.Part := TP_BUTTON;
        end;
    end;
  end
  else
  begin
    Result.Element := teButton;
    Result.Part := BP_PUSHBUTTON;
  end;
  FillStateForDetails(Result);
end;

procedure TElDBTreeNavButton.FillStateForDetails(var ADetails: TThemedElementDetails);
begin
  if Assigned(Parent) and TElDBTreeNavigator(Parent).FIsToolbar then
	begin
    if not Enabled then
      ADetails.State := TS_DISABLED
    else
    if FState in [ebsDown, ebsExclusive] then
      ADetails.State := TS_PRESSED
    else
    if (Down and IsSwitch) then
    begin
      if FMouseInControl or FMouseInArrow then
        ADetails.State := TS_HOTCHECKED
      else
        ADetails.State := TS_CHECKED;
    end
    else
    if FMouseInControl or FMouseInArrow then
      ADetails.State := TS_HOT
    else
      ADetails.State := TS_NORMAL;
  end
  else
  begin
    if not Enabled then
      ADetails.State := PBS_DISABLED
    else
    if (FDown and FIsSwitch) or (FState in [ebsDown, ebsExclusive]) then
      ADetails.State := PBS_PRESSED
    else
    if FMouseInControl or FMouseInArrow then
      ADetails.State := PBS_HOT
    else
      ADetails.State := PBS_NORMAL;
  end;
end;

function TElDBTreeNavButton.GetArrowDetails: TThemedElementDetails;
begin
  if Assigned(Parent) and TElDBTreeNavigator(Parent).FIsToolbar then
  begin
    // tiToolBar TP_SPLITBUTTONDROPDOWN
    if not Enabled then
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownDisabled)
    else
    if FState in [ebsArrDown, ebsExclusive] then
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownPressed)
    else
    if FMouseInArrow or FMouseInControl then
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownHot)
    else
      result := ThemeServices.GetElementDetails(ttbSplitButtonDropDownNormal);
  end
  else
  begin
    // tiButton CP_DROPDOWNBUTTON
    if not Enabled then
      result := ThemeServices.GetElementDetails(tcDropDownButtonDisabled)
    else
    if FState in [ebsArrDown, ebsExclusive] then
      result := ThemeServices.GetElementDetails(tcDropDownButtonPressed)
    else
    if FMouseInControl or FMouseInArrow then
      result := ThemeServices.GetElementDetails(tcDropDownButtonHot)
    else
      result := ThemeServices.GetElementDetails(tcDropDownButtonNormal);
  end;
end;

procedure TElDBTreeNavButton.SetUseImageList(newValue : Boolean);
begin
  if (UseImageList <> newValue) then
  begin
    if (FRole = tnbrCustom) or (ComponentState * [csLoading, csReading] <> []) then
      inherited SetUseImageList(newValue);
  end; { if }
end; { SetUseImageList }

procedure TElDBTreeNavButton.Loaded;
begin
  inherited;
  if (FRole <> tnbrCustom) and (not FUseCustomImages) then
  begin
    inherited SetImageList(TElDBTreeNavigator(Parent).FIntImageList);
    inherited SetUseImageList(true);
    inherited SetImageIndex(integer(FRole));
  end;
end;

procedure TElDBTreeNavButton.SetImageList(newValue : TCustomImageList);
begin
  if (FRole = tnbrCustom) or (FUseCustomImages) or (ComponentState * [csLoading, csReading] <> []) then
    inherited SetImageList(newValue);
end;

constructor TElDBTreeNavButton.Create(AOwner : TComponent);
begin
  inherited;
  FRole := tnbrCustom;
end;

procedure TElDBTreeNavButton.SetImageIndex(newValue : Integer);
begin
  if (FRole = tnbrCustom) or (FUseCustomImages) or (ComponentState * [csLoading, csReading] <> []) then
    inherited SetImageIndex(newValue);
end;

// Set Default Hint Strings

procedure TElDBTreeNavButton.CMHintShow(var Message: TCMHintShow);

 var HintInfo : PHintInfo;

  procedure GetHintButtonByRole;
   var {$ifdef LMD_UNICODE}
       T        : WideChar;
       WS       : WideString;
       {$endif}
       l        : integer;
       S        : String;
  begin
      if not Assigned(ElDBTreeNavButtonsHint[Role]) then
        exit;

      S := LoadResString(ElDBTreeNavButtonsHint[Role]);

      if Length(S)=0 then
        exit;

      {$ifdef LMD_UNICODE}
        S := LMDWideGetShortHint(S);
        WS:= S;

        l := Length(S) + 1 + Length(WS) * 2;
        SetLength(HintInfo.HintStr, l + 4);
        Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);
        Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
        T := #0;
        Move(T, HintInfo.HintStr[l + 1], sizeof(T));
        T := #$FFFE;
        Move(T, HintInfo.HintStr[l + 3], sizeof(T));
      {$else}
        l := Length(S);
        SetLength(HintInfo.HintStr, l + 1);
        Move(S[1], HintInfo.HintStr[1], l);
        HintInfo.HintStr[l+1] := #0;
      {$endif}
  end;
begin

  inherited;
  if (Role = tnbrCustom)or(Length(Hint)>0) then exit;
  HintInfo := Message.HintInfo;
  GetHintButtonByRole;

end;

constructor TElDBTreeNavigator.Create(AOwner : TComponent);
begin
  inherited;
  FConfirmDelete := true;
  FIntImageList := TCustomImageList.Create(Self);
  FIntImageList.Width := 14;
  FIntImageList.Height := 13;
  FIntImageList.AddMasked(FGlyphBitmap, FGlyphBitmap.Canvas.Pixels[0, FGlyphBitmap.Height - 1]);
  UseImageList := true;
  ShowCaption := false;
  ShowGlyph := true;
  BtnOffsHorz := 0;
  BtnOffsVert := 0;
  BevelOuter := bvNone;
end;

function TElDBTreeNavigator.FindButtonByRole(Role : TElDBTreeNavButtonRole):
    TElDBTreeNavButton;
var i : integer;
begin
  result := nil;
  for i := 0 to FButtons.Count -1 do
  begin
    if TElDBTreeNavButton(FButtons[i]).Role = Role then
    begin
      result := TElDBTreeNavButton(FButtons[i]);
      Break;
    end;
  end;
end;

function TElDBTreeNavigator.AddButton(Role : TElDBTreeNavButtonRole): TElDBTreeNavButton;
begin
  if Role <> tnbrCustom then
    Result := FindButtonByRole(Role)
  else
    Result := nil;

  if Result = nil then
  begin
    Result := TElDBTreeNavButton(inherited AddButton(ebtButton));
    Result.Role := Role;
  end;
  CheckButtonsState;
end;

procedure TElDBTreeNavigator.AddButtons(const Roles : array of TElDBTreeNavButtonRole);
 var i:integer;
begin
    for i:=0 to High(Roles) do
      AddButton(Roles[i]);
    CheckButtonsState;
end;

function TElDBTreeNavigator.GetButtonClass: TElToolButtonClass;
begin
  Result := TElDBTreeNavButton;
end;

procedure TElDBTreeNavigator.SetIsToolbar(Value: Boolean);
var i : integer;
begin
  if FIsToolbar <> Value then
  begin
    FIsToolbar := Value;
    if (ComponentState * [csLoading, csReading, csDestroying] = []) then
    for i := 0 to FButtons.Count - 1 do
    begin
      TElToolButton(FButtons[i]).Invalidate;
    end;
  end;
end;

destructor TElDBTreeNavigator.Destroy;
begin
  FTree := nil;
  FIntImageList.Free;
  FIntImageList := nil;
  inherited;
end;

procedure TElDBTreeNavigator.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and Assigned(FTree) and
    (AComponent = ElDBXTree) then ElDBXTree := nil;
end;

procedure TElDBTreeNavigator.Loaded;
begin
  inherited;
  CheckButtonsState;
end;

procedure TElDBTreeNavigator.CMControlChange(var Msg : TCMControlChange);

begin
  inherited;
  CheckButtonsState;
end;

procedure TElDBTreeNavigator.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  CheckButtonsState;
end;

procedure TElDBTreeNavigator.CheckButtonsState;
var
  I: integer;
//  AButton   : TElDBTreeNavButton;
begin
  if ButtonCount=0 then
    exit;
  for i := FButtons.Count - 1 DownTo 0 do
  begin
    CustomToolButton[i].Enabled := (Assigned(FTree));
//    if (CustomToolButton[i] is TElDBTreeNavButton) then
//    begin
//      AButton := CustomToolButton[i] as TElDBTreeNavButton;
//   tnbrFirstRootItem, tnbrFirst, tnbrPrior, tnbrNext, tnbrLast, tnbrLastRootItem,
//   tnbrInsert, tnbrInsertChild, tnbrDelete, tnbrEdit, tnbrPost,tnbrCancel, tnbrRefresh, tnbrCustom
//     if Assigned(FTree) and Assigned(FTree.Selected) then
//       case AButton.Role of
//         tnbrFirstRootItem, tnbrPrior: AButton.Enabled := (FTree.Selected.AbsoluteIndex <> 0);
//         tnbrFirst: AButton.Enabled := (FTree.Selected.Index <> 0);
//         tnbrNext, tnbrLastRootItem: AButton.Enabled := (FTree.Selected.GetNextSibling <> nil);
//       end;
//    end;
  end;
end;

procedure TElDBTreeNavigator.ScrollTree;
var
  i, j : integer;
  it, it1, pr : TElDBXTreeItem;
begin
  if not Assigned(FTree) then
    exit;
  if Assigned(FTree.Selected) then
  begin
    i := FTree.IndexInView(FTree.Selected);
    if (i<0) then
//      VScrollBar.Position := max(0,MSender.VScrollBar.Position - 1);
      with FTree.Selected do
      begin
        i := Index;
        if Level = 0 then
          FTree.VScrollBar.Position := Index
        else
        begin
          it := FTree.Items.GetFirstNode;
          pr := Parent;
          if pr.Level <> 0 then
            pr := pr.Parent;
          for j := 1 to Pr.Index do
          begin
            if it.Expanded then
            begin
              it1 := it.GetFirstChild;
              if Assigned(it1) and (it1.ChildrenCount <> 0) then
                i := i + it1.ChildrenCount + 1
              else
                i := i + it.ChildrenCount + 1;
            end
            else
              i := i + 1;
            it := it.GetNextSibling;
          end;
          FTree.VScrollBar.Position := i;
        end;
      end;
  end;
end;

function TElDBTreeNavigator.GetTree: TCustomElDBXTree;
begin
  Result := FTree;
  CheckButtonsState;
end;

procedure TElDBTreeNavigator.SetTree(Value: TCustomElDBXTree);
begin
  FTree := Value;
//  if Value <> nil then Value.FreeNotification(Self);
  CheckButtonsState;
end;

procedure TElDBTreeNavButton.SetUseCustomImage(Value: Boolean);
begin
  FUseCustomImages := Value;
  if Value then
  begin
    Images := TElDBTreeNavigator(Parent).Images;
  end
  else
  begin
    inherited SetImageIndex(integer(FRole));
    inherited SetImageList(TElDBTreeNavigator(Parent).FIntImageList);
    inherited SetUseImageList(true);
  end;
end;

initialization

  FGlyphBitmap := TBitmap.Create;
  FGlyphBitmap.LoadFromResourceName(HInstance, 'ELDBTREENAVBUTTONS');
  finalization
  try
    FGlyphBitmap.Free;
  except
    on e:Exception do
    begin
      LMDDebug('ERROR finalization ElDBTreeNavigator: ' + e.Message);
    end;
  end;

end.
