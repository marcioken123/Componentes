unit VSOLGroup;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls,VSOLButton,buttons;

type
    TVSOutlookGroupPosition = (spTop,spBottom);
type
  TVSOutlookGroupButton = class(TSpeedButton)
  protected
   procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
   procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
   procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
   procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  public
    constructor Create(AOwner : TComponent);override;
  end;

type
  TVSOutlookGroup = class(TCustomPanel)
  private
    { Private declarations }
    FParent : TComponent;
    FButton : TSpeedButton;
    FOLButtons : TStringList;
    FLargeImages : TImageList;
    FSmallImages : TImageList;
    FImageSize : TOLImageSize;
    FButtonCaption : TCaption;
    FOnButtonClick : TNotifyEvent;
    FPosition : TVSOutlookGroupPosition;
    Findex : integer;
    FBusy : boolean;
  protected
    { Protected declarations }
    procedure SetSmallImages(value : TImageList);
    procedure SetLargeImages(value : TImageList);
    procedure SetImageSize(sz : TOLImageSize);
    procedure Loaded;override;
    procedure Resize;override;
    procedure SetCaption(value : TCaption);
    procedure DoButtonClick(Sender : TObject);
    function GetButtonHeight : integer;
    procedure SetButtonFont(value : TFont);
    procedure SetButtonHeight(value : integer);
    procedure Paint;override;
    procedure ReadState(Reader : TReader);override;
    procedure ButtonDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure WMEraseBkgnd(var Message: TWmEraseBkgnd); message WM_ERASEBKGND;
  public
    { Public Declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
    function HasParent : boolean;override;
    function GetParentComponent : TComponent;override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean); override;
    procedure SetParentComponent(Value : TComponent);override;
    procedure MovingDown;
    procedure MovingUp;
    property SmallImages : TImageList read FSmallImages write SetSmallImages;
    property LargeImages : TImageList read FLargeImages write SetLargeImages;
    property ImageSize : TOLImageSize read FImageSize write SetImageSize;
    property ButtonHeight : integer read GetButtonHeight write SetButtonHeight;
    property Caption;
    property Position : TVSOutlookGroupPosition read FPosition write FPosition;
    property ButtonFont : TFont write SetButtonFont;
    property ob : TComponent read FParent write FParent;
    property OnButtonClick : TNotifyEvent read FOnButtonClick  write FOnButtonClick ;
  published
    { Published declarations }
//    property Align ;
    property Index : integer read FIndex write FIndex;
    property Color;
    property ButtonCaption  : TCaption read FButtonCaption write SetCaption;
  end;


implementation

uses VSOutLookBar;

constructor TVSOutlookGroup.Create(AOwner: TComponent);
begin
    inherited Create(AOwner);
    FBusy := False;
    DoubleBuffered := True;
    BevelOuter := bvNone;
    BevelInner := bvNone;
    color := clGray;
    Align := alTop;
    FButton := TVSOutlookGroupButton.Create(Self);
    FButton.Parent := Self;
    FButton.OnClick := DoButtonClick;
    FOLButtons := TStringList.Create;
    FullRepaint := false;
    FButton.Caption := Caption;
    FButton.Align := alTop;
    FOnButtonClick := TVSOutLookBar(Parent).GroupButtonClick;
    Caption := '';
    FPosition := spBottom;
    ControlStyle := ControlStyle + [csOpaque];
end;

destructor TVSOutlookGroup.Destroy;
begin

    inherited;
end;


procedure TVSOutlookGroup.Loaded;
begin
    inherited;
    Caption := '';
    FButton.Height := TVSOutLookBar(Parent).ButtonHeight;
    FButton.Font := TVSOutLookBar(Parent).ButtonFont;
    Width := Parent.Width;
    FButton.Caption := FButtonCaption;
    Left := 4;
    Width := Parent.Width - 10;
    FButton.BringToFront;
    FButton.Cursor := crHandPoint;
end;

procedure TVSOutlookGroup.Resize;
begin
    FButton.Width := Self.Width;
    inherited;
end;

procedure TVSOutlookGroup.SetSmallImages(value : TImageList);
begin

end;

procedure TVSOutlookGroup.SetLargeImages(value : TImageList);
begin

end;

procedure TVSOutlookGroup.SetImageSize(sz : TOLImageSize);
begin

end;

procedure TVSOutlookGroup.SetCaption(value : TCaption);
begin
    FButton.Caption := value;
    FButtonCaption := value;
    FButton.Height := Self.Canvas.TextHeight(FButtonCaption) + 6;

