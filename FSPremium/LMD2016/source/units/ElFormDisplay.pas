unit ElFormDisplay;

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

ElFormDisplay unit
------------------

Changes
-------
 - Usage of forms from resource DLLs fixed
 + DetachForm method added
 - "Container property is not defined" issue fixed

Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses

  Windows,
  Classes,
  Forms,
  Messages,
  Controls,
  SysUtils,
  Graphics,

  LMDElConst,
  LMDProcs,
  LMDHTMLUnit,
  LMDTypes,

  ElPanel,
  ElHTMLLbl,
  ElFormContainer;

type
  TElFormDisplay = class;
  TElFDHTMLForm = class;

  TElAlignment=(agTopLeft, agTopCenter, agTopRight, agCenterLeft,
                 agCenter, agCenterRight, agBottomLeft, agBottomCenter,
                 agBottomRight);
  TElFormDisplayChangeEvent=procedure(Sender:TObject; NewForm:TCustomForm; var Cancel:Boolean) of object;
  TElFDMessageEvent=procedure(Sender:TObject; var Message:TMessage) of object;
  TElFormDisplayPosition=(fdpTopLeft, fdpTopCenter, fdpTopRight,
                           fdpCenterLeft, fdpCenter, fdpCenterRight,
                           fdpBottomLeft, fdpBottomCenter, fdpBottomRight, fdpClient);

  {*************************** TElFormDisplayChangeLink  ********************}
  TElFormDisplayChangeLink = class
  private
    FSender:TElFormDisplay;
    FOnChange:TNotifyEvent;
  public
    destructor Destroy; override;
    procedure Change; dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TElFormDisplay read FSender write FSender;
  end;

  {--------------------- TElFormDisplay --------------------------------------}
  TElFormDisplay = class(TCustomElPanel)
  private
    FClients: TList;
    FFormContainer: TElFormContainer;
    FChangeLink:TElFormContainerChangeLink;
    FCloseInactiveForms: boolean;
    FDHTMLForm: TElFDHTMLForm;
    FDHTMLFormColor:TColor;
    FAssignColor,
    FHook,
    FUseRes,
    FSaveResources:Boolean;
    FOldWndProc:TWndMethod;
    FOnMessage:TElFDMessageEvent;

    FActiveFormIndex:Integer;
    FPosition:TElFormDisplayPosition;

    FOnChange:TNotifyEvent;
    FOnChanging:TElFormDisplayChangeEvent;

    procedure DoFormChange(Sender: TObject);
    function GetActiveForm:TCustomForm;
    //procedure SetForm(aValue:TForm);
    procedure SetActiveForm(aValue:TCustomForm);
    procedure SetActiveFormIndex(aValue:Integer);
    procedure SetPosition(aValue:TElFormDisplayPosition);
    procedure SetFormContainer(aValue: TElFormContainer);

    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SetFocus;
  protected
    FOnLinkClick : TElHTMLLinkClickEvent;
    procedure AlignControls(AControl: TControl;var Rect : TRect); override;
    procedure GetChange(Sender:TObject);//override;
    procedure Loaded;override;
    procedure NewWndProc(var Message:TMessage);
    procedure Notification(AComponent : TComponent; operation : TOperation); override;
    procedure Paint;override;
    procedure Resize;override;
    procedure TriggerLinkClickEvent(HRef : string); virtual;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure DetachForm(AXPos: integer = 0; AYPos: integer = 0; AWidth: integer = 0; AHeight: integer = 0; ABorderStyle: TFormBorderStyle = bsSizeable; ABorderIcons: TBorderIcons = [biSystemMenu, biMinimize, biMaximize]; AModal: boolean = false);

    function FindNextForm(CurForm:TCustomForm; GoForward:Boolean): TCustomForm;
    procedure CloseActiveForm;
    procedure HideActiveForm;
    procedure SelectNextForm(GoForward: Boolean);

    procedure RegisterChanges(aValue: TElFormDisplayChangeLink);
    procedure UnRegisterChanges(aValue: TElFormDisplayChangeLink);

    property ActiveForm:TCustomForm read GetActiveForm write SetActiveForm;
  published
    property HookWindowProc:Boolean read FHook write FHook default false;
    property SaveResources:Boolean read FSaveResources write FSaveResources default False;
    property UseResForms:Boolean read FUseRes write FUseRes default false;
    property AssignColor:Boolean read FAssignColor write FAssignColor default false;
    property HTMLFormBackColor:TColor read FDHTMLFormColor write FDHTMLFormColor default clNone;
    property Position:TElFormDisplayPosition read FPosition write SetPosition default fdpClient;
    property OnChange:TNotifyEvent read FOnChange write FOnChange;
    property OnChanging:TElFormDisplayChangeEvent read FOnChanging write FOnChanging;

    property OnLinkClick : TElHTMLLinkClickEvent read FOnLinkClick write FOnLinkClick;
    property OnMessage:TElFDMessageEvent read FOnMessage write FOnMessage;
    // ---
    property FormContainer: TElFormContainer read FFormContainer write SetFormContainer;
    property ActiveFormIndex:Integer read FActiveFormIndex write SetActiveFormIndex stored true;
    property CloseInactiveForms: boolean read FCloseInactiveForms write FCloseInactiveForms;
    // ---
    property AlphaLevel;
    property AlwaysPaintBackground;
    property Background;
    property BackgroundType;
    property GradientEndColor;
    property GradientStartColor;
    property GradientSteps;
    property Alignment;
    property Layout;
    property OwnerDraw;
    property ImageForm;
    property Resizable;
    property Movable;
    property OnMove;
    property OnPaint;

    property SizeGrip;
    property Align nodefault;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelSpaceColor;
    property BevelWidth;
    property BorderStyle;
    property BorderWidth;
    property TransparentXPThemes;
    property ParentThemeMode default true;
    property ThemeMode;
    property ThemeGlobalMode;

    property Color;

    property DragCursor;

    property DragMode;
    property Enabled;
    property Font;

    property Locked;
    property MouseCapture default False;

    property ParentColor;

    property ParentCtl3D;

    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowFocus;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property Caption;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnResize;
    property OnStartDrag;

    property Anchors;
    property Constraints;
    property DockSite;
    property DockOrientation;
    property BevelKind;
    property DoubleBuffered default False;
    property DragKind;
    property OnContextPopup;
  end;

  {--------------------- TElFDHTMLForm ----------------------------------------}
  TElFDHTMLForm = class (TCustomForm)
  private
    FHTMLLabel: TElHTMLLabel;
    procedure HTMLLabelLinkClick(Sender: TObject; HRef: TLMDString);
  public
    constructor CreateNew(AOwner: TComponent; Dummy: Integer); override;
    property HTMLLabel: TElHTMLLabel read  FHTMLLabel write FHTMLLabel;
  end;

  {--------------------- Exceptions -------------------------------------------}
  EElFormDisplay = class (Exception)
  end;

