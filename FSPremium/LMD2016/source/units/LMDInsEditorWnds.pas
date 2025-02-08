unit LMDInsEditorWnds;
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

LMDInsEditorWnds unit (YB)
--------------------------
Unit contains callback interfaces used by property and component editors.

Changes
-------

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, LMDTypes, LMDStrings,
  LMDInsCst, LMDInsClass, LMDInsEditorUtils;

type
  TLMDEditorWindowManager   = class;
  TLMDEditorWindowCallbacks = class;

  TLMDEditorWndState     = set of (ewsMarkingModified, ewsUpdatingView,
                                   ewsDestroying);

  TLMDEditorWndCommand   = (ewcUpdateView, ewcHideWindow, ewcShowWindow,
                            ewcDestroyWindow, ewcUpdateStayOnTop);
  TLMDEditorWndOnCommand = procedure(Sender: TObject;
                                     ACommand: TLMDEditorWndCommand) of object;

  TLMDEditorWindowCallbacksClass = class of TLMDEditorWindowCallbacks;
  TLMDEditorWindowCallbacks      = class
  private
    FManager:   TLMDEditorWindowManager;
    FOnCommand: TLMDEditorWndOnCommand;
    FState:     TLMDEditorWndState;

    procedure DoCommand(ACommand: TLMDEditorWndCommand);
    function  GetStayOnTop: Boolean;
    function  GetEditorUtils: TLMDEditorUtils;
  protected
    procedure UpdateView;     // Something changed, including
                              // selection changes.
    procedure HideWindow;
    procedure ShowWindow;
    procedure DestroyWindow;  // Will destroy self.
    procedure UpdateStayOnTop;
  public
    constructor Create(AManager: TLMDEditorWindowManager); virtual;
    destructor Destroy; override;

    property  Manager: TLMDEditorWindowManager read FManager;
    property  EditorUtils: TLMDEditorUtils read GetEditorUtils;
    property  State: TLMDEditorWndState read FState;
    property  StayOnTop: Boolean read GetStayOnTop;
    property  OnCommand: TLMDEditorWndOnCommand read FOnCommand write FOnCommand;
  end;

  TLMDEditorWindowManager = class
  private
    FEditorWndCbs:   TList;
    FParentComp:     TComponent;
    FEditorUtils:    TLMDEditorUtils;
    FStayOnTop:      Boolean;

    procedure DisassociateAllCallbacks;
    procedure SetStayOnTop(const Value: Boolean);
  public
    constructor Create(AParentComp: TComponent;
                       AEditorUtils: TLMDEditorUtils);
    destructor Destroy; override;

    function  CreateCallbacks: TLMDEditorWindowCallbacks;
    procedure UpdateAll;
    procedure ShowAll;
    procedure HideAll;
    procedure DestroyAll;

    property  ParentComp: TComponent read FParentComp;
    property  StayOnTop: Boolean read FStayOnTop write SetStayOnTop;
  end;

implementation

{ TLMDEditorWindowCallbacks }

constructor TLMDEditorWindowCallbacks.Create(
  AManager: TLMDEditorWindowManager);
begin
  inherited Create;

  FManager := AManager;
  FManager.FEditorWndCbs.Add(Self);
end;

destructor TLMDEditorWindowCallbacks.Destroy;
begin
  if FManager <> nil then
    FManager.FEditorWndCbs.Remove(Self);
  inherited;
end;

procedure TLMDEditorWindowCallbacks.DestroyWindow;
begin
  if not (ewsDestroying in FState) then
  begin
    Include(FState, ewsDestroying);
    DoCommand(ewcDestroyWindow);
  end;
end;

procedure TLMDEditorWindowCallbacks.DoCommand(
  ACommand: TLMDEditorWndCommand);
begin
  if Assigned(FOnCommand) then
    FOnCommand(Self, ACommand);
end;

function TLMDEditorWindowCallbacks.GetEditorUtils: TLMDEditorUtils;
begin
  Result := FManager.FEditorUtils;
end;

function TLMDEditorWindowCallbacks.GetStayOnTop: Boolean;
begin
  Result := FManager.StayOnTop;
end;

procedure TLMDEditorWindowCallbacks.HideWindow;
begin
  DoCommand(ewcHideWindow);
end;

procedure TLMDEditorWindowCallbacks.ShowWindow;
begin
  DoCommand(ewcShowWindow);
end;

procedure TLMDEditorWindowCallbacks.UpdateStayOnTop;
begin
  DoCommand(ewcUpdateStayOnTop);
end;

procedure TLMDEditorWindowCallbacks.UpdateView;
begin
  if ewsMarkingModified in FState then // No circular view updates.
    Exit;

  Include(FState, ewsUpdatingView);
  try
    DoCommand(ewcUpdateView);
  finally
    Exclude(FState, ewsUpdatingView);
  end;
end;

{ TLMDEditorWindowManager }

procedure TLMDEditorWindowManager.DisassociateAllCallbacks;
var
  i: Integer;
begin
  for i := 0 to FEditorWndCbs.Count - 1 do
    TLMDEditorWindowCallbacks(FEditorWndCbs[i]).FManager := nil;
  FEditorWndCbs.Clear;
end;

constructor TLMDEditorWindowManager.Create(AParentComp: TComponent;
  AEditorUtils: TLMDEditorUtils);
begin
  inherited Create;
  FEditorWndCbs   := TList.Create;
  FParentComp     := AParentComp;
  if AEditorUtils <> nil then
    FEditorUtils  := AEditorUtils.AddRef;
end;

destructor TLMDEditorWindowManager.Destroy;
begin
  DestroyAll;
  DisassociateAllCallbacks; // If some were not destroyed.

  FEditorWndCbs.Free;
  if FEditorUtils <> nil then
    FEditorUtils.Release;
  inherited;
end;

procedure TLMDEditorWindowManager.DestroyAll;
var
  i: Integer;
begin
  for i := FEditorWndCbs.Count - 1 downto 0 do
    TLMDEditorWindowCallbacks(FEditorWndCbs[i]).DestroyWindow;
end;

procedure TLMDEditorWindowManager.HideAll;
var
  i: Integer;
begin
  for i := FEditorWndCbs.Count - 1 downto 0 do
    TLMDEditorWindowCallbacks(FEditorWndCbs[i]).HideWindow;
end;

procedure TLMDEditorWindowManager.ShowAll;
var
  i: Integer;
begin
  for i := FEditorWndCbs.Count - 1 downto 0 do
    TLMDEditorWindowCallbacks(FEditorWndCbs[i]).ShowWindow;
end;

procedure TLMDEditorWindowManager.UpdateAll;
var
  i: Integer;
begin
  for i := FEditorWndCbs.Count - 1 downto 0 do
    TLMDEditorWindowCallbacks(FEditorWndCbs[i]).UpdateView;
end;

function TLMDEditorWindowManager.CreateCallbacks: TLMDEditorWindowCallbacks;
begin
  Result := TLMDEditorWindowCallbacks.Create(Self);
end;

procedure TLMDEditorWindowManager.SetStayOnTop(const Value: Boolean);
var
  i: Integer;
begin
  if FStayOnTop <> Value then
  begin
    FStayOnTop := Value;
    for i := FEditorWndCbs.Count - 1 downto 0 do
      TLMDEditorWindowCallbacks(FEditorWndCbs[i]).UpdateStayOnTop;
  end;
end;

end.
