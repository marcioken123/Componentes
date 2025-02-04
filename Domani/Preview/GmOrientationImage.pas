{******************************************************************************}
{                                                                              }
{                      GmOrientationImage.pas v2.61 Pro                        }
{                                                                              }
{           Copyright (c) 2001 Graham Murt  - www.MurtSoft.co.uk               }
{                                                                              }
{   Feel free to e-mail me with any comments, suggestions, bugs or help at:    }
{                                                                              }
{                           graham@murtsoft.co.uk                              }
{                                                                              }
{******************************************************************************}

unit GmOrientationImage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, GmTypes,
  GmPreview, Buttons, GmConst;

  {$I GMPS.INC}

type
  TGmOrientationPage = class(TGmPaperImage)
  private
    FOrientation: TGmOrientation;
    FShowHeaderFooter: Boolean;
    procedure SetOrientation(AOrientation: TGmOrientation);
    procedure DrawHeaderFooter(Canvas: TCanvas; AArea: TRect; Border: integer);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Orientation: TGmOrientation read FOrientation write SetOrientation;
  end;

  TGmOrientationImage = class(TWinControl)
  private
    FBorderStyle: TBorderStyle;
    FBtnPortrait: TSpeedButton;
    FBtnLandscape: TSpeedButton;
    FOrientation: TGmOrientation;
    FPreview: TGmPreview;
    FPageImage: TGmOrientationPage;
    FShowButtons: Boolean;
    FShowHeaderFooter: Boolean;
    // events...
    FOnChanging: TNotifyEvent;
    FOnClickPortrait: TNotifyEvent;
    FOnClickLandscape: TNotifyEvent;

    function GetAbout: string;
    function GetVersion: Extended;
    procedure SetAbout(const AValue: string);

    procedure BtnClick(Sender: TObject);
    procedure SetGmPreview(APreview: TGmPreview);
    procedure SetOrientation(AOrientation: TGmOrientation);
    procedure SetShadow(AShadow: TGmShadow);
    procedure SetShowButtons(AValue: Boolean);
    procedure SetShowHeaderFooter(AValue: Boolean);
    function GetShadow: TGmShadow;
    procedure SetBorderStyle(const Value: TBorderStyle);

    { Private declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    // update messages...
    procedure OrientationChanged(var Message: TMessage); message GM_ORIENTATION_CHANGED;
    procedure ComponentResize(var Message: TMessage); message WM_SIZE;
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Version: Extended read GetVersion;
    { Public declarations }
  published
    property About: string read GetAbout write SetAbout;
    property BorderStyle: TBorderStyle read FBorderStyle write SetBorderStyle default bsSingle;
    property Color default clGray;
    property Orientation: TGmOrientation read FOrientation write SetOrientation;
    property ParentColor;
    property Preview: TGmPreview read FPreview write SetGmPreview;
    property ShowHint;
    property Shadow: TGmShadow read GetShadow write SetShadow;
    property ShowButtons: Boolean read FShowButtons write SetShowButtons default True;
    property ShowHeaderFooter: Boolean read FShowHeaderFooter write SetShowHeaderFooter default True;
    property Visible;
    // events
    property OnChanging: TNotifyEvent read FOnChanging write FOnChanging;
    property OnClickPortrait: TNotifyEvent read FOnClickPortrait write FOnClickPortrait;
    property OnClickLandscape: TNotifyEvent read FOnClickLandscape write FOnClickLandscape;
    { Published declarations }
  end;

implementation

{$R OrienRes.RES}

//------------------------------------------------------------------------------

procedure TGmOrientationPage.SetOrientation(AOrientation: TGmOrientation);
var
  TempVal: integer;
begin
  // set the orientation of the TGmOrientationImage page...
  if FOrientation <> AOrientation then
  begin
    FOrientation := AOrientation;
    // resize page...
    TempVal := Width;
    Width := Height;
    Height := TempVal;
    Top := (TWinControl(Owner).Height - Height) div 2;
    Invalidate;
  end;
end;

procedure TGmOrientationPage.DrawHeaderFooter(Canvas: TCanvas; AArea: TRect; Border: integer);
begin
  // draw a header and footer on the page image...
  if FShowHeaderFooter then
  begin
    Canvas.Pen.Color := $00777777;
    Canvas.Polyline([Point(AArea.Left+Border, AArea.Top+Border)   , Point(AArea.Right-Border, AArea.Top+Border)]);
    Canvas.Polyline([Point(AArea.Left+Border, AArea.Bottom-Border), Point(AArea.Right-Border, AArea.Bottom-Border)]);
  end;
end;

constructor TGmOrientationPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Shadow := TGmShadow.Create;
  Gutter := 5;
end;

destructor TGmOrientationPage.Destroy;
begin
  Shadow.Free;
  inherited Destroy;
end;

procedure TGmOrientationPage.Paint;
var
  AChar: Char;
  TextPos: TPoint;
  PageArea: TRect;
begin
  // paint the page...
  inherited;
  with Canvas do
  begin
    Pen.Style := psSolid;
    PageArea := PageRect;
    DrawHeaderFooter(Canvas, PageArea, 6);
    Font.Name := 'Times New Roman';
    Font.Size := 16;
    Font.Color := clSilver;
    Brush.Style := bsClear;
    if FOrientation = gmPortrait then AChar := 'P' else AChar := 'L';
    TextPos.x := (Width - TextWidth(AChar)) div 2;
    TextPos.y := (Height - TextHeight(AChar)) div 2;
    TextOut(TextPos.x, TextPos.y ,AChar);
  end;
end;

//------------------------------------------------------------------------------


constructor TGmOrientationImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBorderStyle := bsSingle;
  Color := clGray;
  Width := 121;
  Height := 89;
  FPageImage := TGmOrientationPage.Create(Self);
  FPageImage.FShowHeaderFooter := True;
  FShowHeaderFooter := True;
  with FPageImage do
  begin
    Left := 40;
    Width := 50;
    Height := 65;
    Shadow.Width := 2;
    Parent := Self;
  end;
  FShowButtons := False;
  Orientation := gmPortrait;
  SetShowButtons(True);
end;

destructor TGmOrientationImage.Destroy;
begin
  // free the TGmOrientationImage and destroy...
  if Assigned(FPreview) then FPreview.RemoveAssociatedComponent(Self);
  if Assigned(FBtnPortrait) then FBtnPortrait.Free;
  if Assigned(FBtnLandscape) then FBtnLandscape.Free;
  FPageImage.Free;
  inherited Destroy;
end;

function TGmOrientationImage.GetAbout: string;
begin
  Result := Self.ClassName+' v'+FloatToStr(GetVersion);
end;

function TGmOrientationImage.GetVersion: Extended;
begin
  Result := SUITE_VERSION;
end;

procedure TGmOrientationImage.SetAbout(const AValue: string);
begin
  // does nothing.
end;

procedure TGmOrientationImage.CreateParams(var Params: TCreateParams);
const
  BorderStyles: array[TBorderStyle] of DWORD = (0, WS_BORDER);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    Style := Style or BorderStyles[FBorderStyle];
    if NewStyleControls and Ctl3D and (FBorderStyle = bsSingle) then
    begin
      Style := Style and not WS_BORDER;
      ExStyle := ExStyle or WS_EX_CLIENTEDGE;
    end;
  end;
end;

procedure TGmOrientationImage.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FPreview) then
    FPreview := nil;
