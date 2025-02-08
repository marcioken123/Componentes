unit LMDTagEditor;
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

LMDTagEditor unit (AH)
----------------------

Changes
-------
Release 11.00 (October 2011)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, SysUtils, Controls, Graphics, Themes, Messages, LMDTypes, LMDFlowPanel, LMDEdit, LMDThemes, LMDClass,
  LMDFigures, LMDFillers, LMDCustomControl, LMDBaseControl, LMDGraph, LMDGradientFrames, LMDProcs, LMDGraphUtils,
  LMDCustomSpeedButton, LMDButtonBase, LMDGlyph, LMDMain, LMDFXCaption, LMDButtonLayout;

type
  TLMDTagControl = class(TLMDCustomSpeedButton)
  private
    FMouseOnGlyph: Boolean;
  protected
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure InformOptionSet; override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TLMDTag = class (TCollectionItem)
  private
    FHint: String;
    FCaption: String;
    FTagControl: TLMDTagControl;
    function GetPressed: Boolean;
    procedure SetHint(const Value: String);
    procedure SetPressed(const Value: Boolean);
    procedure SetTagControl(const Value: TLMDTagControl);
    procedure SetText(const Value: String);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property TagControl: TLMDTagControl read FTagControl write SetTagControl;
  published
    property Text: String read FCaption write SetText;
    property Hint: String read FHint write SetHint;
    property Pressed: Boolean read GetPressed write SetPressed default false;
//    property Enabled : Boolean read FEnabled write SetEnabled default true;
  end;

  TLMDTags = class (TCollection)
  private
    FOwner  : TWinControl;
    FOnChange:TNotifyEvent;
    FCaseSensetive: Boolean;
    function GetItem(Index: Integer): TLMDTag;
    procedure SetItem(Index: Integer; Value: TLMDTag);
    function GetItemControl(Index: Integer): TLMDTagControl;
  protected
    procedure Change;
    function GetOwner: TPersistent; override;
//    procedure Update(Item: TCollectionItem); override;
  public
    constructor Create(Owner : TWinControl);
    destructor Destroy; override;
    function Add: TLMDTag;
    function IndexOf(const ASearch: TLMDString): integer;
    function IndexOfObject(const AObject: TLMDTagControl): integer;
    property Items[Index: Integer]: TLMDTag read GetItem write SetItem;
    property Objects[Index: Integer]: TLMDTagControl read GetItemControl;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property CaseSensitive: Boolean read FCaseSensetive write FCaseSensetive;
  end;

  TLMDTagProperties = class(TPersistent)
  private
    FLayout: TLMDButtonLayout;
    FOnChanged: TNotifyEvent;
    FThemeMode: TLMDThemeMode;
    FFontFX: TLMDFXCaption;
    FFont: TFont;
    FCursor: TCursor;
    FStyle: TLMDUserButtonStyle;
    procedure SetCursor(const Value: TCursor);
    procedure SetFont(const Value: TFont);
    procedure SetFontFX(const Value: TLMDFXCaption);
    procedure SetLayout(const Value: TLMDButtonLayout);
    procedure SetOnChanged(const Value: TNotifyEvent);
    procedure SetStyle(const Value: TLMDUserButtonStyle);
    procedure SetThemeMode(const Value: TLMDThemeMode);
  protected
    procedure AssignTo(AObject: TPersistent); override;
    procedure Changed;
    property OnChanged: TNotifyEvent read FOnChanged write SetOnChanged;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Style: TLMDUserButtonStyle read FStyle write SetStyle;
    property Cursor: TCursor read FCursor write SetCursor default crArrow;
    property Layout: TLMDButtonLayout read FLayout write SetLayout;
    property Font: TFont read FFont write SetFont;
    property FontFX: TLMDFXCaption read FFontFX write SetFontFX;
    property ThemeMode: TLMDThemeMode read FThemeMode write SetThemeMode default ttmNone;
  end;

  TLMDTagEditor = class(TLMDCustomFlowPanel)
  private
    FMinEditorWidth: Integer;
    FDisableCorrectWidth: Boolean;
    FDeleteGlyph: TBitmap;
    FDeleteHighlightGlyph: TBitmap;
    FSelectDuplicatedTags: Boolean;
    FMultiselect: Boolean;
    FTagProperties: TLMDTagProperties;
    procedure CorrectEditorWidth;
    procedure SetMinEditorWidth(const Value: Integer);
    function CreateTagControl(const ATag: string): TLMDTagControl;
    procedure SetupMinEditorWidth;
    procedure SetMultiselect(const Value: Boolean);
    procedure SetGlyphDelete(const Value: TBitmap);
    procedure SetGlyphDeleteHighlight(const Value: TBitmap);
  protected
    FTag: TLMDTagControl;
