unit LMDIdeActns;
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

LMDIdeActns unit (YB)
---------------------
LMD IDE-Tools actions unit.

Changes
-------

###############################################################################}

interface

uses
  Classes, Controls, Windows, Messages, SysUtils, ActnList, Menus, LMDIdeCst,
  LMDTypes, LMDSvcPvdr, LMDDsgDesigner, LMDIdeUtils;

type
  {**************************** TLMDDesignerAction ****************************}

  TLMDDesignerAction = class(TAction)
  private
    FDesigner:        TLMDDesigner;
    FServiceProvider: TLMDServiceProvider;
    
    procedure SetDesigner(const Value: TLMDDesigner);
    procedure SetServiceProvider(const Value: TLMDServiceProvider);
  protected
    procedure Notification(AComponent: TComponent;
                           Operation: TOperation); override;
    function  GetActiveDesigner: TLMDDesigner;
  public
    destructor Destroy; override;

    function Update: Boolean; override;
  published
    property Designer: TLMDDesigner read FDesigner write SetDesigner;
    property ServiceProvider: TLMDServiceProvider read FServiceProvider write SetServiceProvider;
  end;

  {**************************** TLMDDsgAlignAction ****************************}

  TLMDDsgAlignAction = class(TLMDDesignerAction)
  public
    function Update: Boolean; override;
  end;

  TLMDAlignToGrid = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignLeft = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignRight = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignHSpaceEqually = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignHCenter = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignHCenterInWindow = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignTop = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignBottom = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignVSpaceEqually = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignVCenter = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  TLMDAlignVCenterInWindow = class(TLMDDsgAlignAction)
  public
    constructor Create(AOwner: TComponent); override;
    function Execute: Boolean; override;
  end;

  {************************** TLMDDsgClipboardAction **************************}

  TLMDDsgClipboardAction = class(TLMDDesignerAction)
  end;

  TLMDDsgCut = class(TLMDDsgClipboardAction)
  public
    constructor Create(AOwner: TComponent); override;
    function    Update: Boolean; override;
    function    Execute: Boolean; override;
  end;

  TLMDDsgCopy = class(TLMDDsgClipboardAction)
  public
    constructor Create(AOwner: TComponent); override;
    function    Update: Boolean; override;
    function    Execute: Boolean; override;
  end;

  TLMDDsgPaste = class(TLMDDsgClipboardAction)
  public
    constructor Create(AOwner: TComponent); override;
    function    Update: Boolean; override;
    function    Execute: Boolean; override;
  end;

  {***************************** TLMDDsgSelectAll *****************************}

  TLMDDsgSelectAll = class(TLMDDesignerAction)
  public
    constructor Create(AOwner: TComponent); override;
    function    Execute: Boolean; override;
  end;

  {**************************** TLMDDsgDelSelected ****************************}

  TLMDDsgDelSelected = class(TLMDDesignerAction)
  public
    constructor Create(AOwner: TComponent); override;
    function    Update: Boolean; override;
    function    Execute: Boolean; override;
  end;

  {**************************** TLMDDsgLockAction *****************************}

  TLMDDsgLockAction = class(TLMDDesignerAction)
  end;

  TLMDDsgClearLocks = class(TLMDDsgLockAction)
  public
    constructor Create(AOwner: TComponent); override;
    function    Execute: Boolean; override;
  end;

  TLMDDsgLockSelected = class(TLMDDsgLockAction)
  private
    FLockMode: TLMDDesignerLockMode;
  public
    constructor Create(AOwner: TCOmponent); override;
    function    Update: Boolean; override;
    function    Execute: Boolean; override;
  published
    property LockMode: TLMDDesignerLockMode read FLockMode write FLockMode default [lmNoMove, lmNoResize, lmNoDelete];
  end;

  {*************************** TLMDDsgZOrderAction ****************************}

  TLMDDsgZOrderAction = class(TLMDDesignerAction)
  public
    function Update: Boolean; override;
  end;

  TLMDDsgBringToFront = class(TLMDDsgZOrderAction)
  public
    constructor Create(AOwner: TCOmponent); override;
    function    Execute: Boolean; override;
  end;

  TLMDDsgSendToBack = class(TLMDDsgZOrderAction)
  public
    constructor Create(AOwner: TCOmponent); override;
    function    Execute: Boolean; override;
  end;

  {**************************** TLMDDsgTabOrderDlg ****************************}

  TLMDDsgTabOrderDlg = class(TLMDDesignerAction)
  public
    constructor Create(AOwner: TCOmponent); override;
    function    Execute: Boolean; override;
  end;

  {************************* TLMDDsgCreationOrderDlg **************************}

  TLMDDsgCreationOrderDlg = class(TLMDDesignerAction)
  public
    constructor Create(AOwner: TCOmponent); override;
    function    Execute: Boolean; override;
  end;

  {*************************** ILMDCurDesignerService *************************}

  ILMDCurDesignerService = class
  public
    function GetCurrentDesigner: TLMDDesigner; virtual; abstract;
  end;

