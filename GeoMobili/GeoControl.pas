unit GeoControl;

interface                      

uses
  Classes, SysUtils, Windows, Messages, Controls, Graphics, ExtCtrls,
  Forms, ImgList, StdCtrls, ActnList, Dialogs, DesignEditors, DesignIntf;

Type
  TGXOutlookItem = class;
  TGeoCustomControl = class;
  TGXButtonState = (bsUp, bsDown);
  TGXHitResult = (hrNone, hrSection, hrIcon, hrButton, hrIconText);

  TGXItemActionLink = class(TActionLink)
  protected
    FClient: TGXOutlookItem;
    procedure AssignClient(AClient: TObject); override;
    function IsCaptionLinked: Boolean; override;
    function IsEnabledLinked: Boolean; override;
    function IsVisibleLinked: Boolean; override;
    function IsOnExecuteLinked: Boolean; override;
    procedure SetCaption(const Value: string); override;
    procedure SetEnabled(Value: Boolean); override;
    procedure SetVisible(Value: Boolean); override;
    procedure SetOnExecute(Value: TNotifyEvent); override;
  end;

  TGXItemActionLinkClass = class of TGXItemActionLink;

  TGXOutlookItem = class(TCollectionItem)
  private
    FImageIndex: integer;
    FCaption: string;
    FEnabled: Boolean;
    FIconRect: TRect;
    FTextRect: TRect;
    FData: Pointer;
    FTag: integer;
    FVisible: Boolean;
    FActionLink: TGXItemActionLink;
    FOnClick: TNotifyEvent;
  protected
    procedure DoActionChange(Sender: TObject);
    procedure ActionChange(Sender: TObject; CheckDefaults: boolean); dynamic;
    function GetAction: TBasicAction;
    function GetActionLinkClass: TGXItemActionLinkClass; dynamic;
    function GetComponentState: TComponentState;
    function GetOutlookBar: TGeoCustomControl;
    procedure SetAction(Value: TBasicAction);
    procedure SetEnabled(Value: Boolean);
    procedure SetVisible(Value: Boolean);
    procedure SetCaption(Value: string);
    procedure SetImageIndex(Value: integer);

    property ActionLink: TGXItemActionLink read FActionLink write FActionLink;
    property ComponentState: TComponentState read GetComponentState;
    property OutlookBar: TGeoCustomControl read GetOutlookBar;
  public
    procedure Change;
    procedure Click;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property Data: Pointer read FData write FData;
  published
    property Action: TBasicAction read GetAction write SetAction;
    property Caption: string read FCaption write SetCaption;
    property Enabled: Boolean read FEnabled write SetEnabled;
    property ImageIndex: integer read FImageIndex write SetImageIndex;
    property Tag: integer read FTag write FTag;
    property Visible: Boolean read FVisible write SetVisible;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
  end;

  TGXOutlookItems = class(TCollection)
  private
    FBar: TGeoCustomControl;
    FCaption: string;
    FIndex: Integer;
    FBtnRect: TRect;
    FVisible: boolean;
    function GetItem(Index: Integer): TGXOutlookItem;
    procedure SetItem(Index: Integer; Value: TGXOutlookItem);
    procedure SetCaption(Value: string);
    procedure SetVisible(const Value: boolean);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
    function Add: TGXOutlookItem;
    procedure Delete(Index: Integer);
    procedure Swap(Index1,Index2: Integer);
    property Items[Index: Integer]: TGXOutlookItem read GetItem write SetItem; default;
    property Caption: string read FCaption write SetCaption;
    property Visible: boolean read FVisible write SetVisible;
    property Index: Integer read FIndex;
  end;

  TGXSlideInfo = record
    NewSection,OldSection: Integer;
  end;

  TGXOutlookChangingEvent = procedure (Sender:TObject; var CanChange: Boolean) of object;

  TGXOutlookFrameStyle = (fsRaised, fsLowered, fsButton, fsNone, fsRowRaised, fsRowLowered, fsRowButton );

