unit pLMDCPGetCore;
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

LMD-Tools Core Controls Object access methods (RM)
--------------------------------------------------
Impements LMDCPGet[..] methods for most used common objects in LMD-Tools.

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  RTLConsts, StdCtrls, ExtCtrls, Forms, Windows, Classes, Graphics,
  LMDBase, LMDClass, LMDButton, LMDWave, LMDCustomContainer, LMDCont,
  LMDFillObject, LMDGradient, LMDShadow,
  LMDGlyphTextLayout, LMDButtonLayout, LMDTransparent, LMDBevel,
  LMD3DCaption, LMDFXCaption, LMDBitmapEffectObject, LMDCaption,
  LMDSmallBar, LMDGraph;

  function LMDCPGetDateTimeFormat (var format : String):Boolean;

  // from LMDUtils
  procedure LMDComLoadCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
  procedure LMDComSaveCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);

  // 28-12-2001 -> see LMDCPGetStrings with Code-Editor support in pLMDDsgnCPGetCore.pas
  function LMDCPGetStrings(aList:TStrings):Boolean; overload;
  // ---
  function LMDCPGetBevel(aBevel:TLMDBevel):Boolean;
  function LMDCPGetBitmap(aBitmap:TBitmap):Boolean;
  function LMDCPGetBitmapEffectObject(aBitmapObject:TLMDBitmapEffectObject):Boolean;
  function LMDCPGetBitmapStyle(aBitmapStyle:TLMDBitmapStyle):TLMDBitmapStyle;
  function LMDCPGetButtonLayout(aLayout:TLMDButtonLayout):Boolean;
  function LMDCPGetGlyphTextLayout(aLayout:TLMDGlyphTextLayout):Boolean;
//  function LMDCPGetCaption(const aValue:String; aMaxLength:Integer):String;
  function LMDCPGetHTMLString(var Value:TLMDHTMLString):Boolean;
  function LMDCPGetColor(aColor:TColor;aStrings:TStrings=nil):TColor;
  function LMDCPGetFillObject(aFillObject:TLMDFillObject):Boolean;
  function LMDCPGetFont(aFont:TFont):Boolean;
  function LMDCPGetFont3D(aFont3D:TLMD3DCaption):Boolean;
  function LMDCPGetFontFx(aFontFx:TLMDFxCaption):Boolean;
  function LMDCPGetGradient(aGradient:TLMDGradient):Boolean;
  //function LMDCPGetLMDCaption(aCaption:TLMDCaption; AllowMultiline:Boolean):Boolean;
  //function LMDCPGetShadow(aShadow:TLMDShadow):Boolean;
  function LMDCPGetSmallBar(aSmBarOptions:TLMDSmallBar):Boolean;
  function LMDCPGetTransparent(aTransparent:TLMDTransparent):Boolean;

  function LMDCPGetSettingEditor(aObject:TPersistent):Boolean;

implementation

uses
  Consts, Messages, Controls, ExtDlgs, Dialogs, SysUtils, Inifiles, Registry, Types,
  LMDUtils, LMDHTMLLabel,
  LMDCustomCheckListDlg,
  pLMDComBrushDlg,
  pLMDBitmapEffectEditorDlg,
  pLMDBevelEditorDlg,
  pLMDButtonLayoutEditorDlg,
  pLMDDateTimeFormatEditorDlg,
  pLMDGradientEditorDlg,
  pLMDFontFXEditorDlg,
  pLMDTransparentEditorDlg,
  pLMDSmallBarEditorDlg,
  pLMDStringsEditorDlg,
  pLMDFillObjectEditorDlg,
  pLMDBitmapStyleEditorDlg,
  pLMDGlyphTextLayoutEditorDlg,
  pLMDMaskEditorDlg,
  LMDCFCSettingObject,
  pLMDHTMLEditDlg;

