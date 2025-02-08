unit LMDRTFRuler;
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

LMDRTFRuler unit (RM)
--------------------

Changes
-------
Release 4.06 (XXX 2008)
[+] BackColor, MarginColor properties added [VB]

Release 4.05 (June 2008)
[+] IndentMarkerWidth property added [VB]

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses Windows, Classes, Controls, ExtCtrls, StdCtrls, Graphics,
     LMDRTFBase, LMDTypes;

type
  // Ruler event types
  TLMDRTFRulerEvent = procedure(Sender: TObject; aPos: integer) of object;
  TLMDRTFRulerMode = (rmWithMargins, rmWithoutMargins);

  TIndentImage = class;

{ *****************************  TLMDRTFRuler  ************************** }

  TLMDRTFRuler = class(TCustomControl)
  private
    FMode: TLMDRTFRulerMode;
    FDragging: Boolean;
    FDraggingLeft: Boolean;
    FDraggingRight: Boolean;
    FDragOfs: Integer;
    FImgFirstIndent: TIndentImage;
    FImgLeftIndent: TIndentImage;
    FImgRightIndent: TIndentImage;
    FImgBothLeftIndent: TIndentImage;
    FMarginRight: Integer;
    FMarginLeft: Integer;
    FRichEdit: TCustomMemo;
    FTabs: TList;
    FEditRect: TRect;
    FMeasurement: TLMDMeasurement;
    FHostRect: TRect;
    FRulerTab: double;
    FDist, FFact: Integer;
    FOffset: Integer;
    FBackColor: TColor;
    FMarginColor: TColor;
    FControlCanvas: TControlCanvas;
    FOnRulerTabCreate: TLMDRTFRulerEvent;
    FOnRulerTabChange: TLMDRTFRulerEvent;
    FOnRulerTabDestroy: TLMDRTFRulerEvent;
    FOnRulerFirstIdentChange: TLMDRTFRulerEvent;
    FOnRulerLeftIdentChange: TLMDRTFRulerEvent;
    FOnRulerRightIdentChange: TLMDRTFRulerEvent;
    function GetIndentFirst: Integer;
    function GetIndentLeft: Integer;
    function GetIndentRight: Integer;
    procedure SetBackColor(const Value: TColor);
    procedure SetIndentFirst(const Value: Integer);
    procedure SetIndentLeft(const Value: Integer);
    procedure SetIndentRight(const Value: Integer);
    procedure SetMarginColor(const Value: TColor);
    procedure SetMarginLeft(const Value: Integer);
    function  GetMarginLeft: integer;
    function  GetMarginRight: integer;
    procedure SetMarginRight(const Value: Integer);
    procedure SetRichedit(const Value: TCustomMemo);
    procedure SetMode(Value: TLMDRTFRulerMode);
    procedure SetMeasurement(Value: TLMDMeasurement);
    procedure SetHostRect(const Value: TRect);
    function  GetRulerTabPos(Pos, Trend: integer; dx: integer): integer;
    procedure SetOffset(Value: Integer);
    procedure SetIndentValue(IndentImage: TIndentImage; Value: integer);
    function  RightBound: integer;
    function GetIndentMarkerWidth: integer;
  protected
    procedure RequestAlign; override;
    procedure AdjustClientRect(var Rect: TRect); override;
//    procedure AdjustSize; override;
//    function CanResize(var NewWidth, NewHeight: Integer): Boolean; override;
    procedure DrawFocusLine(x1, y1, x2, y2: LongInt);
    procedure IndentMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IndentMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure IndentMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IndentPaint(Sender: TObject);
    procedure TabMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure TabMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TabPaint(Sender: TObject);
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MoveFocusLine(oldOfs, newOfs: LongInt);
    procedure Notification(aComponent: TComponent; Operation: TOperation); override;
    function CreateTab(aPos: LongInt): Boolean;//TPaintBox;
    function PageWidth: Longint;
    procedure SetRichEditTabs;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure CreateTabs;
    procedure SetIndents(Left, First, Right: integer);
    property Mode: TLMDRTFRulerMode read FMode write SetMode;
    property HostRect: TRect read FHostRect write SetHostRect;
    property IndentMarkerWidth: integer read GetIndentMarkerWidth;
    property EditRect: TRect read FEditRect;
  published
    property Color;
    property BackColor: TColor read FBackColor write SetBackColor default clBtnFace;
    property MarginColor: TColor read FMarginColor write SetMarginColor default clBtnShadow;
    property IndentFirst: Integer read GetIndentFirst write SetIndentFirst;
    property IndentLeft: Integer read GetIndentLeft write SetIndentLeft;
    property IndentRight: Integer read GetIndentRight write SetIndentRight;
    property MarginLeft: Integer read GetMarginLeft write SetMarginLeft default 0;
    property MarginRight: Integer read GetMarginRight write SetMarginRight default 0;
    property Offset: Integer read FOffset write SetOffset default 0;
    property RichEdit: TCustomMemo read FRichEdit write SetRichedit;
    property Measurement: TLMDMeasurement read FMeasurement write SetMeasurement default unPoints;
    property OnRulerTabCreate: TLMDRTFRulerEvent read FOnRulerTabCreate write
      FOnRulerTabCreate;
    property OnRulerTabChange: TLMDRTFRulerEvent read FOnRulerTabChange write
      FOnRulerTabChange;
    property OnRulerTabDestroy: TLMDRTFRulerEvent read FOnRulerTabDestroy write
      FOnRulerTabDestroy;
    property OnRulerFirstIdentChange: TLMDRTFRulerEvent read
      FOnRulerFirstIdentChange write FOnRulerFirstIdentChange;
    property OnRulerLeftIdentChange: TLMDRTFRulerEvent read
      FOnRulerLeftIdentChange write FOnRulerLeftIdentChange;
    property OnRulerRightIdentChange: TLMDRTFRulerEvent read
      FOnRulerRightIdentChange write FOnRulerRightIdentChange;
  end;

{ *****************************  TIndentImage  ************************** }

  TIndentID = (riFirst, riLeft, riRight, riBothLeft);

  TIndentImage = class(TPaintBox)
  private
    FIndentID: TIndentID;
    FDragging: Boolean;
    FValue: integer;
    procedure SetIndentID(Value: TIndentID);
  protected