//  TGXOutlookFrameType = (ftIcon, ft
  TGXScrollBtnStyle = (sbButton, sbSlider);

  TGeoCustomControl = class(TCustomControl)
  private
    FList: TList;
    FSelectedButton: Integer;
    FSelectedItem: Integer;
    FTopIndex: Integer;
    FButtonHeight: Integer;
    FTopBtn: TRect;
    FBottomBtn: TRect;
    FBackGround: TPicture;
    FBtnFont: TFont;
    FSelectedFont: TFont;
    FOnItemClick: TNotifyEvent;
    FOnItemTextClick: TNotifyEvent;
    FOnChange: TNotifyEvent;
    FOnItemTextChange: TNotifyEvent;
    FOnChanging: TGXOutlookChangingEvent;
    FFrameStyle: TGXOutlookFrameStyle;
    FSpacing: Integer;
    FTopSpacing: Integer;
    FDesign: Boolean;
    FSliderRect: TRect;
    FWordWrap: Boolean;
    FTracking: TGXHitResult;
    FTrackingData: Integer;
    FMouseOver: TGXHitResult;
    FMouseOverData: Integer;
    FSlideInfo: TGXSlideInfo;
    FSmoothScrolling: Boolean;
    FPaintBM: TBitmap;
    FSlideSrc,FSlideDest: TRect;
    FSliding: Boolean;
    FScrollDelay: Integer;
    FAllowEditing: Boolean;                                 { Tom - 07/30/1999}
    FEditIcon: Integer;
    FEditing: Boolean;    FEditIconText: TEdit;    FImageList: TCustomImageList;    FButtonWidth: integer;    FVisibleItems: integer;    FScrollBtnStyle: TGXScrollBtnStyle;    FButtonColor: TColor;    FItemHightlightColor: TColor;    FItemHightlightFont: TFont;    FStripAccChar: boolean;    FVisibleFactor: integer;    function GetVisibleCount: integer;    function GetVisibleAfter(Value: integer): integer;    function GetNextSection(Value: integer): integer;    procedure BarVisibleChange(Item: TGXOutlookItems);    function GetPriorSection(Value: integer): integer;
  protected
    procedure SetStripAccChar(const Value: boolean);
    procedure IncVisibleFactor;
    procedure DecVisibleFactor;

    procedure SetItemHightlightColor(const Value: TColor);
    procedure SetItemHightlightFont(const Value: TFont);
    procedure SetButtonColor(const Value: TColor);
    procedure SetScrollBtnStyle(const Value: TGXScrollBtnStyle);
    procedure SetImages(const Value: TCustomImageList);
    procedure SetSpacing(Value: Integer);
    procedure SetTopSpacing(Value: Integer);
    procedure SetFrameStyle(Value: TGXOutlookFrameStyle);
    function GetIcons(Index: Integer): TGXOutlookItems;
    procedure SetIcons(Index: Integer; Icons: TGXOutlookItems);
    function GetCount: Integer;
    procedure SetSelectedButton(Value: Integer);
    procedure SetSelectedItem(Value: Integer);
    procedure SetBackground(Value: TPIcture);
    procedure SetBtnFont(Value: TFont);
    procedure SetSelectedFont(Value: TFont);
    procedure ReadData(Reader: TReader);
    procedure WriteData(Writer: TWriter);
    function DoWrite: Boolean;
    function PaintBackground(ACanvas: TCanvas; ARect: TRect): Boolean;
    procedure PaintSlider(ACanvas: TCanvas; Button: Integer; ARect: TRect);
    procedure PaintButton(ACanvas: TCanvas; Button: Integer; ARect: TRect; State: TGXButtonState);
    procedure PaintBorder(ACanvas: TCanvas);
    procedure SetButtonHeight;
    procedure SetWordWrap(Value: Boolean);
    procedure DoSlide(NewSection: Integer);
    procedure FontChange(Sender: TObject);
    procedure BackgroundChange(Sender: TObject);
    procedure StartEditing;
    procedure StopEditing(SaveChanges: Boolean);                           { Tom - 07/30/1999 }    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure UpdatePaint; virtual;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure WMEraseBkgnd(var Msg: TMessage); message WM_ERASEBKGND;
    procedure CMColorChanged(var Msg: TMessage); message CM_ColorChanged;
    procedure WMSize(var Msg: TWMSize); message WM_Size;
    procedure DefineProperties(Filer: TFiler); override;
    procedure CreateWnd; override;
    function GetClientRect: TRect; override;
    procedure Loaded; override;

    // internal properties
    property Design: Boolean read FDesign write FDesign;

    // properties to be published
    property Background: TPicture read FBackground write SetBackground;
    property ButtonFont: TFont read FBtnFont write SetBtnFont;
    property ButtonColor: TColor read FButtonColor write SetButtonColor default clBtnFace;
    property FrameStyle: TGXOutlookFrameStyle read FFrameStyle write SetFrameStyle default fsButton;
    property ItemHightlightColor: TColor read FItemHightlightColor write SetItemHightlightColor;
    property ItemHightlightFont: TFont read FItemHightlightFont write SetItemHightlightFont;
    property Images: TCustomImageList read FImageList write SetImages;
    property SelectedButton: Integer read FSelectedButton write SetSelectedButton;
    property SelectedFont: TFont read FSelectedFont write SetSelectedFont;
    property Spacing: Integer read FSpacing write SetSpacing;
    property StripAccChar: boolean read FStripAccChar write SetStripAccChar default True;
    property TopSpacing: Integer read FTopSpacing write SetTopSpacing;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property AllowEditing: Boolean read FAllowEditing write FAllowEditing;   { Tom - 07/30/1999}
    property ScrollDelay: Integer read FScrollDelay write FScrollDelay;
    property ScrollBtnStyle: TGXScrollBtnStyle read FScrollBtnStyle write SetScrollBtnStyle default sbButton;
    property SmoothScrolling: Boolean read FSmoothScrolling write FSmoothScrolling;
    property WordWrap: Boolean read FWordWrap write SetWordWrap;
    property OnItemTextChange: TNotifyEvent read FOnItemTextChange write FOnItemTextChange;
    property OnChanging: TGXOutlookChangingEvent read FOnChanging write FOnChanging;
    property OnItemClick: TNotifyEvent read FOnItemClick write FOnItemClick;
    property OnItemTextClick: TNotifyEvent read FOnItemTextClick write FOnItemTextClick;      { Tom - 07/30/1999}
    property SelectedItem: Integer read FSelectedItem write SetSelectedItem;
  public
    procedure Paint; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Clear;
    function Add: TGXOutlookItems;
    procedure Delete(Index: Integer);
    procedure HitTest(x,y: Integer; var htResult: TGXHitResult; var Index: Integer);
    procedure Change; virtual;
    procedure TextChange; virtual;
    property VisibleCount: integer read GetVisibleCount;
    property Count: Integer read GetCount;
    property Items[Index: Integer]:TGXOutlookItems read GetIcons write SetIcons;
    property ItemsVisible: integer read FVisibleItems;
    property TopIndex: integer read FTopIndex; 
  end;

  TGeoControl = class(TGeoCustomControl)
  published
    {$IFDEF VER120}
    property Anchors;
    {$ENDIF}
    property Align;
    property AllowEditing;
    property Background;
    property ButtonColor;
    property ButtonFont;
    property Color default clBtnShadow;
    property Cursor;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FrameStyle;
    property Font;
    property HelpContext;
    property ItemHightlightColor;
    property ItemHightlightFont;
    property SelectedFont;
    property StripAccChar;
    property Images;
    property ParentColor;
    property ParentFont;
    property PopupMenu;
    property ScrollBtnStyle;
    property ScrollDelay;
    property ShowHint;
    property SmoothScrolling;
    property Spacing;
    property TabStop;
    property TabOrder;
    property Tag;
    property TopSpacing;
    property Visible;
    property WordWrap;
    property OnChange;
    property OnChanging;
    property OnDblClick;
    property OnEndDrag;
    property OnItemClick;
    property OnItemTextClick;
    property OnItemTextChange;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property SelectedButton;
    property SelectedItem;
  end;

procedure Register;

implementation

uses GeoControlProp;

procedure Register;
begin
  RegisterComponents('GeoMobilli', [TGeoControl]);
  RegisterComponentEditor(TGeoControl, TGeoControlEditor);
end;

procedure TGXItemActionLink.AssignClient(AClient: TObject);
begin
  FClient := aClient as TGXOutlookItem;
end;

function TGXOutlookItem.GetActionLinkClass: TGXItemActionLinkClass;
begin
  Result := TGXItemActionLink;
end;

function TGXOutlookItem.GetComponentState: TComponentState;
begin
  if Assigned(OutlookBar) then
    result := OutlookBar.ComponentState
  else
    result := [];
end;

function TGXOutlookItem.GetOutlookBar: TGeoCustomControl;
begin
  result := nil;
  if Assigned(Collection) then
    result := TGXOutlookItems(Collection).FBar;
end;

function TGXItemActionLink.IsCaptionLinked: Boolean;
begin
  Result := inherited IsCaptionLinked and
    (FClient.Caption = (Action as TCustomAction).Caption);
end;

function TGXItemActionLink.IsEnabledLinked: Boolean;
begin
  Result := inherited IsEnabledLinked and
    (FClient.Enabled = (Action as TCustomAction).Enabled);
end;

function TGXItemActionLink.IsOnExecuteLinked: Boolean;
begin
  Result := inherited IsOnExecuteLinked and
    (@FClient.OnClick = @Action.OnExecute);
end;

function TGXItemActionLink.IsVisibleLinked: Boolean;
begin
  Result := inherited IsVisibleLinked and
    (FClient.Visible = (Action as TCustomAction).Visible);
end;

procedure TGXItemActionLink.SetCaption(const Value: string);
begin
  if IsCaptionLinked then FClient.Caption := Value;
end;

procedure TGXItemActionLink.SetEnabled(Value: Boolean);
begin
  if IsEnabledLinked then FClient.Enabled := Value;
end;

procedure TGXItemActionLink.SetOnExecute(Value: TNotifyEvent);
begin
  if IsOnExecuteLinked then FClient.OnClick := Value;
end;

procedure TGXItemActionLink.SetVisible(Value: Boolean);
begin
  if IsVisibleLinked then FClient.Visible := Value;
