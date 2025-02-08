unit LMDFxImage;
{$I LMDCmps.inc}

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

LMDFxImage unit (RM, AH)
------------------------

Note
----
LMD FxPack is based on code licensed from Eugene Kryukov

Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Graphics, Controls, Forms, StdCtrls, ExtCtrls, SysUtils, Classes,
  LMDFxBase, LMDFxAnimation, LMDFxImageList, LMDFxBitmap;

type

  { ************************ class TLMDFxImage ******************************* }
  TLMDFxImage = class(TLMDFxGraphicControl)
  private
    FAnimation: TLMDFxAnimation;
    FAnimating: boolean;
    FChangeLink:TLMDFxChangeLink;
    FCenter: Boolean;
    FDrawing: Boolean;
    FImageIndex: integer;
    FImageList: TLMDFxImageList;
    FIncrementalDisplay: Boolean;
    FOnProgress: TProgressEvent;
    FPicture: TPicture;
    FProportional: Boolean;
    FSavedPicture: TPicture;
    FStretch: Boolean;
    FTransparent: Boolean;
    procedure SetAnimation(const Value: TLMDFxAnimation);
    procedure SetBoolean(index:Integer;Value:Boolean);
    procedure SetImages(const Value: TLMDFxImageList);
    procedure SetImageIndex(const Value: integer);
    procedure SetPicture(Value: TPicture);
    procedure GetChange(Sender: TObject);
    function GetPicture: TPicture;
    //function HasNoListControl: Boolean;
  protected
    function CalcDestRect(APicture: TPicture): TRect;
    function CanAutoSize(var NewWidth, NewHeight: Integer): Boolean; override;
    function DoPaletteChange: Boolean;
    procedure ExecuteAnimation;
    procedure DoProgress(Sender: TObject; Stage: TProgressStage;
                         PercentDone: Byte; RedrawNow: Boolean; const R: TRect; const Msg: string); dynamic;
    function GetPalette: HPALETTE; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IMLEmpty:Boolean;
    property CurrentPicture:TPicture read GetPicture;
  published
    property Align;
    property Anchors;
    property Animation: TLMDFxAnimation read FAnimation write SetAnimation;
    property AutoSize;
    property Center: Boolean index 0 read FCenter write SetBoolean default false;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ImageIndex: integer read FImageIndex write SetImageIndex;
    property Images: TLMDFxImageList read FImageList write SetImages;
    property IncrementalDisplay: Boolean index 1 read FIncrementalDisplay write SetBoolean default false;
    property ParentShowHint;
    property Picture: TPicture read FPicture write SetPicture {stored HasNoListControl};
    property PopupMenu;
    property Proportional: Boolean index 2 read FProportional write SetBoolean default false;
    property ShowHint;
    property Stretch: Boolean index 3 read FStretch write SetBoolean default false;
    property Transparent: Boolean index 4 read FTransparent write SetBoolean default false;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnProgress: TProgressEvent read FOnProgress write FOnProgress;
    property OnStartDock;
    property OnStartDrag;

  end;

implementation

uses
  LMDFxUtils, LMDFxEffect{$IFNDEF LMDCOMP9}, JPEG{$ENDIF};

type
  THackWControl = class(TWinControl);

