unit LMDCustomBevelPanel;
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

LMDCustomBevelPanel unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls,
  LMDCustomPanel, LMDBevel, LMDGraph, LMDClass;

type
  {-------------------TLMDCustomBevelPanel-------------------------------------}
  TLMDCustomBevelPanel=class(TLMDCustomPanel)
  private
    procedure SetBevel(aValue:TLMDBevel);
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure CMLMDBevelChanged(var Message:TMessage);message CM_LMDBEVELCHANGED;
  protected
    FBevel : TLMDBevel;
    FNoHandleUpdate:Boolean;
    function GetSizeRect:TRect;override;

    procedure DoThemeChanged; override;
    procedure MouseEnter; override;
    procedure MouseExit; override;
    procedure DoEnter; override;
    procedure DoExit; override;

    procedure RestoreBorderBack; override;
    procedure RestoreBorderFront; override;
    procedure AlignControls(AControl: TControl; var Rect: TRect);override;
    procedure AdjustClientRect(var Rect: TRect);override;
    function BevelExt:Integer;

    procedure CreateParams(var Params:TCreateParams);override;
    function DblBevelExt:Integer;
    function BeveledRect:TRect;
    procedure GetChange(Sender:TObject);override;
    function GetEmpty:Boolean;override;
    procedure Paint;override;
    function GetBevel:TLMDBevel; override;
    procedure CreateBevel; virtual;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    property Bevel:TLMDBevel read FBevel write SetBevel;
    property Transparent;
  published  
    property NoHandleUpdate:Boolean read FNoHandleUpdate write FNoHandleUpdate default false;
    {$IFDEF LMDCOMP14}
    property OnGesture;
    property Touch;
    {$ENDIF}
  end;

implementation

uses
  Types, SysUtils, Themes,
  LMDThemes;

{************************ Class TLMDCustomBevelPanel **************************}
{------------------------- Private---------------------------------------------}
Procedure TLMDCustomBevelPanel.SetBevel(aValue:TLMDBevel);
begin
  FBevel.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.CMLMDBevelChanged(var Message: TMessage);
begin
  if Bevel.SupportWindowsMode then
    RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (GetBevel.Mode=bmWindows) and not IsThemed then
    RecreateWnd;
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCustomBevelPanel.GetSizeRect:TRect;
begin
  result:=BeveledRect;
  Result.Left := Result.Right-GetSystemMetrics(SM_CXHSCROLL);
  Result.Top := Result.Bottom - GetSystemMetrics(SM_CYVSCROLL) ;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.DoEnter;
begin
  if ((not Focused) and (Flat)) or (FaceController <> nil) then
    RestoreBorderFront;
  inherited DoEnter;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.DoExit;
begin
  inherited DoExit;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomBevelPanel.DoThemeChanged;
var
  i: integer;
begin

  // Delphi 2k7 fix
  if {Showing and} (ComponentState * [csLoading, csReading] = []) then
    begin
      //VB August 2005
      //-- 7.02 --
      for i :=0 to ControlCount-1 do
        //if Controls[i] is TGraphicControl then
          Controls[i].Perform(WM_THEMECHANGED,0,0);
      //--
      ReCreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.MouseEnter;
begin
  ForceMouseAbove;
  if ((not Focused) and (Flat) and not (Entered)) then
    RestoreBorderFront;
  inherited MouseEnter;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.MouseExit;
begin
  inherited MouseExit;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.RestoreBorderFront;
begin
  if GetBevel.Mode = bmWindows then
    inherited RestoreBorderFront
  else
    GetBevel.PaintBevel(Canvas, GetClientRect, true);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.RestoreBorderBack;
begin
  if inherited GetBevel <> nil then //there is a bevel object set in the face controller
    begin
      GetBevel.PaintBevel(Canvas, GetClientRect, true);
      exit;
    end;
  if ((not Focused) and (Flat) and (not MouseAbove)) then
    if GetBevel.Mode = bmWindows then
      inherited RestoreBorderBack
    else
      begin   //erase Bevel
        //top
        RepBack (Rect (0, 0, Width, GetBevel.BevelExtend));
        //left
        RepBack (Rect (0, GetBevel.BevelExtend, GetBevel.BevelExtend, Height));
        //bottom
        RepBack (Rect (GetBevel.BevelExtend, Height-GetBevel.BevelExtendRight-1,
                       Width, Height));
        //right
        RepBack (Rect (Width - GetBevel.BevelExtendRight, GetBevel.BevelExtend,
                       Width, Height - GetBevel.BevelExtendRight));
      end;
end;

{------------------------------ Protected -------------------------------------}
procedure TLMDCustomBevelPanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  Rect:=GetBevel.ClientRect(Rect);
  inherited AlignControls(AControl, Rect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  //FlateRect(Rect, -FBevel.BevelExtend, -FBevel.BevelExtend);
end;

{------------------------------------------------------------------------------}
function TLMDCustomBevelPanel.BevelExt:Integer;
begin
  result:=GetBevel.BevelExtend
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
    begin
      if (GetBevel.Mode=bmWindows) then
        begin
          if NewStyleControls and Ctl3D then
            ExStyle := ExStyle or WS_EX_CLIENTEDGE
          else
            Style := Style or WS_BORDER;
        end;
      if IsThemed then
        begin
          ExStyle := ExStyle and not WS_EX_CLIENTEDGE;
          Style := Style and not WS_BORDER;
       end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.CreateBevel;
begin
  FBevel:=TLMDBevel.Create(Self);
end;

{------------------------------------------------------------------------------}
function TLMDCustomBevelPanel.GetBevel: TLMDBevel;
begin
  result:=inherited GetBevel;
  if result = nil then
    result:=FBevel;
end;


{------------------------------------------------------------------------------}
function TLMDCustomBevelPanel.DblBevelExt:Integer;
begin
  result:=2*BevelExt;
end;

{------------------------------------------------------------------------------}
function TLMDCustomBevelPanel.BeveledRect:TRect;
begin
  result:=GetBevel.ClientRect(GetClientRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.GetChange(Sender:TObject);
begin
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then exit;
  if Sender=FBevel then
    begin
      if FNoHandleUpdate or not (FBevel.ModeChanging) then
        Refresh
      else
        RecreateWnd;
      exit;
    end;
  inherited GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDCustomBevelPanel.GetEmpty;
begin
  result:=(GetBevel.BevelExtend=0) and (GetBevel.Mode<>bmWindows);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomBevelPanel.Paint;
var
  bRect: TRect;
  lThemeMode: TLMDThemeMode;
begin
  FillControl;

  if csDesigning in ComponentState then
    if GetEmpty and not SizeGrip then
      begin
        DrawDashedFrame;
        exit;
      end;

  if (Focused or not Flat or (csDesigning in ComponentState)) or (inherited GetBevel <> nil) then
    GetBevel.PaintBevel(Canvas, GetClientRect, Transparent)
  else
    RestoreBorderBack;

  if SizeGrip then
    begin
      bRect := GetSizeRect;
      lThemeMode := UseThemeMode;
      if lThemeMode <> ttmNone then
        LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, ThemeServices.GetElementDetails(tsGripper), bRect)
      else
        DrawFrameControl(Canvas.Handle, GetSizeRect, DFC_SCROLL, DFCS_SCROLLSIZEGRIP)
    end;
end;

{------------------------- Public----------------------------------------------}
constructor TLMDCustomBevelPanel.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  CreateBevel;
  FBevel.SupportWindowsMode:=True;
  FBevel.OnChange:=GetChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomBevelPanel.Destroy;
begin
  FreeAndNil(FBevel);
  inherited Destroy;
end;

end.