end;

//*********************** TGXOutlookItems *************************
constructor TGXOutlookItems.Create;
begin
  inherited Create(TGXOutlookItem);
  FVisible := True;
end;

function TGXOutlookItems.Add: TGXOutlookItem;
begin
  Result := TGXOutlookItem(inherited Add);
end;

procedure TGXOutlookItems.Delete(Index: Integer);
begin
  if (FBar.SelectedItem = Index) and (FBar.SelectedButton = Self.Index) then
    FBar.SelectedItem := -1;
  Items[Index].Free;
  FBar.UpdatePaint;
end;

function TGXOutlookItems.GetItem(Index: Integer): TGXOutlookItem;
begin
  Result := TGXOutlookItem(inherited GetItem(Index));
end;

procedure TGXOutlookItems.SetItem(Index: Integer; Value: TGXOutlookItem);
begin
  inherited SetItem(Index, Value);
end;

procedure TGXOutlookItems.SetCaption(Value: string);
begin
  FCaption := Value;
  FBar.UpdatePaint;
end;

procedure TGXOutlookItems.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    if FVisible then
      FBar.IncVisibleFactor
    else
      FBar.DecVisibleFactor;
    FBar.BarVisibleChange(self);  
    FBar.UpdatePaint;
  end;
end;

procedure TGXOutlookItems.Assign(Source: TPersistent);
var
  i: Integer;
begin
  if Source is TGXOutlookItems then
  begin
    Clear;
    Caption := TGXOutlookItems(Source).Caption;
    for i := 0 to TGXOutlookItems(Source).Count - 1 do
      with Add do
        Assign(TGXOutlookItems(Source).Items[i]);
  end
  else
    inherited Assign(Source);
end;

procedure TGXOutlookItems.Swap(Index1,Index2: Integer);
var
  TempIcon: TGXOutlookItem;
begin
  BeginUpdate;
  TRY
    //Create temporary storage
    TempIcon := Add;
    TempIcon.Assign(Items[Index1]);
    Items[Index1].Assign(Items[Index2]);
    Items[Index2].Assign(TempIcon);
    //Delete temporary storage
    Delete(Count - 1);
  FINALLY
    EndUpdate;
  END;
end;

//*********************** TGXOutlookItem *************************
constructor TGXOutlookItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FImageIndex := -1;
  FEnabled := True;
  FVisible := True;
end;

destructor TGXOutlookItem.Destroy;
begin
  if Assigned(ActionLink) then
  begin
    FActionLink.Free;
    FActionLink := nil;
  end;  
  inherited Destroy;
end;

procedure TGXOutlookItem.Assign(Source: TPersistent);
begin
  if Source is TGXOutlookItem then
  begin
    Action := TGXOutlookItem(Source).Action;
    ImageIndex := TGXOutlookItem(Source).ImageIndex;
    Caption := TGXOutlookItem(Source).Caption;
    Enabled := TGXOutlookItem(Source).Enabled;
    Visible := TGXOutlookItem(Source).Visible;
  end
  else
    inherited Assign(Source);
end;

procedure TGXOutlookItem.SetCaption(Value: string);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Change;
  end;
end;

procedure TGXOutlookItem.SetImageIndex(Value: integer);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Change;
  end;
end;

procedure TGXOutlookItem.Change;
begin
  TGXOutlookItems(Collection).FBar.UpdatePaint;
end;

procedure TGXOutlookItem.Click;
begin
  if Assigned(FOnClick) and (Action <> nil) and (@FOnClick <> @Action.OnExecute) then
    FOnClick(Self)
  else if not (csDesigning in ComponentState) and (ActionLink <> nil) then
    ActionLink.Execute
  else if Assigned(FOnClick) then
    FOnClick(Self);
end;

procedure TGXOutlookItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if Assigned(Action) and (Operation = opRemove) and (Action = AComponent) then
    Action := nil;
end;

function TGXOutlookItem.GetAction: TBasicAction;
begin
  if ActionLink <> nil then
    Result := ActionLink.Action
  else
    Result := nil;
end;

procedure TGXOutlookItem.SetAction(Value: TBasicAction);
begin
  if Value = nil then
  begin
    if Assigned(ActionLink) then
    begin
      ActionLink.Free;
      ActionLink := nil;
    end;  
  end
  else
    if Assigned(OutlookBar) then
    begin
      if ActionLink = nil then
        ActionLink := GetActionLinkClass.Create(Self);
      ActionLink.Action := Value;
      ActionLink.OnChange := DoActionChange;
      ActionChange(Value, csLoading in Value.ComponentState);
      Value.FreeNotification(OutlookBar);
    end;
end;

procedure TGXOutlookItem.DoActionChange(Sender: TObject);
begin
  ActionChange(Sender, False);
end;

procedure TGXOutlookItem.ActionChange(Sender: TObject; CheckDefaults: boolean);
begin
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or (Self.Caption = '') then
        Self.Caption := Caption;
      if not CheckDefaults or (Self.Enabled = True) then
        Self.Enabled := Enabled;
      if not CheckDefaults or (Self.Visible = True) then
        Self.Visible := Visible;
      if not CheckDefaults or not Assigned(Self.OnClick) then
        Self.OnClick := OnExecute;
    end;
end;

procedure TGXOutlookItem.SetEnabled(Value: Boolean);
begin
  if FEnabled <> Value then
  begin
    FEnabled := Value;
    Change;
  end;
end;

procedure TGXOutlookItem.SetVisible(Value: Boolean);
begin
  if FVisible <> Value then
  begin
    FVisible := Value;
    Change;
  end;
end;


//********************* TGeoCustomControl **********************
constructor TGeoCustomControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPaintBM := TBitmap.Create;
  FVisibleFactor := 0;
  FStripAccChar := true;
  FButtonWidth := GetSystemMetrics(SM_CXVSCROLL);
  FScrollBtnStyle := sbButton;
  FTracking := hrNone;
  FItemHightlightColor := clNone;
  FMouseOver := hrNone;
  FSmoothScrolling := true;
  FScrollDelay := 5;
  FSliding := False;
  FDesign := False;
  FButtonColor := clBtnFace;
  ControlStyle := [csOpaque, csClickevents, csDoubleClicks];
  FList := TList.Create;
  FBackground := TPicture.Create;
  FBackground.OnChange := BackgroundChange;
  FSelectedFont := TFont.Create;
  FSelectedFont.OnChange := FontChange;
  FItemHightlightFont := TFont.Create;
  FItemHightlightFont.OnChange := FontChange;
  FBtnFont := TFont.Create;
  FBtnFont.OnChange := FontChange;
  FSelectedButton := -1;
  FSelectedItem := -1;
  FTopIndex := 0;
  FSpacing := 10;
  FTopSpacing := 4;
  FSliderRect := Rect(0,0,0,0);
  Color := clBtnShadow;
  Width := 100;
  Height := 300;
  FEditIcon := -1;
  FEditing := False;  FrameStyle := fsButton;end;