//    FTags: TLMDMemoryStrings;
    FTags: TLMDTags;
    FEditor: TLMDEdit;
    procedure SetCaseSensetive(const Value: Boolean);
    function GetCaseSensetive: Boolean;

    procedure Paint; override;
    procedure DoEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Resize; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddTag(const ATag: string): boolean; virtual;
    function RemoveTag(const ATag: string): boolean; overload; virtual;
    function RemoveTag(const ATag: TLMDTagControl): boolean; overload; virtual;
    function RemoveTag(const ATagIndex: integer): boolean; overload; virtual;
    function SelectTag(const ATag: string): Boolean; overload; virtual;
    function SelectTag(const ATag: TLMDTagControl): boolean; overload; virtual;
    function SelectTag(const ATagIndex: integer): Boolean; overload; virtual;
  published
    property CaseSensetive: Boolean read GetCaseSensetive write SetCaseSensetive default false;
    property MinEditorWidth: Integer read FMinEditorWidth write SetMinEditorWidth default 20;
    property SelectDuplicatedTags: Boolean read FSelectDuplicatedTags write FSelectDuplicatedTags default false;
    property Multiselect: Boolean read FMultiselect write SetMultiselect;
    property GlyphDelete: TBitmap read FDeleteGlyph write SetGlyphDelete;
    property GlyphDeleteHighlight: TBitmap read FDeleteHighlightGlyph write SetGlyphDeleteHighlight;
    property TagProperties: TLMDTagProperties read FTagProperties;
    property Tags: TLMDTags read FTags;
    property BorderMargins;
    property ControlsPaddingX;
    property ControlsPaddingY;
  end;

implementation

{ TLMDTagEditor }

function TLMDTagEditor.AddTag(const ATag: string): boolean;
begin
  if FTags.IndexOf(ATag) = -1 then
  begin
    SetupMinEditorWidth;
//    FTags.AddObject(ATag, CreateTagControl(ATag));
    CreateTagControl(ATag);
    CorrectEditorWidth;
    Result := True;
  end
  else
    Result := false;
end;

function TLMDTagEditor.RemoveTag(const ATag: string): boolean;
begin
  Result := RemoveTag(FTags.IndexOf(ATag));
end;

function TLMDTagEditor.RemoveTag(const ATag: TLMDTagControl): boolean;
begin
  Result := RemoveTag(FTags.IndexOfObject(ATag));
end;

function TLMDTagEditor.RemoveTag(const ATagIndex: integer): boolean;
var
  LTag: TLMDTagControl;
begin
  Result := false;
  if (ATagIndex >= 0) and (ATagIndex < FTags.Count) then
  begin
    SetupMinEditorWidth;
    LTag := TLMDTagControl(FTags.Objects[ATagIndex]);
    LTag.Free;
    FTags.Delete(ATagIndex);
    CorrectEditorWidth;

    Result := true;
  end;
end;

procedure TLMDTagEditor.Resize;
begin
  inherited;
  if not FDisableCorrectWidth then
    CorrectEditorWidth;
end;

constructor TLMDTagEditor.Create(AOwner: TComponent);
begin
  inherited;
  AutoWrap := True;

  FTagProperties := TLMDTagProperties.Create;

  FEditor := TLMDEdit.Create(Self);
  FEditor.Parent := Self;
