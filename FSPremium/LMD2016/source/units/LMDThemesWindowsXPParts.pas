unit LMDThemesWindowsXPParts;
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

LMDThemesWindowsXPParts unit (VB)
---------------------------------
Classes for theme parts


ToDo
----

Changes
-------
Release 8.0 (XX 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows, LMDTypes, LMDThemesGeneral, LMDThemesWindowsXP;

type
  TWindowsXPThemeButton = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeCheckBoxState = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeCheckBox = class(TWindowsXPThemePart)
  private
    FUncheckedDisabled: TWindowsXPThemeCheckBoxState;
    FCheckedDisabled: TWindowsXPThemeCheckBoxState;
    FMixedDisabled: TWindowsXPThemeCheckBoxState;
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  public
    constructor Create(Theme: TWindowsXPTheme;
      Parent: TWindowsXPThemePart; Section: string); override;
    destructor Destroy; override;
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      const Rect: TRect); override;
  end;

  TWindowsXPThemeComboBoxDropDown = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeComboBox = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeGroupBox = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeEditText = class(TWindowsXPThemePart)
  private
    FDisabled: TWindowsXPThemePart;
    FReadOnly: TWindowsXPThemePart;
  public
    constructor Create(Theme: TWindowsXPTheme;
      Parent: TWindowsXPThemePart; Section: string); override;
    destructor Destroy; override;
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      const Rect: TRect); override;
  end;

  TWindowsXPThemeEdit = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeExplorerBarButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeExplorerBar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeHeaderItem = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeHeader = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeListView = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemePushButtonDisabled = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemePushButton = class(TWindowsXPThemePart)
  private
    FDisabled: TWindowsXPThemePushButtonDisabled;
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  public
    constructor Create(Theme: TWindowsXPTheme;
      Parent: TWindowsXPThemePart; Section: string); override;
    destructor Destroy; override;
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      const Rect: TRect); override;
  end;

  TWindowsXPThemeProgress = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeScrollBarPart = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeScrollBarButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeScrollBarSizeBox = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeScrollBar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeSpinButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeSpin = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeRadioButtonDisabled = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeRadioButton = class(TWindowsXPThemePart)
  private
    FUncheckedDisabled: TWindowsXPThemeRadioButtonDisabled;
    FCheckedDisabled: TWindowsXPThemeRadioButtonDisabled;
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  public
    constructor Create(Theme: TWindowsXPTheme;
      Parent: TWindowsXPThemePart; Section: string); override;
    destructor Destroy; override;
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      const Rect: TRect); override;
  end;

  TWindowsXPThemeStatusPane = class(TWindowsXPThemePart)
  public
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); override;
    procedure GetThemeBackgroundExtent(DC: HDC; StateID: integer;
      const ContentRect: TRect; out ExtentRect: TRect); override;
  end;

  TWindowsXPThemeStatusGripper = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeStatus = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeTabPart = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  public
    procedure GetThemeBackgroundContentRect(DC: HDC; StateID: integer;
      const BoundingRect: TRect; out ContentRect: TRect); override;
  end;

  TWindowsXPThemeTab = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeToolbarPart = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeToolbar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeTrackBarThumb = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeTrackBarTics = class(TWindowsXPThemePart)
  public
    procedure DrawThemeBackground(DC: HDC; StateID: integer; const Rect: TRect;
      ClipRect: PRect); override;
  end;

  TWindowsXPThemeTrackBar = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeTreeViewGlyph = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeTreeView = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

  TWindowsXPThemeWindowFrame = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeWindowCaptionState = class;

  TWindowsXPThemeWindowCaption = class(TWindowsXPThemeWindowFrame)
  private
    FActive: TWindowsXPThemeWindowCaptionState;
    FInActive: TWindowsXPThemeWindowCaptionState;
  public
    constructor Create(Theme: TWindowsXPTheme;
      Parent: TWindowsXPThemePart; Section: string); override;
    destructor Destroy; override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      const Rect: TRect); override;
  end;

  TWindowsXPThemeWindowCaptionState = class(TWindowsXPThemeWindowFrame)
  public
    constructor Create(Theme: TWindowsXPTheme;
      Parent: TWindowsXPThemePart; Section: string); override;
    procedure DrawThemeText(DC: HDC; StateID: integer; Text: PLMDChar;
      CharCount: integer;  TextFlags: cardinal; TextFlags2: cardinal;
      const ARect: TRect); override;
  end;

  TWindowsXPThemeWindowButton = class(TWindowsXPThemePart)
  protected
    function GetStateRectIndex(StateID: integer): integer; override;
  end;

  TWindowsXPThemeWindow = class(TWindowsXPTheme)
  public
    constructor Create(Manager: TThemeManager); override;
  end;