Destructor TGeoCustomControl.Destroy;
begin
  FPaintBM.Free;
  Clear;
  FSelectedFont.Free;
  FItemHightlightFont.Free;
  FBtnFont.Free;
  FList.Free;
  FBackground.Free;
  inherited Destroy;
end;

procedure TGeoCustomControl.FontChange(Sender: TObject);
begin
  UpdatePaint;
end;

procedure TGeoCustomControl.BackgroundChange(Sender: TObject);
begin
  UpdatePaint;
end;

function TGeoCustomControl.GetIcons(Index: Integer): TGXOutlookItems;
begin
  Result := TGXOutlookItems(FList.Items[Index]);
end;

procedure TGeoCustomControl.SetIcons(Index: Integer; Icons: TGXOutlookItems);
begin
  TGXOutlookItems(FList.Items[Index]).Assign(Icons);
end;

procedure TGeoCustomControl.Clear;
begin
  while FList.Count > 0 do
  begin
    TGXOutlookItems(FList.Items[0]).Free;
    FList.Delete(0);
  end;
  FSelectedItem := -1 ;         { Tom - 07/??/1999 }
  FSelectedButton := -1;
end;

function TGeoCustomControl.Add: TGXOutlookItems;
begin
  Result := TGXOutlookItems.Create;
  Result.FBar := Self;
  FList.Add(Result);
  Result.FIndex := FList.Count - 1;
  if SelectedButton = -1 then
  begin
    FSelectedButton := 0;
    UpdatePaint;
  end;
end;

procedure TGeoCustomControl.Delete(Index: Integer);
begin
  if (Index >= 0) and (Index <= FList.Count - 1) then
  begin
    if FSelectedButton = Index then
      FSelectedItem := -1
    else
      if FSelectedButton > Index then
        Dec(FSelectedButton);
    TGXOutlookItems(FList.Items[Index]).Free;
    FList.Delete(Index);
    if FSelectedButton > FList.Count - 1 then
      FSelectedButton := FList.Count - 1;
    Repaint;
  end;
end;

function TGeoCustomControl.GetCount: Integer;
begin
  if Assigned(FList) then
    result := FList.Count
  else
    result := 0;  
end;

procedure TGeoCustomControl.WMEraseBkgnd(var Msg: TMessage);
begin
  Msg.Result := 1;
end;

function TGeoCustomControl.GetClientRect: TRect;
begin
  Result := inherited GetClientRect;
  InflateRect(Result,-1,-1);
{  if Border = bsSingle then
    InflateRect(Result,-1,-1);}
end;

procedure TGeoCustomControl.Loaded;
var
  i, j: integer;
begin
  inherited Loaded;
  for i := 0 to Count - 1 do
    for j := 0 to Items[i].Count - 1 do
      if Assigned(Items[i].Items[j].Action) then
        Items[i].Items[j].ActionChange(Action, True);
end;

procedure TGeoCustomControl.PaintSlider(ACanvas: TCanvas; Button: Integer; ARect: TRect);
const
  BtnMargin = 4;

  procedure PaintTopButton(State: TGXButtonState);
  var
    R: TRect;
    BtnSliderWidth,BtnSliderHeight: Integer;   
  begin
    if FScrollBtnStyle = sbSlider then
      R := Rect(ARect.left, ARect.Top - 1, ARect.Right, ARect.Top + 10)
    else
      R := Rect(ARect.Right - (FButtonWidth + BtnMargin), ARect.Top + BtnMargin,
                ARect.Right - BtnMargin, ARect.Top + BtnMargin + FButtonWidth);
    FTopBtn := R;
    ACanvas.brush.color:= ButtonColor;
    ACanvas.FillRect (R);
    ACanvas.brush.style:=bsclear;

    BtnSliderWidth := (((R.Right - R.left) div 2) + R.left) - 3;
    BtnSliderHeight := (((R.Bottom - R.Top) div 2) + R.Top) - 1;

    if State = bsUp then
    begin
      if FScrollBtnStyle = sbSlider then
        Frame3D(ACanvas,R,clBtnHighlight,clBtnShadow,1)
      else
        Frame3D(ACanvas,R,clWhite,clblack,1);
    end
    else
    begin
      if FScrollBtnStyle = sbSlider then
        Frame3D(ACanvas,R,clBtnShadow,clBtnHighlight,1)
      else
        Frame3D(ACanvas,R,clblack,clWhite,1);

      Inc(BtnSliderWidth, 1);
      Inc(BtnSliderHeight, 1);
    end;
    ACanvas.pen.color := clBlack;
    ACanvas.Brush.Color := clBlack;
    ACanvas.Polygon([Point(BtnSliderWidth + 3, BtnSliderHeight),
                     Point(BtnSliderWidth + 2, BtnSliderHeight),
                     Point(BtnSliderWidth + 5, BtnSliderHeight + 2),
                     Point(BtnSliderWidth, BtnSliderHeight + 2)]);
  end;

  procedure PaintBottomButton(State: TGXButtonState);
  var
    R: TRect;
    BtnSliderWidth,BtnSliderHeight: Integer;
  begin
    if FScrollBtnStyle = sbSlider then
      R := Rect(ARect.left, ARect.Bottom - 10, ARect.Right, ARect.Bottom + 1)
    else
      R := Rect(ARect.Right - (FButtonWidth + BtnMargin), ARect.Bottom - (FButtonWidth + BtnMargin),
               ARect.Right - BtnMargin, ARect.Bottom - BtnMargin);
    FBottomBtn := R;
    ACanvas.brush.color:= ButtonColor;
    ACanvas.FillRect (R);
    ACanvas.brush.style:=bsclear;

    BtnSliderWidth := (((R.Right - R.left) div 2) + R.left) - 3;
    BtnSliderHeight := (((R.Bottom - R.Top) Div 2) + R.Top) - 1;
    
    if State = bsUp then
    begin
      if FScrollBtnStyle = sbSlider then
        Frame3D(ACanvas,R,clBtnHighlight,clBtnShadow,1)
      else
        Frame3D(ACanvas,R,clWhite,clblack,1);
    end
    else
    begin
      if FScrollBtnStyle = sbSlider then
        Frame3D(ACanvas,R,clBtnShadow,clBtnHighlight,1)
      else
        Frame3D(ACanvas,R,clblack,clWhite,1);
      Inc(BtnSliderWidth, 1);
      Inc(BtnSliderHeight, 1);
    end;
    
    ACanvas.pen.color := clBlack;
    ACanvas.Brush.Color := clBlack;
    ACanvas.Polygon([Point(BtnSliderWidth, BtnSliderHeight),
                     Point(BtnSliderWidth + 5, BtnSliderHeight),
                     Point(BtnSliderWidth + 2, BtnSliderHeight + 2),
                     Point(BtnSliderWidth + 3, BtnSliderHeight + 2)]);
  end;
  procedure PaintItemHighlight(aRect: TRect);
  begin
    with ACanvas do
    begin
      if FItemHightlightColor <> clNone then
      begin
        Brush.Color := FItemHightlightColor;
        FillRect(aRect);
      end;  
      Font.Assign(FItemHightlightFont);
    end;
  end;
  function StripAccl(Value: string): string;
  begin
    while Pos('&',Value) > 0 do
      System.Delete(Value, Pos('&',Value),1);
    result := Value;
  end;
