unit LMDDockButton;
{$I lmdcmps.Inc}

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

LMDDockButton unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Controls, Forms, Classes, Messages,
  LMDBase, LMDClass, LMDButtonBase, LMDCustomButton;
  type
  TLMDDockButton=class(TLMDCustomButton)
  private
    FAdjustSize,
    FChanging,
    FDocked,
    FDestroying,
    FReflect:Boolean;
    FControl:TWinControl;
    FPosition:TLMDDockPosition;
    FMargin:Integer;
    FWndProcOld: TWndMethod;
    procedure SetBoolean(Index:Integer; aValue:Boolean);
    procedure SetControl(aValue:TWinControl);
    procedure SetMargin(aValue:Integer);
    procedure SetPosition(aValue:TLMDDockPosition);
    procedure AdjustToControl;
    procedure AdjustToButton;
    procedure InitWndProc;
    procedure RestoreWndProc;
    function HasControl:Boolean;
    procedure ReadIdent(Reader: TReader);
    procedure CMReDock(var Message:TMessage); message CM_REDOCK;
  protected
    procedure BoundsChange(State:TLMDBoundsChangeStates);override;
    procedure CreateWnd;override;
    procedure DefineProperties(Filer:TFiler);override;
    procedure DockControl;
    procedure Loaded;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure Notification(AComponent: TComponent;Operation:TOperation);override;
    procedure OwnWndProc(var Message: TMessage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CtlXP;  // compatibility
  published
    property AdjustDockedSize:Boolean index 0 read FAdjustSize write SetBoolean default True;
    property Control:TWinControl read FControl write SetControl;
    property Docked:Boolean index 1 read FDocked write SetBoolean default True;
    property GlyphKind default gkEllipsis;
    property Margin:Integer read FMargin write SetMargin default 1;
    property Position:TLMDDockPosition read FPosition write SetPosition default dpRight;
    property ReflectOwnChanges:Boolean index 2 read FReflect write SetBoolean default True;
    property ThemeMode;
    property ThemeGlobalMode;
  end;

implementation

uses
  Types, SysUtils,
  LMDUtils;

{--------------------------- Private ------------------------------------------}
procedure TLMDDockButton.SetControl(aValue:TWinControl);
var
  tmp, tmp1:TComponent;
  T: integer;
begin
  if (aValue<>FControl) and (aValue<>self) then
    begin
      //tmp := nil;
      RestoreWndProc;
      FControl:=aValue;
      if FControl<>nil then
        begin
          T := SendMessage(FControl.Handle, CM_LMDDOCKED, 0, 0);

          if T <> 0 then
            begin

              tmp := TComponent(T);

              tmp1:=FControl;
              FControl:=nil;
              LMDRaiseDockError(tmp, tmp1);
            end
          else
            begin
              FControl.FreeNotification(Self);
              DockControl;
             end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.SetBoolean(Index:Integer; aValue:Boolean);
begin
  case Index of
    0: if FAdjustSize<>aValue then
         begin
           FAdjustSize:=aValue;
           If HasControl then AdjustToControl;
         end;
    1: if aValue<>FDocked then
         begin
           FDocked:=aValue;
           if HasControl then
             DockControl
           else
             if FControl<>nil then RestoreWndProc;
         end;
    2: if aValue<>FReflect then
         begin
           FReflect:=aValue;
           if FReflect and HasControl then AdjustToButton;
         end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.SetMargin(aValue:Integer);
begin
  if FMargin<>aValue then
    begin
      FMargin:=aValue;
      if HasControl then AdjustToControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.SetPosition(aValue:TLMDDockPosition);
begin
  if FPosition<>aValue then
    begin
      FPosition:=aValue;
      if HasControl then AdjustToControl;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDDockButton.HasControl:Boolean;
begin
  result:=FDocked and (FControl<>nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.InitWndProc;
//var
//  tmp: TFarProc;
begin
  If HasControl and not Assigned(FWndProcOld) then
    try
      FControl.HandleNeeded;
      FWndProcOld := FControl.WindowProc;
      FControl.WindowProc := OwnWndProc;
(*
      tmp := TFarProc(GetWindowLong(FControl.Handle, GWL_WNDPROC));
      {3.1: form inheritance}
//      if tmp=FWndProc then exit;
      FWndProcOld:=tmp;
      SetWindowLong(FControl.Handle, GWL_WNDPROC, TLMDPtrInt(FWndProc));
*)
    except
      on Exception do RestoreWndProc;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.RestoreWndProc;
begin
  FDestroying:=True;
  try
    if Assigned(FWndProcOld)  and Assigned(FControl)  and (FControl.HandleAllocated) then
      FControl.WindowProc := FWndProcOld;
//      SetWindowLong(FControl.Handle, GWL_WNDPROC, TLMDPtrInt(FWndProcOld));

    FWndProcOld:=nil;
  finally
    FDestroying:=False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.AdjustToControl;
var
  h,w:Integer;
  bRect:TRect;
begin
  h:=0; w:=0;
  if FChanging or (FControl=nil) or not FControl.HandleAllocated then exit;

  with FControl do
    bRect:=Rect(Left, Top, Width, height);

  {no docking if Align of Control<>alNone}
  if (FControl.Align<>alNone) then exit;

  FChanging:=True;
  try
    case FPosition of
      dpTop, dpBottom:
        begin
          h:=Height;
          if FAdjustSize then w:=bRect.Right else w:=Width;
        end;
      dpRight, dpLeft:
        begin
          w:=Width;
          if FAdjustSize then h:=bRect.Bottom else h:=Height;
        end;
    end;

    with bRect do
      case FPosition of
        dpLeft:SetBounds(Left-w-FMargin, Top, w, h);
        dpRight:SetBounds(Left+Right+FMargin, Top, w, h);
        dpTop:SetBounds(Left, top-h-FMargin, w, h);
        dpBottom:SetBounds(Left, Top+Bottom+FMargin, w, h);
      end;
  finally
    FChanging:=False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.AdjustToButton;
var
  h,w:Integer;

begin
  h:=0; w:=0;
  {no docking if Align of Control<>alNone}
  if FChanging or (FControl.Align<>alNone) then exit;

  FChanging:=True;
  try
    case FPosition of
      dpTop, dpBottom:
        begin
          h:=FControl.Height;
          if FAdjustSize then w:=Width else w:=FControl.Width;
        end;
      dpRight, dpLeft:
        begin
          w:=FControl.Width;
          if FAdjustSize then h:=Height else h:=FControl.Height;
        end;
    end;

    with BoundsRect do
      case FPosition of
        dpLeft:FControl.SetBounds(Right+Margin, Top, w, h);
        dpRight:FControl.SetBounds(Left-w-FMargin, Top, w, h);
        dpTop:FControl.SetBounds(Left, Bottom+FMargin, w, h);
        dpBottom:FControl.SetBounds(Left, Top-h-FMargin, w, h);
      end;
  finally
    FChanging:=False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.CMReDock(var Message:TMessage);
begin
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.ReadIdent(Reader: TReader);
begin
  FAdjustSize:=Reader.ReadBoolean;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDDockButton.BoundsChange(State:TLMDBoundsChangeStates);
begin
  if FReflect and HasControl then AdjustToButton;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.CreateWnd;
begin
  inherited CreateWnd;
  InitWndProc;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('AdjustSize', ReadIdent, nil, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.DockControl;
begin
  if not HasControl or (csLoading in ComponentState) then exit;
  FChanging:=False;
  InitWndProc;
  AdjustToControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.Loaded;
begin
  inherited Loaded;
  {DockControl;}  // To Do?
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FControl) and (Operation = opRemove) then SetControl(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDDockButton.OwnWndProc(var Message: TMessage);
begin
   if FDestroying then exit;

   with Message do
     begin
       if Assigned(FWndProcOld) then
         FWndProcOld(Message);
{
         Result:=CallWindowProc(FWndProcOld, FControl.Handle, Msg, WParam, LParam)
       else
         Result:=CallWindowProc(DefWndProc, FControl.Handle, Msg, WParam, LParam);
}
       case Msg of

         CM_LMDDOCKED:

           Result := LRESULT(Self);

         WM_ENABLE:

           Enabled:=TWMENABLE(Message).Enabled;

         WM_DESTROY:
           begin
             RestoreWndProc;
             if not (csDestroying in ComponentState) then
               PostMessage(Handle, CM_REDOCK,0,0)        {send message to ourself}
             else
               FDestroying:=true;
           end;
         WM_MOVE, WM_SIZE:
           AdjustToControl;
         WM_SHOWWINDOW:
            if not (csDesigning in ComponentState) then

              if not TWMShowWindow(Message).Show then

                Visible:=False
               else
                 if not Visible then
                   begin
                     AdjustToControl;
                     Visible:=True;
                   end;
       end;
     end;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDDockButton.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FAdjustSize:=True;
  FDocked:=True;
  FMargin:=1;
  FPosition:=dpRight;
  FReflect:=True;
  FChanging:=False;
  FWndProcOld:=nil;

  // 6.0 New!
  ControlStyle:=ControlStyle-[csSetCaption];
  FGlyphKind:=gkEllipsis;

  Width:=22;
  Height:=22;
end;

{------------------------------------------------------------------------------}
destructor TLMDDockButton.Destroy;
begin
  RestoreWndProc;
  FControl:=nil;
  inherited Destroy;
end;

end.
