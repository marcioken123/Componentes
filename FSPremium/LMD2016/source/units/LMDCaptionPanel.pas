unit LMDCaptionPanel;
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

LMDCaptionPanel unit (RM)
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Forms, Graphics, Messages, StdCtrls,
  LMDBase, LMDClass, LMDGraph, LMDObject, LMDCustomBevelPanel, LMDCustomPanel,
  LMDPanelCaptionObject;

const
  def_CaptionButtonReduce=3;
  def_GroupScrollBar=16;

type

  TLMDCaptionPanelClient=class(TLMDCustomPanel)
  private
    FParent:TComponent;
  protected
    function GetEmpty:Boolean;override;
    procedure ReadState(Reader: TReader); override;
    // Make compiler in CLR happy
    procedure Click;override;
  public
    function GetParentComponent:TComponent; override;
    constructor Create(AOwner : TComponent);override;
    property Canvas;
    property OnMouseDown;
    property OnMouseUp;
    property OnMouseMove;
    property OnClick;
    property OnDblClick;
    //-----
    property Transparent;
  published
    property Height stored false;
    property Left stored false;
    property Top stored false;
    property Width stored false;
    property TabStop stored false;
    property TabOrder stored false;
    property UseDockManager stored false;
    property ParentColor stored false;
  end;

  TLMDCaptionPanelRequestEvent=procedure(Sender:TObject; var Cancel:Boolean) of object;
  TLMDCaptionPanelDrawEvent=procedure(Sender:TObject; aCanvas:TCanvas; aRect:TRect) of object;

  TLMDCaptionPanel = class(TLMDCustomBevelPanel)
  private
    FHeight,
    FIndex:Integer;
    FCaptionSettings: TLMDPanelCaptionObject;
    FExpanded: Boolean;

    FOnCaptionDraw:TLMDCaptionPanelDrawEvent;
    FOnCloseBtnClick,
    FOnCollapsing,
    FOnExpanding: TLMDCaptionPanelRequestEvent;
    FOnHelpBtnClick,
    FOnCollapsed,
    FOnExpanded:TNotifyEvent;

    FCaption: TCaption;
    FButtonList:TList;

    FClient:TLMDCaptionPanelClient;
    FCustomData:String;
    procedure WriteInteger(Writer: TWriter);
    //procedure WritePanel(Stream:TStream);
    procedure ReadInteger(Reader:Treader);
    //procedure ReadPanel(Stream:TStream);

    procedure SetCaptionSettings(const Value: TLMDPanelCaptionObject);
    procedure SetExpanded(const Value: Boolean);
    procedure SetCaption(const Value: TCaption);

    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMVisibleChanged(var Message: TMessage); message CM_VISIBLECHANGED;
    procedure CMTransparentChanged(var Message: TMessage); message CM_TRANSPARENTCHANGED;
    procedure WMNCHitTest(var Message: TWMNCHitTest);message WM_NCHitTest;
    procedure WMSize(var Msg: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMOVE); message WM_MOVE;
    procedure SetIndex(const Value: Integer);
    function GetPanelGroup: TComponent;
    procedure PassMouseEventsToClient;
  protected
    procedure ReadState(Reader: TReader); override;
    function GetChildOwner:TComponent;override;

    procedure AdjustClientRect(var aRect: TRect); override;
    procedure AlignControls(AControl: TControl; var aRect: TRect);override;
    //function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure CreateWnd;override;
    procedure CreateParams(var Params:TCreateParams);override;
    procedure DefineProperties(Filer: TFiler);override;
    procedure DoClick(Sender: TObject);
    procedure DoMove;override;

    procedure DoMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DoMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure DoMouseClick(Sender: TObject);
    procedure DoMouseDblClick(Sender: TObject);

    function GetCaptionRect:TRect;
    procedure GetChange(Sender:TObject);override;
    // limit "Move" - feature on titlebar
    function GetMoveRect:TRect;override;
    procedure InitButtonList;
    procedure ClearButtonList;
    procedure Paint;override;
    procedure Loaded;override;
    procedure PaintCaptionBar(aRect:TRect);

    property InternalSize:Integer read FHeight write FHeight;
  public
    constructor Create(AOwner : TComponent);override;
    destructor Destroy;override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent);override;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer);override;
    procedure Change;
    procedure Expand;
    procedure Collapse;
    procedure SetSilentIndex(Index:Integer);

    // 7.01: Access to internal client panel
    property ClientPanel:TLMDCaptionPanelClient read FClient;
    // --------------
    property DockManager;
    property PanelGroup:TComponent read GetPanelGroup;
  published
    // useful in TLMDCaptiongroup only
    property PanelIndex:Integer read FIndex write SetIndex default 0;

    property Caption:TCaption read FCaption write SetCaption;
    property CaptionSettings:TLMDPanelCaptionObject read FCaptionSettings write SetCaptionSettings;
    property CustomData:String read FCustomData write FCustomData;
    property Expanded:Boolean read FExpanded write SetExpanded default True;

    property OnCloseBtnClick:TLMDCaptionPanelRequestEvent read FOnCloseBtnClick write FOnCloseBtnClick;
    property OnHelpBtnClick:TNotifyEvent read FOnHelpBtnClick write FOnHelpBtnClick;
    property OnCollapsing:TLMDCaptionPanelRequestEvent read FOnCollapsing write FOnCollapsing;
    property OnExpanding:TLMDCaptionPanelRequestEvent read FOnExpanding write FOnExpanding;
    property OnCollapsed:TNotifyEvent read FOnCollapsed write FOnCollapsed;
    property OnExpanded:TNotifyEvent read FOnExpanded write FOnExpanded;
    property OnCaptionDraw:TLMDCaptionPanelDrawEvent read FOnCaptionDraw write FOnCaptionDraw;
    property OnMove;

    // LMD V7 Enhancements
    property AllowSizing;
    property AllowMoving default true;
    property AutoBringToFront;
    property ControlLocked;

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

    Property About;
    property Align;
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
    property ThemeGlobalMode;
    property ThemeMode;
  end;

