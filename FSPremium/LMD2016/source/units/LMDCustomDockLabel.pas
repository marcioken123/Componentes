unit LMDCustomDockLabel;
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

LMDCustomDockLabel unit ()
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Controls, Classes, Messages,
  LMDBase, LMDClass, LMDTypes, LMDCustomSimpleLabel;

type
  {-------------------TLMDCustomDockLabel--------------------------------------}
  TLMDCustomDockLabel=class(TLMDCustomSimpleLabel)
  private
    FAdjustSize,
    FChanging,
    FDocked,
    FDestroying,
    FReflect    : Boolean;
    FPosition   : TLMDDockPosition;
    FMargin     : Integer;
    FWndProc    : TFarProc;
    FWndProcOld : TFarProc;
    procedure SetBoolean(Index:Integer; aValue:Boolean);
    procedure SetControl(aValue:TWinControl);
    procedure SetMargin(aValue:Integer);
    procedure SetPosition(aValue:TLMDDockPosition);

    procedure AdjustToControl;
    procedure AdjustToLabel;
    procedure InitWndProc;
    procedure RestoreWndProc;
    function HasControl:Boolean;
    procedure ReadIdent(Reader: TReader);
  protected
    procedure BoundsChange(State:TLMDBoundsChangeStates);override;
    procedure DefineProperties(Filer:TFiler);override;
    procedure DockControl;
    procedure Loaded;override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure Notification(AComponent: TComponent;Operation:TOperation);override;
    procedure OwnWndProc(var Message: TMessage);

    property AdjustDockedSize:Boolean index 0 read FAdjustSize write SetBoolean default False;
    property Docked:Boolean index 1 read FDocked write SetBoolean default True;
    property FocusControl:TWinControl read GetControl write SetControl;
    property Margin:Integer read FMargin write SetMargin default 1;
    property Position:TLMDDockPosition read FPosition write SetPosition default dpLeft;
    property ReflectOwnChanges:Boolean index 2 read FReflect write SetBoolean default False;
  public
    constructor Create(aOwner:TComponent);override;
    destructor Destroy;override;
    procedure CorrectBounds;override;
  published
    property About;
    property Action;
    property Align;
  end;

implementation

uses
  Types, SysUtils, Forms, Graphics,
  LMDUtils, LMDGraphUtils;