implementation

uses
  UxTheme,
  LMDThemes,
  LMDThemesEngine,
  LMDThemesWindowsXPConsts, LMDThemesWindowsXPTypes;

{------------------ TWindowsXPThemeButton --------------------------------}
constructor TWindowsXPThemeButton.Create(Manager: TThemeManager);
var
  Part: TWindowsXPThemePart;
begin
  inherited;
  Part := TWindowsXPThemePushButton.Create(Self, nil, 'Button.PushButton');
  AddPart(BP_PUSHBUTTON, Part);
  Part := TWindowsXPThemeRadioButton.Create(Self, nil, 'Button.RadioButton');
  AddPart(BP_RADIOBUTTON, Part);
  Part := TWindowsXPThemeCheckBox.Create(Self, nil, 'Button.CheckBox');
  AddPart(BP_CHECKBOX, Part);
  Part := TWindowsXPThemeGroupBox.Create(Self, nil, 'Button.GroupBox');
  AddPart(BP_GROUPBOX, Part);
end;

{------------------ TWindowsXPThemeCheckBoxState --------------------------------}
function TWindowsXPThemeCheckBoxState.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBS_UNCHECKEDNORMAL) and (StateID <= CBS_MIXEDDISABLED) then
    Result := StateID - CBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeCheckBox --------------------------------}
constructor TWindowsXPThemeCheckBox.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FUncheckedDisabled := TWindowsXPThemeCheckBoxState.Create(Theme,
    Self, 'Button.CheckBox(UncheckedDisabled)');
  FCheckedDisabled := TWindowsXPThemeCheckBoxState.Create(Theme,
    Self, 'Button.CheckBox(CheckedDisabled)');
  FMixedDisabled := TWindowsXPThemeCheckBoxState.Create(Theme,
    Self, 'Button.CheckBox(MixedDisabled)');
end;

{------------------------------------------------------------------------------}
destructor TWindowsXPThemeCheckBox.Destroy;
begin
  FMixedDisabled.Free;
  FCheckedDisabled.Free;
  FUncheckedDisabled.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeCheckBox.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  case StateID of
    CBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    CBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    CBS_MIXEDDISABLED    : FMixedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
  else
    inherited;
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeCheckBox.DrawThemeText(DC: HDC; StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  const Rect: TRect);
begin
  case StateID of
    CBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    CBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    CBS_MIXEDDISABLED    : FMixedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
  else
    inherited;
  end;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeCheckBox.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBS_UNCHECKEDNORMAL) and (StateID <= CBS_MIXEDDISABLED) then
    Result := StateID - CBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeGroupBox --------------------------------}
function TWindowsXPThemeGroupBox.GetStateRectIndex(StateID: integer): integer;
begin
  Result := 0;
end;

{------------------ TWindowsXPThemeComboBoxDropDown --------------------------------}
function TWindowsXPThemeComboBoxDropDown.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBXS_NORMAL) and (StateID <= CBXS_DISABLED) then
    Result := StateID - CBXS_NORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeComboBox --------------------------------}
constructor TWindowsXPThemeComboBox.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'ComboBox');
  AddPart(0, Root);
  Part := TWindowsXPThemeComboBoxDropDown.Create(Self, Root, 'ComboBox.DropDownButton');
  AddPart(CP_DROPDOWNBUTTON, Part);
end;

{------------------ TWindowsXPThemeEdit --------------------------------}
constructor TWindowsXPThemeEdit.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Edit');
  AddPart(0, Root);
  Part := TWindowsXPThemeEditText.Create(Self, Root, 'Edit');
  AddPart(EP_EDITTEXT, Part);
end;

{------------------ TWindowsXPThemeEditText --------------------------------}
constructor TWindowsXPThemeEditText.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FDisabled := TWindowsXPThemePart.Create(Theme, Self, 'Edit.Edittext(Disabled)');
  FReadOnly := TWindowsXPThemePart.Create(Theme, Self, 'Edit.Edittext(ReadOnly)');
end;