implementation

{***************************** TLMDDesignerAction *****************************}
{------------------------------------------------------------------------------}
destructor TLMDDesignerAction.Destroy;
begin
  Designer        := nil;
  ServiceProvider := nil;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDDesignerAction.GetActiveDesigner: TLMDDesigner;
var
  svc: ILMDCurDesignerService;
begin
  Result := nil;

  if FDesigner <> nil then
    Result := FDesigner
  else if LMDTryGetService(FServiceProvider, ILMDCurDesignerService, svc) then
    Result := svc.GetCurrentDesigner;

  if (Result <> nil) and not Result.Active then
    Result := nil;
end;

{------------------------------------------------------------------------------}
procedure TLMDDesignerAction.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if Operation = opRemove then
  begin
    if AComponent = FDesigner then
      Designer := nil;
    if AComponent = FServiceProvider then
      ServiceProvider := nil;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDesignerAction.SetDesigner(const Value: TLMDDesigner);
begin
  if FDesigner <> Value then
  begin
    if FDesigner <> nil then
      FDesigner.RemoveFreeNotification(Self);
    FDesigner := Value;
    if FDesigner <> nil then
      FDesigner.FreeNotification(Self);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDesignerAction.SetServiceProvider(
  const Value: TLMDServiceProvider);
begin
  if FServiceProvider <> Value then
  begin
    if FServiceProvider <> nil then
      FServiceProvider.RemoveFreeNotification(Self);
    FServiceProvider := Value;
    if FServiceProvider <> nil then
      FServiceProvider.FreeNotification(Self);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDDesignerAction.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil);
  Result  := True;
end;

{****************************** TLMDDsgAlignAction ****************************}
{------------------------------------------------------------------------------}
function TLMDDsgAlignAction.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil) and (dsgr.Selection.Count > 0);
  Result  := True;
end;

{******************************** TLMDAlignLeft *******************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignLeft.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignLeft;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignLeft.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atLeftTop, atNoChanges);
  Result := True;
end;

{******************************* TLMDAlignRight *******************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignRight.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignRight;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignRight.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atRightBottom, atNoChanges);
  Result := True;
end;

{************************** TLMDAlignHSpaceEqually ****************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignHSpaceEqually.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignHSpaceEqually;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignHSpaceEqually.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atSpaceEqually, atNoChanges);
  Result := True;
end;

{***************************** TLMDAlignHCenter *******************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignHCenter.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignHCenter;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignHCenter.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atCenter, atNoChanges);
  Result := True;
end;

{************************* TLMDAlignHCenterInWindow ***************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignHCenterInWindow.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignHCenterInWindow;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignHCenterInWindow.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atCenterInWindow, atNoChanges);
  Result := True;
end;

{******************************* TLMDAlignTop *********************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignTop.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignTop;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignTop.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atNoChanges, atLeftTop);
  Result := True;
end;

{****************************** TLMDAlignBottom *******************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignBottom.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignBottom;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignBottom.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atRightBottom, atLeftTop);
  Result := True;
end;

{*************************** TLMDAlignVSpaceEqually ***************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignVSpaceEqually.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignVSpaceEqually;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignVSpaceEqually.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atSpaceEqually, atLeftTop);
  Result := True;
end;

{****************************** TLMDAlignVCenter ******************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignVCenter.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignVCenter;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignVCenter.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atCenter, atLeftTop);
  Result := True;
end;

