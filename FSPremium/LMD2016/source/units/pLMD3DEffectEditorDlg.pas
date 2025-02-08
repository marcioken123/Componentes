unit pLMD3DEffectEditorDlg;
{$I lmdcmps.inc}

interface

uses
  Windows, Classes, Graphics, Forms, Controls, Dialogs,
  Buttons, StdCtrls, ExtCtrls,
  LMDClass, LMDTypes, LMDGraph, LMDProcs, LMDBaseGraphicControl,
  LMDGraphicControl, LMDCustom3DButton, LMDColorComboBox, LMDProgress, LMDCustomButton,
  LMDCustomColorComboBox, LMDBaseMeter, LMDCustomProgress, LMDCaption,
  LMDDockButton, LMDCustomComponent, LMDCustomComboBox, LMDThemes,
  LMDButton, LMDCustomControl, LMDCustomPanel, LMDCustomBevelPanel,
  LMDBaseEdit, LMDCustomEdit, LMDCustomMaskEdit, LMDCustomExtSpinEdit,
  LMDSpinEdit, LMDControl, LMDBaseControl, LMDThemedComboBox;

type

  TLMD3DEffectEditorDlg = class(TForm)
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label4: TLabel;
    spind: TLMDSpinEdit;
    Label5: TLabel;
    BtnImg: TImage;
    Bevel3: TBevel;
    Label3: TLabel;
    cmbB: TLMDColorComboBox;
    Label1: TLabel;
    cmbD: TLMDColorComboBox;
    Label2: TLabel;
    cmbL: TLMDColorComboBox;
    Label6: TLabel;
    cmbS: TLMDColorComboBox;
    lmdprog: TLMDProgress;
    cmbState: TComboBox;
    dlgb: TLMDDockButton;
    dlgd: TLMDDockButton;
    dlgl: TLMDDockButton;
    dlgs: TLMDDockButton;
    EXECUTE: TLMDButton;
    STOP: TLMDButton;
    Ok: TLMDButton;
    LMDButton4: TLMDButton;
    btngetpic: TLMDButton;
    btngetcap: TLMDButton;
    procedure resetClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cmbBChange(Sender: TObject);
    procedure spindChange(Sender: TObject);
    procedure dlgBClick(Sender: TObject);
    procedure btngetpicClick(Sender: TObject);
    procedure EXECUTEClick(Sender: TObject);
    procedure STOPClick(Sender: TObject);
    procedure cmbStateChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FShow:Boolean;
  public
    FColB, FColD, FColL, FColS: TColor;
    FBevelW: TLMD3DButtonBevelWidth;
    FOrig, FUp, FDown, FDis: TBitmap;
    FCaption: TLMDCaption;
    FDialogKind: integer;
    Procedure SetLabels;
  end;

var
  FDoTerminate:Boolean;

  procedure LMDDrawCaptionFace(aCaption: TLMDCaption; aBmp: TBitmap);
  function LMDDrawButton3D(const ASrcBitmap: TBitmap;
           AnUpBitmap, ADownBitmap, ADisabledBitmap: TBitmap;
           TransparentCl, LightCl, ShadowCl, DisabledCl,
           OpaqueGlassColor, TransparentGlassColor,
           BevelCl
           : TColor;
           OpaqueGlass:Boolean;
           BevelWidth: Integer;
           aProgBar: TLMDProgress): Boolean;

  function LMDMakeBmpSemiTransparent(ADestBitmap: TBitmap;
           TranspCol, SemiTranspCol, ShadowCol: TColor): Boolean;

implementation

uses
  Types, TypInfo, SysUtils,
  pLMDCommon, pLMDCPGetCore, pLMDCPGetMain, LMDGraphUtils;

{$R *.DFM}

