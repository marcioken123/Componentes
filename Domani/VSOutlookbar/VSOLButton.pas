unit VSOLButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,ActnList,math;

type
    TOLImageSize  = (isSmall,isLarge);

type
  TVSOutlookButton = class(TGraphicControl)
  private
    { Private declarations }
    FMouseIsOver : boolean;
    FFont : TFont;
    FLargeImages : TImageList;
    FSmallImages : TImageList;
    FImageSize : TOLImageSize;
    FImageIndex : integer;
    FImageRect : TRect;
    FLoaded : boolean;
    FMouseIsDown : boolean;
    FDragDelta : integer;
  protected
    { Protected declarations }
    procedure Paint;override;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetFont(value : TFont);
    procedure SetSmallImages(value : TImageList);
    procedure SetLargeImages(value : TImageList);
    procedure SetImageSize(sz : TOLImageSize);
    procedure SetImageIndex(value : integer);
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure Loaded ;override;
  public
    { Public declarations }
    procedure SetSize;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;override;
  published
    { Published declarations }
    property Anchors;
    property Action;
    property Caption ;
    property SmallImages : TImageList read FSmallImages write SetSmallImages;
    property LargeImages : TImageList read FLargeImages write SetLargeImages;
    property ImageIndex : integer read FImageIndex write SetImageIndex;
    property ImageSize : TOLImageSize read FImageSize write SetImageSize;
    property TextFont  : TFont read FFont write SetFont;
    property Visible;
    property DragCursor;
    property DragKind;
    property DragMode;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

procedure Register;

implementation

constructor TVSOutlookButton.Create(AOwner: TComponent);
begin
     FLoaded := False;
     inherited Create(AOwner);
     FDragDelta := 0;
     FMouseIsDown := False;
     FFont := TFont.Create;
     FImageIndex := -1;
     Height := 50;
     Width := 50;
     FImageSize := isLarge;
end;

destructor TVSOutlookButton.Destroy;
begin
    FFont.Free;
    inherited;
end;

procedure TVSOutlookButton.SetSmallImages(value : TImageList);
begin
     if FSmallImages <> value then
     begin
          FSmallImages := value;
          if FLoaded then SetSize;
//          Invalidate;
     end;
end;

procedure TVSOutlookButton.SetLargeImages(value : TImageList);
begin
     if FLargeImages <> value then
     begin
          FLargeImages := value;
          if FLoaded then SetSize;
//          Invalidate;
     end;

end;

procedure TVSOutlookButton.SetImageSize(sz : TOLImageSize);
begin
     if FImageSize <> sz then
     begin
          FImageSize := sz;
          if FLoaded = True then
            SetSize;
          if FLoaded = True then //wierd!! only works properly the second time;
            SetSize;
     end;
end;

procedure TVSOutlookButton.SetImageIndex(value : integer);
begin
    if FImageIndex <> value then
    begin
       FImageIndex := value;
       if FLoaded then SetSize;
       Invalidate;
    end;
end;

procedure TVSOutlookButton.SetFont(value : TFont);
begin
  FFont.Assign(value);
  Canvas.Font.Assign(FFont);
  if FLoaded then
  begin
        SetSize;
        Refresh;
  end;

end;


procedure TVSOutlookButton.Paint;
var x,y : integer;
    imgList : TImageList;
    r : TRect;
    txtRect : TRect;