//  FEditor.Bevel.BorderSides := [];
//  FEditor.Bevel.EdgeStyle := etEtched;
//  FEditor.Bevel.Mode := bmEdge;

  FEditor.AutoSize := true;
  FEditor.Align := alNone;
  FEditor.OnKeyUp := DoEditorKeyUp;
  FMinEditorWidth := 20;

  FTags := TLMDTags.Create(Self);

  FDeleteGlyph := TBitmap.Create;
  FDeleteGlyph.LoadFromResourceName(HInstance, IDB_DELETETAG);

  FDeleteHighlightGlyph := TBitmap.Create;
  FDeleteHighlightGlyph.LoadFromResourceName(HInstance, IDB_DELETETAGH);

  FSelectDuplicatedTags := false;
end;

destructor TLMDTagEditor.Destroy;
begin
  FEditor.Free;
//  for i := 0 to FTags.Count - 1 do
//    FTags.Objects[i].Free;
  FTags.Free;
  FDeleteGlyph.Free;
  FDeleteHighlightGlyph.Free;
  FTagProperties.Free;
  inherited;
end;

procedure TLMDTagEditor.DoEditorKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  LTag: TLMDTagControl;
  i: Integer;
begin
  case Key of
  VK_RETURN:
    begin
      if FEditor.Text <> '' then
      begin
        if AddTag(FEditor.Text) then
          FEditor.Text := ''
        else
          if FSelectDuplicatedTags then
            SelectTag(FEditor.Text);
      end;
    end;
  VK_BACK:
    begin
      if (FEditor.Text = '') and (FTags.Count > 0) then
      begin
        LTag := TLMDTagControl(FTags.Objects[FTags.Count - 1]);
        if LTag.Down then
          RemoveTag(FTags.Count - 1) // last tag
        else
          LTag.Down := true;
      end;
    end;
  VK_DELETE:
    begin
      if FEditor.Text = '' then
      begin
        i := 0;
        while i < FTags.Count do
        begin
          if TLMDTagControl(FTags.Objects[i]).Down then
            RemoveTag(i)
          else
            inc(i);
        end;
      end;
    end;
  end;
end;

function TLMDTagEditor.GetCaseSensetive: Boolean;
begin
  Result := FTags.CaseSensitive;
end;

procedure TLMDTagEditor.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  FEditor.SetFocus;
end;

procedure TLMDTagEditor.Paint;
var
  box : TThemedEdit;
  LThemeMode: TLMDThemeMode;
begin
  LThemeMode := UseThemeMode;
  if LThemeMode <> ttmNone then
  begin
    box := teEditTextNormal;
    if Focused then
      box := teEditTextFocused;
    if MouseAbove then
      box := teEditTextHot;
    if GetReadOnly then
      box := teEditTextReadOnly;
    if not Enabled then
      box := teEditTextDisabled;
    LMDThemeServices.DrawElement(LThemeMode, Canvas.Handle, box, ClientRect);
  end
  else
    inherited;
end;

function TLMDTagEditor.SelectTag(const ATag: string): Boolean;
begin
  Result := SelectTag(FTags.IndexOf(ATag));
end;

function TLMDTagEditor.SelectTag(const ATag: TLMDTagControl): boolean;
begin
  Result := SelectTag(FTags.IndexOfObject(ATag));
end;

function TLMDTagEditor.SelectTag(const ATagIndex: integer): Boolean;
begin
  Result := false;
  if (ATagIndex >= 0) and (ATagIndex < FTags.Count) then
  begin
    TLMDTagControl(FTags.Objects[ATagIndex]).Down := true;
    Result := true;
  end;
end;

procedure TLMDTagEditor.SetupMinEditorWidth;
begin
  FDisableCorrectWidth := true;
  FEditor.Width := FMinEditorWidth;
  FDisableCorrectWidth := false;
end;