{------------------------------------------------------------------------------}
destructor TWindowsXPThemeEditText.Destroy;
begin
  FReadOnly.Free;
  FDisabled.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeEditText.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  case StateID of
    ETS_DISABLED: if LMDThemeEngine.DisabledColorMode = scmNoChange then
                    inherited
                  else
                    FDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    ETS_READONLY: if LMDThemeEngine.ReadOnlyColorMode = scmNoChange then
                    inherited
                  else
                    FReadOnly.DrawThemeBackground(DC, StateID, Rect, ClipRect);
  else
    inherited;
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeEditText.DrawThemeText(DC: HDC; StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  const Rect: TRect);
begin
  case StateID of
    ETS_DISABLED: FDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    ETS_READONLY: FReadOnly.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
  else
    inherited;
  end
end;

{------------------ TWindowsXPThemeExplorerBar --------------------------------}
constructor TWindowsXPThemeExplorerBar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'ExplorerBar');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.HeaderBackground');
  AddPart(EBP_HEADERBACKGROUND, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.HeaderClose');
  AddPart(EBP_HEADERCLOSE, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.NormalGroupBackground');
  AddPart(EBP_NORMALGROUPBACKGROUND, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.NormalGroupCollapse');
  AddPart(EBP_NORMALGROUPCOLLAPSE, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.NormalGroupExpand');
  AddPart(EBP_NORMALGROUPEXPAND, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.NormalGroupHead');
  AddPart(EBP_NORMALGROUPHEAD, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.SpecialGroupBackground');
  AddPart(EBP_SPECIALGROUPBACKGROUND, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.SpecialGroupCollapse');
  AddPart(EBP_SPECIALGROUPCOLLAPSE, Part);
  Part := TWindowsXPThemeExplorerBarButton.Create(Self, Root, 'ExplorerBar.SpecialGroupExpand');
  AddPart(EBP_SPECIALGROUPEXPAND, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'ExplorerBar.SpecialGroupHead');
  AddPart(EBP_SPECIALGROUPHEAD, Part);
end;

{------------------ TWindowsXPThemeExplorerBarButton --------------------------------}
function TWindowsXPThemeExplorerBarButton.GetStateRectIndex(StateID: integer): integer;
begin
  case StateID of
    EBHC_NORMAL : Result := 0;
    EBHC_HOT    : Result := 1;
    EBHC_PRESSED: Result := 2;
  else
    Result := 0;
  end;
end;

{------------------ TWindowsXPThemeHeader --------------------------------}
constructor TWindowsXPThemeHeader.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Header');
  AddPart(0, Root);
  Part := TWindowsXPThemeHeaderItem.Create(Self, Root, 'Header.HeaderItem');
  AddPart(HP_HEADERITEM, Part);
  Part := TWindowsXPThemeHeaderItem.Create(Self, Root, 'Header.HeaderItem');
  AddPart(HP_HEADERITEMLEFT, Part);
  Part := TWindowsXPThemeHeaderItem.Create(Self, Root, 'Header.HeaderItem');
  AddPart(HP_HEADERITEMRIGHT, Part);
end;

{------------------ TWindowsXPThemeHeaderItem --------------------------------}
function TWindowsXPThemeHeaderItem.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID = HIS_NORMAL) or (StateID = HILS_NORMAL) or (StateID = HIRS_NORMAL) then
    Result := 0
  else
  if (StateID = HIS_HOT) or (StateID = HILS_HOT) or (StateID = HIRS_HOT) then
    Result := 1
  else
  if (StateID = HIS_PRESSED) or (StateID = HILS_PRESSED) or (StateID = HIRS_PRESSED) then
    Result := 2
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeListView --------------------------------}
constructor TWindowsXPThemeListView.Create(Manager: TThemeManager);
var
  Part: TWindowsXPThemePart;
begin
  inherited;
  Part := TWindowsXPThemePart.Create(Self, nil, 'ListView');
  AddPart(0, Part);
end;

{------------------ TWindowsXPThemeProgress --------------------------------}
constructor TWindowsXPThemeProgress.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Progress');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.Bar');
  AddPart(PP_BAR, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.BarVert');
  AddPart(PP_BARVERT, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.Chunk');
  AddPart(PP_CHUNK, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Progress.ChunkVert');
  AddPart(PP_CHUNKVERT, Part);
end;

{------------------ TWindowsXPThemePushButtonDisabled --------------------------------}
function TWindowsXPThemePushButtonDisabled.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= PBS_NORMAL) and (StateID <= PBS_DEFAULTED) then
    Result := StateID - PBS_NORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemePushButton --------------------------------}
constructor TWindowsXPThemePushButton.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FDisabled := TWindowsXPThemePushButtonDisabled.Create(Theme, Self,
    'Button.PushButton(Disabled)');
end;

{------------------------------------------------------------------------------}
destructor TWindowsXPThemePushButton.Destroy;
begin
  FDisabled.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePushButton.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  if StateID = PBS_DISABLED then
    FDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect)
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemePushButton.DrawThemeText(DC: HDC;
  StateID: integer; Text: PLMDChar; CharCount: integer; TextFlags,
  TextFlags2: cardinal; const Rect: TRect);
begin
  if StateID = PBS_DISABLED then
    FDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect)
  else
    inherited;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemePushButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= PBS_NORMAL) and (StateID <= PBS_DEFAULTED) then
    Result := StateID - PBS_NORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeRadioButtonDisabled --------------------------------}
function TWindowsXPThemeRadioButtonDisabled.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= RBS_UNCHECKEDNORMAL) and (StateID <= RBS_CHECKEDDISABLED) then
    Result := StateID - RBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeRadioButton --------------------------------}