{********************* Class TLMDShadowEditorDlg ***************************}
{------------------------- Private---------------------------------------------}
procedure TLMD3DEffectEditorDlg.FormActivate(Sender: TObject);
begin
  if not FShow then FShow:=true;
  cmbB.SelectedColor:=FColB;
  cmbD.SelectedColor:=FColD;
  cmbL.SelectedColor:=FColL;
  cmbS.SelectedColor:=FColS;
  spind.MaxValue:=5;
  if FBevelW>5 then FBevelW:=5;
  spind.Value:=FBevelW;
  if not FOrig.Empty then BtnImg.Picture.Bitmap.assign(FOrig);
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.FormCreate(Sender: TObject);
begin
  LMDComLoadDelphiCustomColor(cmbB.CustomColors);
  LMDComLoadDelphiCustomColor(cmbD.CustomColors);
  LMDComLoadDelphiCustomColor(cmbL.CustomColors);
  LMDComLoadDelphiCustomColor(cmbS.CustomColors);
  FShow:=False;
  FCaption:=TLMDCaption.Create;
  {$IFDEF LMDCOMP11}LMDSetThemeMode(self, ttmPlatform);{$ENDIF}
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.resetClick(Sender: TObject);
{var
  b:TLMDShadow;}
begin
{  b:=TLMDShadow.Create;
  test.Shadow.Assign(b);
  b.Free;
  SetLabels;}
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LMDComSaveDelphiCustomColor(cmbB.CustomColors);
  LMDComSaveDelphiCustomColor(cmbD.CustomColors);
  LMDComSaveDelphiCustomColor(cmbL.CustomColors);
  LMDComSaveDelphiCustomColor(cmbS.CustomColors);
end;

{------------------------------------------------------------------------------}
Procedure TLMD3DEffectEditorDlg.SetLabels;
begin
  (*With Test.Shadow do
    begin
      {Style}
      cmbstyle.ItemIndex:=Ord(Style);
      {Color}
      cmbS.SelectedColor:=Color;
      {Depth}
      spind.Value:=Depth;
    end;*)
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.cmbBChange(Sender: TObject);
begin
  {test.Shadow.Color:=cmbS.SelectedColor;
  If FShow then SetLabels;}
  if Sender=cmbB then
    FColB:=cmbB.SelectedColor
  else if Sender=cmbD then
    FColD:=cmbD.SelectedColor
  else if Sender=cmbL then
    FColL:=cmbL.SelectedColor
  else
    FColS:=cmbS.SelectedColor;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.spindChange(Sender: TObject);
begin
  {test.Shadow.Depth:=TLMDShadowDepth(spind.value);
  If FShow then SetLabels;}
  FBevelW:=spind.AsInteger;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.dlgBClick(Sender: TObject);
begin
  if Sender=dlgB then
    cmbB.Execute
  else if Sender=dlgD then
    cmbD.Execute
  else if Sender=dlgL then
    cmbL.Execute
  else
    cmbS.Execute;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.btngetpicClick(Sender: TObject);
var
  b: Boolean;
begin
  b:=False;
  if Sender=btngetcap then if LMDCPGetLMDCaption(FCaption, false) then
    if FCaption.Caption<>'' then
      begin
        EXECUTE.enabled:=True;
        LMDDrawCaptionFace(FCaption, FOrig);
        b:=True;
      end;
  if Sender=btngetpic then if LMDCPGetBitmap(FOrig) then
    begin
      EXECUTE.enabled:=True;
      b:=True;
    end;

  if b then
    begin
      cmbState.Text:='Original';
      BtnImg.Picture.Bitmap.Assign(FOrig);
      Ok.enabled:=False;
      cmbState.enabled:=False;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.EXECUTEClick(Sender: TObject);