var
  IconHeight: Integer;
  ItemHeight: integer;
  IconWidth: Integer;
  IconRect: TRect;
  FrameHeight: Integer;
  ItemRect,FrameR: TRect;
  ItemTop: Integer;
  Icon: TIcon;
  i: Integer;
  S: string;
begin
  for i := 0 to Items[Button].Count - 1 do
  begin
    Items[Button].Items[i].FIconRect := Rect(0,0,0,0);
    Items[Button].Items[i].FTextRect := Rect(0,0,0,0);
  end;
  ItemRect := Rect(0,0,0,0);
  FBottomBtn := Rect(0,0,0,0);
  FTopBtn := Rect(0,0,0,0);
  if not PaintBackground(ACanvas,ARect) then
  begin
    ACanvas.Brush.Color := Self.Color;
    ACanvas.FillRect(ARect);
  end;
  with ACanvas do
  begin
    Font.Assign(Self.Font);
    Dec(ARect.Left, 1);
    Inc(ARect.Right, 1);
    Frame3D(ACanvas, ARect, clBlack, clBtnHighlight, 1);
    if FSliding then EXIT;
    ItemTop := ARect.Top + FTopSpacing;
    if Assigned(Images) then
    begin
      IconHeight := Images.Height;
      IconWidth := Images.Width;
    end
    else
    begin
      IconHeight := 32;
      IconWidth := 32;
    end;

    // now we paint the items
    Icon := TIcon.Create;
    TRY
      FVisibleItems := (ARect.Bottom - ARect.Top) div (IconHeight + 12 + TextHeight('Wg') + FSpacing);
      for i := FTopIndex to Items[Button].Count - 1 do
      begin
        // if the item is not visible then skip it
        if (NOT Items[Button].Items[i].Visible) AND (NOT FDesign) then Continue;
        
        S := Items[Button].Items[i].Caption;
        //Need to set initial rectangle so DrawText can calculate space required
        ItemRect.Left := ClientRect.Left + 2;
        ItemRect.Right := ClientRect.Right - 2;
        ItemRect.Top := ItemTop;
        ItemHeight := IconHeight + 4;
        ItemRect.Bottom := ItemTop;
        // now we calculate the area for the text
        if FStripAccChar then
          s := StripAccl(s);
        if FWordWrap then
        begin
          DrawText(ACanvas.Handle, PChar(S), length(S), ItemRect,
                   DT_CALCRECT + DT_CENTER + DT_WORDBREAK);
          ItemHeight := ItemHeight + (ItemRect.Bottom - ItemRect.Top);
        end
        else
          ItemHeight := ItemHeight + TextHeight('Wg');
        ItemHeight := ItemHeight + FSpacing;
        ItemRect.Left := ClientRect.Left + 2;
        ItemRect.Right := ClientRect.Right - 2;
        ItemRect.Top := ItemTop;
        ItemRect.Bottom := ItemTop + ItemHeight;
        if ItemRect.Bottom < ARect.Bottom then
        begin
          // give the frame a 2 pixel margin around the icon of the item
          FrameR.Left := ClientRect.Left - 4 + (ClientWidth - IconWidth) div 2;
          FrameR.Top := ItemRect.Top;
          FrameR.Right := FrameR.Left + IconWidth + 8;
          FrameR.Bottom := FrameR.Top + IconHeight + 8;
          // save the icon rect
          IconRect := FrameR;

          // save the frame height here, because calls to Frame3d will change it
          // and we need this to figure out were the text goes
          FrameHeight := (FrameR.Bottom - FrameR.Top);

          // adjust the frame size if the frame style is one of the row styles.
          if (FrameStyle in [fsRowLowered, fsRowRaised, fsRowButton]) then
          begin
            // if there is no editing then wrap the row frame around the text too
            if not AllowEditing then
              FrameR.Bottom := ItemRect.Bottom;
            FrameR.Left := 1;
            FrameR.Right := ClientRect.Right;
          end;

          // save the heightlight area
          Items[Button].Items[i].FIconRect := FrameR;

          // draw the frame of the item
          Font.Assign(Self.Font);
          if ( (fTracking = hrIcon) and (fTrackingData = i) ) or
             ( (fMouseOver = hrIcon) and (FMouseOverData = i) ) then
          begin
            if (FrameStyle in [fsRaised, fsButton, fsRowRaised, fsRowButton]) and (fTracking = hrNone) then
            begin
              if (SelectedItem <> i) or (FrameStyle in [fsRaised, fsRowRaised]) then
                Frame3D(ACanvas, FrameR, cl3DLight, cl3DDkShadow, 1);
              PaintItemHighlight(FrameR);
            end
            else
              if (FrameStyle in [fsLowered, fsRowLowered]) or (fTracking = hrIcon) then
              begin
                PaintItemHighlight(FrameR);
                Frame3D(ACanvas, FrameR, cl3DDkShadow, cl3DLight, 1);
              end;
          end;
          if ( (SelectedItem = i) and (FTracking <> hrIcon) ) or
             ( (FTracking = hrIcon) and (FTrackingData = i) ) then
          begin
            if FrameStyle in [fsButton, fsRowButton] then
              Frame3D(ACanvas, FrameR, cl3DDkShadow, cl3DLight, 1);
            Font.Assign(SelectedFont);
          end;

          // draw the icon
          if Assigned(Images) AND (Items[Button].Items[i].ImageIndex > -1) AND
             (Items[Button].Items[i].ImageIndex < Images.Count) then
          begin
            Images.GetIcon(Items[Button].Items[i].ImageIndex, Icon);
            Draw( IconRect.Left + 4, IconRect.Top + 4, Icon);
          end;

          // draw the text of the item
          ItemRect.Top := ItemRect.Top + FrameHeight;
          Items[Button].Items[i].FTextRect := ItemRect;
          Brush.Style := bsClear;
          if WordWrap then
            DrawText(ACanvas.Handle, PChar(S), length(S), ItemRect, DT_CENTER + DT_WORDBREAK)
          else
            DrawText(ACanvas.Handle, PChar(S), length(S), ItemRect,
                     DT_CENTER + DT_SINGLELINE + DT_END_ELLIPSIS);
          Brush.Style := bsSolid;
        end
        else
        begin
          if (FTracking = hrButton) and (FTrackingData = 0) then
            PaintBottomButton(bsDown)
          else
            PaintBottomButton(bsUp);
          Break;
        end;
        Font.Style := [];
        ItemTop := ItemTop + ItemHeight;
      end;
    FINALLY
      Icon.Free;
    END;
  end;
  if (FTopIndex > 0) then
  begin
    if (FTracking = hrButton) and (FTrackingData = 1) then
      PaintTopButton(bsDown)
    else
      PaintTopButton(bsUp);
  end;
end;

function TGeoCustomControl.PaintBackground(ACanvas: TCanvas; ARect: TRect): Boolean;
var
  X,Y: Integer;
  XMax,YMax: Integer;
  SRect,DRect: TRect;