begin
     inherited;
     with Canvas do
     begin
         case FImageSize of
           isSmall :
           begin
             imgList := FSmallImages;
             if imgList <> nil then
             begin
                  FImageRect.Left := 2;
                  FImageRect.Top := 2 ;
                  imgList.Draw(Canvas,FImageRect.Left ,FImageRect.Top,FImageIndex);
                  FImageRect.Right := FImageRect.Left + imgList.Width;
                  FImageRect.Bottom := FImageRect.Top + imgList.Height;
             end;
             Brush.Color := Color;
             Brush.Style := bsClear;
             Font.Assign(FFont);
             txtRect := Rect(FImageRect.Right + 4,FImageRect.Top,Width - 2,FImageRect.Bottom);
             DrawText(Canvas.Handle,PChar(Caption),Length(Caption),txtRect,DT_END_ELLIPSIS + DT_LEFT+ DT_NOCLIP);
           end;

           isLarge :
           begin
             imgList := FLargeImages;
             if imgList <> nil then
             begin
                  x := (Self.Width - imgList.Width) div 2;
                  y := 2;
                  imgList.Draw(Canvas,x,y,FImageIndex);
                  FImageRect.Left := x;
                  FImageRect.Top := y ;
                  FImageRect.Right := x + imgList.Width;
                  FImageRect.Bottom := y + imgList.Height;
             end;
             Brush.Color := Color;
             Brush.Style := bsClear;
             Font.Assign(FFont);
             r := Rect(2,FImageRect.Bottom + 6,Width - 2,Height - 2);
             txtRect := r;
             DrawText(Canvas.Handle,PChar(Caption),Length(Caption),txtRect,DT_END_ELLIPSIS + DT_CENTER+ DT_WORDBREAK + DT_NOCLIP + DT_VCENTER);
           end;
         end;
     end;
end;

procedure TVSOutlookButton.CMMouseEnter(var Message: TMessage);
begin
    if FMouseIsOver = False then
    begin
         FMouseIsOver := True;
         with Canvas do
         begin
              Pen.Color := clSilver;
              MoveTo(FImageRect.Left - 2,FImageRect.Bottom + 2);
              LineTo(FImageRect.Left - 2,FImageRect.Top - 2);
              LineTo(FImageRect.Right + 2,FImageRect.Top - 2);
              Pen.Color := clBlack;
              LineTo(FImageRect.Right + 2,FImageRect.Bottom  + 2);
              LineTo(FImageRect.Left - 2,FImageRect.Bottom + 2);
         end;
    end;
end;

procedure TVSOutlookButton.CMMouseLeave(var Message: TMessage);
begin
    if FMouseIsOver = True then
    begin
         FMouseIsOver := False;
         with Canvas do
         begin
              Pen.Color := Color;
              Brush.Style := bsClear;
              Rectangle(FImageRect.Left - 2,FImageRect.Top -2 ,
                        FImageRect.Right + 3,FImageRect.Bottom + 3);
         end;
    end;
end;

procedure TVSOutlookButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    inherited MouseDown(button,shift,x,y);
    FMouseIsDown := True;
         with Canvas do
         begin
              Pen.Color := clBlack;
              MoveTo(FImageRect.Left - 2,FImageRect.Bottom + 2);
              LineTo(FImageRect.Left - 2,FImageRect.Top - 2);
              LineTo(FImageRect.Right + 2,FImageRect.Top - 2);
              Pen.Color := clSilver;
              LineTo(FImageRect.Right + 2,FImageRect.Bottom  + 2);
              LineTo(FImageRect.Left - 2,FImageRect.Bottom + 2);
         end;
end;


procedure TVSOutlookButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    inherited MouseUp(button,shift,x,y);
    FMouseIsDown := False;
    if FMouseIsOver = True then
    begin
         with Canvas do
         begin
              Pen.Color := clSilver;
              MoveTo(FImageRect.Left - 2,FImageRect.Bottom + 2);
              LineTo(FImageRect.Left - 2,FImageRect.Top - 2);
              LineTo(FImageRect.Right + 2,FImageRect.Top - 2);
              Pen.Color := clBlack;
              LineTo(FImageRect.Right + 2,FImageRect.Bottom  + 2);
              LineTo(FImageRect.Left - 2,FImageRect.Bottom + 2);
         end;
    end;
    FMouseIsDown := False;
end;

procedure TVSOutlookButton.MouseMove(Shift: TShiftState; X, Y: Integer);
const
     MAXDRAGDELTA = 20;