begin
  EXECUTE.enabled:=False;
  STOP.enabled:=True;
  FDoTerminate:=False;
  Caption:='Please wait - effect is being generated...';
  LMDDrawButton3D(FOrig, FUp, FDown, FDis,
           FOrig.Canvas.Pixels[0,FOrig.Height-1], FColL, FColS, FColD,
           clNone, clNone, FColB, False,
           FBevelW, LMDProg);
  if not FDoTerminate then
    begin
      cmbState.Text:='Up';
      BtnImg.Picture.Bitmap.Assign(FUp);
      OK.enabled:=True;
      cmbState.enabled:=True;
    end
  else
    begin
      cmbState.Text:='Original';
      BtnImg.Picture.Bitmap.Assign(FOrig);
      OK.enabled:=False;
      cmbState.enabled:=False;
    end;
  Caption:='3DEffect-Editor';
  LMDProg.Position:=0;
  FDoTerminate:=False;
  STOP.enabled:=False;
  EXECUTE.enabled:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.STOPClick(Sender: TObject);
begin
  FDoTerminate:=True;
end;

{------------------------------------------------------------------------------}
procedure TLMD3DEffectEditorDlg.cmbStateChange(Sender: TObject);
begin
  if cmbState.Text='Up' then
    BtnImg.Picture.Bitmap.Assign(FUp)
  else if cmbState.Text='Down' then
    BtnImg.Picture.Bitmap.Assign(FDown)
  else if cmbState.Text='Disabled' then
    BtnImg.Picture.Bitmap.Assign(FDis)
  else if cmbState.Text='Original' then
    BtnImg.Picture.Bitmap.Assign(FOrig);

end;

{------------------------------------------------------------------------------}
procedure LMDDrawCaptionFace(aCaption: TLMDCaption; aBmp: TBitmap);
var
  aRect: TRect;
  Flags: Word;
begin
   aRect:=Rect(0,0,0,0);
   with aBmp, aCaption do
     begin
       LMDDrawTextCalcExt(aBmp.Canvas, aCaption.Caption,
         aCaption.FontFx, aRect, aCaption.Font,
         MultiLine, True, 0,0);
     end;
   with aBmp do
     begin
       Width:=aRect.Right;
       Height:=aRect.Bottom;
       Canvas.Brush.Color:=clSilver;
       Canvas.FillRect(Rect(0,0,Width,Height));
       Canvas.Brush.Color:=clSilver;
       Canvas.Font:=aCaption.Font;

       OffsetRect(aRect,-aRect.Left,-aRect.Top);

       {Flags for DrawText}
       flags:=DT_EXPANDTABS or DT_WORDBREAK or TLMDAlignFlags[aCaption.Alignment];
       if (not aCaption.MultiLine) or {(}(aCaption.FontFx.Angle<>0){ or
          not (aCaption.Alignment in [agTopLeft, agTopCenter, agTopRight]))} then
          flags:=flags or DT_SINGLELINE;

       if (aCaption.FontFx.Angle>0) then Flags:=Flags or DT_NOPREFIX;

       LMDDrawTextExt(Canvas, aCaption.Caption, aCaption.FontFx, aRect,
                      Flags, [TLMDDrawTextStyle(dtEnabled), dtClip], @aRect);

     end;

end;

{---------------------- LMDDrawButton3D ---------------------------------------}
{------------------------------------------------------------------------------}
function LMDDrawButton3D(const ASrcBitmap: TBitmap;
         AnUpBitmap, ADownBitmap, ADisabledBitmap: TBitmap;
         TransparentCl, LightCl, ShadowCl, DisabledCl,
         OpaqueGlassColor, TransparentGlassColor,
         BevelCl
         : TColor;
         OpaqueGlass:Boolean;
         BevelWidth: Integer;
         aProgBar: TLMDProgress): Boolean;
var
  Xtra, TempSrcBmp, TempUpBmp, TempDownBmp, TempDisBmp, CopyBmp: TBitmap;
  Prog: Boolean;
  Perc, TempPerc, ActBevel: integer;
  LineX,LineY: integer;
  ActXYCol: TColor;