//    procedure Paint; override;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property  IndentID: TIndentID read FIndentID write SetIndentID;
    property  Value: integer read FValue write FValue;
  end;

const
//  RulerAdj = 3 / 4;
  FBorderUp = 5;
  FBorderDown = 5;
  FBorderLeft = 5;
  FBorderRight = 5;
  DefTabSizePoints = 36;

implementation

uses
  SysUtils, Messages, Math,
  RichEdit, LMDRTFRichEdit, LMDConversion;

{ *****************************  TLMDRTFRuler  ************************** }
const
  BmpSemi = 4; {The width of each Indent divided by two}
  FMinIndentDist = 92;

{  ****************************** public  ********************************* }
{ ------------------------------------------------------------------------- }

constructor TLMDRTFRuler.Create(aOwner: TComponent);

  function  CreateIndent_1(IndentID: TIndentID): TIndentImage;
  begin
    Result := TIndentImage.Create(self);
    Result.OnMouseDown:= IndentMouseDown;
    Result.OnMouseMove:= IndentMouseMove;
    Result.OnMouseUp:= IndentMouseUp;
    Result.IndentID := IndentID;
    Result.OnPaint:= IndentPaint;
    Result.Parent := self;
  end;

begin
  inherited Create(aOwner);

  DoubleBuffered := True;
  Width:= 300;
  Height:= 25;
  Font.Name:= 'Small Fonts';
  Font.Size:= 7;
  ParentColor:= False;
  FMeasurement := unPoints;
  FDist := 36;
  FFact := 3;
  FRulerTab := LMDPointsToPixelsX(FDist) / FFact / 2;

  FImgFirstIndent:= CreateIndent_1(riFirst);
  FImgLeftIndent:= CreateIndent_1(riLeft);

  FImgRightIndent:= CreateIndent_1(riRight);//CreateIndent;
  FImgBothLeftIndent:= CreateIndent_1(riBothLeft);

  FMarginRight:= 0;
  FMarginLeft:= 0;

  FImgFirstIndent.Left:= 0;
  FImgLeftIndent.Left:= 0;
  FImgRightIndent.Left:= 0;

  FTabs:= TList.Create;

  FBackColor := clBtnFace;
  FMarginColor := clBtnShadow;
end;

{  ***************************** protected  ******************************* }
{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.RequestAlign;
//procedure TLMDRTFRuler.AdjustSize;
var
  B: integer;
begin
  inherited ;

  if Assigned(FRichEdit)  then
    begin
      if  FRichEdit is TLMDCustomRichEdit then
        TLMDCustomRichEdit(FRichEdit).SetRulerPosition
      else
        begin
//          if  FRichEdit.BorderStyle = bsSingle  then
          B := 1;
          SetBounds(FRichEdit.Top + B, FRichEdit.Left + B,
                    FRichEdit.Width - B * 2, Height);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);

  if  FRichEdit is TLMDCustomRichEdit then
    TLMDCustomRichEdit(FRichEdit).GetRulerPosition(Rect);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.DrawFocusLine(x1, y1, x2, y2: Integer);
begin
  if  not Assigned(FControlCanvas)  then
    begin
      FControlCanvas := TControlCanvas.Create;
      FControlCanvas.Control:= FRichEdit;
      FControlCanvas.Pen.Style:= psDot;
      FControlCanvas.Pen.Color:= clGray;
    end;

  SetROP2(FControlCanvas.Handle, R2_NOTXORPEN);
  FControlCanvas.MoveTo(x1, y1);
  FControlCanvas.LineTo(x2, y2);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.IndentMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  L: integer;
begin
  if  (csDesigning in ComponentState) then exit;

  if Button = mbLeft then
    begin
      FDragging:= true;
      FDragOfs:= X;
    FImgFirstIndent.Tag:= FImgFirstIndent.Left;
      FImgRightIndent.Tag:= FImgRightIndent.Left;
      FImgBothLeftIndent.Tag:= FImgBothLeftIndent.Left;
    if  Sender is TIndentImage  then
        TIndentImage(Sender).FDragging := True;

      if Assigned(FRichEdit)  then
        begin
          FEditRect := TLMDRichEdit(RichEdit).GetEditRect;
          L := {Left - FRichEdit.Left + }TControl(Sender).Left + BmpSemi;
          DrawFocusline(L, 1, L, FEditRect.Bottom);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRTFRuler.GetRulerTabPos(Pos, Trend: integer; dx: integer): integer;
var
  ii: double;
begin
  if  Round(FRulerTab / 2) < Abs(Trend) then
    begin
      Pos := Pos + dx + Trend;
      ii := HostRect.Left;

      while ii < Pos do
        ii := ii + FRulerTab;

      if  Trend < 0 then
        ii := ii - FRulerTab;

      if  ii < HostRect.Left  then  ii := HostRect.Left;

      if  ii > HostRect.Right then  ii := HostRect.Right;

      Result := Round(ii) - dx;
    end
  else
    Result := Pos;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.IndentMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);

  function  int_CheckBounds(var V: integer; oldV, iMin, iMax: integer): Boolean;
  begin
    if  V > iMax  then
      V := iMax
    else
    if  V < iMin  then
      V := iMin;

    Result := (V <> oldV);
  end;

var
  oldOfs, newOfs, newLeft: LongInt;
  Ctrl: TControl;