implementation
uses
  Types, SysUtils, ExtCtrls,
  LMDCaptionPanelGroup, LMDSysIn, LMDButtonBase, LMDProcs, LMDBaseGraphicControl,
  UxTheme, Themes,
  LMDThemes,LMDFxCaption, LMDGraphUtils;

type
  TLMDParentGroup=class(TLMDCaptionPanelGroup)
  public
     // not for public use
    //procedure FixPanelIndex;override;
    //procedure UpdatePanelIndex(Value, old:Integer);override;
  end;

{------------------------------------------------------------------------------}
{procedure TLMDParentGroup.FixPanelIndex;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
{procedure TLMDParentGroup.UpdatePanelIndex(Value,old:Integer);
begin
  inherited;
end;
}

type
  TLMDSystemButtonStyle=(sbsHelp, sbsMin, sbsClose, sbsMax);

  TLMDSystemButton = class(TLMDBaseGraphicControl)
  private
    FStyle: TLMDSystemButtonStyle;
    FMouseOver,
    FPressed: Boolean;
    FOwner:TComponent;
    procedure SetStyle(const Value: TLMDSystemButtonStyle);
  protected
    procedure DblClick;override;
    procedure MouseDown(Button:TMouseButton; Shift:TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift:TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;  X, Y: Integer); override;
    procedure MouseEnter;override;
    procedure MouseExit;override;
    procedure Paint;override;
  public
    constructor Create(AOwner : TComponent);override;
    destructor Destroy;override;
    property Style:TLMDSystemButtonStyle read FStyle write SetStyle;
    procedure Click;override;
  end;

{ TLMDSystemButton }
{ *************************** Private *****************************************}
{------------------------------------------------------------------------------}
procedure TLMDSystemButton.SetStyle(const Value: TLMDSystemButtonStyle);
begin
  if Value<>FStyle then
    begin
      FStyle:=Value;
      Invalidate;
    end;
end;

{ *************************** Protected ***************************************}
{------------------------------------------------------------------------------}
procedure TLMDSystemButton.Click;
var
  tmp:Boolean;
begin
  inherited;
  if Owner is TLMDCaptionPanel then
    with TLMDCaptionPanel(Owner) do
     Case FStyle of
       sbsHelp: DoClick(nil);
       sbsMin:
        if Expanded then Collapse;
       sbsMax:
        if not Expanded then Expand;
       sbsClose:
         begin
           tmp:=false;
           if Assigned(OnCloseBtnClick) then
             OnCloseBtnClick(self, tmp);
            if not tmp then
              Visible:=False; // event
         end;
     end;

end;

{------------------------------------------------------------------------------}
procedure TLMDSystemButton.DblClick;
begin
  inherited;
  Click;
end;

{------------------------------------------------------------------------------}
procedure TLMDSystemButton.MouseEnter;
begin
  inherited;
  FMouseOver:=True;
  Repaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDSystemButton.MouseExit;
begin
  inherited;
  FMouseOver:=False;
  Repaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDSystemButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if (Button=mbLeft) and not FPressed then
    begin
      FPressed:=True;
      Repaint;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSystemButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  tp:TPoint;
begin
  inherited;
  tp:=Point(X,y);
  if MouseCapture Then
    begin
      if PtInRect(ClientRect,tp)<>FMouseOver then
        begin
          FMouseOver:=not FMouseOver;
          RePaint;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSystemButton.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if FPressed then
    begin
      FPressed:=False;
      RePaint;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSystemButton.Paint;
var
  uType,
  uState :UINT;
  aRect:TRect;
  lThemeMode: TLMDThemeMode;
  dt: TThemedElementDetails;
begin
  if ThemeGlobalMode then
    lThemeMode := LMDApplication.ThemeGlobalMode
  else
    lThemeMode := LMDThemeServices.UseTheme(TLMDCaptionPanel(Parent).ThemeMode);

  aRect:=ClientRect;
  uState:=0;
  uType := DFC_CAPTION;
  dt.Element := teWindow;

  case FStyle of
    sbsClose: begin uState:=DFCS_CAPTIONCLOSE; dt.Part := WP_MDICLOSEBUTTON; end;
    sbsHelp: begin uState:=DFCS_CAPTIONHELP; dt.Part := WP_MDIHELPBUTTON; end;
    sbsMAX: begin uState:=DFCS_CAPTIONMAX; dt.Part := WP_MDIRESTOREBUTTON; end;
    sbsMIN: begin uState:=DFCS_CAPTIONMIN; dt.Part := WP_MDIMINBUTTON; end;
  end;

  dt.State := 1;
  if not Enabled then
    begin
      uState:=uState or DFCS_INACTIVE;
      dt.State := 4;
    end;
  if FMouseOver then
    begin
      uState:=uState or DFCS_HOT;
      dt.State := 2;
    end;
  if FPressed then
    begin
      uState:=uState or DFCS_PUSHED;
      dt.State := 3;
    end;

  //SetBkMode(Canvas.Handle,Windows.TRANSPARENT);
  if lThemeMode = ttmNone then
    DrawFrameControl (Canvas.Handle, aRect, uType, uState)
  else
    begin
      InflateRect(aRect, 1, 1);
      LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, dt, aRect);
    end;
