unit LMDSimplePanel;
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

LMDSimplePanel unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Windows, Messages, Classes, Controls,
  LMDCustomBevelPanel;

const
  defSizeGrip=16;

type
  TLMDSimplePanel = class(TLMDCustomBevelPanel)
  private
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
    procedure WMNCCalcSize(var Message: TWMNCCALCSIZE); message WM_NCCALCSIZE;
    procedure WMNCPaint(var Msg: TWMNCPaint); message WM_NCPAINT;
    procedure WMSIZE(var Message: TWMSIZE); message WM_SIZE;
  protected
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
  public
    constructor Create(AOwner: TComponent);  override;
    property CtlXP;  // compatibility
    property DockManager;
  published
    // 8.0
    property ParentBackground default false;
    // 7.01
    property NoHandleUpdate;
    // LMD V7 Enhancements
    property AllowMoving;
    property AllowSizing;
    property ControlLocked;
    property SizeGrip;
    property ThemeMode;
    property ThemeGlobalMode;
    property OnMove;

    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property UseDockManager default false;
    property DockSite;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;

    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnEndDock;
    property OnGetSiteInfo;
    property OnStartDock;
    property OnUnDock;
    property FaceController;
    property About;
    property Align;
//    property BackFX;
    property Bevel;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property Locked;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation

uses
  Types,
  LMDClass, LMDGraph;
{----------------------- private ----------------------------------------------}
{------------------------------------------------------------------------------}
procedure TLMDSimplePanel.CMCtl3DChanged(var Message: TMessage);
begin
  if NewStyleControls and (Bevel.Mode=bmWindows) then
    RecreateWnd
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimplePanel.WMNCCalcSize(var Message: TWMNCCalcSize);

begin
  inherited;
  if (Bevel.Mode=bmWindows) and IsThemed then
    begin
      with Message.CalcSize_Params^ do
       rgrc[0]:=Rect(rgrc[0].Left+1, rgrc[0].Top+1,
                rgrc[0].Right-1, rgrc[0].Bottom-1);
     end
end;

{------------------------------------------------------------------------------}
procedure TLMDSimplePanel.WMNCPaint(var Msg: TWMNCPaint);
var
  DC:HDC;
  Rgn, ExRgn:HRgn;
  lTheme: TLMDThemeMode;
begin
  lTheme:=UseThemeMode;
  if (Bevel.Mode=bmWindows) and (lTheme<>ttmNone) and not ((csLoading in ComponentState) or not IsWindowVisible(Handle)) then
    begin
      inherited;
      DC:=GetWindowDC(Handle);
      if DC<>0 then
        try
          Canvas.Lock;
          try
            Canvas.Handle:=DC;
            Rgn:=CreateRectRgn(0,0,Width,Height);
            ExRgn:=CreateRectRgn(1,1,Width-1,Height-1);
            SelectClipRgn(DC, Rgn);
            try
              ExtSelectClipRgn(DC, ExRgn, RGN_DIFF);
              DrawThemeBevel(lTheme, Canvas, Rect(0,0, Width, Height))
            finally
              DeleteObject(Rgn);
              DeleteObject(ExRgn);
              SelectClipRgn(Canvas.Handle,0);
              Canvas.Handle:=0;
            end;
          finally
            Canvas.UnLock;
          end;
        finally
          ReleaseDC(Handle, DC);
        end;
      end
    else
      inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimplePanel.WMSIZE(var Message: TWMSIZE);
begin
  inherited;
  if (Bevel.Mode=bmWindows) and IsThemed then
    Perform(WM_NCPaint, 0,0);
end;

{----------------------- protected --------------------------------------------}
procedure TLMDSimplePanel.AlignControls(AControl: TControl; var Rect: TRect);
begin
  if SizeGrip then
    Rect.Bottom:=Rect.Bottom-defSizeGrip;
  inherited;
end;

{----------------------- public -----------------------------------------------}
constructor TLMDSimplePanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //ControlStyle:=ControlStyle + [csOpaque]-[csParentBackground];
  ControlStyle:=ControlStyle + [csOpaque]{$IFDEF LMDCOMP7}-[csParentBackground]{$ENDIF};
  {$IFNDEF LMDCOMP7}
  BeginUpdate; 
  ParentBackground := false; 
  EndUpdate;
  {$ENDIF}
end;

end.