procedure ElFreeResources(aControl:TWinControl);
function ElAlignRect(Alignment:TElAlignment; srcRect, destRect:TRect):TRect;
procedure ElGetRectWH(const srcRect:TRect; var w,h:Integer);
function ElStrEmpty(const aValue:String):Boolean;

implementation

uses

  TypInfo;

// Dummy helper classes
{------------------------------------------------------------------------------}
type
  TMyForm=class(TCustomForm)
  public
    property IsControl;
    property OnActivate;
    property OnDeactivate;
    property OnHide;
  end;
  TElResWinControl=class(TWinControl)
  protected

    procedure CreateHandle;override;

  public
    procedure FreeResources;
  end;

{------------------------------------------------------------------------------}

{------------------------- Private --------------------------------------------}
procedure TElFormDisplay.SetActiveForm(aValue:TCustomForm);
var
  tmp:Integer;
begin
  //tmp:=FList.IndexOf(aValue);
  if not Assigned(FormContainer) then
    raise EElFormDisplay.Create(Format(SElRequiredPropertyIsNotDefined,['FormContainer']));
  tmp := FormContainer.FormList.IndexOf(aValue);
  if tmp<>-1 then SetActiveFormIndex(tmp);
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.SetFormContainer(aValue: TElFormContainer);
begin
  if FFormContainer<>nil then
    FFormContainer.UnRegisterChanges(FChangeLink);

  FFormContainer:=aValue;

  if FFormContainer<>nil then
    begin
      FFormContainer.RegisterChanges(FChangeLink);
      FFormContainer.FreeNotification(Self);
    end;
  DoFormChange(nil);
end;

