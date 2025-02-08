unit ElXTreeCellCombo;
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

ElXTreeCell unit
----------------


Changes
-------
Release 7.0 ()
 - Initial Release

###############################################################################}

interface

uses
  Classes,
  Controls,
  Math,
  Windows,
  Graphics,
  StdCtrls,
  Types,
  Themes,

  LMDTypes,
  LMDHTMLUnit,
{$ifdef LMD_UNICODE}
  LMDUnicodeStrings,
{$else}
  LMDStrings,
{$endif}
  LMDGraphUtils,
  LMDGraph,
  LMDCLass, 
  LMDThemes,
  LMDProcs,

  ElHeader,
  ElTreeInplaceEditors,
  ElXTree,
  ElXTreeCell,
  ElTreeComboBox;

type
  {$IFDEF LMD_UNICODE}
  TElItemsStrings = class(TLMDWideStringList);
  {$ELSE}
  TElItemsStrings = class(TStringList);
  {$ENDIF}

  TElXCellComboBox = class(TElXCellControl)
  private
    function GetText: TLMDString;
    procedure SetText(const Value: TLMDString);
  protected
    FArrRect: TRect;
    FItemIndex: Integer;
    FDropDownWidth: Integer;
    FAutoCompletion: Boolean;
    FStyle: TComboBoxStyle;
    FIsHTML: Boolean;
    FText: TLMDString;
    FItems: TLMDStrings;
    FMouseOverArrow: Boolean;
    FCell: TElXCustomTreeCell;
    FOnChange: TNotifyEvent;
    FOnDropDown: TNotifyEvent;
    FOnCloseUp: TNotifyEvent;

    procedure SetItems(Value: TLMDStrings);
    procedure SetItemIndex(Value: Integer);
    procedure InternalChange(Sender: TObject);
    procedure TranslateOnDropDown(Sender: TObject);
    procedure TranslateOnCloseUp(Sender: TObject);
  public
    procedure SetControlActive; override;
    procedure TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure TriggerMouseMoveEvent(Shift: TShiftState; X, Y: Integer); override;
    procedure Assign(Source: TElXCellControl); override;
    constructor Create; override;
    destructor Destroy; override;
    procedure Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect); override;
  published
    property Items: TLMDStrings read FItems write SetItems;
    property Text: TLMDString read GetText write SetText;
    property ItemIndex: Integer read FItemIndex write SetItemIndex default -1;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnDropDown: TNotifyEvent read FOnDropDown write FOnDropDown;
    property OnCloseUp: TNotifyEvent read FOnCloseUp write FOnCloseUp;
    property DropDownWidth: Integer read FDropDownWidth write FDropDownWidth;
    property AutoCompletion: Boolean read FAutoCompletion write FAutoCompletion;
    property Style: TComboBoxStyle read FStyle write FStyle;
    property IsHTML: Boolean read FIsHTML write FIsHTML;
  end;

  TElXCellCombpInplaceCombo = class(TElTreeInplaceComboBox)
  public
    procedure CompleteOperation(Accepted: boolean); override;
  end;

var
  HelperInplaceCombo: TElXCellCombpInplaceCombo;

implementation

type
  THCustomElXTree = class(TCustomElXTree);
  THElXTreeView = class(TElXTreeView);
  THElXTreeItem = class(TElXTreeItem);
  THElXTreeCell = class(TElXCustomTreeCell);

constructor TElXCellComboBox.Create;
begin
  inherited;
  FItems := TElItemsStrings.Create;
  FItemIndex := -1;
  FStyle := csDropDownList;
  FIsHTML := False;
end; 

destructor TElXCellComboBox.Destroy;
begin
  FItems.Free;
  inherited;
end;

procedure TElXCellComboBox.Assign(Source: TElXCellControl);
begin
  if Source is TElXCellComboBox then
  begin
    with Source as TElXCellComboBox do
    begin
      Self.Items := Items;
      Self.ItemIndex := ItemIndex;
      Self.DropDownWidth := DropDownWidth;
      Self.AutoCompletion := AutoCompletion;
      Self.Style := Style;
      Self.IsHTML := IsHTML;
      Self.Text := Text;
      Self.OnChange := OnChange;
      Self.OnDropDown := OnDropDown;
      Self.OnCloseUp := OnCloseUp;
    end;
    inherited;
  end;
end;

