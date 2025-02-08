unit pLMDBmpRegionEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls,  ExtDlgs, ComCtrls, Buttons,
  LMDClass, LMDCont, LMDCustomControl, LMDThemes,
  LMDProgressFill, LMDGraphicControl, LMDBaseGraphicControl, LMDBaseLabel,
  LMDBaseMeter, LMDCustomProgressFill, LMDCustomPanel,
  LMDCustomBevelPanel, LMDCustomScrollBox, LMDCustomSimpleLabel,
  LMDCustomButton, LMDBaseGraphicButton, LMDCustomSpeedButton, LMDComboBox,
  LMDSimplePanel, LMDSpeedButton, LMDButton, LMDSimpleLabel, LMDScrollBox,
  LMDCheckBox, LMDButtonControl, LMDRegionMask, LMDCustomCheckBox, LMDCustomComponent,
  LMDCustomComboBox, LMDImageList, LMDCustomImageList,
  LMDBaseController, LMDCustomContainer, ImgList, LMDThemedComboBox, LMDControl,
  LMDBaseControl;

type
  TLMDfrmRegionFromBMPdlg = class(TForm)
    openpic: TOpenPictureDialog;
    TabbedNotebook1: TPageControl;
    LoadButton: TLMDSpeedButton;
    DimLabel: TLMDSimpleLabel;
    LMDScrollBox1: TLMDScrollBox;
    Image1: TImage;
    LMDSimplePanel1: TLMDSimplePanel;
    LMDSimpleLabel1: TLMDSimpleLabel;
    cc: TLMDSimpleLabel;
    cl: TListBox;
    LMDSimplePanel2: TLMDSimplePanel;
    zoom: TPaintBox;
    ViewLabel: TLMDSimpleLabel;
    LMDSimpleLabel4: TLMDSimpleLabel;
    LMDSimplePanel3: TLMDSimplePanel;
    bsLabel: TLMDSimpleLabel;
    LMDSimpleLabel3: TLMDSimpleLabel;
    cb: TLMDComboBox;
    ccb: TLMDCheckBox;
    colb: TLMDComboBox;
    BuildButton: TLMDSpeedButton;
    Progress: TLMDProgressFill;
    LMDButton1: TLMDButton;
    OKButton: TLMDButton;
    LMDImageList1: TLMDImageList;
    cb2: TLMDComboBox;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
//    procedure BitBtn1Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure BuildButtonClick(Sender: TObject);
    procedure clKeyPress(Sender: TObject; var Key: Char);
    procedure clDrawItem(Control: TWinControl; Index: Integer; Rect: TRect;
      State: TOwnerDrawState);
    procedure clMeasureItem(Control: TWinControl; Index: Integer;
      var Height: Integer);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure zoomMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure zoomMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure clKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LoadButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ccbChange(Sender: TObject);
    procedure colbChange(Sender: TObject);
    procedure cbChange(Sender: TObject);
  private
    StartP,
    POfAll : Integer;
  public
    createAllBorders : Boolean;
    RgnMask : TLMDRegionMask;
    function CreateRgnFromBitmap2 (bmp : TBitmap; const transcol : array of TColor; numtranscol : Integer) : HRGN;

    procedure PaintRGNBorder2 (bmp : TBitmap; region : HRGN; style : integer);
    procedure PaintRGNBorder3 (bmp : TBitmap; region : HRGN; style : integer);
  end;

implementation

uses
  Types,
  LMDGraph, LMDProcs;

{$R *.DFM}

function TLMDfrmRegionFromBMPdlg.CreateRgnFromBitmap2 (bmp : TBitmap;
          const transcol : array of TColor; numtranscol : Integer) : HRGN;
var

  p : PByteArray;

  sx, sy,
  ex, ey,
  y,
  x : Integer;
  rgb_ : array[0..2] of byte;
  fr : HRGN;

  function isTransCol (aValue : TColor) : boolean;
  var
    i : integer;
  begin
    result := false;
    i := 0;
    while (i < numtranscol) and (transcol[i] <> aValue) do
      inc(i);
    if (i < numtranscol) and (transcol[i] = aValue) then result := true;
  end;