{ ---------------------------------------------------------------------------- }
procedure TElFormDisplay.Notification(AComponent : TComponent; operation : TOperation);
begin
  inherited Notification(AComponent, operation);
  if (operation = opRemove) then
    begin
      if (AComponent = FFormContainer) then
        FormContainer := nil;
    end;  { if }
end;  { Notification }

{------------------------------------------------------------------------------}
procedure TElFormDisplay.SetActiveFormIndex(aValue:Integer);
var
  cancel:Boolean;
begin
  if csLoading in ComponentState then
    begin
      FActiveFormIndex := aValue;
      exit;
    end;

  if csDesigning in ComponentState then
    begin
      if Assigned(FFormContainer) then
        begin
          if ( aValue < -1 ) or (aValue > FFormContainer.FormList.Count-1) then
            aValue := -1;
          FActiveFormIndex := aValue;
        end
      else
        FActiveFormIndex := -1;
      exit;
    end;

    cancel:=false;
    if not Assigned(FormContainer) then
      raise EElFormDisplay.Create(Format(SElRequiredPropertyIsNotDefined,['FormContainer']));
    if Assigned(FOnChanging) then
      //if FormContainer.FormList[aValue].Form <> nil then //Removed Jan 2009 on user request [VB]
        FOnChanging(self, FormContainer.FormList[aValue].Form, cancel);
    if Cancel then exit;
    if aValue <> FActiveFormIndex  then
      begin
        if CloseInactiveForms then
          CloseActiveForm
        else
          HideActiveForm;
        if Assigned(FFormContainer) then
        begin
          if ( aValue < -1 ) or (aValue > FFormContainer.FormList.Count-1) then
            aValue := -1;
          FActiveFormIndex := aValue;
          if FActiveFormIndex <> -1 then
            DoFormChange(nil);
        end;
      end;
end;

procedure TElFormDisplay.DoFormChange(Sender: TObject);
var
  tmp: TCustomForm;
  IsDHTML: boolean;
  procedure UpdateDHTMLForm;
  begin
    with FormContainer do
      begin
        FDHTMLForm.HTMLLabel.Container := HTMLContainer;
        FDHTMLForm.HTMLLabel.ContainerIndex := FormList.Items[FActiveFormIndex].HTMLContainerIndex;
        FDHTMLForm.Name := FormList.Items[FActiveFormIndex].FormName;
        FDHTMLForm.HTMLLabel.WordWrap := true;
      end;
  end;

begin
  if [csLoading, csDestroying {, csDesigning}]*ComponentState<>[] then exit;
  if FActiveFormIndex = -1 then
    exit;
  if not Assigned(FormContainer) then
    raise EElFormDisplay.Create(Format(SElRequiredPropertyIsNotDefined,['FormContainer']));

  // show new page
  tmp := FormContainer.Formlist[FActiveFormIndex].Form;
  IsDHTML := FormContainer.CheckHTMLContainer and
        (FormContainer.HTMLContainer <> nil) and
        (FormContainer.Formlist[FActiveFormIndex].HTMLContainerIndex <> -1);
  try
  if tmp = nil then
    begin
      if IsDHTML then
        begin
          if FDHTMLForm = nil then
            FDHTMLForm := TElFDHTMLForm.CreateNew(Application, 0);
          if FDHTMLForm = nil then exit;
          with FormContainer do
            begin
              UpdateDHTMLForm;
              FormList.Items[FActiveFormIndex].Form := FDHTMLForm;
              FormList.Items[FActiveFormIndex].FormClassName := FDHTMLForm.ClassName;
            end;
          tmp := FDHTMLForm;
          if FDHTMLFormColor<>clNone then
            tmp.Color:=FDHTMLFormColor;
        end
      else
        begin
          Application.CreateForm(TFormClass(FindClass(FormContainer.Formlist[FActiveFormIndex].FormClassName)), tmp);
          FormContainer.Formlist[FActiveFormIndex].Form := tmp;
        end;
    end
  else
    if IsDHTML then UpdateDHTMLForm;
  except
    on e:exception do
    begin
      FActiveFormIndex := -1;
      raise Exception.Create(e.message);
    end;
  end;
  FFormContainer.FormList[ActiveFormIndex].Width := TForm(tmp).Width;
  FFormContainer.FormList[ActiveFormIndex].Height := TForm(tmp).Height;
  try
    tmp.Visible := false;

    SetWindowLong(tmp.Handle, GWL_STYLE, WS_CHILD OR WS_CLIPSIBLINGS or WS_CLIPCHILDREN);
    SetWindowLong(tmp.Handle, GWL_EXSTYLE, 0);

    if UseResForms then
      tmp.ParentWindow := Self.Handle
    else
      tmp.Parent:=self;

    with TForm(tmp) do
    begin
      BorderStyle := bsNone;
      BorderIcons := [];
      Position := poDefault;
      TabStop := False;
    end;
    if FPosition=fdpClient then
      begin
        if UseResForms then
          tmp.BoundsRect := ClientRect
        else
          tmp.Align := alClient;
      end
    else
      begin
        tmp.Align:=alNone;
        tmp.BoundsRect:= ElAlignRect(TElAlignment(Ord(FPosition)), tmp.ClientRect, ClientRect{BeveledRect}); //vb
      end;

    if FAssignColor then
      tmp.Color:=self.Color;

    if FHook then
      begin
        FOldWndProc:=tmp.WindowProc;
        tmp.WindowProc:=NewWndProc;
      end;

    tmp.BringToFront;
  finally
    tmp.Visible:=True;