begin
  if  (csDesigning in ComponentState) then exit;

  if FDragging then
    begin
      Ctrl := TControl(Sender);
      if Assigned(FRichEdit)  then
        oldOfs:= Ctrl.Left + BmpSemi
      else
        oldOfs:= -1;

      newLeft := GetRulerTabPos(Ctrl.Left, X - FDragOfs, BmpSemi);

      if Sender = FImgLeftIndent then
        begin
          if  int_CheckBounds(newLeft, Ctrl.Left, HostRect.Left - BmpSemi,
                    FImgRightIndent.Left - FMinIndentDist)  then
            begin
              Ctrl.Left := newLeft;
              FImgBothLeftIndent.Left := newLeft;

              if  Assigned(FOnRulerLeftIdentChange) then
                FOnRulerLeftIdentChange(Self, Ctrl.Left);
            end;
        end;
      if Sender = FImgFirstIndent then
        begin
          if  int_CheckBounds(newLeft, Ctrl.Left, HostRect.Left - BmpSemi,
                    FImgRightIndent.Left - FMinIndentDist)  then
            begin
              Ctrl.Left := newLeft;

              if assigned(FOnRulerFirstIdentChange) then
                FOnRulerFirstIdentChange(Self, Ctrl.Left);
            end;
        end;
      if Sender = FImgRightIndent then
        begin
          if  int_CheckBounds(newLeft, Ctrl.Left,
                  Max(FImgFirstIndent.Left, FImgLeftIndent.Left) + FMinIndentDist,
                    RightBound - BmpSemi)  then
            begin
              Ctrl.Left := newLeft;
              if assigned(FOnRulerRightIdentChange) then
                FOnRulerRightIdentChange(Self, Ctrl.Left);
            end;
        end;
      if Sender = FImgBothLeftIndent then
        begin
          newOfs := FImgLeftIndent.Left - FImgFirstIndent.Left;

          if  newOfs > 0 then
          begin
            Y := HostRect.Left + newOfs - BmpSemi;
            X := FImgRightIndent.Left - FMinIndentDist;
          end
          else
          begin
            Y := HostRect.Left - BmpSemi;
            X := FImgRightIndent.Left - FMinIndentDist + newOfs;
          end;

          if  int_CheckBounds(newLeft, Ctrl.Left, Y, X) then
          begin
            Ctrl.Left := newLeft;
            FImgLeftIndent.Left := newLeft;
            FImgFirstIndent.Left := newLeft - newOfs;
          end;
        end;
      if FRichEdit <> nil then
        begin
          newOfs:= Ctrl.Left + BmpSemi;
          MoveFocusLine(oldOfs, newOfs);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.IndentMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  V: integer;
begin
  if  (csDesigning in ComponentState) then exit;

  FreeAndNil(FControlCanvas);
  if FDragging and (Button = mbLeft) and (Shift = []) then
    begin
      FDragging:= False;

      if  Sender is TIndentImage  then
        TIndentImage(Sender).FDragging := False;

      FreeAndNil(FControlCanvas);

      if Assigned(FRichEdit)  then
        DrawFocusline(TControl(Sender).Left + BmpSemi, 1,
          TControl(Sender).Left + BmpSemi, FEditRect.Bottom);

      if  TControl(Sender).Left <> TControl(Sender).Tag then
        begin
          V := LMDPixelsXTo(TPaintBox(Sender).Left + BmpSemi - FEditRect.Left, Measurement);
{
          if  Sender = FImgLeftIndent then
            TLMDRichEdit(RichEdit).Paragraph.LeftIndent := V
          else
}
          if  Sender = FImgRightIndent  then
            TLMDRichEdit(RichEdit).Paragraph.RightIndent:=
              LMDPixelsXTo(PageWidth, Measurement) - V
          else
          if  (Sender = FImgFirstIndent) or (Sender = FImgLeftIndent) then
            begin
              V := LMDPixelsXTo(FImgLeftIndent.Left + BmpSemi -
                        FEditRect.Left, Measurement);
              TLMDRichEdit(RichEdit).Paragraph.SetParagraphIndent(
                V, LMDPixelsXTo(FImgFirstIndent.Left + BmpSemi -
                        FEditRect.Left, Measurement) - V);
            end
          else
          if  (Sender = FImgBothLeftIndent) then
              TLMDRichEdit(RichEdit).Paragraph.SetParagraphIndent(
                V, LMDPixelsXTo(FImgFirstIndent.Left + BmpSemi -
                        FEditRect.Left, Measurement) - V);
        end;

      Invalidate;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.IndentPaint(Sender: TObject);

type
  TIndentID = (riFirst, riLeft, riRight, riBothLeft);

  procedure DrawGhostIndent(Ind: TindentID);
  var
    x, y: Integer;
  begin
    with Canvas do
      begin
        Pen.Color:= clBtnShadow;
        Brush.Color:= clBtnFace;
        if (ind = riFirst) and (FImgFirstIndent.Left <> FImgFirstIndent.Tag)
          then
          begin
            x:= FImgFirstIndent.Tag;
            y:= FImgFirstIndent.Top;
            Polygon([Point(x + 0, y + 0), Point(x + 8, y + 0), Point(x + 8, y +
                3),
              Point(x + 4, y + 7), Point(x + 0, y + 3)]);
          end;
        if (ind = riRight) and (FImgRightIndent.Left <> FImgRightIndent.Tag)
          then
          begin
            x:= FImgRightIndent.Tag;
            y:= FImgRightIndent.Top;
            Polygon([Point(x + 0, y + 7), Point(x + 0, y + 4), Point(x + 4, y +
                0),
              Point(x + 8, y + 4), Point(x + 8, y + 7)]);
          end;
        if (ind = riLeft) and (FImgLeftIndent.Left <> FImgBothLeftIndent.Tag)
          then
          begin
            x:= FImgBothLeftIndent.Tag;
            y:= FImgLeftIndent.Top;
            Polygon([Point(x + 0, y + 7), Point(x + 0, y + 4), Point(x + 4, y +
                0),
              Point(x + 8, y + 4), Point(x + 8, y + 7)]);
          end;
        if (ind = riBothLeft) and (FImgBothLeftIndent.Left <>
          FImgBothLeftIndent.Tag) then
          begin
            x:= FImgBothLeftIndent.Tag;
            y:= FImgBothLeftIndent.Top;
            MoveTo(x + 0, y + 0);
            LineTo(x + 0, y + 4);
            LineTo(x + 8, y + 4);
            LineTo(x + 8, y + 0);
            LineTo(x + 7, y + 0);
          end;
      end;
  end;