end;

procedure TVSOutlookGroup.MovingDown;
var i : integer;
begin
    for i := 0 to Self.ComponentCount -1 do
    begin
         if not (self.Components[i] is TSpeedButton) then
         begin
              TControl(self.Components[i]).SendToBack;
              TControl(self.Components[i]).Anchors := [akBottom];
         end;
    end;
end;

procedure TVSOutlookGroup.MovingUp;
var i : integer;
begin
    for i := 0 to Self.ComponentCount -1 do
    begin
         if not (self.Components[i] is TSpeedButton) then
         begin
              TControl(self.Components[i]).SendToBack;
              TControl(self.Components[i]).Anchors := [akTop];
         end;

    end;
end;

procedure TVSOutlookGroup.DoButtonClick(Sender : TObject);
begin
    FButton.BringToFront;
    if Assigned(FOnButtonClick) then
       FOnButtonClick(Self);
end;


function TVSOutlookGroup.GetButtonHeight : integer;
begin
   result := FButton.Height;
end;

procedure TVSOutlookGroup.Paint;
begin
    inherited;
    With Canvas do
    begin
        Pen.Color := clBlack;
        MoveTo(0,FButton.Height);
        LineTo(0,Height);
    end;
end;

function TVSOutlookGroup.HasParent : boolean;
begin
    result := True;
end;

procedure TVSOutlookGroup.ReadState(Reader : TReader);
begin
    if Reader.Parent is TVSOutLookBar then
       Parent := TVSOutLookBar(Reader.Parent);
    inherited ReadState(Reader);

end;

function TVSOutlookGroup.GetParentComponent : TComponent;
begin
    result := FParent;
end;

procedure TVSOutlookGroup.SetParentComponent(Value : TComponent);
begin
    if FParent <> value then
    begin
         if FParent <> nil then
            TVSOutLookBar(FParent).RemoveGroup(Self);
         if Value <> nil then
            TVSOutLookBar(Value).AddGroup(Self);
         FParent := Value;
    end;
end;

procedure TVSOutlookGroup.ButtonDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
begin
     DragOver(Source,X,Y,State,Accept);
end;

procedure TVSOutlookGroup.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
begin
  inherited DragOver(Source,X,Y,State,Accept);
  if FBusy = True then exit;
  FBusy := True;

  if TVSOutLookBar(Parent).ActiveGroup <> self then
    TVSOutLookBar(Parent).ActiveGroup := self;
  Accept := True;
  FBusy := False;
end;

procedure TVSOutlookGroup.SetButtonHeight(value : integer);
begin
    FButton.Height := value;
end;

procedure TVSOutlookGroup.SetButtonFont(value : TFont);
begin
    FButton.Font.Assign(value);
end;

Procedure TVSOutlookGroup.WMEraseBkgnd(var Message: TWmEraseBkgnd);
Begin
  Message.Result:= 1; { Do nothing, but mark the message as being handled}
End;



constructor TVSOutlookGroupButton.Create(AOwner : TComponent);
begin
    inherited Create(AOwner);

end;

procedure TVSOutlookGroupButton.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  Message.Result := 1;
end;


procedure TVSOutlookGroupButton.DragOver(Source: TObject; X, Y: Integer; State: TDragState;
      var Accept: Boolean);
begin
  inherited DragOver(Source,X,Y,State,Accept);
  TVSOutLookGroup(Parent).DragOver(Source,X,Y,State,Accept);
end;

procedure TVSOutlookGroupButton.CMMouseEnter(var Message: TMessage);
var oldcolor : Tcolor;
begin
     With Canvas do
     begin
         MoveTo(1,Height-2);
         OldColor := Pen.Color;
         Pen.Color := clBlack;
         LineTo(Width-2,Height-2);
         LineTo(Width-2,1);
         Pen.Color := oldcolor;
     end;
end;

procedure TVSOutlookGroupButton.CMMouseLeave(var Message: TMessage);
var oldcolor : Tcolor;
begin
     invalidate;
     exit;
     With Canvas do
     begin
         MoveTo(1,Height-2);
         OldColor := Pen.Color;
         Pen.Color := clBtnShadow;
         LineTo(Width-2,Height-2);
         LineTo(Width-2,1);
         Pen.Color := oldcolor;
     end;
end;

initialization
   // loading forms when the package containing TSpeedbutton is not loaded
   // causes 'class not found' errors without this!!
   RegisterClass(TSpeedButton);

end.