begin
  result := 0;
  sx := -1;
  sy := -1;
  ex := 0;
  ey := 0;

  bmp.PixelFormat := pf24Bit;
  for y := 0 to bmp.Height - 1 do
    begin
      p := bmp.ScanLine[y];
      for x := 0 to bmp.Width - 1 do
        begin

          rgb_[2] := (p[x * 3]);
          rgb_[1] := (p[x * 3 + 1]);
          rgb_[0] := (p[x * 3 + 2]);

          if (not (isTransCol (RGB (rgb_[0], rgb_[1], rgb_[2])))) and (x < bmp.Width - 1) then
            begin
                begin
                  if sx = -1 then //sy = -1
                    begin
                      sx := x;
                      sy := y;
                    end;
                  ex := x+1;
                  ey := y+1;
                end;
            end
          else
            if sx <> -1 then //sy <> -1
              begin
                fr := CreateRectRgn (sx, sy, ex, ey);
                if result = 0 then
                  result := fr
                else
                  begin
                    CombineRgn (result, result, fr, {RGN_DIFF}RGN_OR);
                    DeleteObject (fr);
                  end;
                sx := -1;
                sy := -1;
              end;
        end;
      Progress.Position := Round (POfAll / bmp.Height * (y+1));
    end;
end;

procedure TLMDfrmRegionFromBMPdlg.PaintRGNBorder2 (bmp : TBitmap; region : HRGN; style : integer);
type
  PRect = ^TRect;
var
  x,y : Integer;
  aRect : TRect;
  b : hbrush;
  colorUp, colorDown : TColor;
begin
  GetRgnBox (region, aRect);
  if aRect.Right = 0 then inc (aRect.Right);
  if aRect.Bottom = 0 then inc (aRect.Bottom);
  b := CreateSolidBrush (clBlack);

  //set defaults
  colorUp := clWhite;
  colorDown := clGray;

  case style of
    2,4: begin
          colorUp := clWhite;
          colorDown := clGray;
        end;
    3,5 : begin
          colorUp := clGray;
          colorDown := clWhite;
        end;
  end;
  case style of
    1 : //FrameRgn (dc, region, b ,1, 1);
        for x := aRect.Left to aRect.Right do
          for y := aRect.Top to aRect.Bottom do
            begin
              if PtInRegion (region, x, y) and not PtInRegion (region,x-1, y) then
                bmp.Canvas.Pixels[x, y] := clBlack
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x-1, y) then
                  bmp.Canvas.Pixels[x-1, y] := clBlack;
              if PtInRegion (region, x, y) and not PtInRegion (region,x, y-1) then
                bmp.Canvas.Pixels[x, y] := clBlack
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x, y-1) then
                  bmp.Canvas.Pixels[x, y-1] := clBlack;

              Progress.Position := StartP + Round (POfAll / aRect.Right *  (x+1));
              Application.ProcessMessages;
            end;
    2, 3 :
        for x := aRect.Left to aRect.Right do
          for y := aRect.Top to aRect.Bottom do
            begin
              if PtInRegion (region, x, y) and not PtInRegion (region,x-1, y) then
                bmp.Canvas.Pixels[x, y] := colorUp
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x-1, y) then
                  bmp.Canvas.Pixels[x-1, y] :=  colorDown;
              if PtInRegion (region, x, y) and not PtInRegion (region,x, y-1) then
                bmp.Canvas.Pixels[x, y] := colorUp
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x, y-1) then
                  bmp.Canvas.Pixels[x, y-1] := colorDown;

              Progress.Position := StartP + Round (POfAll / aRect.Right *  (x+1));
              Application.ProcessMessages;
            end;
    4,5 : begin
            for x := aRect.Left to aRect.Right do
              for y := aRect.Top to aRect.Bottom do
                begin
                  if PtInRegion (region, x, y) and not PtInRegion (region,x-1, y) then
                    begin
                      bmp.Canvas.Pixels[x, y] := clBlack;
                      bmp.Canvas.Pixels[x+1, y] := ColorUp
                    end
                  else
                    if not PtInRegion (region, x, y) and PtInRegion (region,x-1, y) then
                      begin
                        bmp.Canvas.Pixels[x-1, y] := clBlack;
                        bmp.Canvas.Pixels[x-2, y] := ColorDown;
                      end;
                  if PtInRegion (region, x, y) and not PtInRegion (region,x, y-1) then
                    begin
                      bmp.Canvas.Pixels[x, y] :=  clBlack;
                      bmp.Canvas.Pixels[x, y+1] := ColorUp
                    end
                  else
                    if not PtInRegion (region, x, y) and PtInRegion (region,x, y-1) then
                      begin
                        bmp.Canvas.Pixels[x, y-1] := clBlack;
                        bmp.Canvas.Pixels[x, y-2] := ColorDown;
                      end;
                  Progress.Position := StartP + Round (POfAll / aRect.Right *  (x+1));
                  Application.ProcessMessages;
                end;
          end;
  end;
  DeleteObject (b);
  Progress.Position := 0;