begin
  if (Sender = FImgFirstIndent) and FDragging then DrawGhostIndent(riFirst);
  if (Sender = FImgRightIndent) and FDragging then DrawGhostIndent(riRight);
  if (Sender = FImgLeftIndent) and FDragging then DrawGhostIndent(riLeft);
  if (Sender = FImgBothLeftIndent) and FDragging then
    DrawGhostIndent(riBothLeft);

  with (Sender as TPaintbox).Canvas do
    begin
      Brush.Style:= bsClear;
      if Sender <> FImgBothLeftIndent then
        FillRect(Rect(0, 0, (Sender as TPaintBox).Width, (Sender as
          TPaintBox).Height));
      Brush.Style:= bsSolid;
      Brush.Color:= clBtnFace;
      Pen.Color:= clBlack;
      if Sender = FImgFirstIndent then
        begin
          Polygon([Point(0, 0), Point(8, 0), Point(8, 3),
            Point(4, 7), Point(0, 3)]);
          Pen.Color:= clBtnHighLight;
          MoveTo(6, 1);
          LineTo(1, 1);
          LineTo(1, 3);
          LineTo(4, 6);
        end;

      if (Sender = FImgLeftIndent) or (Sender = FImgRightIndent) then
        begin
          Polygon([Point(0, 7), Point(0, 4), Point(4, 0),
            Point(8, 4), Point(8, 7)]);
          Pen.Color:= clBtnHighLight;
          MoveTo(1, 5);
          LineTo(1, 4);
          LineTo(5, 0);
        end;
      if Sender = FImgBothLeftIndent then
        begin
          FillRect(Rect(0, 0, TPaintBox(Sender).Width,
            TPaintBox(Sender).Height));
          MoveTo(0, 0);
          LineTo(0, 4);
          LineTo(8, 4);
          LineTo(8, 0);
          LineTo(7, 0);
          Pen.Color:= clBtnHighLight;
          MoveTo(1, 2);
          LineTo(1, 0);
          LineTo(7, 0);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.Paint;
var
  I: LongInt;
  S: string;
  aR, aB, R1: integer;
  aPageWidth: integer;
  MaxI: integer;
  k, V: integer;
  ii, D: double;
  H_5, H_2, TH, TH_2: integer;
  L, H: integer;
  EditRect: TRect;
begin
  if  Assigned(RichEdit) and RichEdit.HandleAllocated then
  RichEdit.Perform(EM_GETRECT, 0, TLMDPtrInt(@EditRect))
  else
    EditRect := ClientRect;

  aPageWidth := RightBound;

  L := EditRect.Left;
  H := Height;

   { PrepareIndents }
  if FBorderUp - 3 < 0 then
    FImgFirstIndent.Top:= 0
  else if (FBorderUp - 3) > (H - 8) then
    FImgFirstIndent.Top:= H - 8
  else
    FImgFirstIndent.Top:= FBorderUp - 3;

  if Height - FBorderDown - 8 < 0 then
    FImgLeftIndent.Top:= 0
  else if (H - FBorderDown - 8) > (H - 13) then
    FImgLeftIndent.Top:= H - 13
  else
    FImgLeftIndent.Top:= H - FBorderDown - 8;

  FImgRightIndent.Top:= FImgLeftIndent.Top;
  FImgBothLeftIndent.Top:= FImgLeftIndent.Top + 8;

   {Draw Borders}
  aR := Width - FBorderRight;
  aB := H - FBorderDown;
  R1 := aPageWidth - FMarginRight;

  if  R1 > aR then  R1 := aR;

  Canvas.Brush.Color:= FBackColor;
  Canvas.FillRect(Rect(0, 0, Width, FBorderUp));
  Canvas.FillRect(Rect(0, aB, Width, H));
  Canvas.FillRect(Rect(0, 0, FBorderLeft + 1, H));
  Canvas.FillRect(Rect(aR, 0, Width, H));

   {Draw Margins}
  if (FMode = rmWithMargins) then
    begin
      if  R1 < aR  then
        begin
          Canvas.Brush.Color:= FMarginColor;
          Canvas.FillRect(Rect(R1, FBorderUp, aPageWidth, aB));
        end;

      if  FMarginLeft > 0  then
        begin
          Canvas.Brush.Color:= FMarginColor;
          Canvas.FillRect(Rect(FBorderLeft, FBorderUp,
            FBorderLeft + FMarginLeft - 1, aB));
          Canvas.Brush.Color:= FBackColor;
          Canvas.FillRect(Rect(FBorderLeft + FMarginLeft - 1, FBorderUp,
            FBorderLeft + FMarginLeft + 1, aB));
        end;
    end
  else
    begin
      if  aR > EditRect.Right then
        aR := EditRect.Right;

      Canvas.Brush.Color:= FBackColor;
      Canvas.FillRect(Rect(0, FBorderUp, L, aB));
      Canvas.FillRect(Rect(EditRect.Right, FBorderUp, Width, aB));
    end;

  if  aPageWidth < aR then
    begin
     {Draw unpaged area}
      Canvas.Brush.Color:= FBackColor;
      Canvas.FillRect(Rect(aPageWidth, FBorderUp, aR, aB));
    end;

   {Draw Main Area}
  Canvas.Brush.Color:= Color;

  if (FMode = rmWithMargins) then
    Canvas.Fillrect(Rect(FBorderLeft + FMarginLeft + 1, FBorderUp, R1, aB))
  else
    Canvas.Fillrect(Rect(FBorderLeft + L, FBorderUp, EditRect.Right, aB));

   {Draw Margin Handlers}
  if FMode = rmWithMargins then
  begin
    if FMarginRight = 0 then
      Canvas.Brush.Color:= FMarginColor
    else
      Canvas.Brush.Color:= FBackColor;
    Canvas.FillRect(Rect(aPageWidth - FMarginRight - 1,
      FBorderUp, aPageWidth - FMarginRight + 1, aB));
  end;

   { Draw delims }
  Canvas.Brush.Color:= Color;
  Canvas.Brush.Style:= bsClear;
  Canvas.Pen.Color:= Font.Color;
  Canvas.Font:= Font;

  D := FRulerTab;
  I:= L;
  MaxI := Min(aPageWidth - 6, aR);
  k := 0;
  ii := i;
  H_5 := (H - 5) div 2;
  H_2 := (H - 2) div 2;
  V := 0;
  TH := Canvas.TextHeight('0');
  TH_2 := (Height - TH) div 2;

  while (i < MaxI) do
    begin
      if  (k mod FFact) = 0 then
        begin
          if  ((k mod (FFact * 2)) = 0) then
            begin
              if  (V <> 0)  then
                begin
                  if  V < 0 then
                    S:= IntToStr(-V)
                  else
                    S:= IntToStr(V);

                  Canvas.TextOut(i - Canvas.TextWidth(S) div 2, TH_2, S);
                  Canvas.MoveTo(i, TH_2 - 1);
                  Canvas.LineTo(i, TH_2 - 2);
                  Canvas.MoveTo(i, TH_2 + TH);
                  Canvas.LineTo(i, TH_2 + TH + 1);
                end
              else
                begin