//    tmp.SetFocus;

    if Assigned(TMyForm(tmp).OnActivate) then
      TMyForm(tmp).OnActivate (tmp); //JH, July 2001
    if Assigned(FOnChange) then FOnChange(self);
  end;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.SetPosition(aValue:TElFormDisplayPosition);
var
  OldPosition : TElFormDisplayPosition;
begin
  OldPosition := FPosition;
  if aValue<>FPosition then
    begin
      FPosition:=aValue;
      if Assigned(ActiveForm) then
        begin
          if FPosition=fdpClient then
            ActiveForm.Align:=alClient
          else
            begin
              ActiveForm.Align:=alNone;
              if OldPosition = fdpClient then
                begin
                  ActiveForm.Width := FFormContainer.FormList[ActiveFormIndex].Width;
                  ActiveForm.Height := FFormContainer.FormList[ActiveFormIndex].Height;
                end;
            end;
          ReAlign;
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TElFormDisplay.GetActiveForm:TCustomForm;
begin
  result:=nil;
  if (FActiveFormIndex<>-1) then
    result := FormContainer.Formlist[FActiveFormIndex].Form;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if TabStop and (ActiveForm<>nil) then
    if ActiveForm.ActiveControl <> nil then
      ActiveForm.SetFocus
end;

{------------------------- Protected ------------------------------------------}
procedure TElFormDisplay.AlignControls (AControl : TControl;var Rect : TRect);
var
  msg: TMessage;//WORD;
begin
  inherited AlignControls(aControl, Rect);
  if csDesigning in ComponentState then exit;
  if not Assigned(FormContainer) then
    raise EElFormDisplay.Create(Format(SElRequiredPropertyIsNotDefined,['FormContainer']));
  if (FormContainer.Formlist.Count>0) and Assigned(ActiveForm) then
    if FPosition<>fdpClient then
      begin
        DisableAlign;
        ActiveForm.BoundsRect:=ElAlignRect(TElAlignment(Ord(FPosition)), ActiveForm.ClientRect, ClientRect{BeveledRect}); //vb

        //msg.Msg := CM_LMDBACKCHANGED;  //vb !!! check it later
        ActiveForm.BroadCast(msg);
        EnableAlign;
      end;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.GetChange(Sender:TObject);
begin
 // inherited GetChange(Sender); -> Sender.invalidate ??
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then exit;
  if (FormContainer.Formlist.Count>0) and Assigned(ActiveForm) then
    ReAlign;
  //else
  //  if Assigned(FForm) then FForm.BoundsRect:=ClientRect{BeveledRect}; //vb
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.Loaded;
begin
  inherited Loaded;
  DoFormChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.NewWndProc(var Message: TMessage);
begin
  if Assigned(FOnMessage) then FOnMessage(self, Message);

  case Message.Msg of
    WM_LBUTTONDOWN,
    WM_SETFOCUS:
      begin
        if Assigned(ActiveForm) then
          ActiveForm.SetFocus;
      end;
  end;

  if Assigned(FOldWndProc) then FOldWndProc(Message);
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.Paint;
begin
  inherited Paint;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.Resize;
