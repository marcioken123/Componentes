unit pLMDCPGetMain;
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

LMD-Tools Main Controls Object access methods (RM)
--------------------------------------------------
Impements LMDCPGet[..] methods for objects in Main LMD-Tools controls.

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  RTLConsts, StdCtrls, ExtCtrls, Forms, Windows, Classes, Graphics,
  LMDBase, LMDClass, LMDLED, LMDCustomContainer, LMDCont, LMDDateL, LMDDateTime,
  LMDCustom3DButton, LMDShape, LMDTeeth, LMDSimpleBevel, LMDShapeFill, LMDShadow,
  LMDPointList, LMDCaption, LMDRegionMask, LMDGraph;

  procedure LMDCPGetButtonFace3D(aComponent: TLMDCustom3DButton);
  function LMDCPGetLED(aLed:TLMDLED):Boolean;
  function LMDCPGetLMDCaption(aCaption:TLMDCaption; AllowMultiline:Boolean):Boolean;
  function LMDCPGetShadow(aShadow:TLMDShadow):Boolean;
  function LMDCPGetShape(aShape:TLMDShapeType):TLMDShapeType;
  function LMDCPGetShapeFill(aShapeFill:TLMDShapeFill):Boolean;
  function LMDCPGetSimpleBevel(aSimpleBevel:TLMDSimpleBevel):Boolean;
  function LMDCPGetTeeth(aTeeth:TLMDTeeth):Boolean;
  function LMDCPGetPointList(aValue : TLMDPointList) : boolean;
  function LMDCPGetDateList (aValue : TLMDDateList) : Boolean;
  function LMDCPGetRegionMask (aValue : TLMDRegionMask; border : Boolean) : Boolean;
  function LMDCPGetLightColor(aLightColor:TLMDLightColor):TLMDLightColor;

implementation

uses
  Types, Consts, Messages, Controls, ExtDlgs, Dialogs, SysUtils, Registry,
  LMDProcs, LMDFillObject, LMDGraphUtils,
  pLMDCPGetCore,
  pLMDFillObjectEditorDlg,
  pLMDLEDEditorDlg,
  pLMD3DEffectEditorDlg,
  pLMDShadowEditorDlg,
  pLMDSimpleBevelEditorDlg,
  pLMDTeethEditorDlg,
  pLMDCaptionEditorDlg,
  pLMDShapeEditorDlg,
  pLMDDateListEditorDlg,
  pLMDPointListEditorDlg,
  pLMDBmpRegionEditorDlg,
  pLMDLightEditorDlg;

{ ---------------------------------------------------------------------------- }
procedure LMDCPGetButtonFace3D(aComponent: TLMDCustom3DButton);
var
  Temp,TempUp,TempDown,TempDis, TempUpM, TempDownM, TempDisM: TBitmap;
  aRect: TRect;
  LMD3DEffectEditorDlg:TLMD3DEffectEditorDlg;
begin
  Temp:=nil;
  TempUp:=nil;
  TempDown:=nil;
  TempDis:=nil;

  LMD3DEffectEditorDlg:=TLMD3DEffectEditorDlg.Create(Application);
  try
    Temp:=TBitmap.Create;
    TempUp:=TBitmap.Create;
    TempDown:=TBitmap.Create;
    TempDis:=TBitmap.Create;

    LMD3DEffectEditorDlg.FDialogKind:=aComponent.FKind;
    LMD3DEffectEditorDlg.FColB:=clBlack;
    LMD3DEffectEditorDlg.FColD:=clWhite;
    LMD3DEffectEditorDlg.FColL:=clWhite;
    LMD3DEffectEditorDlg.FColS:=clGray;
    LMD3DEffectEditorDlg.FBevelW:=2;
    LMD3DEffectEditorDlg.FOrig:=Temp;
    LMD3DEffectEditorDlg.FUp:=TempUp;
    LMD3DEffectEditorDlg.FDown:=TempDown;
    LMD3DEffectEditorDlg.FDis:=TempDis;

    LMD3DEffectEditorDlg.ShowModal;
    if LMD3DEffectEditorDlg.ModalResult=mrOK then
      begin
        TempUpM:=TBitmap.Create;
        TempDownM:=TBitmap.Create;
        TempDisM:=TBitmap.Create;
        try
          if tempUp.Empty then exit;
          aRect:=Rect(0,0,TempUp.Width,TempUp.Height);
          Temp.Assign(TempUp);
          LMDBmpCreateMasksExt(Temp.Canvas, aRect, TempUpM, TempUp,
           TempUp.Canvas.Pixels[0,0]);
          Temp.Assign(TempDown);
          LMDBmpCreateMasksExt(Temp.Canvas, aRect, TempDownM, TempDown,
           TempDown.Canvas.Pixels[0,0]);
          Temp.Assign(TempDis);
          LMDBmpCreateMasksExt(Temp.Canvas, aRect, TempDisM, TempDis,
           TempDis.Canvas.Pixels[0,0]);
          aComponent.Width:=TempUp.Width;
          aComponent.Height:=TempUp.Height;

          aComponent.Set3DPics(TempUp, TempDown, TempDis,
           TempUpM, TempDownM, TempDisM);

        finally
          if Assigned (TempUpM) then TempUpM.Destroy;
          if Assigned (TempDownM) then TempDownM.Destroy;
          if Assigned (TempDisM) then TempDisM.Destroy;
        end;
      end;
  finally
    if Assigned (Temp) then Temp.Destroy;
    if Assigned (TempUp) then TempUp.Destroy;
    if Assigned (TempDown) then TempDown.Destroy;
    if Assigned (TempDis) then TempDis.Destroy;
    LMD3DEffectEditorDlg.Destroy;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetLMDCaption(aCaption:TLMDCaption; AllowMultiline:Boolean):Boolean;