begin

  Prog:=false;
  TempPerc:=0;
  Perc:=TempPerc;
  if assigned(aProgBar) then Prog:=true;

  {-copy source into an often used bitmap-------------}
  TempSrcBmp:=TBitmap.Create;
  TempSrcBmp.Assign(ASrcBitmap);

  {-íf OpaqueGlass-effect is demanded, it will be executed NOW!}
  if OpaqueGlass=True then
    begin
      LMDMakeBmpSemiTransparent(TempSrcBmp,
        TransparentCl, TransparentGlassColor, OpaqueGlassColor);
    end;

  {-create tempBitmaps being big enough---------------}
  Xtra:=TBitmap.Create;
  TempUpBmp:=TBitmap.Create;
  TempDownBmp:=TBitmap.Create;
  TempDisBmp:=TBitmap.Create;
  CopyBmp:=TBitmap.Create;
  Xtra.Assign(TempSrcBmp);
  TempUpBmp.Assign(TempSrcBmp);
  TempDownBmp.Assign(TempSrcBmp);

  {-creating ...}
  Xtra.Width:=TempSrcBmp.Width+2*(BevelWidth);
  Xtra.Height:=TempSrcBmp.Height+2*(BevelWidth);
  Xtra.Canvas.Pen.Color:=TransparentCl;
  Xtra.Canvas.Pen.Width:=BevelWidth+1;
  with Xtra do Canvas.Rectangle(0,0,Width,Height);
  Xtra.Canvas.Draw(BevelWidth,BevelWidth,TempSrcBmp);
  {:)}
  TempUpBmp.Width:=TempSrcBmp.Width+2*(BevelWidth);
  TempUpBmp.Height:=TempSrcBmp.Height+2*(BevelWidth);
  TempUpBmp.Canvas.Brush.Color:=TransparentCl;
  TempUpBmp.Canvas.Pen.Color:=TransparentCl;
  {TempUpBmp.Canvas.Pen.Width:=BevelWidth+1;}
  with TempUpBmp do Canvas.Rectangle(0,0,Width,Height);
  TempUpBmp.Canvas.Draw(BevelWidth,BevelWidth,TempSrcBmp);
  {:)}
  TempDownBmp.Width:=TempSrcBmp.Width+2*(BevelWidth);
  TempDownBmp.Height:=TempSrcBmp.Height+2*(BevelWidth);
  TempDownBmp.Canvas.Brush.Color:=TransparentCl;
  TempDownBmp.Canvas.Pen.Color:=TransparentCl;
  with TempDownBmp do Canvas.Rectangle(0,0,Width,Height);
  TempDownBmp.Canvas.Draw(BevelWidth+1,BevelWidth+1,TempSrcBmp);

  {-...copying}
  {TempDownBmp.Assign(TempUpBmp);}
  TempDisBmp.Assign(TempUpBmp);

  {BevelWidth+1 for the Bevel in Up,Disabled}
  for ActBevel:=1 to BevelWidth+2 do
    begin
      {if ActBevel=1 then CopyBmp.Assign(Xtra) else }CopyBmp.Assign(TempUpBmp);

      with CopyBmp do

        for LineY:=0 to Height-1 do
          for LineX:=0 to Width-1 do
            begin
              {remind TColor}
              ActXYCol:=Canvas.Pixels[LineX,LineY];

    {------------------for Button-Up,-Down,-Disabled---------------}
              if ActXYCol<>TransparentCl then
                begin
        {-------UP:shadow - Algorithms----------------------------------------}

                {*Algorithm 1}

                  if (LineX<Width) and (LineY<Height) and (ActBevel<BevelWidth+2) then
                    begin
                      if Canvas.Pixels[LineX,LineY+1]=TransparentCl then
                        if Canvas.Pixels[LineX-1,LineY+1]=TransparentCl then
                          if ActBevel<BevelWidth+1 then
                          {Schatten für Up, Licht für Down, Umrandung if =BevelWidth+1}
                            begin
                              TempUpBmp.Canvas.Pixels[LineX-1,LineY+1]:=ShadowCl;
                              TempDisBmp.Canvas.Pixels[LineX-1,LineY+1]:=ShadowCl;
                              TempDownBmp.Canvas.Pixels[LineX,LineY+2]:=LightCl;
                            end
                          else
                            begin
                              TempUpBmp.Canvas.Pixels[LineX-1,LineY+1]:=BevelCl;
                              TempDisBmp.Canvas.Pixels[LineX-1,LineY+1]:=BevelCl;
                            end;

                  {*Algorithm 6}

                      if Canvas.Pixels[LineX-1,LineY]<>TransparentCl then
                        if Canvas.Pixels[LineX,LineY-1]<>TransparentCl then
                          if Canvas.Pixels[LineX+1,LineY+1]=TransparentCl then
                            if Canvas.Pixels[LineX,LineY+1]=TransparentCl then
                              if Canvas.Pixels[LineX+1,LineY]=TransparentCl then
                                if ActBevel<BevelWidth+1 then
                                  begin
                                    TempUpBmp.Canvas.Pixels[LineX+1,LineY+1]:=ShadowCl;
                                    TempUpBmp.Canvas.Pixels[LineX,LineY+1]:=ShadowCl;
                                    TempUpBmp.Canvas.Pixels[LineX+1,LineY]:=ShadowCl;
                                    TempDisBmp.Canvas.Pixels[LineX+1,LineY+1]:=ShadowCl;
                                    TempDisBmp.Canvas.Pixels[LineX,LineY+1]:=ShadowCl;
                                    TempDisBmp.Canvas.Pixels[LineX+1,LineY]:=ShadowCl;
                                    TempDownBmp.Canvas.Pixels[LineX+2,LineY+2]:=LightCl;
                                    TempDownBmp.Canvas.Pixels[LineX+1,LineY+2]:=LightCl;
                                    TempDownBmp.Canvas.Pixels[LineX+2,LineY+1]:=LightCl;
                                  end
                                else
                                  begin
                                    TempUpBmp.Canvas.Pixels[LineX+1,LineY+1]:=BevelCl;
                                    TempUpBmp.Canvas.Pixels[LineX,LineY+1]:=BevelCl;
                                    TempUpBmp.Canvas.Pixels[LineX+1,LineY]:=BevelCl;
                                    TempDisBmp.Canvas.Pixels[LineX+1,LineY+1]:=BevelCl;
                                    TempDisBmp.Canvas.Pixels[LineX,LineY+1]:=BevelCl;
                                    TempDisBmp.Canvas.Pixels[LineX+1,LineY]:=BevelCl;
                                  end;

                  {*Algorithm 2}

                      if Canvas.Pixels[LineX+1,LineY]=TransparentCl then
                        if Canvas.Pixels[LineX+1,LineY-1]=TransparentCl then
                          if ActBevel<BevelWidth+1 then
                            begin
                              TempUpBmp.Canvas.Pixels[LineX+1,LineY-1]:=ShadowCl;
                              TempDisBmp.Canvas.Pixels[LineX+1,LineY-1]:=ShadowCl;
                              TempDownBmp.Canvas.Pixels[LineX+2,LineY]:=LightCl;
                            end
                          else
                            begin
                              TempUpBmp.Canvas.Pixels[LineX+1,LineY-1]:=BevelCl;
                              TempDisBmp.Canvas.Pixels[LineX+1,LineY-1]:=BevelCl;
                            end;

                  end;{if (LineX<Width) and (LineY<Height) and (ActBevel<BevelWidth+2) then}

        {-------UP:light - Algorithms------------------------------------------}

                {*Algorithm 10}

                  if (LineY>0) then
                    if (Canvas.Pixels[LineX,LineY-1]=TransparentCl) and not
                    ((OpaqueGlass) and (ASrcBitmap.Canvas.Pixels[LineX-
                      BevelWidth,LineY-BevelWidth-1]=TransparentGlassColor)) then
                        if ActBevel<BevelWidth+1 then
                          begin
                            TempUpBmp.Canvas.Pixels[LineX,LineY-1]:=LightCl;
                            TempDisBmp.Canvas.Pixels[LineX,LineY-1]:=LightCl;
                            TempDownBmp.Canvas.Pixels[LineX+1,LineY]:=ShadowCl;
                          end
                        else
                          if ActBevel<BevelWidth+2 then
                            begin
                              TempUpBmp.Canvas.Pixels[LineX,LineY-1]:=BevelCl;
                              TempDisBmp.Canvas.Pixels[LineX,LineY-1]:=BevelCl;
                              TempDownBmp.Canvas.Pixels[LineX+1,LineY]:=BevelCl;{++}
                            end
                          else
                            TempDownBmp.Canvas.Pixels[LineX,LineY]:=BevelCl;{++}

                {*Algorithm 11}

                  if (LineX>0) then
                    if (Canvas.Pixels[LineX-1,LineY]=TransparentCl) and not
                    ((OpaqueGlass) and (ASrcBitmap.Canvas.Pixels[LineX-
                      BevelWidth-1,LineY-BevelWidth]=TransparentGlassColor)) then
                      if ActBevel<BevelWidth+1 then
                        begin
                          TempUpBmp.Canvas.Pixels[LineX-1,LineY]:=LightCl;
                          TempDisBmp.Canvas.Pixels[LineX-1,LineY]:=LightCl;
                          TempDownBmp.Canvas.Pixels[LineX,LineY+1]:=ShadowCl;
                        end
                      else
                        if ActBevel<BevelWidth+2 then
                          begin
                            TempUpBmp.Canvas.Pixels[LineX-1,LineY]:=BevelCl;
                            TempDisBmp.Canvas.Pixels[LineX-1,LineY]:=BevelCl;
                            TempDownBmp.Canvas.Pixels[LineX,LineY+1]:=BevelCl;{++}
                          end
                        else
                          TempDownBmp.Canvas.Pixels[LineX,LineY]:=BevelCl;{++*}

                {*Algorithm 7}

                  if (LineX>0) and (LineY>0) then
                    if Canvas.Pixels[LineX+1,LineY]<>TransparentCl then
                      if Canvas.Pixels[LineX,LineY+1]<>TransparentCl then
                        if Canvas.Pixels[LineX-1,LineY-1]=TransparentCl then
                          if Canvas.Pixels[LineX,LineY-1]=TransparentCl then
                            if Canvas.Pixels[LineX-1,LineY]=TransparentCl then
                              if ActBevel<BevelWidth+1 then
                                begin
                                  TempUpBmp.Canvas.Pixels[LineX-1,LineY-1]:=LightCl;
                                  TempUpBmp.Canvas.Pixels[LineX,LineY-1]:=LightCl;
                                  TempUpBmp.Canvas.Pixels[LineX-1,LineY]:=LightCl;
                                  TempDisBmp.Canvas.Pixels[LineX-1,LineY-1]:=LightCl;
                                  TempDisBmp.Canvas.Pixels[LineX,LineY-1]:=LightCl;
                                  TempDisBmp.Canvas.Pixels[LineX-1,LineY]:=LightCl;
                                  TempDownBmp.Canvas.Pixels[LineX,LineY]:=ShadowCl;
                                  TempDownBmp.Canvas.Pixels[LineX+1,LineY]:=ShadowCl;
                                  TempDownBmp.Canvas.Pixels[LineX,LineY+1]:=ShadowCl;
                                end
                              else
                                if ActBevel<BevelWidth+2 then
                                  begin
                                    TempUpBmp.Canvas.Pixels[LineX-1,LineY-1]:=BevelCl;
                                    TempUpBmp.Canvas.Pixels[LineX,LineY-1]:=BevelCl;
                                    TempUpBmp.Canvas.Pixels[LineX-1,LineY]:=BevelCl;
                                    TempDisBmp.Canvas.Pixels[LineX-1,LineY-1]:=BevelCl;
                                    TempDisBmp.Canvas.Pixels[LineX,LineY-1]:=BevelCl;
                                    TempDisBmp.Canvas.Pixels[LineX-1,LineY]:=BevelCl;
                                    TempDownBmp.Canvas.Pixels[LineX,LineY]:=BevelCl;{++}
                                    TempDownBmp.Canvas.Pixels[LineX+1,LineY]:=BevelCl;{++}
                                    TempDownBmp.Canvas.Pixels[LineX,LineY+1]:=BevelCl;{++}
                                  end
                                else
                                  begin
                                    TempDownBmp.Canvas.Pixels[LineX,LineY]:=BevelCl;{++}
                                    TempDownBmp.Canvas.Pixels[LineX+1,LineY]:=BevelCl;{++}
                                    TempDownBmp.Canvas.Pixels[LineX,LineY+1]:=BevelCl;{++}
                                  end;

    {---------------------------------------------------------------}

    {------------------ Button-Disabled?----------------------------}
                if ActBevel=1 then
                  if (LineX Mod 2=0) xor (LineY Mod 2=0) then
                    TempDisBmp.Canvas.Pixels[LineX,LineY]:=DisabledCl;
    {---------------------------------------------------------------}
              end;{if ActXYCol<>TransparentCl then}

            if Prog then
              begin
                Application.ProcessMessages;
                if FDoTerminate then
                  begin
                    Xtra.Free;  TempSrcBmp.Free;  TempUpBmp.Free;
                    TempDownBmp.Free;  TempDisBmp.Free;  CopyBmp.Free;
                    exit;
                  end;

                TempPerc:=Round( (  (((ActBevel-1)*Height)+LineY)  /
                  ((BevelWidth+2)*Height) )*100);

                if Perc<>TempPerc then
                  begin
                    Perc:=TempPerc;
                    aProgBar.Position:=TLMDPercent(Perc);
                  end;
              end;

            end;{for LineX,Y}

    if ActBevel<BevelWidth+2 then
      TempSrcBmp.Assign(TempUpBmp)
    else
      begin
        AnUpBitmap.Assign(TempUpBmp);
        ADownBitmap.Assign(TempDownBmp);
        ADisabledBitmap.Assign(TempDisBmp);

        Xtra.Free;
        TempSrcBmp.Free;
        TempUpBmp.Free;
        TempDownBmp.Free;
        TempDisBmp.Free;
        CopyBmp.Free;

      end;

  end;{BevelWidth}

