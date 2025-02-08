unit LMDFormShadow;
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

LMDFormShadow unit ()
---------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Forms,
  Windows,
  Messages,
  Classes,
  LMDTypes,
  LMDWndProcComponent,
  LMDShadow,
  LMDGraph;

type
  {------------------------- TLMDFormShadow -----------------------------------}
  TLMDFormShadow = class(TLMDWndProcComponent)
  private
    bMouseCapture     : Boolean;
    hRightWindow      : HWND;
    hBottomWindow     : HWND;
    tmpShadowStyle    : TLMDShadowStyle;
    FShadow           : TLMDShadow;
    FIAShadow         : Boolean;
    procedure CreateShadow;
    procedure DestroyShadow;
    procedure HideShadow;
    function  IsNoShadow:Boolean;
    procedure MoveShadow;
    procedure SetShadow(aValue:TLMDShadow);
    procedure SetShadowParams(hWindow : HWND);
    procedure ShowShadowWnd(iCmdShow : Integer);
    procedure ShowShadow;
  protected
    procedure Init;override;
    procedure GetChange(Sender:TObject);override;
    procedure RestoreState;override;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
  published
    property About;
    property Shadow:TLMDShadow read FShadow write SetShadow;
    property Enabled;
    property ShowInActive:Boolean read FIAShadow write FIAShadow default True;
  end;

implementation
uses
  sysutils,  Graphics, Controls,
  LMDProcs, LMDGraphUtils, LMDClass;

{************************* Class TLMDShadow ***********************************}

const sClassName = 'LMDShadowClass';
      GWL_ShadowStyle= 0;
      GWL_Color      = 4;

function WndShadowProc(hWindow:HWnd; Message: UINT; wParam: WPARAM;
                        lParam: LPARAM): LRESULT; stdcall; export;
{$F+}
var
  ClientRect : TRect;
begin
  case Message of
    WM_SETFOCUS:
      begin
        Result := 0;
        exit;
      end;
    WM_ERASEBKGND:
      begin
        case TLMDShadowStyle(GetWindowLong(hWindow, GWL_ShadowStyle)) of
          hssSolid:
            with TCanvas.Create do
              try
                Handle      := HDC(wParam);
                Brush.Style := bsSolid;
                Brush.Color := TColor(GetWindowLong(hWindow, GWL_COLOR));
                GetClientRect(hWindow, ClientRect);
                FillRect(ClientRect);
                Result := 1;
                exit;
              finally
                Free;
              end;
          hssTracing:
            begin
              GetClientRect(hWindow, ClientRect);
              LMDFillPattern(HDC(wParam), ClientRect,
                             LMDApplication.GetBrushBitmap(TColor(GetWindowLong(hWindow, GWL_COLOR))));
              Result := 1;
              exit;
            end;
        end;
      end;
  end;
  Result := DefWindowProc(hWindow, Message, wParam, lParam);
end;
{$F-}

{--------------------------- Private ------------------------------------------}
procedure TLMDFormShadow.SetShadow(aValue:TLMDShadow);
begin
  FShadow.Assign(aValue);
end;

{------------------------------------------------------------------------------}

procedure TLMDFormShadow.SetShadowParams(hWindow : HWND);
begin
  with FShadow do
    begin
      SetWindowLong(hWindow, GWL_ShadowStyle, TLMDPtrInt(Style));
      SetWindowLong(hWindow, GWL_Color, TLMDPtrInt(Color));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShadow.DestroyShadow;
begin

  if  hRightWindow <> 0 then
    DestroyWindow(hRightWindow);
  if  hBottomWindow <> 0  then
    DestroyWindow(hBottomWindow);

  hRightWindow := 0;
  hBottomWindow := 0;

end;

{------------------------------------------------------------------------------}
function TLMDFormShadow.IsNoShadow:Boolean;
var
  Frm: TForm;