end;

procedure TGmOrientationImage.OrientationChanged(var Message: TMessage);
begin
  // keep the orientation in syncronization with the TGmPreview...
  Orientation := FPreview.Orientation;
end;

procedure TGmOrientationImage.ComponentResize(var Message: TMessage);
begin
  FBtnPortrait.SetBounds((Width div 2) - 44, (Height div 2) - 26, FBtnPortrait.Width, FBtnPortrait.Height);
  FBtnLandscape.SetBounds((Width div 2) - 44, (Height div 2) + 2, FBtnLandscape.Width, FBtnLandscape.Height);
  FPageImage.SetBounds((Width div 2) -14, (Height div 2) - 32, FPageImage.Width, FPageImage.Height);
end;

procedure TGmOrientationImage.BtnClick(Sender: TObject);
begin
  // call the button events when clicked...
  if Assigned(FOnChanging) then FOnChanging(Self);
  if (Sender = FBtnPortrait) and (Orientation <> gmPortrait) then
  begin
    if Assigned(FPreview) then FPreview.Orientation := gmPortrait;
    if Assigned(FOnClickPortrait) then FOnClickPortrait(Self);
  end
  else
  if (Sender = FBtnLandscape) and  (Orientation <> gmLandscape) then
  begin
    if Assigned(FPreview) then FPreview.Orientation := gmLandscape;
    if Assigned(FOnClickLandscape) then FOnClickLandscape(Self);
  end;