procedure TElXCellComboBox.TriggerMouseUpEvent(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetControlActive;
end;

procedure TElXCellComboBox.Paint(ACell: TElXCustomTreeCell; Canvas: TCanvas; R: TRect);
var
  LTree: THCustomElXTree;
  BtnRect: TRect;
  LRender : TLMDHTMLRender;
  LUseThemeMode: TLMDThemeMode;
  LDetails: TThemedElementDetails;
  procedure DrawThemedButton(ARect: TRect);
  var
    // FTheme   : HTheme;
    // sid      : integer;
    LDetail: TThemedComboBox;
  begin
    // FTheme := LMDThemeService.Theme[tiComboBox];
    if not Enabled then
      // sid := CBXS_DISABLED
      LDetail := tcDropDownButtonDisabled
    else
      if FMouseOverArrow then
        // sid := CBXS_HOT
        LDetail := tcDropDownButtonHot
      else
        // sid := CBXS_NORMAL;
        LDetail := tcDropDownButtonNormal;
    LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetail, ARect, LMDRectToPtr(ARect));

  end;

  procedure DrawNotThemedButton(ARect: TRect);
  var
    LDrawFlags: Integer;
  begin
    Canvas.Brush.Color := LTree.Color;
    Canvas.FillRect(ARect);
    LDrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
    if LTree.Flat then
    DrawEdge(Canvas.Handle, ARect, BDR_RAISEDINNER, BF_RECT)
    else
      DrawFrameControl(Canvas.Handle, ARect, DFC_BUTTON, LDrawFlags);
    LMDDrawArrow(Canvas, eadDown, ARect, clBlack, Enabled);
  end;

begin

  LTree := THCustomElXTree((ACell.GetOwner as TElXTreeItem).Owner);

  LUseThemeMode := LTree.UseThemeMode;
  if not Assigned(FCell) then
  begin
    FCell := ACell;
    ACell.Text := FText;
  end;

  if not LTree.VerticalLines then
  InflateRect(R, -1, -1);
  Dec(R.Right);
  BtnRect := R;
  Dec(BtnRect.Right, 2);

  BtnRect.Left := BtnRect.Right - GetSystemMetrics(SM_CYHSCROLL);
  InflateRect(BtnRect, 0, -2);
  FArrRect := BtnRect;
  OffsetRect(FArrRect, ACell.CellRect.Left, ACell.CellRect.Top);

  if LUseThemeMode <> ttmNone then
  begin
    LDetails.Element := teComboBox;
    LDetails.Part := 0;
    LDetails.State := 0;
    LMDThemeServices.DrawElement(LUseThemeMode, Canvas.Handle, LDetails, R, LMDRectToPtr(R));

    if THElXTreeCell(ACell).Selected then
    begin
      InflateRect(R, -1, -1);
      Canvas.Brush.Color := LTree.FocusedSelectColor;
      Canvas.FillRect(R);
      InflateRect(R, 1, 1);
    end;
    DrawThemedButton(BtnRect)
  end
  else
  begin
    Canvas.Brush.Color := clBtnFace;
    Canvas.Brush.Style := bsSolid;
    FrameRect(Canvas.Handle, R, Canvas.Brush.Handle);
    DrawNotThemedButton(BtnRect);
  end;

  R.Right := BtnRect.Left;
  inc(R.Left, 3);
  Canvas.Brush.Style := bsClear;
  if not IsHTML then
  begin
    inc(R.Top, 4);
    LMDDrawText(Canvas.Handle, Text, Length(Text), R, DT_LEFT or DT_BOTTOM or DT_NOPREFIX);
  end
  else
  begin
    inc(R.Top, 2);
    LRender := LTree.View.Render;
    LRender.Data.DefaultBgColor := clNone;

    LRender.Data.DefaultStyle := Font.Style;
    LRender.Data.DefaultHeight:= Font.Height;
    LRender.Data.DefaultFont := Font.Name;
    LRender.Data.Charset := Font.Charset;
    LRender.Data.LinkColor := LTree.LinkColor;
    LRender.Data.LinkStyle := LTree.LinkStyle;
    if THElXTreeCell(ACell).Selected then
      LRender.Data.DefaultColor := LTree.FocusedSelectTextColor
    else
      LRender.Data.DefaultColor := LTree.TextColor;
    //    if WordWrap then
//      LRender.PrepareText(Text, ClientWidth, True)
//    else
      LRender.PrepareText(Text, 0, false);
    LRender.DrawText(Canvas, Point(0, 0), R, LRender.Data.DefaultBgColor);
  end;