function TLMDTagEditor.CreateTagControl(const ATag: string): TLMDTagControl;
begin
  with FTags.Add do
  begin
    Text := ATag;
    Result := FTagControl;
  end;
end;

procedure TLMDTagEditor.CorrectEditorWidth;
begin
  FEditor.Width := (Width - FEditor.Left) - BorderMargins.Right;
end;

procedure TLMDTagEditor.SetCaseSensetive(const Value: Boolean);
begin
  FTags.CaseSensitive := Value;
end;

procedure TLMDTagEditor.SetGlyphDelete(const Value: TBitmap);
begin
  FDeleteGlyph.Assign(Value);
end;

procedure TLMDTagEditor.SetGlyphDeleteHighlight(const Value: TBitmap);
begin
  FDeleteHighlightGlyph.Assign(Value);
end;

procedure TLMDTagEditor.SetMinEditorWidth(const Value: Integer);
begin
  FMinEditorWidth := Value;
end;

procedure TLMDTagEditor.SetMultiselect(const Value: Boolean);
begin
  FMultiselect := Value;
end;

{ TLMDTagControl }

constructor TLMDTagControl.Create(AOwner: TComponent);
begin
  inherited;
end;

procedure TLMDTagControl.InformOptionSet;
begin
  if not TLMDTagEditor(Owner).FMultiselect then
    inherited;
end;

procedure TLMDTagControl.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if LMDPointInRect(Point(X, Y), FGlyphRect) then
  begin
    FMouseOnGlyph := true;
    Glyph.Assign(TLMDTagEditor(Owner).FDeleteHighlightGlyph);
    Invalidate;
  end
  else if (FMouseOnGlyph) then
  begin
    FMouseOnGlyph := false;
    Glyph.Assign(TLMDTagEditor(Owner).FDeleteGlyph);
    Invalidate;
  end;
end;

procedure TLMDTagControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if LMDPointInRect(Point(X, Y), FGlyphRect) then
    TLMDTagEditor(Owner).RemoveTag(Self);
end;

{ TLMDTagProperties }

procedure TLMDTagProperties.AssignTo(AObject: TPersistent);
begin
  if (AObject is TLMDTagControl) then
  begin
    with TLMDTagControl(AObject) do
    begin
      Cursor := FCursor;
      Font := FFont;
      FontFX := FFontFX;
      Layout := FLayout;
      Style := FStyle;
      ThemeMode := FThemeMode;
    end;
  end
  else
    inherited;
end;

procedure TLMDTagProperties.Changed;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

constructor TLMDTagProperties.Create;
begin
  inherited;
  FFontFX := TLMDFxCaption.Create(Self);
  FFontFX.OnChange := FOnChanged;
  FLayout := TLMDButtonLayout.Create(Self);
  FLayout.OnChange := FOnChanged;
  FFont := TFont.Create;
  FFont.OnChange := FOnChanged;
end;

destructor TLMDTagProperties.Destroy;
begin
  FFont.Free;
  FFontFX.Free;
  FLayout.Free;
  inherited;
end;

procedure TLMDTagProperties.SetCursor(const Value: TCursor);
begin
  if (FCursor <> Value) then
  begin
    FCursor := Value;
    Changed;
  end;
end;

procedure TLMDTagProperties.SetFont(const Value: TFont);
begin
  if (FFont <> Value) then
  begin
    FFont := Value;
    Changed;
  end;
end;

procedure TLMDTagProperties.SetFontFX(const Value: TLMDFXCaption);
begin
  if (FFontFX <> Value) then
  begin
    FFontFX := Value;
    Changed;
  end;
end;

procedure TLMDTagProperties.SetLayout(const Value: TLMDButtonLayout);
begin
  if (FLayout <> Value) then
  begin
    FLayout := Value;
    Changed;
  end;
end;

procedure TLMDTagProperties.SetOnChanged(const Value: TNotifyEvent);
begin
  FOnChanged := Value;
end;

procedure TLMDTagProperties.SetStyle(const Value: TLMDUserButtonStyle);
begin
  if (FStyle <> Value) then
  begin
    FStyle := Value;
    Changed;
  end;