end;

procedure TGmOrientationImage.SetGmPreview(APreview: TGmPreview);
begin
  // assign the Preview property to a TGmPreview...
  if Assigned(FPreview) then FPreview.RemoveAssociatedComponent(Self);
  FPreview := APreview;
  if Assigned(FPreview) then
  begin
    FPreview.AddAssociatedComponent(Self);
    Orientation := FPreview.Orientation;
  end;
end;

procedure TGmOrientationImage.SetOrientation(AOrientation: TGmOrientation);
begin
  // change the orientation...
  FOrientation := AOrientation;
  FPageImage.Orientation := AOrientation;
  // select the correct button...
  if FShowButtons then
  begin
    FBtnPortrait.Down := AOrientation = gmPortrait;
    FBtnLandscape.Down := AOrientation = gmLandscape;
  end;
  if Assigned(FPreview) then FPreview.Orientation := AOrientation;
  //Invalidate;
end;

procedure TGmOrientationImage.SetShadow(AShadow: TGmShadow);
begin
  FPageImage.Shadow := AShadow;
  FPageImage.Invalidate;
end;

procedure TGmOrientationImage.SetShowButtons(AValue: Boolean);
begin
  // show or hide the buttons...
  if FShowButtons <> AValue then
  begin
    if AValue = True then
    begin
      FPageImage.Left := 40;
      FBtnPortrait := TSpeedButton.Create(Self);
      with FBtnPortrait do
      begin
        Top := 6;
        Left := 8;
        Glyph.LoadFromResourceName(HInstance, 'BTNPORT');
        GroupIndex := 1;
        Down := True;
        OnClick := BtnClick;
      end;
      FBtnLandscape := TSpeedButton.Create(Self);
      with FBtnLandscape do
      begin
        Top := 34;
        Left := 8;
        Glyph.LoadFromResourceName(HInstance, 'BTNLAND');
        GroupIndex := 1;
        OnClick := BtnClick;
      end;
      FBtnPortrait.Parent := Self;
      FBtnLandscape.Parent := Self;
    end
    else
    begin
      FPageImage.Left := 4;
      FBtnPortrait.Free;
      FBtnLandscape.Free;
      FBtnPortrait := nil;
      FBtnLandscape := nil;
    end;
    FShowButtons := AValue;
  end;
end;

procedure TGmOrientationImage.SetShowHeaderFooter(AValue: Boolean);
begin
  // show or hide the header/footer...
  FShowHeaderFooter := AValue;
  FPageImage.FShowHeaderFooter := AValue;
  FPageImage.Repaint;
end;

function TGmOrientationImage.GetShadow: TGmShadow;
begin
  // return the TGmShadow object...
  Result := FPageImage.Shadow;
end;

procedure TGmOrientationImage.SetBorderStyle(const Value: TBorderStyle);
begin
  if FBorderStyle <> Value then
  begin
    FBorderStyle := Value;
    RecreateWnd;
  end;
end;

end.