{ ************************ class TLMDFxImage ********************************* }
{ ------------------------------ private ------------------------------------- }
procedure TLMDFxImage.SetAnimation(const Value:TLMDFxAnimation);
begin
  FAnimation:=Value;
  if FAnimation<>nil then
    FAnimation.FreeNotification(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImage.SetBoolean(index:Integer; Value: Boolean);
begin
  case index of
    0: if FCenter=Value then exit else FCenter:=Value;
    1: if FIncrementalDisplay=Value then exit else FIncrementalDisplay:=Value;
    2: if FProportional=Value then exit else FProportional:=Value;
    3: if FStretch=Value then exit else FStretch:=Value;
    4: if FTransparent=Value then exit else FTransparent:=Value;
  end;
  GetChange(Self);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImage.SetImageIndex(const Value: integer);
begin
  if FImageIndex <> Value then
    begin
      FImageIndex := Value;
      if not (csLoading in ComponentState) then
        begin
          if IMLEmpty then
            FImageIndex := -1;
          GetChange(nil);
        end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImage.SetImages(const Value: TLMDFxImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=Value;
  if FImageList<>nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;

end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImage.SetPicture(Value: TPicture);
begin
  FPicture.Assign(Value);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxImage.GetPicture: TPicture;
begin
  if not IMLEmpty then
    result:=FImageList.Images[FImageIndex].Picture
  else
    result:=FPicture;
end;

{ ---------------------------------------------------------------------------- }
{function TLMDFxImage.HasNoListControl: Boolean;
begin
  Result := not (Assigned(FImageList) and (FImageList.Images.Count>0) and (FImageIndex<>-1));
end;


{ ------------------------------ protected ----------------------------------- }
function TLMDFxImage.CalcDestRect(APicture: TPicture): TRect;
var
  w, h, cw, ch: Integer;
  xyaspect: Double;
begin
  w := APicture.Width; h := APicture.Height;
  cw := ClientWidth; ch := ClientHeight;

  if FStretch or (FProportional and ((w > cw) or (h > ch))) then
    begin
      if FProportional and (w > 0) and (h > 0) then
        begin
          xyaspect := w / h;
          if w > h then
            begin
              w := cw;
              h := Trunc(cw / xyaspect);
              if h > ch then
                begin
                  h := ch;
                  w := Trunc(ch * xyaspect);
                end;
            end
          else
           begin
             h := ch;
             w := Trunc(ch * xyaspect);
             if w > cw then
               begin
                 w := cw;
                 h := Trunc(cw / xyaspect);
               end;
           end;
        end
      else
        begin
          w := cw;
          h := ch;
        end;
    end;
  Result:=Rect(0,0, w, h);
  if FCenter then
    OffsetRect(Result, (cw - w) div 2, (ch - h) div 2);
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxImage.CanAutoSize(var NewWidth, NewHeight: Integer): Boolean;
var
  tmpb:TPicture;
begin
  Result := True;
  tmpb:=GetPicture;
  if not (csDesigning in ComponentState) or (tmpb.Width > 0) and (tmpb.Height > 0) then
    begin
      if Align in [alNone, alLeft, alRight] then NewWidth:=tmpb.Width;
      if Align in [alNone, alTop, alBottom] then NewHeight:=tmpb.Height;
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxImage.DoPaletteChange: Boolean;
var
  ParentForm: TCustomForm;
  Tmp: TGraphic;
begin
  Result := False;
  Tmp := GetPicture.Graphic;
  if Visible and (not (csLoading in ComponentState)) and (Tmp <> nil) and (Tmp.PaletteModified) then
    begin
      if (Tmp.Palette = 0) then
        Tmp.PaletteModified := False
      else
	begin
	  ParentForm := GetParentForm(Self);
	  if Assigned(ParentForm) and ParentForm.Active and Parentform.HandleAllocated then
    	    begin
	      if FDrawing then
	        ParentForm.Perform(wm_QueryNewPalette, 0, 0)
	      else
	        PostMessage(ParentForm.Handle, wm_QueryNewPalette, 0, 0);
              Result := True;
	      Tmp.PaletteModified := False;
  	    end;
       end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImage.DoProgress(Sender: TObject; Stage: TProgressStage;
                               PercentDone: Byte; RedrawNow: Boolean;
                               const R: TRect; const Msg: string);
begin
  if FIncrementalDisplay and RedrawNow then
    if DoPaletteChange then
      Update
    else
      Paint;
  if Assigned(FOnProgress) then FOnProgress(Sender, Stage, PercentDone, RedrawNow, R, Msg);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImage.ExecuteAnimation;
var
  SourceImage, DestImage: TLMDFxBitmap;
  dRect:Trect;
  tmpb:TPicture;
  ldc: HDC;
begin
  if FAnimation = nil then Exit;
  if GetPicture.Graphic = nil then Exit;
  if FAnimating then Exit;

  tmpb:=GetPicture;
  FAnimating := true;
  try
    { Empty source }
    SourceImage := TLMDFxBitmap.Create;
    SourceImage.SetSize(Width, Height);
    { Draw background }
    //SourceImage.Clear(LMDFxColor(THackWControl(Parent).Color)); VB Sep 2009
    ldc := GetWindowDC(THackWControl(Parent).Handle);
    BitBlt(SourceImage.DC, 0, 0, SourceImage.Width, SourceImage.Height, ldc, left, top, SRCCOPY);
    ReleaseDC(THackWControl(Parent).Handle, lDC);
    { Draw Picture }
    if FSavedPicture.Graphic <> nil then
      begin
        dRect:=CalcDestRect(FSavedPicture);
        SourceImage.DrawGraphic(FSavedPicture.Graphic, dRect);
      end;

    DestImage := TLMDFxBitmap.Create;
    DestImage.SetSize(Width, Height);
    { Draw background }
    //DestImage.Clear(LMDFxColor(THackWControl(Parent).Color));   VB Sep 2009
    ldc := GetWindowDC(THackWControl(Parent).Handle);
    BitBlt(DestImage.DC, 0, 0, SourceImage.Width, SourceImage.Height, ldc, left, top, SRCCOPY);
    ReleaseDC(THackWControl(Parent).Handle, lDC);
    { Draw Picture }
    dRect:=CalcDestRect(tmpb);
    DestImage.DrawGraphic(tmpB.Graphic, dRect);

    { Execute Animation }
    FAnimation.SourceImage := SourceImage;
    FAnimation.DestImage := DestImage;
    FAnimation.ExecuteImage(Canvas, 0, 0);

    FAnimation.SourceImage := nil;
    FAnimation.DestImage := nil;

    { Free resource}
    SourceImage.Free;
    DestImage.Free;

    { Save Picture }
    FSavedPicture.Assign(GetPicture);
  finally
    FAnimating := false;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFxImage.GetChange(Sender: TObject);
var
  G: TGraphic;
  D : TRect;
begin
  if FAnimating or (csLoading in ComponentState) then exit;
  if AutoSize and (Picture.Width > 0) and (Picture.Height > 0) then
    SetBounds(Left, Top, Picture.Width, Picture.Height);
  G := GetPicture.Graphic;
  if G <> nil then
    begin
      if not ((G is TMetaFile) or (G is TIcon)) then
        G.Transparent := FTransparent;
      D := CalcDestRect(GetPicture);
      if (not G.Transparent) and (D.Left <= 0) and (D.Top <= 0) and (D.Right >= Width) and (D.Bottom >= Height) then
        ControlStyle := ControlStyle + [csOpaque]
      else
        ControlStyle := ControlStyle - [csOpaque];
      if DoPaletteChange and FDrawing then Update;
    end
  else
    ControlStyle := ControlStyle - [csOpaque];

  //if not FDrawing then Invalidate;
  if not Enabled or (csDesigning in ComponentState) then Exit;
  ExecuteAnimation;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxImage.GetPalette: HPALETTE;
begin
  Result:=0;
  if CurrentPicture.Graphic<>nil then
     result := CurrentPicture.Graphic.Palette;
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxImage.Loaded;
begin
  inherited;
  FSavedPicture.Assign(GetPicture);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxImage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FAnimation) then
    SetAnimation(nil);
  if (Operation = opRemove) and (AComponent = FImageList) then
    SetImages(nil);
end;

{ -----------------------------------------------------------------------------}
procedure TLMDFxImage.Paint;
var
  Save: Boolean;
  tmpb:TPicture;
begin
  if FAnimating then Exit;
  if csDesigning in ComponentState then
    with inherited Canvas do
      begin
        Pen.Style := psDash;
        Brush.Style := bsClear;
        Rectangle(0, 0, Width, Height);
      end;
  Save := FDrawing;
  FDrawing := True;
  tmpb:=GetPicture;
  try
    Canvas.StretchDraw(CalcDestRect(tmpB), tmpB.Graphic);
  finally
    FDrawing := Save;
  end;
end;

{ ------------------------------ public -------------------------------------- }
constructor TLMDFxImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FImageIndex := -1;
  FSavedPicture := TPicture.Create;
  FPicture := TPicture.Create;
  FPicture.OnChange := GetChange;
  FPicture.OnProgress := DoProgress;
  FChangeLink:=TLMDFxChangeLink.Create;
  FChangeLink.OnChange:=GetChange;

  Height := 105;
  Width := 105;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFxImage.Destroy;
begin
  FChangeLink.OnChange:=nil;
  FreeAndNil(FChangeLink);

  FreeAndNil(FPicture);
  FreeAndNil(FSavedPicture);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFxImage.IMLEmpty: Boolean;
begin
  result:=not ((FImageList<>nil) and FImageList.IsValidItem(FImageIndex));
end;

end.