{ ---------------------------------------------------------------------------- }
function LMDCPGetDateTimeFormat (var format : String) : boolean;
var
  EditDialog:TLMDfrmDateTimePropertyEditor;
begin
  result := false;
  EditDialog:=TLMDfrmDateTimePropertyEditor.Create(Application);
  with EditDialog do
    try
      SetFormat(format);
      if showModal = mrOk then
        begin
          format := Edit1.Text;
          result := true;
        end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure LMDComLoadCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
begin
  if (inifile=nil) or not ((inifile is TIniFile) or
                          (inifile is TRegIniFile)) then exit;
  aList.Clear;
  if iniFile is TRegIniFile then
    TRegIniFile(IniFile).ReadSectionValues(Section, aList)
  else
    TIniFile(IniFile).ReadSectionValues(Section, aList);
end;

{------------------------------------------------------------------------------}
procedure LMDComSaveCustomColorList(IniFile:TObject; const Section:String; aList:TStrings);
var
   i,j:integer;
   colorstr:string;

begin
  if (inifile=nil) or not ((inifile is TIniFile) or
                          (inifile is TRegIniFile)) then exit;
  for i:=0 to aList.Count-1 do
    begin
      colorstr:=aList.Strings[I];
      j:=Pos('=', colorstr);
      if j<>0 then
        begin
          colorstr:=copy(colorstr,1,j-1);
          if inifile is TREGIniFile then
            TRegIniFile(IniFile).WriteString(Section, colorstr, aList.Values[colorstr])
          else
            TIniFile(IniFile).WriteString(Section, colorstr, aList.Values[colorstr]);
        end;
    end;
end;

function LMDCPGetBitmap(aBitmap:TBitmap):Boolean;
var
  ImageEditor: TOpenPictureDialog;
begin
  result:=False;
  ImageEditor := TOpenPictureDialog.Create(nil);
  with ImageEditor do
    try
      DefaultExt := GraphicExtension(TBitmap);
      FileName:='*.'+DefaultExt;
      Filter := GraphicFilter(TBitmap);
      if Execute then
        begin
           aBitmap.LoadFromFile(FileName);
           result:=True;
        end;
    finally
      ImageEditor.Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetBitmapEffectObject(aBitmapObject:TLMDBitmapEffectObject):Boolean;
var
  bEditor: TLMDBitmapEffectEditorDlg;
begin
  result:=False;
  bEditor := TLMDBitmapEffectEditorDlg.Create(Application);
  with bEditor do
    try
      test.BackFx.Assign(aBitmapObject);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aBitmapObject.Assign(test.BackFx);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetColor(aColor:TColor; aStrings:TStrings=nil):TColor;
var
  ColorDlg: TColorDialog;
begin
  result:=aColor;
  ColorDlg := TColorDialog.Create(nil);
  with ColorDlg do
    try
      if Assigned(aStrings) then
        CustomColors.Assign(aStrings);
      Color:=aColor;
      if Execute then
        begin
          result:=Color;
          if Assigned(aStrings) then
            aStrings.Assign(CustomColors);
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetHTMLString(var Value:TLMDHTMLString):Boolean;
begin
  result:=false;
  with TfrmLMDMiniHTMLEditor.Create(Application) do
     try
       HTMLEdit.Text:=Value;
       SetViewControlClass(TLMDHTMLLabel);
       if ShowModal=mrok then
         begin
           Value:=HTMLEdit.Text;
           result:=True;
         end;
     finally
       Release;
     end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetFont(aFont:TFont):Boolean;
var
  FontDlg: TFontDialog;
begin
  FontDlg := TFontDialog.Create(nil);
  with FontDlg do
    try
      Font:=aFont;
      HelpContext:=25000;
      Options:=Options+[fdShowHelp, fdForceFontExist];
      result:=Execute;
      if result then aFont.Assign(Font);
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetStrings(aList:TStrings):Boolean;
var
  FEditor: TLMDfrmStringEditor;
