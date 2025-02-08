unit LMDFormA;
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

LMDFormA unit (RM)
------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, SysUtils, Classes, Controls, Messages, Graphics, Forms, ShellApi, Menus,
  LMDClass, LMDCont, LMDGraph, LMDStrings, LMDBase, LMDProcs, LMDFormPersistent,
  LMDObject, LMDFMDrop, LMDWndProcComponent, LMDIniCtrl;

type
  {------------------------- TLMDForm -----------------------------------------}
  TLMDSendIntegerEvent=procedure(Sender:TObject; Value:Integer) of object;
  TLMDSendStringEvent=procedure(Sender:TObject; const Section:String) of object;

  {Ini-Support}
  {$EXTERNALSYM TLMDFormIniSaveOption}
  TLMDFormIniSaveOption=LMDFormPersistent.TLMDFormIniSaveOption;
  {$EXTERNALSYM TLMDFormIniSaveOptions}
  TLMDFormIniSaveOptions=LMDFormPersistent.TLMDFormIniSaveOptions;

  {general}
  {$EXTERNALSYM TLMDFormOption}
  TLMDFormOption=LMDFormPersistent.TLMDFormOption;
  {$EXTERNALSYM TLMDFormOptions}
  TLMDFormOptions=LMDFormPersistent.TLMDFormOptions;

  TLMDAutoDockSide = (adLeft, adTop, adBottom, adRight);
  TLMDAutoDockSides = set of TLMDAutoDockSide;

  TLMDAutoDockObject = class (TLMDObject)
  private
    FAfterMove,
    FEnabled : Boolean;
    FMoveOut,
    FSides   : TLMDAutoDockSides;
    FLeft,
    FRight,
    FTop,
    FBottom  : Integer;
  public
    constructor Create(Owner:TPersistent=nil); override;
  published
    property AfterMove : Boolean read FAfterMove write FAfterMove default true;
    property Enabled   : Boolean read FEnabled write FEnabled default false;
    property Sides     : TLMDAutoDockSides read FSides write FSides default [adLeft, adTop, adBottom, adRight];
    property MoveOut   : TLMDAutoDockSides read FMoveOut write FMoveOut default [adLeft, adTop, adBottom, adRight];
    property Left      : Integer read FLeft write FLeft default 40;
    property Right     : Integer read FRight write FRight default 40;
    property Top       : Integer read FTop write FTop default 40;
    property Bottom    : Integer read FLeft write FLeft default 40;
  end;

  TLMDForm=class(TLMDFormPersistent)
  private
    FCharCase      : TLMDCharCase;
    FAutoDock      : TLMDAutoDockObject;
    FAcceptFiles   : Boolean;
    FEffect        : TLMDDlgEffect;

    FOnAPMResume    : TNotifyEvent;
    FOnAPMCriticalResume:TNotifyEvent;
    FOnAPMSuspend   :TLMDStandardEvent;
    FOnCompacting   :TLMDSendIntegerEvent;
    FOnDevModeChange:TLMDSendStringEvent;
    FOnDragDrop     :TLMDFMDragDropEvent;
    FOnFontCHange   :TNotifyEvent;
    FOnPaintIcon    :TNotifyEvent;
    FOnSpoolerStatus:TLMDSendIntegerEvent;
    FOnTimeChange   :TNotifyEvent;
    FOnWinIniChange :TLMDSendStringEvent;
    procedure SetAutoDock(const Value: TLMDAutoDockObject);
    procedure HandleMessage(var Message:TMessage);
    procedure SetAcceptFiles(aValue:Boolean);
  protected
    procedure Init; override;
    procedure RestoreState;override;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AcceptFiles:Boolean read FAcceptFiles write SetAcceptFiles default false;
    property CharCase:TLMDCharCase read FCharCase write FCharCase default ccNormal;
    property Effect:TLMDDlgEffect read FEffect write FEffect default deNone;
    property AutoDock:TLMDAutoDockObject read FAutoDock write SetAutoDock;

    {Events}
    property OnAPMCriticalResume:TNotifyEvent read FOnAPMCriticalResume write FOnAPMCriticalResume;
    property OnAPMResume:TNotifyEvent read FOnAPMResume write FOnAPMResume;
    property OnAPMSuspendRequest:TLMDStandardEvent read FOnAPMSuspend write FOnAPMSuspend;
    property OnCompacting:TLMDSendIntegerEvent read FonCompacting write FOnCompacting;
    property OnDevModeChange:TLMDSendStringEvent read FOnDevModeChange write FOnDevmodeChange;
    property OnIniChange:TLMDSendStringEvent read FOnWinIniChange write FOnWinIniChange;
    property OnFMDragDrop:TLMDFMDragDropEvent read FOnDragDrop write FOnDragDrop;
    property OnPaintIcon:TNotifyEvent read FOnPaintIcon write FOnPaintIcon;
    property OnSpoolerStatus:TLMDSendIntegerEvent read FOnSpoolerStatus write FOnSpoolerStatus;
    property OnTimeChange:TNotifyEvent read FOnTimeChange write FonTimeChange;
  end;