{************************* Class TLMDCustomDockLabel **************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDCustomDockLabel.SetControl(aValue:TWinControl);
var
  tmp, tmp1:TComponent;
  T: integer;
begin
  if aValue<>GetControl then
    begin
      RestoreWndProc;
      FControl:=aValue;
      //tmp := nil;
      if (GetControl<>nil) and GetControl.HandleAllocated then
        begin
          T := SendMessage(FControl.Handle, CM_LMDDOCKED, 0, 0);
//          tmp:=TComponent(SendMessage(FControl.Handle, CM_LMDDOCKED, 0, 0));

          if T <> 0 then
            begin

              tmp:=TComponent(T);

              tmp1:=FControl;
              FControl:=nil;
              LMDRaiseDockError(tmp, tmp1);
            end
          else
            begin
              GetControl.FreeNotification(Self);
              DockControl;
            end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.SetBoolean(Index:Integer; aValue:Boolean);
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
           if FReflect and HasControl then AdjustToLabel;
         end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.SetMargin(aValue:Integer);
begin
  if FMargin<>aValue then
    begin
      FMargin:=aValue;
      if HasControl then AdjustToControl;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.SetPosition(aValue:TLMDDockPosition);
begin
  if FPosition<>aValue then
    begin
      FPosition:=aValue;
      if HasControl then AdjustToControl;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomDockLabel.HasControl:Boolean;
begin
  result:=FDocked and (FControl<>nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.InitWndProc;
var
  tmp:TFarProc;
begin
   If HasControl and not Assigned(FWndProcOld)  then
    try
      FControl.HandleNeeded;
      tmp:=TFarProc(GetWindowLong(FControl.Handle, GWL_WNDPROC));

      {3.1: form inheritance}
//      if tmp=FWndProc then exit;
      FWndProcOld:=tmp;

      SetWindowLong(FControl.Handle, GWL_WNDPROC, TLMDPtrInt(FWndProc));

    except
      on Exception do RestoreWndProc;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.RestoreWndProc;
begin
  FDestroying:=True;
  try
    if Assigned(FWndProcOld) and Assigned(FControl) and (FControl.HandleAllocated) then
      SetWindowLong(FControl.Handle, GWL_WNDPROC, TLMDPtrInt(FWndProcOld));
    FWndProcOld:=nil;
  finally
    FDestroying:=False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.AdjustToControl;
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
procedure TLMDCustomDockLabel.AdjustToLabel;
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
procedure TLMDCustomDockLabel.ReadIdent(Reader: TReader);
begin
  FAdjustSize:=Reader.ReadBoolean;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDCustomDockLabel.BoundsChange(State:TLMDBoundsChangeStates);
begin
  if FReflect and HasControl then AdjustToLabel;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.CorrectBounds;
var
  aRect:TRect;
  flags:LongInt;
begin
  if not Assigned(FControl) or not FDocked then
    inherited CorrectBounds
  else
    // 7.0.61: Align test
    if (Align=alNone) and AutoSize and not (csLoading in ComponentState) then
      begin
        aRect:=GetClientRect;
        flags:=0;
        flags:=DrawTextBiDiModeFlags(flags);
        LMDDrawTextCalcExt(Canvas, GetLabelText, Font3D, aRect, Font, MultiLine,
                           ShowAccelChar, 0, flags);
        {FChanging:=False;
        try}
        case FPosition of
          dpTop, dpBottom:
            begin
              if FAdjustSize then aRect.Right:=Width;
              SetBounds(Left, Top, aRect.Right, aRect.Bottom);
            end;
          dpRight, dpLeft:
            begin
              if FAdjustSize then aRect.Bottom:=Height;
              SetBounds(Left, Top, aRect.Right, aRect.Bottom);
            end;
        end;
        {finally
          FChanging:=False;
        end;}
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('AdjustSize', ReadIdent, nil, False);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.DockControl;
begin
  if not HasControl or (csLoading in ComponentState) then exit;
  FChanging:=False;
  InitWndProc;
  AdjustToControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.Loaded;
begin
  inherited Loaded;
  DockControl;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  try
    if HasControl and FControl.Visible then FControl.SetFocus;
  except
    Abort;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.Notification(AComponent: TComponent;  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FControl) and (Operation=opRemove) then
    begin
      self.SetControl(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDockLabel.OwnWndProc(var Message: TMessage);

begin
   if FDestroying {or (csDestroying in ComponentState)} then exit;
   with Message do
     begin
       if Assigned(FWndProcOld) then
         result:=CallWindowProc(FWndProcOld, FControl.Handle, Msg, WParam, LParam);

       case Msg of
         CM_LMDDOCKED:

           Result := LRESULT(Self);

         WM_ENABLE:
           Enabled:=TWMENABLE(Message).Enabled;
         WM_DESTROY:
           begin
             RestoreWndProc;
             if (csDestroying in ComponentState) then  //VB Jul 2009 "FControl = nil" removed
               FDestroying:=true;
           end;
         WM_MOVE, WM_SIZE:
           begin
             AdjustToControl;
             if csDesigning in ComponentState then
               exit;
           end;
         WM_SHOWWINDOW:
           if not (csDesigning in ComponentState) then
             begin
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
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDCustomDockLabel.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FAutoSize:=False;
  FAdjustSize:=False;
  FDocked:=True;
  FMargin:=1;
  FPosition:=dpLeft;
  FReflect:=False;
  FChanging:=False;
  FWndProc := Classes.MakeObjectInstance(OwnWndProc);
  FWndProcOld:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomDockLabel.Destroy;
begin
  RestoreWndProc;
  FControl:=nil;
  Classes.FreeObjectInstance(FWndProc);
  FWndProc:=nil;
  inherited Destroy;
end;

end.
