unit LMDXPThemeManager;
{$I lmdcmps.inc}
{###############################################################################

LMDXPThemeManager unit (JH)
---------------------------

This small class hooks the wnd proc of the application and listens for certain
messages It will created "together" with the LMDApplication class
! WM_CREATE: init xp support WM_THEMECHANGE: validate xp support settings

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Windows, Controls, Messages, Forms,
  {$IFNDEF LMDDISABLE_LMDTHEMES}LMDXPStyles,{$ELSE}uxTheme, {$ENDIF} Themes,
  LMDCustomComponent, LMDClass;

type
  TLMDThemedItem = (tiButton, tiClock, tiComboBox, tiEdit, tiExplorerBar,
                    tiHeader, tiListView, tiMenu, tiPage, tiProgress, tiRebar,
                    tiScrollBar, tiSpin, tiStartPanel, tiStatus, tiTab, tiTaskBand,
                    tiTaskBar, tiToolBar, tiToolTip, tiTrackBar, tiTrayNotify,
                    tiTreeview, tiWindow, tiGlobals);

  TLMDThemeHandles = array[TLMDThemedItem] of HTHEME;

  // Proxy class for Theme handles
  { --------------------------- TLMDXPThemeManager --------------------------- }
  TLMDXPThemeManager = class(TLMDCustomComponent)
  private
    FHWND: HWND;
    FUseThemes:Boolean;
    FThemeHandles: TLMDThemeHandles;
    FSystemThemeIsChanging: boolean;
    function GetThemeItem(Index:TLMDThemedItem): HTHEME;
  protected
    procedure WndProc(var Message: TMessage);
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy; override;
    procedure ResetList;
    property Theme[Index:TLMDThemedItem]:HTHEME read GetThemeItem;
    property SystemThemeIsChanging: boolean read FSystemThemeIsChanging;
  end;


function LMDThemeService: TLMDXPThemeManager;

implementation
{$ifdef CLR}
uses
  WinUtils;
{$endif}
{$IFNDEF LMDDISABLE_LMDTHEMES}
const
  TLMDThemedItemName: array[TLMDThemedItem] of {$IFDEF CLR}String{$ELSE}PWideChar{$ENDIF} = (
                      'BUTTON', 'CLOCK', 'COMBOBOX', 'EDIT', 'EXPLORERBAR',
                      'HEADER', 'LISTVIEW', 'MENU', 'PAGE', 'PROGRESS',
                      'REBAR', 'SCROLLBAR', 'SPIN', 'STARTPANEL', 'STATUS',
                      'TAB', 'TASKBAND', 'TASKBAR', 'TOOLBAR', 'TOOLTIP',
                      'TRACKBAR','TRAYNOTIFY','TREEVIEW' ,'WINDOW', 'GLOBALS');
{$ENDIF}
var
  XPThemeManager : TLMDXPThemeManager = nil;

{ ---------------------------------------------------------------------------- }
function LMDThemeService: TLMDXPThemeManager;
begin
  if not Assigned(XPThemeManager) then
    XPThemeManager := TLMDXPThemeManager.Create(nil);
  result := XPThemeManager;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDXPThemeManager.Create(aOwner: TComponent);
begin
  inherited;
  FSystemThemeIsChanging := false;
  FUseThemes := LMDApplication.UseXPThemes;
  {$IFNDEF LMDDISABLE_LMDTHEMES}
  // here InitThemes --> LMDXPStyles
  {$ENDIF}
  FHWND:=AllocateHWnd(WndProc);
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDXPThemeManager.Destroy;
begin
  DeallocateHWnd(FHwnd);
  ResetList;
  {$IFNDEF LMDDISABLE_LMDTHEMES}
  // here FinalizeThemes
  {$ENDIF}
  inherited;
end;

{ ---------------------------------------------------------------------------- }
function TLMDXPThemeManager.GetThemeItem(Index: TLMDThemedItem): HTHEME;
begin
  if FUseThemes and (FThemeHandles[Index] = 0) then
  {$IFDEF LMDDISABLE_LMDTHEMES}
    FThemeHandles[Index] := ThemeServices.Theme[TThemedElement(Ord(Index))];
  {$ELSE}
    FThemeHandles[Index] := OpenThemeData(0, TLMDThemedItemName[Index]);
  {$ENDIF}
  result := FThemeHandles[Index];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDXPThemeManager.ResetList;
var
  i: TLMDThemedItem;
begin
  for i:=Low(TLMDThemedItem) to High(TLMDThemedItem) do
    if (FThemeHandles[i]<>0) then
      begin
        {$IFNDEF LMDDISABLE_LMDTHEMES}
        {$IFNDEF CLR}if Assigned(CloseThemeData) then{$ENDIF} // ToDo!!! -> remove again
          CloseThemeData(FThemeHandles[i]);
        {$ENDIF}
        FThemeHandles[i] := 0;
      end;
  FUseThemes := LMDApplication.UseXPThemes;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDXPThemeManager.WndProc(var Message: TMessage);
begin
  with Message do
    case msg of
      WM_THEMECHANGED:
        begin
          if LMDApplication.UseXPThemes then
            begin
              FSystemThemeIsChanging := true;
              ResetList;
              LMDApplication.UseXPThemes := false; //disable
              LMDApplication.UseXPThemes := true; //try to enable
              FSystemThemeIsChanging := false;
            end
          else
            ResetList;
       end;
    else
      Result := DefWindowProc(FHwnd, Msg, wParam, lParam);
    end;
end;

initialization
finalization
  LMDThemeService.Free;
end.