constructor TWindowsXPThemeRadioButton.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FUncheckedDisabled := TWindowsXPThemeRadioButtonDisabled.Create(Theme,
    Self, 'Button.RadioButton(UncheckedDisabled)');
  FCheckedDisabled := TWindowsXPThemeRadioButtonDisabled.Create(Theme,
    Self, 'Button.RadioButton(CheckedDisabled)');
end;

{------------------------------------------------------------------------------}
destructor TWindowsXPThemeRadioButton.Destroy;
begin
  FCheckedDisabled.Free;
  FUncheckedDisabled.Free;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeRadioButton.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
begin
  case StateID of
    RBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
    RBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeBackground(DC, StateID, Rect, ClipRect);
  else
    inherited;
  end;
end;

{------------------------------------------------------------------------------}
procedure TWindowsXPThemeRadioButton.DrawThemeText(DC: HDC;
  StateID: integer; Text: PLMDChar; CharCount: integer; TextFlags,
  TextFlags2: cardinal; const Rect: TRect);
begin
  case StateID of
    RBS_UNCHECKEDDISABLED: FUncheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    RBS_CHECKEDDISABLED  : FCheckedDisabled.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
  else
    inherited;
  end;
end;

{------------------------------------------------------------------------------}
function TWindowsXPThemeRadioButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= RBS_UNCHECKEDNORMAL) and (StateID <= RBS_CHECKEDDISABLED) then
    Result := StateID - RBS_UNCHECKEDNORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeScrollBar --------------------------------}