end;

{ *************************** Public ******************************************}
{------------------------------------------------------------------------------}
constructor TLMDSystemButton.Create(AOwner: TComponent);
begin
  inherited;
  FOwner:=aOwner;
end;

{------------------------------------------------------------------------------}
destructor TLMDSystemButton.Destroy;
begin
  inherited;
end;

{ TLMDCaptionPanelClient }
{ *************************** Protected ***************************************}
{------------------------------------------------------------------------------}
function TLMDCaptionPanelClient.GetEmpty: Boolean;
begin
  result:=false;
end;

{ *************************** Public ******************************************}
{------------------------------------------------------------------------------}
constructor TLMDCaptionPanelClient.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle:=ControlStyle+[csAcceptsControls];
  Height:=100;
  ParentColor:=True;
  FParent:=aOwner;
  SetSubComponent(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelClient.Click;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanelClient.GetParentComponent: TComponent;
begin
  result:=FParent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanelClient.ReadState(Reader: TReader);
begin
  inherited;
  if Reader.Parent is TLMDCaptionPanel then
    TLMDCaptionPanel(Reader.Parent).FClient:=self;
end;

{ TLMDCaptionPanelClient }
{ *************************** Private ***************************************}
{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  RePaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.CMTransparentChanged(var Message: TMessage);
begin
  inherited;
  if not (csLoading in ComponentState) then
    FClient.Transparent:=self.Transparent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.CMVisibleChanged(var Message: TMessage);
begin
  inherited;
  if csLoading in ComponentState then exit;
  if (Parent is TLMDCaptionPanelGroup) then
    TLMDCaptionPanelGroup(Parent).Change;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanel.GetPanelGroup: TComponent;
begin
  result:=nil;
  if (Parent is TLMDCaptionPanelGroup) then
    result:=Parent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.ReadInteger(Reader: TReader);
begin
  FHeight:=Reader.ReadInteger;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.SetCaption(const Value: TCaption);
begin
  if Value<>FCaption then
    begin
      FCaption := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.SetCaptionSettings(const Value: TLMDPanelCaptionObject);
begin
  FCaptionSettings.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionPanel.SetExpanded(const Value: Boolean);
var
  tmp:Boolean;
  tp:TComponent;
  bw: Byte;  // Normally Bevel.BevelExtend is true - but here we need width even when WindowsMode is on

  function SearchMinMax:TComponent;
  var
    i:Integer;
  begin
    result:=nil;
    if not (pcsMinMax in FCaptionSettings.Buttons) then exit;
    for i:=0 to Pred(ControlCount) do
      if (Controls[I] is TLMDSystemButton) and (TLMDSystemButton(Controls[i]).Style in [sbsMin, sbsMax]) then
        begin
          result:=Controls[i];
          exit;
        end;
  end;

begin
  if Value<>FExpanded then
    begin
      tmp:=False;
      if Bevel.Mode=bmWindows then bw:=1 else bw:=Bevel.BevelExtend;
      if FExpanded then
        begin
          BeginUpdate;
          try
            if not (csLoading in ComponentState) then
              begin
                // --> Collapse
                If Assigned(FOnCollapsing) then FOnCollapsing(self, tmp);
                if tmp then exit;
              end;

            case FCaptionSettings.Position of
              fsTop, fsBottom:
                begin
                  FHeight:=Height;
                  if not FCaptionSettings.Visible then
                    Visible:=False
                  else
                    if  FCaptionSettings.Position=fsTop then
                      SetBounds(Left, Top, Width, FCaptionSettings.Height+(2*bw)+2)
                    else
                      SetBounds(Left, BoundsRect.Bottom-(FCaptionSettings.Height+(2*bw)+2), Width, FCaptionSettings.Height+(2*bw)+2);
                end;
            else
              begin
                FHeight:=Width;
                if not FCaptionSettings.Visible then
                  Visible:=False
                else
                  if FCaptionSettings.Position=fsLeft then
                    Width:=FCaptionSettings.Height+(2*bw)+2
                  else
                    SetBounds(BoundsRect.Right-(FCaptionSettings.Height+(2*bw)+1), Top, FCaptionSettings.Height+(2*bw)+1, Height);
              end;
            end;
          finally
            EndUpdate(false);
          end;
        end
      else
        try
          BeginUpdate;
          if not (csLoading in ComponentState) then
            begin
              // --> Expand
              If Assigned(FOnExpanding) then FOnExpanding(self, tmp);
              if tmp then exit;
            end;

          // add effect here
          if not Visible then Visible:=True;

          case FCaptionSettings.Position of
            fsTop: Height:=FHeight;
            fsBottom: SetBounds(Left, BoundsRect.Top-(FHeight-(FCaptionSettings.Height+(2*bw)+2)), Width, FHeight);
            fsLeft:Width:=FHeight;
            fsRight: SetBounds(BoundsRect.Right-FHeight, Top, FHeight, Height);
          end;
        finally
          EndUpdate(false);
        end;

      FExpanded := Value;
      FClient.Visible:=FExpanded;
      tp:=SearchMinMax;
      if not (csLoading in ComponentState) then
        if FExpanded then
          begin
            If Assigned(FOnExpanded) then FOnExpanded(self);
            If Assigned(tp) then TLMDSystemButton(tp).Style:=sbsMin;
          end
        else
          begin
            If Assigned(FOnCollapsed) then FOnCollapsed(self);
            If Assigned(tp) then TLMDSystemButton(tp).Style:=sbsMax;
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.SetIndex(const Value: Integer);
begin
  if (Parent is TLMDCaptionPanelGroup) then
    begin
      if Value<>FIndex then
        begin
          if isUpdating or (csLoading in ComponentState) then
            begin
              FIndex := Value;
              exit;
            end;
          if Value>-1 then
            begin
              Parent.Perform(CM_LMDUpdatePanel, Value, FIndex);
//              TLMDParentGroup(Parent).UpdatePanelIndex(Value, FIndex);
//              TLMDCaptionPanelGroup(Parent).UpdatePanelIndex(Value, FIndex);
//              TLMDParentGroup(Parent).FixPanelIndex;
            end;
          TLMDCaptionPanelGroup(Parent).Change;
        end;
      end
    else
      FIndex:=Value;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.PassMouseEventsToClient;
begin
  FClient.OnMouseDown := Self.DoMouseDown;
  FClient.OnMouseUp := Self.DoMouseUp;
  FClient.OnClick := Self.DoMouseClick;
  FClient.OnMouseMove := Self.DoMouseMove;
  FClient.OnDblClick := Self.DoMouseDblCLick;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.WMMOVE(var Message: TWMMOVE);
begin
  inherited;
  if not (csLoading in ComponentState) then
    if FClient.Visible then
      FClient.RePaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if FExpanded or not AllowSizing then
    inherited
  else
    begin
      AllowSizing:=False;
      inherited;
      AllowSizing:=True;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.WMSize(var Msg: TWMSize);
begin
  inherited;
  if csLoading in ComponentState then exit;
  if (Parent is TLMDCaptionPanelGroup) then
    begin
      TLMDCaptionPanelGroup(Parent).Change;
      ReAlign;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.WriteInteger(Writer: TWriter);
begin
  Writer.WriteInteger(FHeight);
end;

{ *************************** Protected ***************************************}
{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.AdjustClientRect(var aRect: TRect);
var
  tmp,tmp1:Integer;
begin
  tmp:=Bevel.BevelExtend+FCaptionSettings.CaptionGap;   // standard gap
  tmp1:=Bevel.BevelExtend+FCaptionSettings.Height-FCaptionSettings.CaptionGap+1; // gap captionside
  if FCaptionSettings.Visible then
    case FCaptionSettings.Position of
      fsLeft: aRect := Rect(tmp1,tmp,ClientWidth-tmp,ClientHeight-tmp);
      fsRight: aRect := Rect(tmp,tmp, ClientWidth-tmp1,ClientHeight-tmp);
      fsTop: aRect := Rect(tmp, tmp1, ClientWidth-tmp,ClientHeight-tmp);
      fsBottom: aRect := Rect(tmp, tmp,ClientWidth-tmp,ClientHeight-tmp1-1);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.AlignControls(AControl: TControl;
  var aRect: TRect);
var
  i, tp, wi, gap2:Integer;
begin
  if isUpdating then exit;
  tp:=(def_CaptionButtonReduce div 2)+1;
  wi:=FCaptionSettings.Height-(2*FCaptionSettings.CaptionGap)-def_CaptionButtonReduce;
  gap2:=Bevel.BevelExtend+FCaptionSettings.CaptionGap; // fix distance from start of button to border
  if FCaptionSettings.Visible then
    case FCaptionSettings.Position of
      fsTop:
        begin
          for i:=0 to FButtonList.Count-1 do
            begin
              TLMDSystemButton(FButtonList[i]).SetBounds(aRect.Right-gap2-((i+1)*wi)-(i*FCaptionSettings.ButtonGap)-1,
                                                         Bevel.BevelExtend+FCaptionSettings.CaptionGap+tp, wi, wi);
            end;
        end;

      fsBottom:
        begin
          for i:=0 to FButtonList.Count-1 do
            begin
              TLMDSystemButton(FButtonList[i]).SetBounds(aRect.Right-gap2-((i+1)*wi)-(i*FCaptionSettings.ButtonGap)-1,
                                                         aRect.Bottom-(Bevel.BevelExtend+(FCaptionSettings.Height-FCaptionSettings.CaptionGap-def_CaptionButtonReduce){wi}+tp), wi, wi);
            end;

        end;

      fsLeft:
        begin
          for i:=0 to FButtonList.Count-1 do
            begin
              TLMDSystemButton(FButtonList[i]).SetBounds(Bevel.BevelExtend+FCaptionSettings.CaptionGap+tp,
                                                         aRect.Top+gap2+tp+(i*(wi+FCaptionSettings.ButtonGap)), wi, wi);
            end;

        end;
      fsRight:
        begin
          for i:=0 to FButtonList.Count-1 do
            begin
              TLMDSystemButton(FButtonList[i]).SetBounds(aRect.Right-(Bevel.BevelExtend+FCaptionSettings.CaptionGap+wi+tp)+1,
                                                         aRect.Bottom-gap2-((i+1)*wi)-(i*FCaptionSettings.ButtonGap)-2, wi, wi);
            end;

        end;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.ClearButtonList;
begin
  while FButtonList.Count>0 do
    begin
      TLMDSystemButton(FButtonList.Last).Free;
      FButtonList.Remove(FButtonlist.Last);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.CreateParams(var Params: TCreateParams);
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.CreateWnd;
begin
  inherited;
  InitButtonList;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('ExpandedValue', ReadInteger, WriteInteger, (not FExpanded));
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DoClick(Sender: TObject);
begin
  if Assigned(FOnHelpBtnClick) then
    FOnHelpBtnClick(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DoMove;
begin
  if (Parent is TLMDCaptionPanelGroup) then
    SetIndex(TLMDCaptionPanelGroup(Parent).PanelIndexAtPos(Left-1, Top-1));
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDown(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseUp(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DoMouseClick(Sender: TObject);
begin
  Click;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DoMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  MouseMove(Shift,X,Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.DoMouseDblClick(Sender: TObject);
begin
  DblClick;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanel.GetCaptionRect:TRect;
var
  aRect:TRect;
begin
  aRect:=BeveledRect;
  if FCaptionSettings.Visible then
    case FCaptionSettings.Position of
      fsLeft: result:=Rect(aRect.Left,aRect.Top, aRect.Left+FCaptionSettings.Height,aRect.Bottom);
      fsRight: result:=Rect(aRect.Right-FCaptionSettings.Height, aRect.Top,aRect.Right,aRect.Bottom-1);
      fsTop: result:=Rect(aRect.Left,aRect.Top, aRect.Right, aRect.Top+FCaptionSettings.Height);
      fsBottom: result:=Rect(aRect.Left,aRect.Bottom-FCaptionSettings.Height-1, aRect.Right, aRect.Bottom);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCaptionPanel.GetChange(Sender: TObject);
begin
  if (Sender=FCaptionSettings) and ([csDestroying, csLoading, csReading]*ComponentState=[]) then
    ReAlign;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.GetChildren(Proc: TGetChildProc;
  Root: TComponent);
begin
  Proc(FClient);
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanel.GetChildOwner: TComponent;
begin
  result:=self;
end;

{------------------------------------------------------------------------------}
function TLMDCaptionPanel.GetMoveRect: TRect;
begin
  result:=GetCaptionRect;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.InitButtonList;
var
  i:TLMDPanelCaptionButton;
  tmp:TLMDSystemButton;
begin
  if isUpdating then exit;
  ClearButtonList;
  for i:=High(TLMDPanelCaptionButton) Downto Low(TLMDPanelCaptionButton) do
    if i in FCaptionSettings.Buttons then
      begin
        tmp:=TLMDSystemButton.Create(self);
        FButtonList.Add(tmp);
        with tmp do
          begin
            Parent:=self;
            //Tag:=Ord(i)+1;
            //OnClick:=DoClick;
          end;
        case i of
           pcsHelp: tmp.Style:=sbsHelp;
           pcsMinMax: if FExpanded then tmp.Style:=sbsMin else tmp.Style:=sbsMax;
           pcsClose:tmp.Style:=sbsClose;
        end;
      end;
  ReAlign;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.Paint;
var
  aRect:TRect;
  lThemeMode: TLMDThemeMode;
begin
  if ThemeGlobalMode then
    lThemeMode := LMDApplication.ThemeGlobalMode
  else
    lThemeMode := LMDThemeServices.UseTheme(ThemeMode);
  if lThemeMode = ttmNone then
    inherited
  else
    begin
      aRect := ClientRect;
      LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, ttPane, aRect);
    end;
  if not CaptionSettings.Visible then
    exit;
  aRect:=GetCaptionRect;
  PaintCaptionBar(aRect);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.PaintCaptionBar(aRect:TRect);
const
  Flags:array[Boolean] of DWORD=(0,DC_ACTIVE);
var
  Rgn: HRgn;
  FFont:TFont;
  Effects:TLMDFxCaption;
  wi:Integer;

begin
  InflateRect(aRect, -FCaptionSettings.CaptionGap, -FCaptionSettings.CaptionGap);
  case FCaptionSettings.PaintMode of
   pcdWindows:
     begin
       Windows.DrawCaption(Handle, Canvas.Handle, aRect,
                           Flags[Enabled] or DC_TEXT or DC_GRADIENT);
     end;
   pcdNormal:
     begin
       if Enabled then
         Canvas.Brush.Color:=FCaptionSettings.ActiveColor
       else
         Canvas.Brush.Color:=FCaptionSettings.InActiveColor;
       Canvas.FillRect(aRect);
     end;
   pcdOwnerDraw:
     begin
       if Assigned(FOnCaptionDraw) then
         begin
           Rgn:=CreateRectRgnIndirect(aRect);
           try
             SelectClipRgn(Canvas.Handle, Rgn);
             FOnCaptionDraw(self, Canvas, aRect);
           finally
             SelectClipRgn(Canvas.Handle, 0);
             DeleteObject(Rgn);
           end;
        end;
        Exit;
     end;
  end;

  If FCaption<>'' then
    begin

      //InflateRect(aRect, -1, -1);
      if FButtonList.Count>0 then
        begin
          wi:=(FCaptionSettings.Height-(2*FCaptionSettings.CaptionGap)-def_CaptionButtonReduce)+FCaptionSettings.ButtonGap;
          case FCaptionSettings.Position of
            fsLeft:
              begin
                aRect.Top:=aRect.Top+(FButtonList.Count*wi);
                aRect.Left:=aRect.Left+1;
              end;
            fsRight:
              begin
                aRect.Bottom:=aRect.Bottom-(FButtonList.Count*wi)+1;
                aRect.Top:=aRect.Top+1;
              end;
            fsTop, fsBottom:
              begin
                aRect.Right:=aRect.Right-(FButtonList.Count*wi)-1;
                aRect.Left:=aRect.Left+1;
              end;
          end;
        end;

      FFont:=TFont.Create;
      Effects:=TLMDFxCaption.Create;
      try
        FFont.Name:=FCaptionSettings.FontName;
        FFont.Size:=FCaptionSettings.FontSize;
        FFont.Style:=[fsBold];
        If Enabled then
          FFont.Color:=FCaptionSettings.FontActiveColor
        else
          FFont.Color:=FCaptionSettings.FontInActiveColor;
        Canvas.Font:=FFont;
        case FCaptionSettings.Position of
          fsRight:Effects.Angle:=270;
          fsLeft:Effects.Angle:=90;
        end;
        if Effects.Angle>0 then
          aRect:=LMDAlignTextRect(FCaptionSettings.Alignment, Caption, Effects, aRect, Canvas.Font,
                                  false, false, DT_NOPREFIX or DT_SINGLELINE);

        LMDDrawTextExt(Canvas, Caption, Effects, aRect, DT_NOPREFIX or DT_SINGLELINE
                       or TLMDALIGNFLAGS[FCaptionSettings.Alignment],
                        [TLMDDrawTextStyle(Enabled), dtClip], @aRect)

       finally
         FFont.Free;
         Effects.Free
       end;
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.ReadState(Reader: TReader);
begin
  inherited;
  // after reading make sure that
  //FClient.Parent:=self;

  FClient.Align:=alClient;
  FClient.Transparent:=Transparent;

  PassMouseEventsToClient;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
begin
  if (not (csDesigning in ComponentState)) or  (Parent is TLMDCaptionPanelGroup) or (csCreating in ControlState) then
    inherited
  else
    if (not FExpanded) and (not isUpdating) then
      inherited SetBounds(ALeft, ATop, Width, Height)
    else
      inherited;
end;

{ *********************** Public **********************************************}
{------------------------------------------------------------------------------}
constructor TLMDCaptionPanel.Create(AOwner: TComponent);
begin
  inherited;
  HandleNonWinControls:=True;
  AllowMoving:=True;
  inherited Caption:='';
  ControlStyle:=ControlStyle-[csAcceptsControls];
  FExpanded:=True;
  FCaptionSettings:=TLMDPanelCaptionObject.Create(self);

  FButtonList:=TList.Create;
  Bevel.BeginUpdate;
  Bevel.StandardStyle:=lsWindowBorder;
  Bevel.Mode:=bmStandard;
  Bevel.EndUpdate(false);

  FClient:=TLMDCaptionPanelClient.Create(self);
  FClient.Parent:=self;
  FClient.Align:=alClient;

  PassMouseEventsToClient;

  FCaptionSettings.OnChange:=GetChange;
  Height:=100;
  Width:=100;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCaptionPanel.Destroy;
begin
  ClearButtonList;
  FreeAndNil(FButtonList);
  FreeAndNil(FCaptionSettings);
  FreeAndNil(FClient);
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.Change;
begin
  ReCreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.Collapse;
begin
  SetExpanded(False);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.Expand;
begin
  SetExpanded(True);
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.Loaded;
begin
  inherited;
  InitButtonList;
end;

{------------------------------------------------------------------------------}
procedure TLMDCaptionPanel.SetSilentIndex(Index: Integer);
begin
  BeginUpdate;
  try
    SetIndex(Index);
  finally
    EndUpdate(false);
  end;
end;

initialization
  Classes.RegisterClass(TLMDCaptionPanelClient);
end.