end;

procedure TLMDfrmRegionFromBMPdlg.PaintRGNBorder3 (bmp : TBitmap; region : HRGN; style : integer);
type
  PRect = ^TRect;
var

  p : PByteArray;

  x,y : integer;
  aRect : TRect;
  b : hbrush;
  colorBlack,
  colorUp, colorDown : LongInt;

    procedure SetColor (x : Integer; col : LongInt);
    begin
      if x < 0 then exit;

      p[x * 3] := GetBValue (col);
      p[x*3+1] := GetGValue (col);
      p[x*3+2] := GetRValue (col);

    end;

begin
  bmp.PixelFormat := pf24Bit;
  GetRgnBox (region, aRect);
  if aRect.Right = 0 then inc (aRect.Right);
  if aRect.Bottom = 0 then inc (aRect.Bottom);
  b := CreateSolidBrush (clBlack);

  //set defaults
  colorUp := ColorToRGB (clWhite);
  colorDown := ColorToRGB (clGray);

  colorBlack := ColorToRGB (clBlack);

  case style of
    2,4: begin
          colorUp := ColorToRGB (clWhite);
          colorDown := ColorToRGB (clGray);
        end;
    3,5 : begin
          colorUp := ColorToRGB (clGray);
          colorDown := ColorToRGB (clWhite);
        end;
  end;
  case style of
    1 : //FrameRgn (dc, region, b ,1, 1);
        for x := aRect.Left to aRect.Right do
          for y := aRect.Top to aRect.Bottom do
            begin
              p := bmp.ScanLine[y];
              if PtInRegion (region, x, y) and not PtInRegion (region,x-1, y) then
                SetColor (x, colorBlack)
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x-1, y) then
                  SetColor (x-1, colorBlack);
              if PtInRegion (region, x, y) and not PtInRegion (region,x, y-1) then
                SetColor (x, clBlack)
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x, y-1) then
                  if y > 0 then
                    begin
                      p:=bmp.ScanLine[y-1];
                      SetColor (x, colorBlack)
                    end;
              Progress.Position := StartP + Round (POfAll / aRect.Right *  (x+1));
              Application.ProcessMessages;
            end;
    2, 3 :
        for x := aRect.Left to aRect.Right do
          for y := aRect.Top to aRect.Bottom do
            begin
              p := bmp.ScanLine[y];
              if PtInRegion (region, x, y) and not PtInRegion (region,x-1, y) then
                SetColor (x, colorUp)
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x-1, y) then
                  SetColor (x-1, colorDown);
              if PtInRegion (region, x, y) and not PtInRegion (region,x, y-1) then
                SetColor (x, colorUp)
              else
                if not PtInRegion (region, x, y) and PtInRegion (region,x, y-1) then
                  if y > 0 then
                    begin
                      p:=bmp.ScanLine[y-1];
                      SetColor (x, colorDown)
                    end;
              Progress.Position := StartP + Round (POfAll / aRect.Right *  (x+1));
              Application.ProcessMessages;
            end;
    4,5 : begin
            for x := aRect.Left to aRect.Right do
              for y := aRect.Top to aRect.Bottom do
                begin
                  p := bmp.ScanLine[y];
                  if PtInRegion (region, x, y) and not PtInRegion (region,x-1, y) then
                    begin
                      SetColor (x, colorBlack);
                      SetColor (x+1, colorUp)
                    end
                  else
                    if not PtInRegion (region, x, y) and PtInRegion (region,x-1, y) then
                      begin
                        SetColor (x-1, colorBlack);
                        SetColor (x-2, colorDown)
                      end;
                  if PtInRegion (region, x, y) and not PtInRegion (region,x, y-1) then
                    begin
                      SetColor (x, colorBlack);
                      p := bmp.ScanLine[y+1];
                      SetColor (x, colorUp)
                    end
                  else
                    if not PtInRegion (region, x, y) and PtInRegion (region,x, y-1) then
                      if y > 1 then
                        begin
                          p := bmp.ScanLine[y-1];
                          SetColor (x, colorBlack);
                          p := bmp.ScanLine[y-2];
                          SetColor (x, colorDown)
                        end;
                  Progress.Position := StartP + Round (POfAll / aRect.Right *  (x+1));
                  Application.ProcessMessages;
                end;
          end;
  end;
  DeleteObject (b);
  Progress.Position := 0;