begin
  inherited Resize;
  if csDesigning in ComponentState then exit;
  if (FormContainer.FormList.Count>0) and Assigned(ActiveForm) then
  begin
    if UseResForms and (FPosition=fdpClient) then
      ActiveForm.BoundsRect:= ClientRect
    else
      ReAlign;
  end;
end;

{-------------------------- Public --------------------------------------------}
constructor TElFormDisplay.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FSaveResources:=False;
  FActiveFormIndex:=-1;
  FPosition:=fdpClient;
  FDHTMLFormColor:=clNone;
  FOldWndProc:=nil;
  // VB
  FChangeLink := TELFormContainerChangeLink.Create;
  FChangeLink.OnChange := DoFormChange;

  FClients:= TList.Create;
  DoubleBuffered := false;
end;

{------------------------------------------------------------------------------}
destructor TElFormDisplay.Destroy;
begin
  FreeAndNil(FChangeLink);
  while FClients.Count > 0 do
    UnRegisterChanges(TElFormDisplayChangeLink(FClients.Last));
  FreeAndNil(FClients);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.DetachForm(AXPos, AYPos: integer; AWidth: integer; AHeight: integer;
  ABorderStyle: TFormBorderStyle; ABorderIcons: TBorderIcons; AModal: boolean);
var
  f: TCustomForm;
  p: TPoint;
  LParent: TWinControl;
begin
  f := ActiveForm;
  if not Assigned(f) then
    exit;
    f.Align := alNone;
  ActiveFormIndex := -1;

  if UseResForms then
    f.ParentWindow := 0
  else
    f.Parent := nil;

  LParent := self;
  while LParent.Parent <> nil do
    LParent := LParent.Parent;
  if (AXPos = 0) and (AYPos = 0) then
    begin
      if (f.Width < LParent.Width) and (f.Height < LParent.Height) then
        begin
          p.X := (LParent.Width - f.Width) div 2;
          p.Y := (LParent.Height - f.Height) div 2;
        end
      else
        begin
          p.X := 20;
          p.y := 20;
        end;
      f.Left := lParent.Left + p.X;
      f.Top := lParent.Top + p.Y;
    end
  else
    begin
      f.Left := AXPos;
      f.Top := AYPos;
    end;

  if AWidth <> 0 then
    f.Width := AWidth;
  if AHeight <> 0 then
    f.Height := AHeight;

  f.BorderStyle := ABorderStyle;
  TForm(f).BorderIcons := ABorderIcons;
  if AModal then
    f.ShowModal
  else
    f.Show;
end;

{------------------------------------------------------------------------------}
function TElFormDisplay.FindNextForm(CurForm:TCustomForm; GoForward:Boolean): TCustomForm;
var
  index:integer;
begin
  result:=nil;

  Index:=FormContainer.FormList.IndexOf(CurForm);
  if (CurForm=nil) or (Index=-1) then exit;

  if GoForward then
    begin
      Inc(Index);
      while (Index<FormContainer.FormList.Count) do
        if Assigned(FormContainer.FormList[Index].Form) then
          begin
            Result:=FormContainer.FormList[Index].Form;
            Exit;
          end
        else
          Inc(Index)
    end
  else
    begin
      Dec(Index);
      while (Index>=0) do
        if Assigned(FormContainer.FormList[Index].Form) then
          begin
            Result := FormContainer.FormList[Index].Form;
            Exit;
          end
        else
          Dec(index);
    end;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.SelectNextForm(GoForward: Boolean);
begin
  SetActiveForm(FindNextForm(ActiveForm, GoForward));
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.CloseActiveForm;

begin
  if FActiveFormIndex=-1 then
    exit;
  if Assigned (TMyForm(ActiveForm).OnDeactivate) then
    TMyForm(ActiveForm).OnDeactivate(ActiveForm);
  if Assigned (TMyForm(ActiveForm).OnHide) then
    TMyForm(ActiveForm).OnHide(ActiveForm);
  if FHook then
    begin
      ActiveForm.WindowProc:=FOldWndProc;
      FOldWndProc:=nil;
    end;
  ActiveForm.Close;
  FActiveFormIndex:=-1;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.HideActiveForm;