begin
  Result := False;
  if (FBackground.Graphic = nil) then EXIT;
  if (FBackground.Graphic.empty) then EXIT;
  XMax := ((ARect.Right - ARect.Left) div FBackground.Width) + 1;
  YMax := ((ARect.Bottom - ARect.Top) div FBackground.Height) + 1;
  for x := 1 to XMax do
    for y := 1 to YMax do
    begin
      DRect := Rect( ARect.Left + (x - 1) * FBackground.Width,
                     ARect.Top + (y - 1) * FBackground.height,
                     ARect.Left + (x - 1) * FBackground.Width + FBackground.Width,
                     ARect.Top + (y - 1) * FBackground.height + FBackground.Height);
      if DRect.Right > ARect.Right then DRect.Right := ARect.Right;
      if DRect.Bottom > ARect.Bottom then DRect.Bottom := ARect.Bottom;
      SRect := Rect(0, 0, FBackground.Width, FBackground.Height);
      SRect.Right := SRect.Left + (DRect.Right - DRect.Left);
      SRect.Bottom := SRect.Top + (DRect.Bottom - DRect.Top);
      ACanvas.CopyRect(DRect, FBackground.Bitmap.Canvas, SRect);
    end;
  Result := True;
end;

procedure TGeoCustomControl.PaintButton(ACanvas: TCanvas; Button: Integer; ARect: TRect; State: TGXButtonState);
var
  S: string;
begin
  with ACanvas do
  begin
    Brush.Color := FButtonColor;
    Font.Assign(ButtonFont);
    FillRect(ARect);
    if State = bsUp then
      Frame3D(ACanvas, ARect, clBtnHighlight, clBtnShadow, 1)
    else
    begin
      Frame3D(ACanvas, ARect, clBtnShadow, clBtnHighlight, 1);
      Inc(ARect.Top, 1);
      Inc(ARect.Left, 1);
    end;
    S := Items[Button].Caption;
    DrawText(ACanvas.Handle, PChar(S), length(S), ARect, DT_CENTER + DT_VCENTER + DT_SINGLELINE);
  end;
end;

procedure TGeoCustomControl.SetButtonHeight;
begin
  Canvas.Font.Assign(FBtnFont);
  FButtonheight := Canvas.TextHeight('Wg') + 8;
end;

procedure TGeoCustomControl.PaintBorder(ACanvas: TCanvas);
var
  ARect: TRect;
begin
  ARect:=Rect(0, 0, Width, Height);
  ACanvas.Brush.Color := Self.Color;
  ACanvas.FillRect(ARect);
  Frame3D(ACanvas, ARect, clBtnShadow, clBtnHighlight, 1);
end;

procedure TGeoCustomControl.Paint;
var
  BtnRect: TRect;
  BtnTop: Integer;
  i: Integer;
begin
  SetButtonHeight;
  FPaintBM.Width := Width;
  FPaintBM.Height := Height;
  PaintBorder(FPaintBM.Canvas);
  BtnRect := Rect(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Top + FButtonHeight);
  for i := 0 to Count - 1 do
  begin
    if Items[i].Visible then
    begin
      Items[i].FBtnRect := BtnRect;
      if (FTracking = hrSection) and (FTrackingData = i) then
        PaintButton(FPaintBM.Canvas, i, BtnRect, bsDown)
      else
        PaintButton(FPaintBM.Canvas, i, BtnRect, bsUp);
      if (i = FSelectedButton) and (FSelectedButton <> -1) then
      begin
        BtnTop := (Clientheight) - ( GetVisibleAfter(i) * FButtonHeight );
        FSliderRect := Rect(ClientRect.Left, BtnRect.Bottom, ClientRect.Right, BtnTop);
        PaintSlider(FPaintBM.Canvas, i, FSliderRect);
        BtnRect := Rect(ClientRect.Left, BtnTop, ClientRect.Right, BtnTop + FButtonHeight);
      end
      else
        BtnRect := Rect(ClientRect.Left, BtnRect.Bottom, ClientRect.Right, BtnRect.Bottom + FButtonheight)
    end
    else
      Items[i].FBtnRect := Rect(-1,-1,-1,-1);
  end;
  Canvas.CopyRect(Rect(0, 0, Width, Height), FPaintBM.Canvas, Rect(0, 0, Width, Height));
end;

procedure TGeoCustomControl.SetSelectedButton(Value: Integer);
begin
  if csLoading in ComponentState then
  begin
    FSelectedButton := Value;
    Exit;
  end;

  if (Value < 0) then
  begin
    if GetVisibleCount = 0 then
      Value := -1
    else
      Value := 0;
  end;

  if (Value < Count) and (value <> FSelectedButton) then
  begin
    if FSmoothScrolling then
      DoSlide(Value)
    else
    begin
      FSelectedButton := Value;
      FSelectedItem := -1;
      FTopIndex := 0;
      UpdatePaint;
      Change;
    end;
  end;
end;

procedure TGeoCustomControl.CreateWnd;
begin
  inherited CreateWnd;
  if (Count > 0) and (SelectedButton = -1) then
    SelectedButton := 0;
end;

procedure TGeoCustomControl.UpdatePaint;
begin
  if NOT (csLoading in ComponentState) then
  begin
    if (Count > 0) and (SelectedButton = -1) then
      SelectedButton := 0;
    Invalidate;
  end;
end;

procedure TGeoCustomControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
  htResult:TGXHitResult;
begin
  HitTest(x, y, htResult, Index);
  if NOT ((htResult = FMouseOver) AND (Index = FMouseOverData)) then
  begin
    FMouseOver := htResult;
    FMouseOverData := Index;
    Repaint;
  end;
end;

{ Tom - 07/30/1999 }
procedure TGeoCustomControl.EditKeyPress(Sender: TObject; var Key: Char);begin  if FEditing then    case Key of      #27: StopEditing(False);      #13: begin             StopEditing(True);             Key := #13;           end;    end;end;{ Tom - 07/30/1999 }procedure TGeoCustomControl.StartEditing;begin  FEditing := True;  if not Assigned(FEditIconText) then  begin    FEditIconText := TEdit.Create(nil);    TRY      with FEditIconText do      begin        OnKeyPress := EditKeyPress;        AutoSize := True;      end;    EXCEPT    END;  end;  with FEditIconText as TEdit do  begin    Visible :=False;    Parent := Self;    Left := Items[SelectedButton].Items[FEditIcon].FTextRect.Left;    Top := Items[SelectedButton].Items[FEditIcon].FTextRect.Top;    Width := Items[SelectedButton].Items[FEditIcon].FTextRect.Right - Left;    FEditIconText.Text := (Items[SelectedButton].Items[FEditIcon].Caption);    SelectAll;    Ctl3D := False;    Visible := True;    Show;    SetFocus;  end;end;procedure TGeoCustomControl.StopEditing(SaveChanges: Boolean);             { Tom - 07/30/1999 }begin  if FEditing then  begin    FEditIconText.Parent := nil;    if SaveChanges then      Items[SelectedButton].Items[SelectedItem].Caption := FEditIconText.Text;    SetFocus;    if SaveChanges then      TextChange;  end;  FEditing := False;end;
procedure TGeoCustomControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  htResult: TGXHitResult;
  Index: Integer;