end;

procedure TLMDfrmRegionFromBMPdlg.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i, j : integer;
begin
  if mbLeft = Button then
    begin
      if cl.Items.Count <> 0 then
        begin
          i := 0;
          while (i < cl.Items.Count) and (cl.Items[i] <> ColorToString (Image1.Canvas.Pixels[x,y])) do
            inc(i);
          if (i = cl.Items.Count) then
            cl.Items.Add (ColorToString (Image1.Canvas.Pixels[x,y]));
        end
      else
        cl.Items.Add (ColorToString (Image1.Canvas.Pixels[x,y]));
      BuildButton.Enabled := true;  
    end;
  if mbRight = Button then
    begin
      if X + 20 > Image1.Picture.Bitmap.Width then
        X := Image1.Picture.Bitmap.Width-20;
      if Y + 20 > Image1.Picture.Bitmap.Height then
        Y := Image1.Picture.Bitmap.Height-20;
      ViewLabel.Caption := '('+
                          IntToStr (X)+'x'+
                          IntToStr (Y)+
                          ')';
      for i := 0 to 19 do
        for j := 0 to 19 do
          begin
            zoom.Canvas.Brush.Color := Image1.Picture.Bitmap.Canvas.Pixels[X+i,Y+j];
            zoom.Canvas.FillRect (Rect(i * 4, j * 4, (i+1) * 4, (j+1) * 4));
          end;
    end;
end;

procedure TLMDfrmRegionFromBMPdlg.FormPaint(Sender: TObject);
begin
//  BitBlt (Canvas.Handle, 0,0, Image1.Picture.Bitmap.Width, Image1.Picture.Bitmap.Height, Image1.Picture.Bitmap.Canvas.Handle, 0, 0, PATCOPY);
end;

procedure TLMDfrmRegionFromBMPdlg.BuildButtonClick(Sender: TObject);
var
  frh : HRGN;
  i : integer;
  c : Array[0..500] of TColor;
  b : HBRUSH;
  b1,
  bmp : TBitmap;
begin
  if cl.Items.count = 0 then
    begin
      ShowMessage ('Please choose at least one color to be transparent!');
      Exit;
    end;

  Progress.Visible := true;
  Progress.Repaint;

  for i := 0 to cl.Items.Count - 1 do
     c[i] := StringToColor(cl.Items[i]);

  if not createAllBorders then
    if cb.ItemIndex < 1 then
      POfAll := 100
    else
      POfAll := 50
  else
    POfAll := 33;

  frh := CreateRgnFromBitmap2 (Image1.Picture.Bitmap, c, cl.Items.Count);

  StartP := POfAll;

  bmp := TBitmap.Create;
  bmp.Assign (Image1.Picture.Bitmap);

  b := CreateSolidBrush (clGreen);
  //if not auto create borders that's the only bitmap and it should carry the wanted border
  if not createAllBorders then
    PaintRgnBorder2 (bmp, frh, cb.ItemIndex)
  else //otherwise bmp already contains the "flat" or "original bmp"
    begin //but we have to create the up and down borders

      //create up bitmap
      b1 := TBitmap.Create;
      try
        //get the image face
        b1.Assign (Image1.Picture.Bitmap);
        //draw the up border
        case cb2.ItemIndex of
          0 : PaintRgnBorder3 (b1, frh, 4);
          1 : PaintRgnBorder3 (b1, frh, 2);
        end;
{        if not Assigned (RgnMask.BorderUpBmp) then
          RgnMask.CreateBorderUpBmp;}
        RgnMask.BorderUpBmp.Assign (b1);

        inc (StartP, POfAll);

      finally
        b1.Free;
      end;
      b1 := TBitmap.Create;
      try
        //get the image face
        b1.Width := Image1.Picture.Bitmap.Width;
        b1.Height := Image1.Picture.Bitmap.Height;
        b1.Canvas.Draw (1,1,Image1.Picture.Bitmap);