begin
  if FActiveFormIndex=-1 then
    exit;

  if Assigned (TMyForm(ActiveForm).OnDeactivate) then
    TMyForm(ActiveForm).OnDeactivate(ActiveForm);
  if Assigned (TMyForm(ActiveForm).OnHide) then
    TMyForm(ActiveForm).OnHide(ActiveForm);

  if FHook then
    begin
      ActiveForm.WindowProc:=FOldWndProc;
      FOldWndProc:=nil;
    end;

  ActiveForm.Align:=alNone;
  ActiveForm.Visible:=False;
  if FSaveResources then ElFreeResources(ActiveForm);
  FActiveFormIndex:=-1;
end;

{------------------------------------------------------------------------------}
destructor TElFormDisplayChangeLink.Destroy;
begin
  if Sender <> nil then Sender.UnRegisterChanges(Self);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplayChangeLink.Change;
begin
  if Assigned(OnChange) then OnChange(Sender)
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.RegisterChanges(aValue: TElFormDisplayChangeLink);
begin
  aValue.Sender:= Self;
  FClients.Add(aValue);
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.UnRegisterChanges(aValue: TElFormDisplayChangeLink);
var
  i: Integer;
begin
  if FClients<>nil then
    for i:= 0 to FClients.Count - 1 do
      if FClients[i] = aValue then
        begin
          aValue.Sender:= nil;
          FClients.Delete(i);
          Break;
        end;
end;

{------------------------------------------------------------------------------}
procedure ElFreeResources(aControl:TWinControl);
begin
  if Assigned(aControl) then

    TElResWinControl(aControl).FreeResources;

end;

{------------------------------------------------------------------------------}
function ElAlignRect(Alignment:TElAlignment; srcRect, destRect:TRect):TRect;
var
  sw, sh, dw, dh:Integer;
begin
  ElGetRectWH(srcRect, sw, sh);
  ElGetRectWH(destRect, dw, dh);
  case Alignment of
    agTopLeft, agTopCenter, agTopRight:result.Top:=0;
    agCenterLeft, agCenter, agCenterRight:result.Top:=(dh-sh) div 2;
    agBottomLeft, agBottomCenter, agBottomRight:result.Top:=dh-sh;
  end;
  case Alignment of
    agTopLeft, agCenterLeft, agBottomLeft:result.Left:=0;
    agTopCenter, agCenter, agBottomCenter:result.Left:=(dw-sw) div 2;
    agTopRight, agCenterRight, agBottomRight:result.Left:=dw-sw;
  end;
  with result do result:=Bounds(destRect.Left+Left, destRect.Top+Top, sw, sh);
end;

{------------------------------------------------------------------------------}
procedure ElGetRectWH(const srcRect:TRect; var w,h:Integer);
begin
  with srcRect do
    begin
     w:=Right-Left;
     h:=Bottom-Top;
    end;
end;

{------------------------------------------------------------------------------}
function ElStrEmpty(const aValue: String): Boolean;
var
  Start, TextEnd : PChar;
  begin
  result:=True;
  if Length(aValue)=0 then exit;
  Start := Pointer (aValue);
  TextEnd := Start + Length (aValue);
  while Start < TextEnd do
    if Start^ = ' ' then inc(Start) else
      begin
        result:= False;
        exit;
      end;
  end;

{ TElResWinControl }

{------------------------------------------------------------------------------}
procedure TElResWinControl.CreateHandle;
begin
  inherited CreateHandle;
end;

{------------------------------------------------------------------------------}
procedure TElResWinControl.FreeResources;
begin
  DestroyHandle;
end;

{ TElFDHTMLForm }
{------------------------------------------------------------------------------}
constructor TElFDHTMLForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited;
  FHTMLLabel := TElHTMLLabel.Create(self);
  FHTMLLabel.Parent := self;
  FHTMLLabel.Align := alClient;
  FHTMLLabel.IsHTML := true;
  FHTMLLabel.OnLinkClick := HTMLLabelLinkClick;
end;

{------------------------------------------------------------------------------}
procedure TElFDHTMLForm.HTMLLabelLinkClick(Sender: TObject; HRef: TLMDString);
begin
  TElFormDisplay(Parent).TriggerLinkClickEvent(HRef);
end;

{------------------------------------------------------------------------------}
procedure TElFormDisplay.TriggerLinkClickEvent(HRef: string);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self,HRef);
end;

end.