//                  Canvas.MoveTo(i, 2);
//                  Canvas.LineTo(i, Height - 2);
                end;
              inc(V, FDist);
            end
          else
            begin
              Canvas.MoveTo(i, H_5);
              Canvas.LineTo(i, H_5 + 5);
            end;
        end
      else
        begin
          Canvas.MoveTo(i, H_2);
          Canvas.LineTo(i, H_2 + 2);
        end;

      inc(k);
      ii := ii + D;
      i := Round(ii);
    end;
  R1 := L;

  if  Assigned(FTabs) then
    for i := 0 to FTabs.Count - 1 do
      with  TPaintBox(FTabs[I]) do
        if  Visible then
          if  Left > R1 then
            R1 := Left;

  k := Round(LMDPointsToPixelsX(DefTabSizePoints));
  i := R1 - L;
  Canvas.Pen.Color := clBtnShadow;

  if  (i mod k) <> 0 then
    inc(R1, k - (i mod k));

  inc(aB);
  dec(H);

  while (R1 < MaxI) do
    begin
      Canvas.MoveTo(R1, aB);
      Canvas.LineTo(R1, H);
      inc(R1, k);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;

  if  (csDesigning in ComponentState) then exit;

  if Button = mbRight then
    begin
      if Assigned(FRichEdit) then
        if TLMDCustomRichEdit(FRichEdit).Mode = edModeAppOnly then
          begin
            if  CreateTab(X)  then
              SetRichEditTabs;
            Exit;
          end;
    RichEdit.Perform(EM_GETRECT, 0, TLMDPtrInt(@FEditRect));
    if (X > FMarginLeft + FBorderLeft - 3) and
        (X < FMarginLeft + FBorderLeft + 3) then
        begin
          FDraggingLeft:= true;
          if Assigned(FRichEdit) then
            DrawFocusLine(Left - FRichEdit.Left + FBorderLeft + FMarginLeft, 1,
              Left - FRichEdit.Left + FBorderLeft + FMarginLeft,
              FRichedit.ClientHeight);
        end
      else if (X > PageWidth - FMarginRight - 3) and
        (x < PageWidth - FMarginRight + 3) then
        begin
          FDraggingRight:= true;
          if Assigned(FRichEdit)  then
            DrawFocusline(Left - FRichEdit.Left + PageWidth - FMarginRight, 1,
              Left - FRichEdit.Left + PageWidth - FMarginRight,
              FRichEdit.ClientHeight);
        end
      else
        begin
          if  CreateTab(X)  then
            SetRichEditTabs;
        end;
    end
  else
exit;

  //  ToDo
  if (Button = mbLeft) and (FMode = rmWithMargins) and Assigned(FRichEdit) then
    if  (X > (FMarginLeft + FBorderLeft - 3))
        and (X < (Fmarginleft + FBorderLeft + 3)) then
      begin
        FDraggingLeft:= true;
        FDragOfs := X;
        DrawFocusline(X, 1, X, FRichEdit.ClientHeight);
      end
    else
    if  (X > (RightBound - FMarginRight - 3))
        and (X < (RightBound - FMarginRight + 3)) then
      begin
        FDraggingRight:= true;
        FDragOfs := X;
        DrawFocusline(X, 1, X, FRichEdit.ClientHeight);
      end;

end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  oldOfs, newOfs: LongInt;
begin
  inherited;

  if  (csDesigning in ComponentState)
      {or (FMode <> rmWithMargins) }then
    exit;

exit;
  //  ToDo
  if  (FMode = rmWithMargins) and
      ((X > (FMarginLeft + FBorderLeft - 3)) and (X < (Fmarginleft + FBorderLeft + 3))
         or
       (X > (RightBound - FMarginRight - 3)) and (X < (RightBound - FMarginRight + 3)))
          then
    Cursor:= crSizeWE
  else
    Cursor:= crDefault;

  if  Assigned(FRichEdit) then
    begin
      if FDraggingLeft then
        begin
          oldOfs:= FDragOfs;
          newOfs:= X;//Left - FRichEdit.Left + FBorderLeft + FMarginLeft;
          MoveFocusLine(oldOfs, newOfs);
          FDragOfs:= newOfs;
        end;
    end;
  if FDraggingRight and (X < RightBound) then
    begin
      if FRichEdit <> nil then
        oldOfs:= Left - FRichEdit.Left + RightBound - FMarginRight
      else
        oldOfs:= -1;

      if FRichEdit <> nil then
        begin
          newOfs:= X;
          MoveFocusLine(oldOfs, newOfs);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  R: TRect;
begin
  inherited;

  if  (csDesigning in ComponentState) then exit;

  if FDraggingLeft then
    begin
      if FRichEdit <> nil then
        DrawFocusline(Left - FRichEdit.Left + FBorderLeft + FMarginLeft, 1,
          Left - FRichEdit.Left + FBorderLeft + FMarginLeft,
          FRichEdit.ClientHeight);

//    ChangeMargin - LEFT
      R:= TLMDRichEdit(RichEdit).PageMargins.AsRect;
      case TLMDRichEdit(RichEdit).Measurement of
        unPoints: R.Left:= Round(MarginLeft {* 3});
        unInches: R.Left:= Round(LMDPointsToInches(MarginLeft));
        unMillimeters: R.Left:= Round(LMDPointsToMillimeters(MarginLeft {* 3}));
      end;
      TLMDRichEdit(RichEdit).PageMargins.AsRect:= R;
      TLMDRichEdit(RichEdit).SetEditRect;
      FDraggingLeft:= false;

    end
  else if FDraggingRight then
    begin
      if FRichEdit <> nil then
        DrawFocusline(Left - FRichEdit.Left + Width - FBorderRight -
          FMarginRight, 1, Left - FRichEdit.Left + Width - FBorderRight -
          FMarginRight,
          FRichEdit.ClientHeight);
//    ChangeMargin - RIGHT

      R:= TLMDRichEdit(RichEdit).PageMargins.AsRect;
      case TLMDRichEdit(RichEdit).Measurement of
        unPoints: R.Right:= Round(MarginRight {* 3});
        unInches: R.Right:= Round(LMDPointsToInches(MarginRight {* 3}));
        unMillimeters: R.Right:= Round(LMDPointsToMillimeters(MarginRight { * 3}));
      end;
      TLMDRichEdit(RichEdit).PageMargins.AsRect:= R;
      TLMDRichEdit(RichEdit).SetEditRect;

      FDraggingRight:= false;
    end
  else
  if  Shift = [ssRight] then
    SetRichEditTabs;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.MoveFocusline(oldOfs, newOfs: Integer);