//        b1.Assign (Image1.Picture.Bitmap);
        //draw the down border
        case cb2.ItemIndex of
          0 : PaintRgnBorder3 (b1, frh, 5);
          1 : PaintRgnBorder3 (b1, frh, 3);
        end;
{        if not Assigned (RgnMask.BorderDnBmp) then
          RgnMask.CreateBorderDnBmp;}
        RgnMask.BorderDnBmp.Assign (b1);
      finally
        b1.Free;
      end;
    end;

  DeleteObject (b);

  //free old region data - if it exists
  RgnMask.FreeMem;

  i := GetRegionData (frh, 0, nil);
  RgnMask.RegionDataSize := i;

  RgnMask.GetMem;
  RgnMask.GetRegionData (frh);

  RgnMask.BorderBmp.Assign (bmp);

  DeleteObject (frh); //throw away that region
  bmp.Free;
  Progress.Visible := false;
  OKbutton.Enabled := true;
  BuildButton.Enabled := false;
end;

procedure TLMDfrmRegionFromBMPdlg.clKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    #8 : cl.Items.Delete (cl.ItemIndex);
  end;
end;

procedure TLMDfrmRegionFromBMPdlg.clDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
begin
  cl.Canvas.Brush.Color := StringToColor(cl.Items[Index]);
  cl.Canvas.FillRect (Rect);
  DrawText (cl.Canvas.Handle, int_Ref(cl.Items[index]), Length(cl.Items[index]), Rect, DT_CENTER);
end;

procedure TLMDfrmRegionFromBMPdlg.clMeasureItem(Control: TWinControl; Index: Integer;
  var Height: Integer);
begin
  Height := 10;
end;

procedure TLMDfrmRegionFromBMPdlg.CancelButtonClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TLMDfrmRegionFromBMPdlg.FormCreate(Sender: TObject);
begin
  cb.ItemIndex := 0;
  colb.ItemIndex := 0;
  RgnMask := TLMDRegionMask.Create;
  createAllBorders := false;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

procedure TLMDfrmRegionFromBMPdlg.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  cc.Color := Image1.Picture.Bitmap.Canvas.Pixels[X, Y];
  cc.Caption := ColorToString (Image1.Picture.Bitmap.Canvas.Pixels[X, Y]);
end;

procedure TLMDfrmRegionFromBMPdlg.zoomMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  cc.Color := zoom.Canvas.Pixels[X, Y];
  cc.Caption := ColorToString (zoom.Canvas.Pixels[X, Y]);
end;

procedure TLMDfrmRegionFromBMPdlg.zoomMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  i : integer;
begin
  if mbLeft = Button then
    begin
      if cl.Items.Count <> 0 then
        begin
          i := 0;
          while (i < cl.Items.Count) and (cl.Items[i] <> ColorToString (zoom.Canvas.Pixels[x,y])) do
            inc(i);
          if (i = cl.Items.Count) then
            cl.Items.Add (ColorToString (zoom.Canvas.Pixels[x,y]));
        end
      else
        cl.Items.Add (ColorToString (zoom.Canvas.Pixels[x,y]));
      BuildButton.Enabled := true;        
    end;
end;

procedure TLMDfrmRegionFromBMPdlg.clKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 46 then
    cl.Items.Delete (cl.ItemIndex);
end;

procedure TLMDfrmRegionFromBMPdlg.LoadButtonClick(Sender: TObject);
begin
  if openpic.Execute then
    begin
      Image1.Picture.LoadFromFile (openpic.Filename);
      DimLabel.Caption := 'Bitmap size: '+
                          IntToStr (Image1.Picture.Bitmap.Width)+'x'+
                          IntToStr (Image1.Picture.Bitmap.Height);
      BuildButton.Enabled := true;                    
    end;
end;

procedure TLMDfrmRegionFromBMPdlg.OKButtonClick(Sender: TObject);
begin
//  RgnMask.Compressed := ccb.Checked;
  ModalResult := mrOK;
end;

procedure TLMDfrmRegionFromBMPdlg.FormDestroy(Sender: TObject);
begin
  RgnMask.Free;
end;

procedure TLMDfrmRegionFromBMPdlg.ccbChange(Sender: TObject);
begin
  RgnMask.Compressed := ccb.Checked;
end;

procedure TLMDfrmRegionFromBMPdlg.colbChange(Sender: TObject);
begin
  // 7.01 RM
  RgnMask.PixelFormat:=TLMDSavePixelFormat(colb.ItemIndex)
  // ----
end;

procedure TLMDfrmRegionFromBMPdlg.cbChange(Sender: TObject);
begin
  BuildButton.Enabled := true;
end;

end.
 