begin
  if  Owner is TForm  then
    begin
      Frm := TForm(Owner);
      Result := (not Frm.Visible)
            or isIconic(Frm.Handle)
            or isZoomed(Frm.Handle)
            or (not (Frm.FormStyle=fsMDiForm) and (not Frm.Active));
    end
  else
    Result := True;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShadow.MoveShadow;
var
  R:TRect;
begin

  GetWindowRect(TForm(Owner).Handle, R);
  with R,FShadow do
    begin
      InvalidateRect(hRightWindow, nil, True);
      InvalidateRect(hBottomWindow, nil, True);
      MoveWindow(hRightWindow,Right,Top+Depth, Depth,Bottom-Top-Depth, true);
      MoveWindow(hBottomWindow,Left+Depth, Bottom,Right-Left{+Depth-Depth},Depth,true);
    end;
  if not IsNoShadow then ShowShadowWnd(SW_SHOWNOACTIVATE);

end;

{------------------------------------------------------------------------------}

procedure TLMDFormShadow.ShowShadowWnd(iCmdShow: Integer);
begin
  ShowWindow(hRightWindow,iCmdShow);
  ShowWindow(hBottomWindow,iCmdShow);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShadow.ShowShadow;
begin
  ShowShadowWnd(SW_SHOWNOACTIVATE);
  end;

{------------------------------------------------------------------------------}
procedure TLMDFormShadow.HideShadow;
begin
  ShowShadowWnd(SW_HIDE);
  end;

{------------------------------------------------------------------------------}

{------------------------ Protected -------------------------------------------}
{$F+}
procedure TLMDFormShadow.WndProc(var Message: TMessage);

  procedure DoDefaultProc;
  begin
    inherited WndProc(Message);
  end;

var
  pOnChange:TNotifyEvent;

begin

  with Message do
    case Msg of
      CM_RECREATEWND:
        begin
          DestroyShadow;
          DoDefaultProc;
          CreateShadow;
          exit;
        end;
      WM_NCLBUTTONDOWN:
        begin

          HideShadow;
          tmpShadowStyle   := FShadow.Style;
          pOnChange        := FShadow.OnChange;
          FShadow.OnChange := NIL;
          tmpShadowStyle   := FShadow.Style;
          FShadow.Style    := hssNone;
          FShadow.OnChange := pOnChange;
          bMouseCapture    := true;

          DoDefaultProc;
          exit;
        end;

      WM_NCHITTEST,
      WM_NCMOUSEMOVE,
      WM_MOUSEMOVE,
      WM_NCLBUTTONUP,
      WM_LBUTTONUP:
        begin
          DoDefaultProc;

          if bMouseCapture then
            begin
              bMouseCapture    := false;
              pOnChange        := FShadow.OnChange;
              FShadow.OnChange := NIL;
              FShadow.Style    := tmpShadowStyle;
              FShadow.OnChange := pOnChange;
              if not IsNoShadow then ShowShadow;
            end;

          exit;
        end;
      else
        DoDefaultProc;
    end;

  with Message do
    case Msg of

      WM_DESTROY :
        DestroyShadow;
      WM_ACTIVATE:

        with TWMActivate(Message) do

          begin
            if Minimized then
              HideShadow
            else
              if Active=WA_INACTIVE then
                if not FIAShadow then HideShadow else
              else
                if IsNoShadow then
                  HideShadow
                else
                  ShowShadow;
          end;
      WM_SHOWWINDOW:
        begin
        if (wParam<>0) then
          begin
            if not isNoShadow then
              ShowShadow
            else
              HideShadow
          end
        else
          HideShadow;
        end;
      WM_MOVE:
        begin
          HideShadow;
          MoveShadow;
          end;
      {3.1}
      WM_WINDOWPOSCHANGED:
        if IsNoShadow then HideShadow;
      WM_SIZE:
        case wParam of
        SIZE_MAXIMIZED ,
          SIZE_MINIMIZED ,
          SIZE_MAXHIDE   ,
          SIZE_MAXSHOW   : HideShadow;
          SIZE_RESTORED  :
            begin
              MoveShadow;
              ShowShadow;
            end;
        else
          begin
            HideShadow;
            MoveShadow;
            end;
        end;
    end;