begin
  result:=False;
  FEditor:=TLMDfrmStringEditor.Create(nil);
  with FEditor do
    try
      LMDButton2.Visible:=False;
      tools.Left:=110;
      StrList.Lines.Assign(TStrings(aList));
      if Showmodal=mrOK then
        begin
          aList.Assign(TStrings(StrList.Lines));
          result:=True
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetFont3D(aFont3D:TLMD3DCaption):Boolean;
var
  FEditor: TLMDFxEditorDlg;
begin
  result:=False;
  FEditor:=TLMDFxEditorDlg.Create(Application);
  with FEditor do
    try
      Test.FontFx.Assign(aFont3D);
      Caption:='3DCaption-Editor';
      rt.Visible:=False;
      AngleV.Visible:=False;
      SetLabels;
      if Showmodal=mrOK then
        begin
          aFont3D.Assign(TLMD3DCaption(Test.FontFx));
          result:=True
        end;
    finally
      Release;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetGlyphTextLayout(aLayout:TLMDGlyphTextLayout):Boolean;
var
  FEditor: TLMDGlyphTextLayoutEditorDlg;
begin
  result:=False;
  FEditor:=TLMDGlyphTextLayoutEditorDlg.Create(nil);
  with FEditor do
    try
      Test.ButtonLayout.Assign (aLayout);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aLayout.Alignment := Test.ButtonLayout.Alignment;
          aLayout.OffsetX := Test.ButtonLayout.OffsetX;
          aLayout.OffsetY := Test.ButtonLayout.OffsetY;
          aLayout.Spacing := Test.ButtonLayout.Spacing;
          aLayout.AlignText2Glyph := Test.ButtonLayout.AlignText2Glyph;
          result:=True
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetBevel(aBevel:TLMDBevel):Boolean;
var
  BevelEditor: TLMDBevelEditorDlg;
begin
  result:=False;
  BevelEditor := TLMDBevelEditorDlg.Create(Application);
  with BevelEditor do
    try
      test.Bevel.Assign(aBevel);
      case aBevel.Mode of
       bmStandard : begin nb.ActivePage:=nb.Pages[0]; end;
       bmCustom : begin nb.ActivePage:=nb.Pages[1]; end;
       bmEdge   : begin nb.ActivePage:=nb.Pages[2]; end;
       bmWindows: begin nb.ActivePage:=nb.Pages[3]; end;
      end;
      SetLabels;
      if Showmodal=mrOK then
        begin
          aBevel.Assign(test.Bevel);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetBitmapStyle(aBitmapStyle:TLMDBitmapStyle):TLMDBitmapStyle;
var
  lEditor:TLMDBitmapStyleEditorDlg;
begin
  result:=aBitmapStyle;
  lEditor := TLMDBitmapStyleEditorDlg.Create(Application);
  with lEditor do
    try
      test.Style:=aBitmapStyle;
      SetLabels;
      if Showmodal=mrOK then
        result:=test.Style;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetButtonLayout(aLayout:TLMDButtonLayout):Boolean;
var
  cEditor:TLMDButtonLayoutEditorDlg;
begin
  result:=False;
  cEditor := TLMDButtonLayoutEditorDlg.Create(Application);
  with cEditor do
    try
      test.ButtonLayout.Assign(aLayout);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aLayout.Assign(test.ButtonLayout);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetFillObject(aFillObject:TLMDFillObject):Boolean;
var
  sEditor:TLMDFillEditorDlg;
begin
  result:=False;
  sEditor := TLMDFillEditorDlg.Create(Application);
  with sEditor do
    try
      Caption:='FillObject-Editor';
      test.FillObject.Assign(aFillObject);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aFillObject.Assign(test.FillObject);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetFontFx(aFontFx:TLMDFxCaption):Boolean;
var
  FEditor: TLMDFxEditorDlg;
  fposX, fPosY:Integer;