begin
  if Button <> mbLeft then
  begin
    inherited MouseDown(Button, Shift, x, y);
    EXIT;
  end;
  SetCapture(Handle);
  HitTest(X, Y, htResult, Index);
  StopEditing(True);
  if FAllowEditing then                 { Tom - 07/08/1999 }  begin    if (htResult = hrIcon) or (htResult = hrIconText) then    begin      if htResult = hrIconText then      begin        if (FEditIcon <> -1) and (FEditIcon = Index) then StartEditing        else FEditIcon := Index;      end      else        FEditIcon := Index;    end    else      FEditIcon := -1;  end;  FTracking := htResult;
  FTrackingData := Index;
  FMouseOver := hrNone;
  Repaint;
end;

procedure TGeoCustomControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  htResult: TGXHitResult;
  Index: Integer;
  CanChange: Boolean;
begin
  if GetCapture=Handle then
    SetCapture(0);
  if Button <> mbLeft then
  begin
    inherited MouseUp(Button, Shift, x, y);
    Exit;
  end;
  CanChange := True;
  HitTest(X, Y, htResult, Index);
  if (htResult = hrSection) or (htResult = hrIcon) then
    if Assigned(FOnChanging) then
      OnChanging(Self, CanChange);
  if CanChange then
    case htResult of
      hrSection:  SelectedButton := Index;
      hrIcon:     begin
                    if Items[SelectedButton].Items[Index].Enabled or FDesign then
                    begin
                      SelectedItem := Index;
                      Items[SelectedButton].Items[Index].Click;
                    end;  
                    if Assigned(OnItemClick) then OnItemClick(Self);
                  end;
      hrIconText: begin                                              { Tom - 07/30/1999 }
                    if Items[SelectedButton].Items[Index].Enabled then SelectedItem := Index                    else if FDesign then SelectedItem := Index;                    if Assigned(OnItemTextClick) then OnItemTextClick(Self);                  end;      hrButton:   begin
                    if Index = 1 then
                      Dec(FTopIndex)
                    else
                      inc(FTopIndex);
                  end;
    end;
  FTracking := hrNone;
  FMouseOver := hrNone;
  RePaint;
end;

procedure TGeoCustomControl.CMMouseLeave(var Msg: TMessage);
begin
  inherited;
  if (FMouseOver = hrIcon) then
  begin
    FMouseOver := hrNone;
    Repaint;
  end;
end;

procedure TGeoCustomControl.HitTest(x,y: Integer; var htResult: TGXHitResult; var Index: Integer);
var
  i: Integer;
begin
  if PtInRect(FTopBtn, Point(X,Y)) then
  begin
    htResult := hrButton;
    Index := 1;
    EXIT;
  end;
  if PtInRect(FBottomBtn, Point(X,Y)) then
  begin
    htResult := hrButton;
    Index := 0;
    EXIT;
  end;
  for i := 0 to Count - 1 do
    if PtInRect(Items[i].FBtnRect, Point(X,Y)) then
    begin
      htResult := hrSection;
      Index := i;
      EXIT;
    end;
  if (SelectedButton >= 0) then                    { Tom - 07/30/1999 }
    for i := 0 to Items[SelectedButton].Count - 1 do    begin      if PtInRect(Items[SelectedButton].Items[i].FIconRect, Point(X,Y)) then      begin        htResult:=hrIcon;        Index := i;        EXIT;      end;      if PtInRect(Items[SelectedButton].Items[i].FTextRect, Point(X,Y)) then      begin        htResult := hrIconText;        Index := i;        EXIT;      end;    end;  htResult := hrNone;end;

procedure TGeoCustomControl.SetSelectedItem(Value: Integer);
begin
  if Value < 0 then
    Value := -1;

  if csLoading in ComponentState then
  begin
    FSelectedItem := Value;
    Exit;
  end;

  if Value > -1 then
    if NOT (FDesign or Items[SelectedButton].Items[Value].Visible) then
      Value := -1;

  if (Value <> FSelectedItem) and (Value < Items[SelectedButton].Count) then
  begin
    FSelectedItem := Value;
    if (FTopIndex >= FSelectedItem) then
      FTopIndex := FSelectedItem
    else if FTopIndex + (FVisibleItems - 1) < FSelectedItem then
      FTopIndex := FSelectedItem - (FVisibleItems - 1);
    if FTopIndex < 0 then
      FTopIndex := 0;
    Invalidate;
    Change;
  end;
end;

procedure TGeoCustomControl.WMSize(var Msg: TWMSize);
begin
  Invalidate;
end;

procedure TGeoCustomControl.SetBackground(Value: TPIcture);
begin
  FBackground.Assign(Value);
  Repaint;
end;

procedure TGeoCustomControl.SetBtnFont(Value: TFont);
begin
  FBtnFont.Assign(Value);
  Repaint;
end;

procedure TGeoCustomControl.SetSelectedFont(Value: TFont);
begin
  FSelectedFont.Assign(Value);
  Repaint;
end;

procedure TGeoCustomControl.ReadData(Reader: TReader);
var
  Icons: TGXOutlookItems;
begin
  with Reader do
  begin
    NextValue;
    ReadListbegin;
    TRY
      while NOT EndofList do
      begin
        Icons:=TGXOutlookItems.Create;
        Icons.FBar:=Self;
        NextValue;
        Icons.Caption:=ReadString;
        ReadValue;
        ReadCollection(Icons);
        FList.Add(Icons);
      end;
    FINALLY
      ReadListend;
    END;
  end;
end;

procedure TGeoCustomControl.WriteData(Writer: TWriter);
var
  i: Integer;
begin
  with Writer do
  begin
    WriteListbegin;
    TRY
      for i := 0 to FList.Count - 1 do
      begin
        WriteString(TGXOutlookItems(FList.Items[i]).Caption);
        WriteCollection(TGXOutlookItems(FList.Items[i]));
      end;
    FINALLY
      WriteListend;
    END;
  end;
end;

function TGeoCustomControl.DoWrite: Boolean;
begin
  Result:=(FList.Count > 0);
end;

procedure TGeoCustomControl.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('List', ReadData, WriteData, DoWrite);
end;

procedure TGeoCustomControl.CMColorChanged(var Msg: TMessage);
begin
  inherited;
  Repaint;
end;

procedure TGeoCustomControl.SetFrameStyle(Value: TGXOutlookFrameStyle);
begin
  if FFrameStyle <> Value then
  begin
    FFrameStyle := Value;
    Repaint;
  end;  
end;