end; {Paint}

procedure TElXCellComboBox.SetItems(Value: TLMDStrings);
begin
  FItems.Assign(Value);
end;

procedure TElXCellComboBox.SetItemIndex(Value: Integer);
begin
  if (Value <> FItemIndex) and InRange(Value, 0, Items.Count - 1) then
  begin
    FItemIndex := Value;
    Text := Items.Strings[FItemIndex];
    Update;
  end;
end;

procedure TElXCellComboBox.TriggerMouseMoveEvent(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  FMouseOverArrow := (InRange(X, FArrRect.Left, FArrRect.Right) and InRange(Y, FArrRect.Top, FArrRect.Bottom));
  Update;
end;

procedure TElXCellComboBox.SetControlActive;
var
  LTree: THCustomElXTree;
  R: TRect;
begin

  LTree := THCustomElXTree((FCell.GetOwner as TElXTreeItem).Owner);
  if THElXTreeView(LTree.View).FInpEdit <> nil then
    THElXTreeView(LTree.View).DoEndEdit(True);

  if not Assigned(HelperInplaceCombo) then
    HelperInplaceCombo := TElXCellCombpInplaceCombo.Create(nil);
  HelperInplaceCombo.Editor.UseXPThemes := LTree.UseXPThemes;
  HelperInplaceCombo.Editor.Items.Assign(FItems);
  HelperInplaceCombo.ValueAsText := Text;
  HelperInplaceCombo.Item := (FCell.GetOwner as TElXTreeItem);
  HelperInplaceCombo.Editor.ItemIndex := ItemIndex;
  HelperInplaceCombo.Editor.OnChange := InternalChange;
  HelperInplaceCombo.Editor.OnCloseUp := TranslateOnCloseUp;
  HelperInplaceCombo.Editor.OnDropDown := TranslateOnDropDown;
  HelperInplaceCombo.Editor.DropDownWidth := DropDownWidth;
  HelperInplaceCombo.Editor.AutoCompletion := AutoCompletion;
  HelperInplaceCombo.Editor.IsHTML := IsHTML;
  if IsHTML then
    HelperInplaceCombo.Editor.Style := csOwnerDrawVariable
  else
    HelperInplaceCombo.Editor.Style := Style;
  HelperInplaceCombo.Tree := LTree;
  THElXTreeView(LTree.View).FInpEdit := HelperInplaceCombo;
  THElXTreeView(LTree.View).FEditingItem := (FCell.GetOwner as TElXTreeItem);
  HelperInplaceCombo.SectionIndex := FCell.Index;
  HelperInplaceCombo.Datatype := sftEnum;
  R := FCell.CellRect;
  dec(R.Bottom, 1);
  dec(R.Right, 1);
  HelperInplaceCombo.CellRect := R;
  if FMouseOverArrow then
    HelperInplaceCombo.InitiallyDropped := True
  else
    HelperInplaceCombo.InitiallyDropped := False;
  HelperInplaceCombo.StartOperation;
end;

function TElXCellComboBox.GetText: TLMDString;
begin
  if Assigned(FCell) then
    Result := FCell.Text
  else
    Result := FText;
end;

procedure TElXCellComboBox.SetText(const Value: TLMDString);
begin
  FText := Value;
  if Assigned(FCell) then
    FCell.Text := Value;
end;

procedure TElXCellComboBox.InternalChange(Sender: TObject);
begin
  if Assigned(HelperInplaceCombo) then
  begin
    FCell.Text := HelperInplaceCombo.Editor.Text;
    FItemIndex := HelperInplaceCombo.Editor.ItemIndex;
  end;
  if Assigned(FOnChange) then
    FOnChange(Sender);
end;

procedure TElXCellComboBox.TranslateOnCloseUp(Sender: TObject);
begin
  if Assigned(FOnCloseUp) then
    FOnCloseUp(Sender);
end;

procedure TElXCellComboBox.TranslateOnDropDown(Sender: TObject);
begin
  if Assigned(FOnDropDown) then
    FOnDropDown(Sender);
end;

{ TElXCellCombpInplaceCombo }

procedure TElXCellCombpInplaceCombo.CompleteOperation(Accepted: boolean);
begin
  inherited;
  Tree := nil;
end;

initialization

finalization
  if Assigned(HelperInplaceCombo) then
    HelperInplaceCombo.Free;

end.