constructor TWindowsXPThemeScrollBar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemeScrollBarPart.Create(Self, nil, 'ScrollBar');
  AddPart(0, Root);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.LowerTrackHorz');
  AddPart(SBP_LOWERTRACKHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.LowerTrackVert');
  AddPart(SBP_LOWERTRACKVERT, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.ThumbBtnHorz');
  AddPart(SBP_THUMBBTNHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.ThumbBtnVert');
  AddPart(SBP_THUMBBTNVERT, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.UpperTrackHorz');
  AddPart(SBP_UPPERTRACKHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.UpperTrackVert');
  AddPart(SBP_UPPERTRACKVERT, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.GripperHorz');
  AddPart(SBP_GRIPPERHORZ, Part);
  Part := TWindowsXPThemeScrollBarPart.Create(Self, Root, 'ScrollBar.GripperVert');
  AddPart(SBP_GRIPPERVERT, Part);
  Part := TWindowsXPThemeScrollBarButton.Create(Self, Root, 'ScrollBar.ArrowBtn');
  AddPart(SBP_ARROWBTN, Part);
  Part := TWindowsXPThemeScrollBarSizeBox.Create(Self, Root, 'ScrollBar.SizeBox');
  AddPart(SBP_SIZEBOX, Part);
end;

{------------------ TWindowsXPThemeScrollBarPart --------------------------------}
function TWindowsXPThemeScrollBarPart.GetStateRectIndex(StateID: integer): integer;
begin
  case StateID of
    SCRBS_NORMAL  : Result := 0;
    SCRBS_HOT     : Result := 1;
    SCRBS_PRESSED : Result := 2;
    SCRBS_DISABLED: Result := 3;
  else
    Result := 0;
  end;
end;

{------------------ TWindowsXPThemeScrollBarButton --------------------------------}
function TWindowsXPThemeScrollBarButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= ABS_UPNORMAL) and (StateID <= ABS_RIGHTDISABLED) then
    Result := StateID - ABS_UPNORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeScrollBarSizeBox --------------------------------}
function TWindowsXPThemeScrollBarSizeBox.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = SZB_LEFTALIGN then
    Result := 1
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeSpin --------------------------------}
constructor TWindowsXPThemeSpin.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Spin');
  AddPart(0, Root);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.Up');
  AddPart(SPNP_UP, Part);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.Down');
  AddPart(SPNP_DOWN, Part);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.UpHorz');
  AddPart(SPNP_UPHORZ, Part);
  Part := TWindowsXPThemeSpinButton.Create(Self, Root, 'Spin.DownHorz');
  AddPart(SPNP_DOWNHORZ, Part);
end;

{------------------ TWindowsXPThemeSpinButton --------------------------------}
function TWindowsXPThemeSpinButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID = UPS_NORMAL) or (StateID = DNS_NORMAL) or
     (StateID = UPHZS_NORMAL) or (StateID = DNHZS_NORMAL) then
    Result := 0
  else
  if (StateID = UPS_HOT) or (StateID = DNS_HOT) or
     (StateID = UPHZS_HOT) or (StateID = DNHZS_HOT) then
    Result := 1
  else
  if (StateID = UPS_PRESSED) or (StateID = DNS_PRESSED) or
     (StateID = UPHZS_PRESSED) or (StateID = DNHZS_PRESSED) then
    Result := 2
  else
  if (StateID = UPS_DISABLED) or (StateID = DNS_DISABLED) or
     (StateID = UPHZS_DISABLED) or (StateID = DNHZS_DISABLED) then
    Result := 3
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeStatusGripper --------------------------------}
function TWindowsXPThemeStatusGripper.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = SZB_LEFTALIGN then
    Result := 1
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeStatus --------------------------------}
constructor TWindowsXPThemeStatus.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Status');
  AddPart(0, Root);
  Part := TWindowsXPThemeStatusPane.Create(Self, Root, 'Status.Pane');
  AddPart(SP_PANE, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Status.GripperPane');
  AddPart(SP_GRIPPERPANE, Part);
  Part := TWindowsXPThemeStatusGripper.Create(Self, Root, 'Status.Gripper');
  AddPart(SP_GRIPPER, Part);
end;

{------------------ TWindowsXPThemeStatusPane --------------------------------------}
procedure TWindowsXPThemeStatusPane.GetThemeBackgroundContentRect(DC: HDC;
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Margins: TXPMargins;
begin
  ContentRect := BoundingRect;
  if Defined[TPP_SIZING_MARGINS] then
  begin
    Margins := MarginsProp[TPP_SIZING_MARGINS];
    Inc(ContentRect.Left, Margins.cxLeftWidth);
    Inc(ContentRect.Top, Margins.cyTopHeight);
    Dec(ContentRect.Right, Margins.cxRightWidth);
    Dec(ContentRect.Bottom, Margins.cyBottomHeight);
  end;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Inc(ContentRect.Left, Margins.cxLeftWidth);
    Inc(ContentRect.Top, Margins.cyTopHeight);
    Dec(ContentRect.Right, Margins.cxRightWidth);
    Dec(ContentRect.Bottom, Margins.cyBottomHeight);
  end;
end;

{----------------------------------------------------------------------------------}
procedure TWindowsXPThemeStatusPane.GetThemeBackgroundExtent(DC: HDC;
  StateID: integer; const ContentRect: TRect; out ExtentRect: TRect);
var
  Margins: TXPMargins;
begin
  ExtentRect := ContentRect;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Dec(ExtentRect.Left, Margins.cxLeftWidth);
    Dec(ExtentRect.Top, Margins.cyTopHeight);
    Inc(ExtentRect.Right, Margins.cxRightWidth);
    Inc(ExtentRect.Bottom, Margins.cyBottomHeight);
  end;
  if Defined[TPP_SIZING_MARGINS] then
  begin
    Margins := MarginsProp[TPP_SIZING_MARGINS];
    Dec(ExtentRect.Left, Margins.cxLeftWidth);
    Dec(ExtentRect.Top, Margins.cyTopHeight);
    Inc(ExtentRect.Right, Margins.cxRightWidth);
    Inc(ExtentRect.Bottom, Margins.cyBottomHeight);
  end;
end;

{------------------ TWindowsXPThemeTabPart ---------------------------------------}
function TWindowsXPThemeTabPart.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= TIS_NORMAL) and (StateID <= TIS_FOCUSED) then
    Result := StateID - TIS_NORMAL
  else
    Result := 0;
end;

{---------------------------------------------------------------------------------}
procedure TWindowsXPThemeTabPart.GetThemeBackgroundContentRect(DC: HDC;
  StateID: integer; const BoundingRect: TRect; out ContentRect: TRect);
var
  Margins: TXPMargins;
begin
  ContentRect := BoundingRect;
  if Defined[TPP_CONTENT_MARGINS] then
  begin
    Margins := MarginsProp[TPP_CONTENT_MARGINS];
    Inc(ContentRect.Left, Margins.cxLeftWidth);
    Inc(ContentRect.Top, Margins.cyTopHeight);
    Dec(ContentRect.Right, Margins.cxRightWidth);
    Dec(ContentRect.Bottom, Margins.cyBottomHeight);
  end
  else
  if Defined[TPP_SIZING_MARGINS] then
  begin
    Margins := MarginsProp[TPP_SIZING_MARGINS];
    Inc(ContentRect.Left, Margins.cxLeftWidth);
    Inc(ContentRect.Top, Margins.cyTopHeight);
    Dec(ContentRect.Right, Margins.cxRightWidth);
    Dec(ContentRect.Bottom, Margins.cyBottomHeight);
  end;
end;

{------------------ TWindowsXPThemeTab -------------------------------------------}
constructor TWindowsXPThemeTab.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Tab');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Tab.Body');
  AddPart(TABP_BODY, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.Pane');
  AddPart(TABP_PANE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItem');
  AddPart(TABP_TABITEM, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItemBothEdge');
  AddPart(TABP_TABITEMBOTHEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItemLeftEdge');
  AddPart(TABP_TABITEMLEFTEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TabItemRightEdge');
  AddPart(TABP_TABITEMRIGHTEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItem');
  AddPart(TABP_TOPTABITEM, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItemBothEdge');
  AddPart(TABP_TOPTABITEMBOTHEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItemLeftEdge');
  AddPart(TABP_TOPTABITEMLEFTEDGE, Part);
  Part := TWindowsXPThemeTabPart.Create(Self, Root, 'Tab.TopTabItemRightEdge');
  AddPart(TABP_TOPTABITEMRIGHTEDGE, Part);
end;

{------------------ TWindowsXPThemeToolbar ---------------------------------------}
constructor TWindowsXPThemeToolbar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Toolbar');
  AddPart(0, Root);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.Button');
  AddPart(TP_BUTTON, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.DropdownButton');
  AddPart(TP_DROPDOWNBUTTON, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.SplitButton');
  AddPart(TP_SPLITBUTTON, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.SplitButtonDropdown');
  AddPart(TP_SPLITBUTTONDROPDOWN, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.Separator');
  AddPart(TP_SEPARATOR, Part);
  Part := TWindowsXPThemeToolbarPart.Create(Self, Root, 'Toolbar.SeparatorVert');
  AddPart(TP_SEPARATORVERT, Part);
end;

{------------------ TWindowsXPThemeToolbarPart -----------------------------------}
function TWindowsXPThemeToolbarPart.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= TS_NORMAL) and (StateID <= TS_HOTCHECKED) then
    Result := StateID - TS_NORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeTrackBar --------------------------------------}
constructor TWindowsXPThemeTrackBar.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'TrackBar');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'TrackBar.Track');
  AddPart(TKP_TRACK, Part);
  Part := TWindowsXPThemePart.Create(Self, Root, 'TrackBar.TrackVert');
  AddPart(TKP_TRACKVERT, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.Thumb');
  AddPart(TKP_THUMB, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbBottom');
  AddPart(TKP_THUMBBOTTOM, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbTop');
  AddPart(TKP_THUMBTOP, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbVert');
  AddPart(TKP_THUMBVERT, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbLeft');
  AddPart(TKP_THUMBLEFT, Part);
  Part := TWindowsXPThemeTrackBarThumb.Create(Self, Root, 'TrackBar.ThumbRight');
  AddPart(TKP_THUMBRIGHT, Part);
  Part := TWindowsXPThemeTrackBarTics.Create(Self, Root, 'TrackBar.Tics');
  AddPart(TKP_TICS, Part);
  Part := TWindowsXPThemeTrackBarTics.Create(Self, Root, 'TrackBar.TicsVert');
  AddPart(TKP_TICSVERT, Part);
end;

{------------------ TWindowsXPThemeTrackBarThumb --------------------------------}
function TWindowsXPThemeTrackBarThumb.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= TUS_NORMAL) and (StateID <= TUS_DISABLED) then
    Result := StateID - TUS_NORMAL
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeTrackBarTics ---------------------------------}
procedure TWindowsXPThemeTrackBarTics.DrawThemeBackground(DC: HDC;
  StateID: integer; const Rect: TRect; ClipRect: PRect);
var
  Pen: HPen;
begin
  if Defined[TPP_COLOR] then
  begin
    Pen := CreatePen(PS_SOLID, 1, ColorProp[TPP_COLOR]);
    Pen := SelectObject(DC, Pen);
    if Rect.Right - Rect.Left > Rect.Bottom - Rect.Top then
    begin
      MoveToEx(DC, Rect.Left, Rect.Bottom, nil);
      LineTo(DC, Rect.Right, Rect.Bottom);
    end
    else begin
      MoveToEx(DC, Rect.Right, Rect.Top, nil);
      LineTo(DC, Rect.Right, Rect.Bottom);
    end;
    Pen := SelectObject(DC, Pen);
    DeleteObject(Pen);
  end
  else
    inherited;
end;

{--------------------------------------------------------------------------------}
constructor TWindowsXPThemeTreeView.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'TreeView');
  AddPart(0, Root);
  Part := TWindowsXPThemeTreeViewGlyph.Create(Self, Root, 'TreeView.Glyph');
  AddPart(TVP_GLYPH, Part);
end;

{------------------ TWindowsXPThemeTreeViewGlyph --------------------------------}
function TWindowsXPThemeTreeViewGlyph.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = GLPS_OPENED then
    Result := 1
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeWindow ---------------------------------------}
constructor TWindowsXPThemeWindow.Create(Manager: TThemeManager);
var
  Root, Part: TWindowsXPThemePart;
begin
  inherited;
  Root := TWindowsXPThemePart.Create(Self, nil, 'Window');
  AddPart(0, Root);
  Part := TWindowsXPThemePart.Create(Self, Root, 'Window.Dialog');
  AddPart(WP_DIALOG, Part);
  // Normal Frames
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.FrameLeft');
  AddPart(WP_FRAMELEFT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.FrameRight');
  AddPart(WP_FRAMERIGHT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.FrameBottom');
  AddPart(WP_FRAMEBOTTOM, Part);
  // Small Frames
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallFrameLeft');
  AddPart(WP_SMALLFRAMELEFT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallFrameRight');
  AddPart(WP_SMALLFRAMERIGHT, Part);
  Part := TWindowsXPThemeWindowFrame.Create(Self, Root, 'Window.SmallFrameBottom');
  AddPart(WP_SMALLFRAMEBOTTOM, Part);
  // Normal Captions
  Part := TWindowsXPThemeWindowCaption.Create(Self, Root, 'Window.Caption');
  AddPart(WP_CAPTION, Part);
  Part := TWindowsXPThemeWindowCaption.Create(Self, Root, 'Window.MinCaption');
  AddPart(WP_MINCAPTION, Part);
  Part := TWindowsXPThemeWindowCaption.Create(Self, Root, 'Window.MaxCaption');
  AddPart(WP_MAXCAPTION, Part);
  // Small Captions
  Part := TWindowsXPThemeWindowCaption.Create(Self, Root, 'Window.SmallCaption');
  AddPart(WP_SMALLCAPTION, Part);
  Part := TWindowsXPThemeWindowCaption.Create(Self, Root, 'Window.SmallMinCaption');
  AddPart(WP_SMALLMINCAPTION, Part);
  Part := TWindowsXPThemeWindowCaption.Create(Self, Root, 'Window.SmallMaxCaption');
  AddPart(WP_SMALLMAXCAPTION, Part);
  // Normal Buttons
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.CloseButton');
  AddPart(WP_CLOSEBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MaxButton');
  AddPart(WP_MAXBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MinButton');
  AddPart(WP_MINBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.RestoreButton');
  AddPart(WP_RESTOREBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.HelpButton');
  AddPart(WP_HELPBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.SysButton');
  AddPart(WP_SYSBUTTON, Part);
  // Small Close Button
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.SmallCloseButton');
  AddPart(WP_SMALLCLOSEBUTTON, Part);
  // MDI Buttons
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MDICloseButton');
  AddPart(WP_MDICLOSEBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MDIMinButton');
  AddPart(WP_MDIMINBUTTON, Part);
  Part := TWindowsXPThemeWindowButton.Create(Self, Root, 'Window.MDIRestoreButton');
  AddPart(WP_MDIRESTOREBUTTON, Part);
end;

{------------------ TWindowsXPThemeWindowFrame --------------------------------}
function TWindowsXPThemeWindowFrame.GetStateRectIndex(StateID: integer): integer;
begin
  if StateID = FS_INACTIVE then
    Result := 1
  else
    Result := 0;
end;

{------------------ TWindowsXPThemeWindowCaption --------------------------------}
constructor TWindowsXPThemeWindowCaption.Create(Theme: TWindowsXPTheme;
  Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
  FActive := TWindowsXPThemeWindowCaptionState.Create(Theme, Self, Section + '(Active)');
  FInactive := TWindowsXPThemeWindowCaptionState.Create(Theme, Self, Section + '(Inactive)');
end;

destructor TWindowsXPThemeWindowCaption.Destroy;
begin
  FActive.Free;
  FInactive.Free;
  inherited;
end;

procedure TWindowsXPThemeWindowCaption.DrawThemeText(DC: HDC; StateID: integer;
  Text: PLMDChar; CharCount: integer; TextFlags, TextFlags2: cardinal;
  const Rect: TRect);
begin
  case StateID of
    FS_ACTIVE: FActive.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
    FS_INACTIVE: FInactive.DrawThemeText(DC, StateID, Text, CharCount, TextFlags, TextFlags2, Rect);
  end;
end;

{------------------ TWindowsXPThemeWindowCaptionState -------------------------}

constructor TWindowsXPThemeWindowCaptionState.Create(
  Theme: TWindowsXPTheme; Parent: TWindowsXPThemePart; Section: string);
begin
  inherited;
end;

procedure TWindowsXPThemeWindowCaptionState.DrawThemeText(DC: HDC;
  StateID: integer; Text: PLMDChar; CharCount: integer; TextFlags,
  TextFlags2: cardinal; const ARect: TRect);
var
  Color: cardinal;
  Rect: TRect;
begin
  Rect := ARect;
  if (Text = nil) or (CharCount = 0) then
    exit;
  if Available[TPP_TEXT_SHADOW_COLOR] then
    begin
      Color := ColorProp[TPP_TEXT_SHADOW_COLOR];
      SetTextColor(DC, Color);
      SetBkMode(DC, TRANSPARENT);
      with Rect do
        OffsetRect(Rect, PointProp[TPP_TEXT_SHADOW_OFFSET].x, PointProp[TPP_TEXT_SHADOW_OFFSET].y);
      {$IFDEF LMD_UNICODE}
      DrawTextW(DC, Text, CharCount, Rect, TextFlags);
      {$ELSE}
      DrawText(DC, Text, CharCount, Rect, TextFlags);
      {$ENDIF}
    end;
  Rect := ARect;
  Color := 0;
  if Available[TPP_TEXT_COLOR] then
    Color := ColorProp[TPP_TEXT_COLOR]
  else
    case StateID of
      FS_ACTIVE:
        Color := Theme.GetThemeSysColor(TMT_CAPTIONTEXT);
      FS_INACTIVE:
        Color := Theme.GetThemeSysColor(TMT_INACTIVECAPTIONTEXT);
    end;
  if Color = 0 then
    case StateID of
      FS_ACTIVE:
        Color := GetSysColor(COLOR_ACTIVECAPTION);
      FS_INACTIVE:
        Color := GetSysColor(COLOR_INACTIVECAPTION);
    end;
  SetTextColor(DC, Color);
  SetBkMode(DC, TRANSPARENT);
  {$IFDEF LMD_UNICODE}
  DrawTextW(DC, Text, CharCount, Rect, TextFlags);
  {$ELSE}
  DrawText(DC, Text, CharCount, Rect, TextFlags);
  {$ENDIF}  
end;

{------------------ TWindowsXPThemeWindowButton -------------------------------}
function TWindowsXPThemeWindowButton.GetStateRectIndex(StateID: integer): integer;
begin
  if (StateID >= CBS_NORMAL) and (StateID <= CBS_INACTIVEDISABLED) then
    Result := StateID - CBS_NORMAL
  else
    Result := 0;
end;

end.
