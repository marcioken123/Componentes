unit ElTreeModalEdit;
{$I lmdcmps.inc}
{
  ##############################################################################
  # Author:             LMD Innovative ()
  # Created:
  # Description:
  # State:              release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  Classes,
  Messages,
  Windows,
  Forms,

  Types,

  LMDTypes,
  ElHeader,
  ElTreeInplaceEditors,
  ElTree;

type
    TModalEditExecuteEvent = procedure(Sender : TObject; var Accepted : boolean) of object;

    TElTreeInplaceModalEdit = class(TElTreeInplaceEditor)
    private
      procedure WndProc(var Message : TMessage);
    protected
      RegMsg: DWORD;
      FWnd  : HWND;
      FInProgress : boolean;
      FOnExecute: TModalEditExecuteEvent;
      function GetVisible: Boolean; override;
      procedure DoStartOperation; override;
      procedure Execute(var Accepted : boolean); virtual;
    public
      constructor Create(AOwner : TComponent); override;
      destructor Destroy; override;
      procedure StartOperation; override;
    published
      property OnExecute: TModalEditExecuteEvent read FOnExecute write FOnExecute;
    end;

implementation

constructor TElTreeInplaceModalEdit.Create(AOwner : TComponent);
begin
  inherited;
  RegMsg := RegisterWindowMessage('TElTreeInplaceModalEdit.ControlMessage');
  {$warnings off}
  FWnd := AllocateHwnd(WndProc);
  {$warnings on}
  FTypes := [sftCustom];
end;

destructor TElTreeInplaceModalEdit.Destroy;
begin
  {$warnings off}
  DeallocateHwnd(FWnd);
  {$warnings on}
  inherited;
end;

procedure TElTreeInplaceModalEdit.WndProc(var Message : TMessage);
begin
  if TLMDPtrUInt(Message.Msg) = RegMsg then
  begin
    CompleteOperation(Message.lParam <> 0);
  end
  else
    with Message do
      DefWindowProc(FWnd, Msg, wParam, lParam);
end;

function TElTreeInplaceModalEdit.GetVisible: Boolean;
begin
  Result := FInProgress;
end;

procedure TElTreeInplaceModalEdit.StartOperation;
var Accepted : boolean;
    DefaultConversion : boolean;
begin
  DefaultConversion := true;
  TriggerBeforeOperation(DefaultConversion);
  FInProgress := true;
  Execute(Accepted);
  FInProgress := false;
  PostMessage(FWnd, WM_NULL, 0, 0);
  PostMessage(FWnd, RegMsg, 0, LPARAM(Accepted));
end;

procedure TElTreeInplaceModalEdit.DoStartOperation;
begin
end;

procedure TElTreeInplaceModalEdit.Execute(var Accepted : boolean);
begin
  if Assigned(FOnExecute) then
    FOnExecute(Self, Accepted)
  else
    Accepted := false;
end;

end.