{************************** TLMDAlignVCenterInWindow **************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignVCenterInWindow.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignVCenterInWindow;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignVCenterInWindow.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelected(atCenterInWindow, atLeftTop);
  Result := True;
end;

{********************************* TLMDDsgCut *********************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgCut.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := TextToShortCut('Ctrl+X');
  Caption  := SLMDActnDsgCut;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgCut.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.CutToClipboard;
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDDsgCut.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil) and dsgr.CanCutToClipboard;
  Result  := True;
end;

{******************************** TLMDDsgCopy *********************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgCopy.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := TextToShortCut('Ctrl+C');
  Caption  := SLMDActnDsgCopy;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgCopy.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.CopyToClipboard;
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDDsgCopy.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil) and dsgr.CanCopyToClipboard;
  Result  := True;
end;

{********************************* TLMDDsgPaste *******************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgPaste.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := TextToShortCut('Ctrl+V');
  Caption  := SLMDActnDsgPaste;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgPaste.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.PasteFromClipboard;
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDDsgPaste.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil) and dsgr.CanPasteFromClipboard;
  Result  := True;
end;

{****************************** TLMDDsgSelectAll ******************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgSelectAll.Create(AOwner: TComponent);
begin
  inherited;
  ShortCut := TextToShortCut('Ctrl+A');
  Caption  := SLMDActnDsgSelectAll;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgSelectAll.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.SelectAll;
  Result := True;
end;

{***************************** TLMDDsgDelSelected *****************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgDelSelected.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnDsgDelSelected;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgDelSelected.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.DeleteSelectedComponents;
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDDsgDelSelected.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil) and (dsgr.Selection.Count > 0);
  Result  := True;
end;

{***************************** TLMDDsgClearLocks ******************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgClearLocks.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnDsgClearLocks;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgClearLocks.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.ClearAllLocks;
  Result := True;
end;

{***************************** TLMDDsgLockSelected ****************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgLockSelected.Create(AOwner: TCOmponent);
begin
  inherited;
  FLockMode := [lmNoMove, lmNoResize, lmNoDelete];
  Caption   := SLMDActnDsgLockSelected;
  Hint      := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgLockSelected.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.LockSelected(FLockMode);
  Result := True;
end;

{------------------------------------------------------------------------------}
function TLMDDsgLockSelected.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil) and (dsgr.Selection.Count > 0);
  Result  := True;
end;

{**************************** TLMDDsgZOrderAction *****************************}
{------------------------------------------------------------------------------}
function TLMDDsgZOrderAction.Update: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr    := GetActiveDesigner;
  Enabled := (dsgr <> nil) and (dsgr.Selection.Count > 0);
  Result  := True;
end;

{**************************** TLMDDsgBringToFront *****************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgBringToFront.Create(AOwner: TCOmponent);
begin
  inherited;
  Caption  := SLMDActnDsgBringToFront;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgBringToFront.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.BringSelectedToFront;
  Result := True;
end;

{***************************** TLMDDsgSendToBack ******************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgSendToBack.Create(AOwner: TCOmponent);
begin
  inherited;
  Caption  := SLMDActnDsgSendToBack;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgSendToBack.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.SendSelectedToBack;
  Result := True;
end;

{****************************** TLMDAlignToGrid *******************************}
{------------------------------------------------------------------------------}
constructor TLMDAlignToGrid.Create(AOwner: TComponent);
begin
  inherited;
  Caption  := SLMDActnAlignToGrid;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDAlignToGrid.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  dsgr.AlignSelectedToGrid;
  Result := True;
end;

{**************************** TLMDDsgTabOrderDlg ******************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgTabOrderDlg.Create(AOwner: TCOmponent);
begin
  inherited;
  Caption  := SLMDActnDsgTabOrderDlg;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgTabOrderDlg.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  LMDTabOrderDialog(dsgr);
  Result := True;
end;

{************************** TLMDDsgCreationOrderDlg ***************************}
{------------------------------------------------------------------------------}
constructor TLMDDsgCreationOrderDlg.Create(AOwner: TCOmponent);
begin
  inherited;
  Caption  := SLMDActnDsgCreationOrderDlg;
  Hint     := Caption;
end;

{------------------------------------------------------------------------------}
function TLMDDsgCreationOrderDlg.Execute: Boolean;
var
  dsgr: TLMDDesigner;
begin
  dsgr := GetActiveDesigner;
  LMDCreationOrderDialog(dsgr);
  Result := True;
end;

{------------------------------------------------------------------------------}
end.