end;
{$F-}

{------------------------------------------------------------------------------}

procedure TLMDFormShadow.CreateShadow;
var
  R  : TRect;
  wc : TWndClass;
  TempClassInfo: TWndClass;
  Frm: TForm;
  ClassRegistered: Boolean;
begin
  if not (csDesigning in ComponentState) and Enabled
    and (Owner is TForm)  then
    begin
      Frm := TForm(Owner);
      wc.style         := CS_PARENTDC;
      wc.lpfnWndProc   := @WndShadowProc;
      wc.cbClsExtra    := 0;
      wc.cbWndExtra    := 5 * SizeOf(LongInt);
      wc.hInstance     := hInstance;
      wc.hIcon         := 0;
      wc.hCursor       := LoadCursor(0, IDC_ARROW);
      wc.hbrBackground := 0;
      wc.lpszMenuName  := '';
      wc.lpszClassName := sClassName;

      ClassRegistered := GetClassInfo(HInstance, wc.lpszClassName,
                          TempClassInfo);

      if  not ClassRegistered then
        Windows.RegisterClass(wc);

      GetWindowRect(Frm.Handle, R);

      with R, FShadow do
        begin
          hRightWindow := CreateWindow(sClassName,'',WS_POPUP,
            Right,Top+Depth, Depth,Bottom-Top-Depth,Frm.Handle,0,HInstance,nil);
          SetShadowParams(hRightWindow);
          hBottomWindow := CreateWindow(sClassName,'',WS_POPUP,
            Left+Depth,Bottom,Right-Left+Depth-Depth, Depth,Frm.Handle,0,HInstance,nil);
          SetShadowParams(hBottomWindow);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShadow.Init;
begin
  inherited Init;
  CreateShadow;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShadow.GetChange(Sender : TObject);
begin
  if (sender=FShadow) and not (csDesigning in ComponentState)
    and (hRightWindow <> 0) and (hBottomWindow <> 0)
    then
    begin
      SetShadowParams(hRightWindow);
      SetShadowParams(hBottomWindow);
      MoveShadow;
      RedrawWindow(hRightWindow,NIL,0,RDW_INVALIDATE or RDW_ERASE);
      RedrawWindow(hBottomWindow,NIL,0,RDW_INVALIDATE or RDW_ERASE);
      exit;
    end;
  inherited GetChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormShadow.RestoreState;
begin
  inherited RestoreState;
  if not (csDesigning in ComponentState) then
  begin
    DestroyShadow;
    Windows.UnRegisterClass(sClassName,hInstance);
    end;
end;

{-------------------------- Public --------------------------------------------}
constructor TLMDFormShadow.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if not (AOwner is TCustomForm) then
    raise ELMDOneInstError.Create(self.ClassName+': AOwner is not TCustomForm',0);
  {$IFDEF LMDCOMP9}if not (csDesigning in ComponentState) then{$ENDIF}
    if ((GetWindowLong(TCustomForm(Owner).Handle, GWL_STYLE) and WS_CHILDWINDOW)>0) then
      raise ELMDOneInstError.Create(self.ClassName+': owner window style cannot be WS_CHILDWINDOW',0); //VB doesn't work in D8 IDE
  if (TForm(Owner).FormStyle=fsMDIChild) then
    raise ELMDOneInstError.Create(self.ClassName+': owner form style cannot be fsMDIChild',0);
  if LMDCheckForSameClass(Owner, TLMDFormShadow, false) then
    raise ELMDOneInstError.Create(self.ClassName,0);

  FHandleMDI:=True;
  FShadow:= TLMDShadow.Create;
  FShadow.OnChange:=GetChange;
  FIAShadow:=True;
end;

{------------------------------------------------------------------------------}
destructor TLMDFormShadow.Destroy;
begin
  DestroyShadow;
  FShadow.Free;
  inherited Destroy;
end;

end.