begin
  result:=False;
  FEditor:=TLMDFxEditorDlg.Create(nil);
  with FEditor do
    try
      Caption:='FxCaption-Editor';
      fPosX:=aFontFx.PosX; fPosY:=aFontFx.PosY;
      Test.FontFx.Assign(aFontFx);
      SetLabels;
      if Showmodal=mrOK then
        with aFontFx do
          begin
            Assign(Test.FontFx);
            PosX:=FPosX;
            PosY:=FPosY;
            result:=True;
          end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetGradient(aGradient:TLMDGradient):Boolean;
var
  GEditor:TLMDGradientEditorDlg;
begin
  result:=False;
  GEditor := TLMDGradientEditorDlg.Create(Application);
  with GEditor do
    try
      test.FillObject.Gradient.Assign(aGradient);
      SetLabels;
      if Showmodal=mrOK then
        begin
          aGradient.Assign(test.FillObject.Gradient);
          result:=True;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetSmallBar(aSmBarOptions:TLMDSmallBar):Boolean;
var
  sEditor: TLMDSmallBarEditorDlg;
begin
  result:=False;
  sEditor:=TLMDSmallBarEditorDlg.Create(nil);
  with sEditor do
    try
      Test.SmallBar.Assign(aSmBarOptions);
      SetLabels;
      if Showmodal=mrOK then
        with aSmBarOptions do
          begin
            Assign(Test.SmallBar);
            result:=True;
          end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetTransparent(aTransparent:TLMDTransparent):Boolean;
var
  GEditor: TLMDTransparentEditorDlg;
begin
  result:=False;
  GEditor := TLMDTransparentEditorDlg.Create(nil);
  with GEditor do
    try
      test.TransparentStyle.Assign(aTransparent);
      SetLabels;
      if Showmodal=mrOK then
        begin
          result:=True;
          aTransparent.Assign(test.TransparentStyle);
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetSettingEditor(aObject:TPersistent):Boolean;
var
  sl:TStringList;
begin
  result:=false;
  sl:=nil;
  case LMDCFCGetSettingsKindObject(aObject) of
    cfcFont:result:= LMDCPGetFont(TFont(aObject));
    cfcFont3D:result:=LMDCPGetFont3D (TLMD3DCaption(aObject));
    cfcFontFX:result:=LMDCPGetFontFX (TLMDFxCaption(aObject));
    cfcFillObject:result:=LMDCPGetFillObject (TLMDFillObject(aObject));
    cfcBitmapEffect: result:=LMDCPGetBitmapEffectObject (TLMDBitmapEffectObject(aObject));
    cfcBevel:result:=LMDCPGetBevel(TLMDBevel(aObject));
    cfcColor:
      begin
        TLMDColorObject(aObject).Color:=LMDCPGetColor(TLMDColorObject(aObject).Color);
        result:=true;
      end;
    cfcCtlSettings:
       with TLMDCustomCheckListDlg.Create(nil) do
         try
            CtlXP:=false;
            Items.Add('Transparent');
            Items.Add('CtlXP');
            DefaultValue:=0;
            Options:=[cloSelectByClick];
            Prompt:='Select desired options...';
            if TLMDCtlSettings(aObject).Transparent then DefaultValue:=1;
            if TLMDCtlSettings(aObject).CtlXP then DefaultValue:=DefaultValue+2;
            If Execute then
              with TLMDCtlSettings(aObject) do
                begin
                  Transparent:=Checked[0];
                  CtlXP:=Checked[1];
                  result:=true;
                end;
         finally
           Free;
         end;
    cfcStyle:
      try
        sl := TStringList.Create;
        sl.Text:=TLMDStyleObject(aObject).StyleName;
        LMDCPGetStrings(sl);
        TLMDStyleObject(aObject).StyleName := trim(sl.Text);
        result:=true;
      finally
        sl.Clear;
        sl.free;
      end;
  end;
end;

end.