implementation

uses
  Types, 
  LMDSysIn, LMDUtils;

{************************* Class TLMDAutoDockObject****************************}
{ -------------------------- public ------------------------------------------ }
constructor TLMDAutoDockObject.Create;
begin
  inherited Create;
  FEnabled := false;
  FSides   := [adLeft, adTop, adBottom, adRight];
  FMoveOut := [adLeft, adTop, adBottom, adRight];
  FLeft    := 40;
  FRight   := 40;
  FTop     := 40;
  FBottom  := 40;
  FAfterMove := true;
end;

{************************* Class TLMDForm**************************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDForm.SetAcceptFiles(aValue:Boolean);
begin
  if aValue<>FAcceptFiles then
    begin
      FAcceptFiles:=aValue;
      if not (csDesigning in ComponentState) and Enabled then
        DragAcceptFiles(WndHandle, FAcceptFiles);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDForm.SetAutoDock(const Value: TLMDAutoDockObject);
begin
  FAutoDock.Assign(Value)
end;

{------------------------------------------------------------------------------}
procedure TLMDForm.HandleMessage(var Message:TMessage);
var
  aList:TStringList;
  tmp:Boolean;
  tmpp:TPoint;
  i, size, count:Integer;
  FileName: string;
  hDrop: THandle;
  buffer:array[0..MAX_PATH] of Char;
  begin
   with Message do
     case Msg of
       WM_DROPFILES:
           begin
             hDrop := THandle(Message.wParam);
             count:=DragQueryFile(hDrop, $FFFFFFFF, nil, 0);
             if Count>0 then
               begin
                 DragQueryPoint(hDrop, tmpp);
                 aList:=TStringList.Create;
                 try
                   for i := 0 to (count-1) do
                     begin
                       size:=DragQueryFile(hDrop, i, nil, 0);
                       if size < MAX_PATH then
                         begin
                           DragQueryFile(hDrop, i, buffer, size + 1);
                           FileName := StrPas(buffer);
                           case FCharCase of
                             ccNormal:    aList.Add(FileName);
                             ccUpperCase: aList.Add(LMDAnsiUpperCase(FileName));
                             ccLowerCase: aList.Add(LMDAnsiLowerCase(FileName));
                           end;
                         end;
                     end;
                   FOnDragDrop(self, Count, tmpp.X, tmpp.Y, aList);
                 finally
                   aList.Free;
                 end;
               end;
           end;
       WM_POWER: {Only Win <4}
         begin
           tmp:=false;
           FOnAPMSuspend(Self, tmp);
           if tmp then Result:=PWR_FAIL;
        end;
     end;

end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDForm.Init;
begin
  inherited Init;
  if Enabled then
    if not (csDesigning in ComponentState) then
      begin
        if  FAcceptFiles  then
          DragAcceptFiles(WndHandle, FAcceptFiles);
        SetRunTimeValues;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDForm.RestoreState;
begin
  if not (csDesigning in ComponentState) then
    DragAcceptFiles(WndHandle, False);
  inherited RestoreState;
end;

{------------------------------------------------------------------------------}
procedure TLMDForm.WndProc(var Message: TMessage);

var
  p : TPoint;

  procedure AlignForm2 (var x, y : Integer);
  var
    dockRect,
    aRect : TRect;
  begin
    aRect.Left := x;
    aRect.Top := y;

    dockRect := ScreenWorkArea;

    if (adLeft in FAutoDock.Sides) then
      if x < dockRect.Left + FAutoDock.Left then
        aRect.Left := 0;

    if adRight in FAutoDock.Sides then
      if x + WndOwner.Width > dockRect.Right- FAutoDock.Right then
        aRect.Left := dockRect.Right - WndOwner.Width;

    if adTop in FAutoDock.Sides then
      if y < dockRect.Top + FAutoDock.Top then
        aRect.Top := dockRect.Top;

    if adBottom in FAutoDock.Sides then
      if y + WndOwner.Height > dockRect.Bottom - FAutoDock.Bottom then
        aRect.Top := DockRect.Bottom - WndOwner.Height;

    if (x < 0) and (adLeft in FAutoDock.MoveOut) then
      aRect.Left := X;
    if (y < 0) and (adTop in FAutoDock.MoveOut) then
      aRect.Top := y;
    if (x + WndOwner.Width > DockRect.Right) and (adRight in FAutoDock.MoveOut) then
      aRect.Left := x;
    if (y + WndOwner.Height > DockRect.Bottom) and (adBottom in FAutoDock.MoveOut) then
      aRect.Top := y;
    x:=aRect.Left;
    y:=aRect.Top;
  end;

begin

  if not Enabled then
    begin
      inherited WndProc(Message);
      exit;
    end;

   with Message do
     begin
       case msg of
         WM_COMPACTING:
           if Assigned(FOnCompacting) then
             FOnCompacting(self, TWMCompacting(Message).CompactRatio);
             WM_DROPFILES:
           if Assigned(FOnDragDrop) then HandleMessage(Message);
         WM_DEVMODECHANGE:
           If Assigned(FOnDevModeChange) then
             FOnDevModeChange(Self, StrPas(PChar(TWMDevModeChange(Message).Device)));
             WM_FONTCHANGE:
           if Assigned(FOnFontCHange) then
             FOnFontChange(Self);
         WM_EXITSIZEMOVE: if (FAutoDock.Enabled) then
                            begin
                              p := Point (WndOwner.Left, WndOwner.Top);
                              AlignForm2 (p.X, p.Y);
                              WndOwner.SetBounds (p.X, p.Y, WndOwner.Width, WndOwner.Height);
                            end;
         WM_PaintIcon:
           if Assigned(FOnPaintIcon) then
             FOnPaintIcon(Self);
         WM_POWER: {Only Win <4}
            case TWMPOWER(Message).PowerEvt of
            PWR_CRITICALRESUME:If Assigned(FOnAPMCriticalResume) then FOnAPMCriticalResume(self);
              PWR_SUSPENDRESUME:If Assigned(FOnAPMResume) then FOnAPMResume(self);
              PWR_SUSPENDREQUEST:If Assigned(FOnAPMSuspend) then HandleMessage(Message);
            end;
         WM_SHOWWINDOW:
           with TWMShowWindow(Message) do
           if Show and (Status=0) and (FEffect<>deNone) then {window is shown}
               case FEffect of
                 deExplode:LMDExplodeForm(TForm(Owner));
                 deExplodeExt:LMDExplodeForm2(TForm(Owner));
               end;
         WM_SPOOLERSTATUS:
           if Assigned(FOnSpoolerStatus) then
             FOnSpoolerStatus(Self, TWMSPoolerStatus(Message).JobsLeft);
             WM_TIMECHANGE:
           if assigned(FOnTimeChange) then
             FOnTimeChange(Self);
         WM_WININIChange:
           If Assigned(FOnWinIniChange) then
             FOnWinIniChange(Self, StrPas(PChar(TWMWININICHANGE(Message).Section)));
             WM_WINDOWPOSCHANGING:
           begin
             if (FAutoDock.Enabled) and (not FAutoDock.AfterMove) then
               begin

                 if (TWindowPos(Pointer(lParam)^).X <> WndOwner.Left) or ( TWindowPos(Pointer(lParam)^).Y <> WndOwner.Top) then
                   AlignForm2 (TWindowPos(Pointer(lParam)^).X, TWindowPos(Pointer(lParam)^).Y);

               end;
           end;
       end;
     end;

  inherited WndProc(Message);

  if  Message.Msg = CM_RECREATEWND  then
    begin
      if  FAcceptFiles  then
        DragAcceptFiles(WndHandle, FAcceptFiles);
    end;

end;

{--------------------------- Public -------------------------------------------}
constructor TLMDForm.Create(AOwner:TComponent);
begin
  inherited Create(aOwner);
  FAcceptFiles:=False;
  FCharCase:=ccNormal;
  FAutoDock := TLMDAutoDockObject.Create;
  FAutoDock.OnChange:=GetChange;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDForm.Destroy;
begin
  FreeAndNil(FAutoDock);
  inherited Destroy;
end;

end.