end;{fct}

{------------------------------------------------------------------------------}
function LMDMakeBmpSemiTransparent(ADestBitmap: TBitmap;
         TranspCol, SemiTranspCol, ShadowCol: TColor): Boolean;
var
  WorkBmp, CopyBmp: TBitmap;
  LineX,LineY: integer;
begin
  Result:=True;
  WorkBmp:=TBitmap.Create;
  CopyBmp:=TBitmap.Create;
{-copy bitmap---------------}

  WorkBmp.Width:=ADestBitmap.Width;
  WorkBmp.Height:=ADestBitmap.Height;
  WorkBmp.Canvas.Pen.Color:=TranspCol;
  WorkBmp.Canvas.Draw(0,0,ADestBitmap);

  CopyBmp.Assign(WorkBmp);

  for LineY:=0 to CopyBmp.Height-1 do
    for LineX:=0 to CopyBmp.Width-1 do
      with CopyBmp do
      begin
        if Canvas.Pixels[LineX,LineY]=SemiTranspCol then
          if (LineX Mod 2=0) xor (LineY Mod 2=0) then
            WorkBmp.Canvas.Pixels[LineX,LineY]:=TranspCol
          else
            WorkBmp.Canvas.Pixels[LineX,LineY]:=ShadowCol
      end;

  {-wipe temp bitmaps---------------}
  ADestBitmap.assign(WorkBmp);
  WorkBmp.Free;
  CopyBmp.Free;
end;

procedure TLMD3DEffectEditorDlg.FormDestroy(Sender: TObject);
begin
  if FCaption<>nil then FCaption.Free;
end;

initialization
  FDoTerminate:=False;

end.

 