end;

procedure TLMDTagProperties.SetThemeMode(const Value: TLMDThemeMode);
begin
  if (FThemeMode <> Value) then
  begin
    FThemeMode := Value;
    Changed;
  end;
end;

{ TLMDTag }

procedure TLMDTag.Assign(Source: TPersistent);
begin
  if (Source is TLMDTagControl) then
  begin
    with TLMDTagControl(Source) do
    begin
      FCaption := Caption;
      FHint := Hint;
      Pressed := Pressed;
    end;
  end
  else
    inherited;
end;

constructor TLMDTag.Create(Collection: TCollection);
var
  LOwner: TLMDTagEditor;
begin
  inherited Create(Collection);
  LOwner := TLMDTagEditor(TLMDTags(Collection).GetOwner);
  FCaption := 'LMDTag1';

  FTagControl := TLMDTagControl.Create(LOwner);
  FTagControl.Left := LOwner.FEditor.Left;
  FTagControl.Top := LOwner.FEditor.Top;
  FTagControl.Caption := FCaption;
  FTagControl.Glyph.Assign(LOwner.FDeleteGlyph);
  FTagControl.AutoSize := true;
  FTagControl.GroupIndex := 1;
  FTagControl.AllowAllUp := true;
  FTagControl.ButtonLayout.AlignText2Glyph := taLeft;
  LOwner.FTagProperties.AssignTo(FTagControl);
  FTagControl.Parent := LOwner;
  FTagControl.DrawGlyphAndText(FTagControl.Canvas, FTagControl.BoundsRect);
end;

destructor TLMDTag.Destroy;
begin

  inherited;
end;

function TLMDTag.GetPressed: Boolean;
begin
  Result := FTagControl.Pressed;
end;

procedure TLMDTag.SetHint(const Value: String);
begin
  FHint := Value;
  FTagControl.Hint := FHint;
end;

procedure TLMDTag.SetPressed(const Value: Boolean);
begin
  FTagControl.Pressed := Value;
end;

procedure TLMDTag.SetTagControl(const Value: TLMDTagControl);
begin
  FTagControl.Assign(FTagControl);
end;

procedure TLMDTag.SetText(const Value: String);
var
  LOwner: TLMDTagEditor;
begin
  LOwner := TLMDTagEditor(TLMDTags(Collection).GetOwner);
  FCaption := Value;
  LOwner.SetupMinEditorWidth;
  FTagControl.Text := FCaption;
  FTagControl.DrawGlyphAndText(FTagControl.Canvas, FTagControl.BoundsRect);
  LOwner.CorrectEditorWidth;
end;

{ TLMDTags }

function TLMDTags.Add: TLMDTag;
begin
  Result := TLMDTag(inherited Add);
end;

function TLMDTags.IndexOf(const ASearch: TLMDString): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
  begin
    if FCaseSensetive then
    begin
      if Items[i].Text = ASearch then
        Result := i;
    end
    else
    begin
      if UpperCase(Items[i].Text) = UpperCase(ASearch) then
        Result := i;
    end;
  end;
end;

function TLMDTags.IndexOfObject(const AObject: TLMDTagControl): integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if Items[i].FTagControl = AObject then
      Result := i;
end;

procedure TLMDTags.Change;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

constructor TLMDTags.Create(Owner: TWinControl);
begin
  inherited Create(TLMDTag);
  FOwner := Owner;
end;

destructor TLMDTags.Destroy;
begin
  FOwner := nil;
  inherited;
end;

function TLMDTags.GetItem(Index: Integer): TLMDTag;
begin
  Result := TLMDTag(inherited GetItem(Index));
end;

function TLMDTags.GetItemControl(Index: Integer): TLMDTagControl;
begin
  Result := GetItem(Index).FTagControl;
end;

function TLMDTags.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TLMDTags.SetItem(Index: Integer; Value: TLMDTag);
begin
  inherited SetItem(Index, Value);
end;

end.