procedure TGeoCustomControl.SetSpacing(Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Repaint;
  end;  
end;

procedure TGeoCustomControl.SetTopSpacing(Value: Integer);
begin
  if FTopSpacing <> Value then
  begin
    FTopSpacing := Value;
    Repaint;
  end;  
end;

procedure TGeoCustomControl.SetWordWrap(Value: Boolean);
begin
  if FWordWrap <> Value then
  begin
    FWordWrap := Value;
    Repaint;
  end;  
end;

procedure TGeoCustomControl.DoSlide(NewSection: Integer);

  procedure SlideDelay;
  var
    StartTick,EndTick: Integer;
  begin
      StartTick := GetTickCount;
      repeat
        EndTick := GetTickCount;
      until EndTick > StartTick + FScrollDelay;
  end;
  
  procedure SlideUp;
  var
    i: integer;
    NewSlideRect: TRect;
  begin
    if FSlideInfo.NewSection > FSlideInfo.OldSection then
    begin
      FSlideSrc.Bottom := Items[FSlideInfo.NewSection].FBtnRect.Bottom;
      FSlideDest.Bottom := FSlideSrc.Bottom;
    end;
    while FSliderRect.Bottom >= FSliderRect.Top + 5 do
    begin
      FSlideSrc.Top := FSlideSrc.Top + 5;
      FSlideDest.Bottom := FSlideDest.Bottom - 5;
      Canvas.CopyRect(FSlideDest, FPaintBM.Canvas, FSlideSrc);
      FSliderRect.Bottom := FSliderRect.Bottom - 5;
      NewSlideRect := FSliderRect;
      NewSlideRect.Top := FSlideDest.Bottom;
      i := GetNextSection(FSlideInfo.NewSection);
      if (i > -1) AND (i < Count) then
      begin
        NewSlideRect.Bottom := Items[i].FBtnRect.Top - 1;
        PaintSlider(Canvas, FSlideInfo.NewSection + 1, NewSlideRect);
      end
      else
      begin
        NewSlideRect.Bottom := ClientHeight;
        PaintSlider(Canvas, FSlideInfo.NewSection, NewSlideRect);
      end;
      SlideDelay;
    end;
  end;

  procedure SlideDown;
  var
    i: integer;
    NewSlideRect: TRect;
    Bottom: Integer;
  begin
    FSlideSrc.Top := Items[FSlideInfo.NewSection].FBtnRect.Bottom + 1;
    FSlideDest.Top := FSlideSrc.Top;
    i := GetNextSection(FSlideInfo.OldSection);
    if i = -1 then
      Bottom := ClientHeight - 1
    else
      Bottom := Items[i].FBtnRect.Top - 1;
    while FSlideDest.Top <= (Bottom) - (Items[fSlideInfo.OldSection].FBtnRect.Bottom - Items[fSlideInfo.OldSection].FBtnRect.Top) - 2 do
    begin
      FSlideSrc.Bottom := FSlideSrc.Bottom - 5;
      FSlideDest.Top := FSlideDest.Top + 5;
      Canvas.CopyRect(FSlideDest, FPaintBM.Canvas, FSlideSrc);
      NewSlideRect := FSliderRect;
      NewSlideRect.Top := Items[FSlideInfo.NewSection].FBtnRect.Bottom + 1;
      NewSlideRect.Bottom := FSlideDest.Top - 1;
      PaintSlider(Canvas, FSlideInfo.NewSection, NewSlideRect);
      SlideDelay;
    end;
  end;

begin
  FSliding := True;
  TRY
    FSlideInfo.OldSection := SelectedButton;
    FSlideInfo.NewSection := NewSection;
    FSlideSrc := FSliderRect;
    FSlideDest := FSliderRect;
    if HandleAllocated then
    begin
      if FSlideInfo.NewSection > FSlideInfo.OldSection then
        SlideUp
      else
        SlideDown;
    end;
  FINALLY
    FSliding := false;
  END;
  FSelectedButton := FSlideInfo.NewSection;
  FSelectedItem := -1;
  FTopIndex := 0;
  UpdatePaint;
  Change;
end;

procedure TGeoCustomControl.Change;
begin
  if NOT(csLoading in ComponentState) then
    if Assigned(FOnChange) then
      FOnChange(self);
end;

procedure TGeoCustomControl.TextChange;
begin
  if NOT(csLoading in ComponentState) then
    if Assigned(FOnItemTextChange) then
      FOnItemTextChange(self);
end;

procedure TGeoCustomControl.SetImages(const Value: TCustomImageList);
begin
  if FImageList <> Value then
  begin
    FImageList := Value;
    if Assigned(FImageList) then
      FImageList.FreeNotification(self);
    invalidate;
  end;
end;

procedure TGeoCustomControl.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  i, j: integer;  
begin
  inherited Notification(AComponent, Operation);
  if Assigned(FImageList) and (Operation = opRemove) and (FImageList = AComponent) then
    FImageList := nil;

  for i := 0 to Count - 1 do
    for j := 0 to Items[i].Count - 1 do
      Items[i].Items[j].Notification(AComponent, Operation);
end;

procedure TGeoCustomControl.SetScrollBtnStyle(const Value: TGXScrollBtnStyle);
begin
  if FScrollBtnStyle <> Value then
  begin
    FScrollBtnStyle := Value;
    invalidate;
  end;  
end;

procedure TGeoCustomControl.SetButtonColor(const Value: TColor);
begin
  if FButtonColor <> Value then
  begin
    FButtonColor := Value;
    invalidate;
  end;
end;

procedure TGeoCustomControl.SetItemHightlightColor(const Value: TColor);
begin
  if FItemHightlightColor <> Value then
  begin
    FItemHightlightColor := Value;
    invalidate;
  end;
end;

procedure TGeoCustomControl.SetItemHightlightFont(const Value: TFont);
begin
  FItemHightlightFont.Assign(Value);
end;

procedure TGeoCustomControl.SetStripAccChar(const Value: boolean);
begin
  if FStripAccChar <> Value then
  begin
    FStripAccChar := Value;
    invalidate;
  end
end;

procedure TGeoCustomControl.DecVisibleFactor;
begin
  Dec(FVisibleFactor);
end;

procedure TGeoCustomControl.IncVisibleFactor;
begin
  Inc(FVisibleFactor);
end;

function TGeoCustomControl.GetVisibleCount: integer;
begin
  result := Count + FVisibleFactor;
end;

function TGeoCustomControl.GetVisibleAfter(Value: integer): integer;
var
  i: integer;
begin
  result := 0;
  for i := Value + 1 to Count - 1 do
    if Items[i].Visible then
      Inc(result);
end;

function TGeoCustomControl.GetNextSection(Value: integer): integer;
var
  i: integer;
begin
  result := -1;
  for i := Value + 1 to Count - 1 do
    if Items[i].Visible then
    begin
      result := i;
      break;
    end;
end;

function TGeoCustomControl.GetPriorSection(Value: integer): integer;
var
  i: integer;
begin
  result := -1;
  for i := Value - 1 downto 0 do
    if Items[i].Visible then
    begin
      result := i;
      break;
    end;
end;

procedure TGeoCustomControl.BarVisibleChange(Item: TGXOutlookItems);
var
  i, j: integer;
  SaveScroll: boolean;
begin
  i := FList.IndexOf(Item);
  if SelectedButton = i then
  begin
    SaveScroll := FSmoothScrolling;
    FSmoothScrolling := false;
    TRY
      j := GetPriorSection(i);
      if j > -1 then
        SelectedButton := j
      else
      begin
        j := GetNextSection(i);
        if j > -1 then
          SelectedButton := j
        else
          SelectedButton := -1;
      end;
    FINALLY
      FSmoothScrolling := SaveScroll;
    END;
  end;  
end;   

end.