var
  cEditor:TLMDCaptionEditorDlg;
begin
  result:=False;
  cEditor := TLMDCaptionEditorDlg.Create(Application);
  with cEditor do
    try
      test.Caption.Assign(aCaption);
      chk.Visible:=AllowMultiLine;
      SetLabels;
      if Showmodal=mrOK then
        begin
          aCaption.Assign(test.Caption);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetLED(aLed:TLMDLED):Boolean;
var
  GEditor: TLMDLEDEditorDlg;
begin
  result:=False;
  GEditor := TLMDLEDEditorDlg.Create(nil);
  with GEditor do
    try
      test.LED.Assign(aLED);
      SetLabels;
      if Showmodal=mrOK then
        begin
          result:=True;
          aLed.Assign(test.Led);
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetShadow(aShadow:TLMDShadow):Boolean;
var
  sEditor:TLMDShadowEditorDlg;
begin
  result:=False;
  sEditor := TLMDShadowEditorDlg.Create(Application);
  with sEditor do
    try
      test.Shadow.Assign(aShadow);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aShadow.Assign(test.Shadow);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetShapeFill(aShapeFill:TLMDShapeFill):Boolean;
var
  sEditor:TLMDFillEditorDlg;
begin
  result:=False;
  sEditor := TLMDFillEditorDlg.Create(Application);
  with sEditor do
    try
      Caption:='ShapeFill-Editor';
      ck1.Visible:=False; ck2.visible:=False; ck3.visible:=False;
      bTest.Visible:=false;
      btnBrush.Visible:=False;
      info.Visible:=True;

      test.FillObject.Assign(aShapeFill);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aShapeFill.Assign(TLMDShapeFill(test.FillObject));
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetShape(aShape:TLMDShapeType):TLMDShapeType;
var
  sEditor:TLMDShapeEditorDlg;
begin
  result:=aShape;
  sEditor := TLMDShapeEditorDlg.Create(Application);
  with sEditor do
    try
      test.Shape:=aShape;
      SetLabels;
      if Showmodal=mrOK then
        result:=test.Shape;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetSimpleBevel(aSimpleBevel:TLMDSimpleBevel):Boolean;
var
  sEditor:TLMDSimpleBevelEditorDlg;
begin
  result:=False;
  sEditor := TLMDSimpleBevelEditorDlg.Create(Application);
  with sEditor do
    try
      test.Bevel.Assign(aSimpleBevel);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aSimpleBevel.Assign(test.Bevel);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetTeeth(aTeeth:TLMDTeeth):Boolean;
var
  tEditor:TLMDTeethEditorDlg;
begin
  result:=False;
  tEditor := TLMDTeethEditorDlg.Create(Application);
  with tEditor do
    try
      test.Teeth.Assign(aTeeth);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aTeeth.Assign(test.Teeth);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetPointList(aValue : TLMDPointList) : boolean;
var
  frmTLMDPointListEditor: TfrmTLMDPointListEditor;
begin
  result := false;
  frmTLMDPointListEditor:= TfrmTLMDPointListEditor.Create(nil);
  try
    frmTLMDPointListEditor.SetPointList (aValue);
    if frmTLMDPointListEditor.ShowModal = mrOk then
      begin
        frmTLMDPointListEditor.GetPointList (aValue);
        result := true;
      end;
  finally
    frmTLMDPointListEditor.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetDateList (aValue : TLMDDateList) : Boolean;
var
  ListEditor: TLMDDateListEditorDlg;
  i : Integer;
  newDate : TLMDDateListRecord;
  s : String;
begin
  result := false;
  ListEditor := TLMDDateListEditorDlg.Create(nil);
  with ListEditor do
    try
      for i := 0 to aValue.Count - 1 do
        DList.Items.Add (DateToStr (aValue.Dates[i].Date) + ';' +
                         TimeToStr (aValue.Dates[i].Date) + ';' +
                         {$IFDEF LMDCOMP12}String{$ENDIF}(aValue.Dates[i].DateString));
      if Showmodal=mrOK then
        begin
          aValue.Clear;
          for i := 0 to DList.Items.Count - 1 do
            begin
              s := DList.Items[i];
              newDate.Date := StrToDate (Copy (s, 1, Pos(';', s) -1));
              Delete (s, 1, Pos(';', s));
              newDate.Date := newDate.Date + StrToTime (Copy (s, 1, Pos(';', s) -1));
              Delete (s, 1, Pos(';', s));
              newDate.DateString := {$IFDEF LMDCOMP12}ShortString{$ENDIF}(s);
              aValue.AddDate (newDate);
            end;
          result := true;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetRegionMask (aValue : TLMDRegionMask; border : boolean) : boolean;
var
  aF:TLMDfrmRegionFromBMPdlg;
begin
  result := false;
  aF:=TLMDfrmRegionFromBMPdlg.Create (Application);
  try
    with aF do
      begin
        if not border then
          begin
            //
            aF.cb.Visible := false;
            aF.cb2.Visible := true;
            aF.createAllBorders := true;
          end;
        RgnMask.Assign (aValue);
        if ShowModal = mrOK then
          begin
            aValue.Assign (RgnMask);
            result := true;
          end;
      end;
  finally
    aF.Free;
  end;
end;

{********************* Class TLMDLightColorProperty ***************************}
function LMDCPGetLightColor(aLightColor:TLMDLightColor):TLMDLightColor;
var
  lEditor:TLMDLightEditorDlg;
begin
  result:=aLightColor;
  lEditor := TLMDLightEditorDlg.Create(nil);
  with lEditor do
    try
      test.LightColor:=aLightColor;
      SetLabels;
      if Showmodal=mrOK then
        result:=test.LightColor;
    finally
      Free;
    end;
end;

end.