begin
    inherited MouseMove(shift,X,Y);
    if FMouseIsDown = True then
    begin
        BeginDrag(False,5);
    end;
end;


procedure TVSOutlookButton.SetSize;
var i,w : integer;
    r1,r2 : TRect;
begin
     case FImageSize of
          isSmall:
          begin
               if FSmallImages <> nil then
               begin
                 if FImageRect.Bottom = 0 then
                 begin
                     FImageRect.Left :=2;
                     FImageRect.Top := 2;
                     FImageRect.Right := FImageRect.Left + FSmallImages.Width;
                     FImageRect.Bottom := FImageRect.Top + FSmallImages.Height ;
                 end;
                 w := Min(Parent.Width - 2,Canvas.TextWidth(Caption) + 8 + FSmallImages.Width  );
                 if width <> w then
                     width := w;
                 Left := 4;
                 i := FSmallImages.Height + 8;
                 if Height <> i then
                    Height := i;
               end
               else
               begin
                 w := Min(Parent.Width - 2,Canvas.TextWidth(Caption) + 24  );
                 if width <> w then
                     width := w;
                 Left := 4;
                 i := 24;
                 if Height <> i then
                    Height := i;
               end;
          end;

          isLarge:
          begin
               if FLargeImages <> nil then
               begin
                 i := FLargeImages.Height + 2;
                 w := Min(Parent.Width - 4,Canvas.TextWidth(Caption) + 4);
                 if width <> w then
                    width := w;
                 Left := (Parent.Width - Width) div 2;

                 if FImageRect.Bottom = 0 then
                 begin
                     FImageRect.Left := (Width - FLargeImages.Width) div 2;
                     FImageRect.Top := 2 ;
                     FImageRect.Right := FImageRect.Left + FLargeImages.Width;
                     FImageRect.Bottom := FImageRect.Top + FLargeImages.Height ;
                 end;
                 i := i + Canvas.TextHeight('Hello World') + 10;
                 r1 := Rect(2,FImageRect.Bottom + 6,Width - 2,i - 2);
                 r2 := r1;
                 DrawText(Canvas.Handle,PChar(Caption),Length(Caption),r2,{DT_END_ELLIPSIS +  }DT_CENTER + DT_WORDBREAK + DT_CALCRECT + DT_NOCLIP);
                 r2 := r1;
                 DrawText(Canvas.Handle,PChar(Caption),Length(Caption),r2,{DT_END_ELLIPSIS +  }DT_CENTER + DT_WORDBREAK + DT_CALCRECT + DT_NOCLIP);
                 i := r2.Bottom  + 2;
                 if height <> i then
                     Height := i;
               end
               else
               begin
                 if FImageRect.Bottom = 0 then
                 begin
                     FImageRect.Left := (Width - 24) div 2;
                     FImageRect.Top := 2 ;
                     FImageRect.Right := FImageRect.Left + 24;
                     FImageRect.Bottom := FImageRect.Top + 24 ;
                 end;
                 i := Canvas.TextHeight('Hello World') + 10;
                 r1 := Rect(2,FImageRect.Bottom + 6,Width - 2,i - 2);
                 r2 := r1;
                 DrawText(Canvas.Handle,PChar(Caption),Length(Caption),r2,{DT_END_ELLIPSIS +  }DT_CENTER + DT_WORDBREAK + DT_CALCRECT + DT_NOCLIP);
                 r2 := r1;
                 DrawText(Canvas.Handle,PChar(Caption),Length(Caption),r2,{DT_END_ELLIPSIS +  }DT_CENTER + DT_WORDBREAK + DT_CALCRECT + DT_NOCLIP);
                 i := r2.Bottom  + 2;
                 if height <> i then
                     Height := i;
               end;
          end;
     end;
     Refresh;
end;

procedure TVSOutlookButton.Loaded ;
begin
     inherited;
     FLoaded := True;
     SetSize;
end;

procedure Register;
begin
  RegisterComponents('VSoft', [TVSOutlookButton]);
end;



end.