begin
  if (OldOfs <> NewOfs) then
    begin
      DrawFocusline(oldOfs, 1, oldOfs, FEditRect.Bottom);
      DrawFocusline(newOfs, 1, newOfs, FEditRect.Bottom);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.Notification(aComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (aComponent = FRichEdit) then RichEdit:= nil;
end;

{  ***************************** private  ********************************* }
{ ------------------------------------------------------------------------- }

function TLMDRTFRuler.GetIndentFirst: Integer;
begin
  Result:= FImgFirstIndent.Left
end;

{ ------------------------------------------------------------------------- }

function TLMDRTFRuler.GetIndentLeft: Integer;
begin
  Result:= FImgLeftIndent.Left
end;

{ ------------------------------------------------------------------------- }
function TLMDRTFRuler.GetIndentMarkerWidth: integer;
begin
  Result := BmpSemi * 2;
end;

{ ------------------------------------------------------------------------- }

function TLMDRTFRuler.GetIndentRight: Integer;
begin
  Result:= FImgRightIndent.Left
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRTFRuler.SetBackColor(const Value: TColor);
begin
  if FBackColor <> Value then
    begin
      FBackColor := Value;
      Repaint;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRTFRuler.SetMarginColor(const Value: TColor);
begin
  if FMarginColor <> Value then
    begin
      FMarginColor := Value;
      Repaint;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRTFRuler.SetIndentValue(IndentImage: TIndentImage; Value: integer);
begin
  if  IndentImage.Value <> Value  then
    begin
      IndentImage.Value := Value;
      IndentImage.Left:= LMDToPixelsX(Value, Measurement) +
        HostRect.Left - BmpSemi;
      if  IndentImage.Left < (HostRect.Left - BmpSemi) then
        IndentImage.Left := HostRect.Left - BmpSemi;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetIndents(Left, First, Right: integer);
begin
  SetIndentValue(FImgLeftIndent, Left);
  FImgBothLeftIndent.Left:= FImgLeftIndent.Left;
  SetIndentValue(FImgFirstIndent, Left + First);
  SetIndentRight(Right);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetIndentFirst(const Value: Integer);
begin
  SetIndentValue(FImgFirstIndent, Value);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetIndentLeft(const Value: Integer);
begin
  SetIndentValue(FImgLeftIndent, Value);
  FImgBothLeftIndent.Left:= FImgLeftIndent.Left;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetIndentRight(const Value: Integer);
begin
  if  FImgRightIndent.Value <> Value  then
    begin
      FImgRightIndent.Value := Value;
      FImgRightIndent.Left:= RightBound - LMDToPixelsX(Value, Measurement) -
        FMarginRight - BmpSemi;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetMarginLeft(const Value: Integer);
begin
  if (FMarginLeft <> Value) and (Value >= 0) and (Value <= PageWidth) then
    begin
      FMarginLeft:= Round(LMDPointsToPixelsX(Value));

      if not (csLoading in ComponentState) then Paint; //Invalidate;
    end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRTFRuler.GetMarginLeft: integer;
begin
  Result := LMDPixelsXTo(FMarginLeft, unPoints);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetMarginRight(const Value: Integer);
var
  P: integer;
begin
//  if FMode = rmWithoutMargins then Exit;
  if (FMarginRight <> Value) and (Value >= 0) then
    begin
      P := Round(LMDPointsToPixelsX(Value));
      if  P > PageWidth then
        P := PageWidth;
      FImgRightIndent.Left:= PageWidth + FMarginLeft;//FImgRightIndent.Left + (P - FMarginRight);//VB April 2008
      FMarginRight:= P;
      if not (csLoading in ComponentState) then
        Invalidate;
    end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRTFRuler.GetMarginRight: integer;
begin
  Result := LMDPixelsXTo(FMarginRight, unPoints);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetMode(Value: TLMDRTFRulerMode);
begin
  if  FMode <> Value  then
    begin
      FMode:= Value;
      if Value = rmWithoutMargins then
        begin
          MarginRight:= 0;
          MarginLeft:= 0;
          FImgRightIndent.Visible := False
        end
      else
        begin
          FImgRightIndent.Visible := True;
        end;

      Invalidate;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetRichEdit(const Value: TCustomMemo);
begin
  if FRichEdit <> Value then
    begin
      FRichEdit:= Value;
      if FRichEdit <> nil then
        begin
          MarginRight:= 0;
          IndentRight:= PageWidth - 4;
          CreateTabs;
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

destructor TLMDRTFRuler.Destroy;
begin
  if Assigned(FRichEdit) then TLMDCustomRichEdit(FRichEdit).Ruler:= nil;
  FTabs.Free;
  FControlCanvas.Free;
  inherited;
end;

{ ------------------------------------------------------------------------- }

function int_TabsCompare(I1, I2: Pointer): Integer;
begin
  Result := TControl(I1).Left - TControl(I2).Left;
end;

{ ------------------------------------------------------------------------- }

function TLMDRTFRuler.CreateTab(aPos: LongInt): Boolean;//TPaintBox;
var
  i: integer;
  PB: TPaintBox;
begin
  Result:= False;
  PB := nil;

  for i := 0 to FTabs.Count - 1 do
    if  TPaintBox(FTabs[i]).Left = aPos  then
      begin
        PB := TPaintBox(FTabs[i]);
        Result := not PB.Visible;
        Break;
      end;

  if  not Assigned(PB)  then
    begin
      for i := 0 to FTabs.Count - 1 do
        if  not TPaintBox(FTabs[i]).Visible then
          begin
            PB := TPaintBox(FTabs[i]);
            Result := True;
            Break;
          end;

      if  not Assigned(PB)  then
        begin
          if FTabs.Count >= MAX_TAB_STOPS then
            Exit;

          Result := True;
          PB:= TPaintBox.Create(Self);
          FTabs.Add(PB);
          with PB do
            begin
              Parent:= Self;
              BoundsRect:= Rect(0, 0, 6, 6);
//              Left:= aPos;
              Top:= 15;
              Cursor:= crArrow;
              OnMouseDown:= TabMouseDown;
              OnMouseMove:= TabMouseMove;
              OnMouseUp:= TabMouseUp;
              OnPaint:= TabPaint;
//              Visible:= True;
            end;
        end;

      PB.Left := aPos;
      FTabs.Sort(int_TabsCompare);
    end;

  PB.Visible := True;
  Invalidate;

  if Assigned(FOnRulerTabCreate) then
    FOnRulerTabCreate(Self, PB.Left);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.CreateTabs;
var
  I: LongInt;
  EditRect: TRect;
  Paragraph: TParaFormat2;
  L: integer;
  TT: double;
begin

  if  (csDesigning in ComponentState) then exit;

  if not Assigned(FRichEdit) or not FRichEdit.HandleAllocated then
    Exit;

  FillChar(Paragraph, SizeOf(Paragraph), 0);

  if TLMDCustomRichEdit(FRichEdit).Version >= 2 then
    Paragraph.cbSize:= SizeOf(TParaFormat2)
  else
    Paragraph.cbSize:= SizeOf(TParaFormat);

  RichEdit.Perform(EM_GETPARAFORMAT, 0, LPARAM(@Paragraph));

  if  (Paragraph.cTabCount <> 0) or (FTabs.Count <> 0) then
    begin
      if  (Paragraph.cTabCount <> 0) then
        begin
          EditRect := TLMDCustomRichEdit(FRichEdit).GetEditRect;
          TT := LMDTwipsToPixelsX(10000) / 10000;

          for I:= 0 to Paragraph.cTabCount - 1 do
            begin
              L := Round(Paragraph.rgxTabs[I] * TT) + EditRect.Left;
              if  i < FTabs.Count then
                begin
                  TPaintBox(FTabs[I]).Left := L;
                  TPaintBox(FTabs[I]).Visible := True;
                end
              else
                CreateTab(L);
            end;
        end;

      for i := Paragraph.cTabCount to FTabs.Count - 1 do
        TPaintBox(FTabs[I]).Visible := False;
      Invalidate;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.TabPaint(Sender: TObject);
begin
  with TPaintBox(Sender).Canvas do
    begin
      Pen.Width:= 5;
      MoveTo(0, 0);
      LineTo(0, TControl(Sender).Height);
      LineTo(TControl(Sender).Width, TControl(Sender).Height);
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDRTFRuler.PageWidth: Longint;
begin
  Result:= 0;
  if Assigned(FRichEdit)  then
    begin
      if FMode = rmWithMargins then
        Result:= TLMDCustomRichEdit(FRichEdit).PrinterPageWidth
      else
        Result:= TLMDCustomRichEdit(FRichEdit).ClientWidth;
    end;
end;

{ ------------------------------------------------------------------------- }

function  TLMDRTFRuler.RightBound: integer;
begin
  Result := PageWidth + FBorderLeft;

  if FMode = rmWithMargins then
    inc(Result, FMarginLeft + FMarginRight);
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.TabMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if  (csDesigning in ComponentState) then exit;

  if Button = mbLeft then
    begin
      FDragging:= true;
      FDragOfs:= X;
    RichEdit.Perform(EM_GETRECT, 0, TLMDPtrInt(@FEditRect));
    TControl(Sender).Tag:= FImgFirstIndent.Left;
      if FRichEdit <> nil then
        DrawFocusline(TControl(Sender).Left, 1,
          TControl(Sender).Left, FRichEdit.ClientHeight);
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.TabMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
var
  OldL: LongInt;
  Ctrl: TControl;
  VisibleChange, PosChange: Boolean;
begin
  if  (csDesigning in ComponentState) then exit;

  if FDragging then
    begin
      Ctrl := TControl(Sender);
      OldL := Ctrl.Left;
      Ctrl.Left := GetRulerTabPos(Ctrl.Left, X - FDragOfs, 0);

      if  Ctrl.Left < FEditRect.Left then
        Ctrl.Left := FEditRect.Left
      else
      if  Ctrl.Left > FEditRect.Right then
        Ctrl.Left := FEditRect.Right;
      if Assigned(FRichEdit)  then
        begin
          VisibleChange := (Ctrl.Visible <> (Y <= Ctrl.Height));
          PosChange := (OldL <> Ctrl.Left);

          if Ctrl.Visible and (VisibleChange or PosChange) then
            DrawFocusline(OldL, 1, OldL, FRichEdit.ClientHeight);

          Ctrl.Visible:= (Y <= Ctrl.Height);

          if Ctrl.Visible and (VisibleChange or PosChange) then
            DrawFocusline(Ctrl.Left, 1, Ctrl.Left, FRichEdit.ClientHeight);

          if not Ctrl.Visible then
            begin
              if assigned(FOnRulerTabDestroy) then
                FOnRulerTabDestroy(Self, Ctrl.Left)
            end
          else
            if assigned(FOnRulerTabChange) then
              FOnRulerTabChange(Self, Ctrl.Left);
        end;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.TabMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if  (csDesigning in ComponentState) then exit;

  if FDragging and (Button = mbLeft) then
    begin
      if FRichEdit <> nil then
        if TControl(Sender).Visible then
          DrawFocusline(TControl(Sender).Left, 1,
            TControl(Sender).Left, FRichEdit.ClientHeight)
        else
          begin
          end;
      Invalidate;
      FDragging:= False;
    end;
    SetRichEditTabs;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetRichEditTabs;
var
  Paragraph: TParaFormat2;
  I, j: LongInt;
  EditRect: TRect;
  TT: extended;
begin
  if  (csDesigning in ComponentState) then exit;

  if TLMDCustomRichEdit(FRichEdit).HandleAllocated then
  begin
  FillChar(Paragraph, SizeOf(Paragraph), 0);
  if TLMDCustomRichEdit(FRichEdit).Version >= 2 then
      Paragraph.cbSize:= SizeOf(Paragraph)
    else
      Paragraph.cbSize:= SizeOf(TParaFormat);

  RichEdit.Perform(EM_GETPARAFORMAT, 0, LPARAM(@Paragraph));
  with Paragraph do
      begin
        dwMask:= PFM_TABSTOPS;
        cTabCount:= 0;
        j := 0;

        for i := 0 to FTabs.Count - 1 do
          if  TPaintBox(FTabs[I]).Visible then
            inc(cTabCount);

        if  cTabCount > 0 then
          begin
            EditRect := TLMDCustomRichEdit(FRichEdit).GetEditRect;
            TT := LMDPixelsXToTwips(1);
            for I:= 0 to FTabs.Count - 1 do
              if  TPaintBox(FTabs[I]).Visible then
                begin
//                  rgxTabs[j]:= LMDPixelsXToTwips(TPaintBox(FTabs[I]).Left - EditRect.Left);
                  rgxTabs[j]:= Round((TPaintBox(FTabs[I]).Left - EditRect.Left) * TT);
                  inc(j);
                end;
          end;
      end;

  RichEdit.Perform(EM_SETPARAFORMAT, 0, LPARAM(@Paragraph));
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetMeasurement(Value: TLMDMeasurement);
begin
  if  FMeasurement <> Value then
    begin
      FMeasurement := Value;

      case  FMeasurement of
        unInches:
          begin
            FDist := 1;
            FFact := 4;
            FRulerTab := LMDInchesToPixelsX(FDist * InchFactor) / FFact / 2;
          end;
        unMillimeters:
          begin
            FDist := 1;
            FFact := 2;
            FRulerTab := LMDMillimetersToPixelsX(FDist * 10) / FFact / 2;
          end;
        else
          begin
            FDist := 36;
            FFact := 3;
            FRulerTab := LMDPointsToPixelsX(FDist) / FFact / 2;
          end;
      end;

      Invalidate;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetHostRect(const Value: TRect);
var
  dx: integer;
begin
  if  (FHostRect.Left <> Value.Left) or (FHostRect.Right <> Value.Right)
    {or (FHostRect.Top <> Value.Top) or (FHostRect.Bottom <> Value.Bottom)} then
    begin
      dx := Value.Left - FHostRect.Left;
      FHostRect := Value;

      if  dx <> 0 then
        begin
          CreateTabs;
          FImgFirstIndent.Left := FImgFirstIndent.Left + dx;
          FImgLeftIndent.Left := FImgLeftIndent.Left + dx;
          FImgBothLeftIndent.Left := FImgBothLeftIndent.Left + dx;
          FImgRightIndent.Left := FImgRightIndent.Left + dx;
        end;
      Invalidate;
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFRuler.SetOffset(Value: Integer);
begin
  if  FOffset <> Value then
    begin
      FOffset := Value;
    end;
end;

{ *****************************  TIndentImage  ************************** }

constructor TIndentImage.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  BoundsRect:= Rect(0, 0, BmpSemi * 2 + 1, 8);
  Cursor:= crArrow;
  Visible:= True;
  FDragging := False;
  FValue := -10;
  ControlStyle := [csCaptureMouse, csClickEvents];//csSetCaption];
end;

{ ------------------------------------------------------------------------- }

destructor TIndentImage.Destroy;
begin
  inherited ;
end;

{ ------------------------------------------------------------------------- }
(*
procedure TIndentImage.Paint;
  procedure DrawGhostIndent(Ind: TindentID);
  var
    x, y: Integer;
  begin
    with Canvas do
      begin
        Pen.Color:= clBtnShadow;
        Brush.Color:= clBtnFace;
        if (ind = riFirst) and (Left <> Tag) then
          begin
            x:= Tag;
            y:= Top;
            Polygon([Point(x + 0, y + 0), Point(x + 8, y + 0), Point(x + 8, y +
                3),
              Point(x + 4, y + 7), Point(x + 0, y + 3)]);
          end;
        if (ind = riRight) and (Left <> Tag) then
          begin
            x:= Tag;
            y:= Top;
            Polygon([Point(x + 0, y + 7), Point(x + 0, y + 4), Point(x + 4, y +
                0),
              Point(x + 8, y + 4), Point(x + 8, y + 7)]);
          end;
{
        if (ind = riLeft) and (FImgLeftIndent.Left <> FImgBothLeftIndent.Tag)
          then
          begin
            x:= FImgBothLeftIndent.Tag;
            y:= FImgLeftIndent.Top;
            Polygon([Point(x + 0, y + 7), Point(x + 0, y + 4), Point(x + 4, y +
                0),
              Point(x + 8, y + 4), Point(x + 8, y + 7)]);
          end;
}
        if (ind = riBothLeft) and (Left <> Tag) then
          begin
            x:= Tag;
            y:= Top;
            MoveTo(x + 0, y + 0);
            LineTo(x + 0, y + 4);
            LineTo(x + 8, y + 4);
            LineTo(x + 8, y + 0);
            LineTo(x + 7, y + 0);
          end;
      end;
  end;

begin
  if FDragging then DrawGhostIndent(FIndentID);

  with TCustomControl(Parent).Canvas do
    begin
      Brush.Style:= bsClear;
//      if FIndentID <> riBothLeft then
      FillRect(Rect(0, 0, Width, Height));
      Brush.Style:= bsSolid;
      Brush.Color:= clBtnFace;
      Pen.Color:= clBlack;

      case  FIndentID of
        riFirst:
          begin
            Polygon([Point(0, 0), Point(8, 0), Point(8, 3),
              Point(4, 7), Point(0, 3)]);
            Pen.Color:= clBtnHighLight;
            MoveTo(6, 1);
            LineTo(1, 1);
            LineTo(1, 3);
            LineTo(4, 6);
          end;

        riLeft, riRight:
          begin
            Polygon([Point(0, 7), Point(0, 4), Point(4, 0),
              Point(8, 4), Point(8, 7)]);
            Pen.Color:= clBtnHighLight;
            MoveTo(1, 5);
            LineTo(1, 4);
            LineTo(5, 0);
          end;

        riBothLeft:
          begin
//            FillRect(Rect(0, 0, Width, Height));
            MoveTo(0, 0);
            LineTo(0, 4);
            LineTo(8, 4);
            LineTo(8, 0);
            LineTo(7, 0);
            Pen.Color:= clBtnHighLight;
            MoveTo(1, 2);
            LineTo(1, 0);
            LineTo(7, 0);
          end;
      end;
    end;
end;
*)
{ ------------------------------------------------------------------------- }

procedure TIndentImage.SetIndentID(Value: TIndentID);
begin
  if  FIndentID <> Value  then
    begin
      FIndentID := Value;
      Invalidate;
    end;
end;

end.
