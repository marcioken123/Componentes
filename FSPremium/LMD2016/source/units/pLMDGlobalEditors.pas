unit pLMDGlobalEditors;
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

pLMDGlobalEditors unit (RM)
---------------------------
Global available Designtime Editors

ToDo
----
* Delphi 7 writes item BOLD, when it is not default and  when it will be saved
  to DFM. This must be recognized by LMD editors as well.
* Picture and Graphic editors might be recreated with cool new editor -> In
  Delphi 7 there is still nothing new.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface
uses
  Menus,
  DesignIntf, DesignEditors, VCLEditors, DesignMenus, ColnEdit,
  Windows, Classes, Sysutils, Dialogs, Graphics, TypInfo, Forms, ComCtrls;

type
  //   --> LMD-Tools 7.X: New version?, search for // (old code)
  {********************* Class TLMDGraphicProperty ****************************}
  {----------------------------------------------------------------------------}
{  TLMDGraphicProperty = class(TGraphicProperty)
  public
    //procedure Edit; override; --> Thomas: ReCreate
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
//  end;

  {----------------------------------------------------------------------------}
{  TLMDPictureProperty = class(TPictureProperty)
  public
    // procedure Edit; override; --> Thomas: ReCreate
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
//  end;

  {*********************** TLMDBrushProperty **********************************}
  TLMDBrushProperty = class(TClassProperty, ICustomPropertyDrawing)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    { CustomPropertyDrawing }
    procedure PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
  end;

  {************************** TLMDDateTimeProperty ****************************}
  TLMDDateTimeProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {************************** TLMDFileNameProperty ****************************}
  TLMDFileNameProperty = class (TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     procedure Edit; override;
  end;

  {************************** TLMDHintProperty ********************************}
  TLMDHintProperty=class(TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     procedure Edit; override;
  end;

  {*********************** TLMDHotkeyProperty *********************************}
  TLMDHotkeyProperty = class(TShortCutProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end;

  {************************** TLMDStringProperty ******************************}
  TLMDStringProperty= class(TStringProperty)
     function GetAttributes: TPropertyAttributes; override;
     procedure Edit; override;
  end;

  {************************* TLMDStdCaptionProperty ***************************}
  TLMDStdCaptionProperty= class(TLMDStringProperty)
     function GetAttributes: TPropertyAttributes; override;
  end;

  {*********************** TLMDCollectionItemsEditor **************************}
  // useful for collection items which again are collection properties
  TLMDCollectionItemsEditor = class(TCollectionEditor)
  protected
    FItemMenu: TMenuItem;
    FItemButton: TToolButton;
    procedure Loaded; override;
    procedure OpenEditor(Sender:TObject);
    function GetWorkCollection(index:Integer):TCollection;virtual;abstract;
  end;

  {*********************** TLMDWideStringsProperty ****************************}
  TLMDWideStringsProperty = class(TClassProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

  // get standard bitmaps for e.g. LMD Collection editor
  function LMDGetToolBitmap:TBitmap;

implementation
uses
  Controls, Registry, Consts,
  StdCtrls, ExtCtrls, Contnrs,
  LMDRtlConst, LMDTypes, LMDDateTime, LMDUnicodeStrings, pLMDCst, pLMDComBrushDlg,
  pLMDCPGetBase, pLMDWideStringsEditDlg; //StringList Editor

// Preliminary - Common routines should be created in LMDUtils.pas
// -----------------------------------------------------------------------------
{procedure LMDDrawGraphic(aCanvas:TCanvas; const aRect:TRect;
                         aGraphic:TGraphic; const aValue:string);
var
  hr, wr:Single;
  tmp:TRect;
  tmpb: TBitmap;
begin
  tmp:=aRect;
  aCanvas.FillRect(aRect);
  // calculate Aspect Ratio
  hr:=(aRect.Bottom-ARect.Top)/aGraphic.Height;
  wr:=(aRect.Right-aRect.Left)/aGraphic.Width;

  if hr<wr then
    tmp.Right:=tmp.Left+Trunc(aGraphic.Width*hr)
  else
    tmp.Bottom:=tmp.Top+ Trunc(aGraphic.Height*wr);

  if (aGraphic is TIcon) and ((hr>1) or (wr>1)) then
    begin
      // Note: Create common routine in LMDUtils for this task
      tmpb := TBitmap.Create;
      with tmpb do
        try
          Height := TIcon(aGraphic).Height;
          Width  := TIcon(aGraphic).Width;
          Canvas.Brush.Color := clBtnFace;
          Canvas.FillRect(Rect(0,0,Width, Height));
{          Canvas.Draw(0, 0, TIcon(aGraphic));
          aCanvas.StretchDraw(tmp, tmpb);
        finally
          Free;
        end;
     end
   else
     aCanvas.StretchDraw(tmp, aGraphic);
  tmp:=Rect(tmp.Right,aRect.Top,aRect.Right,aRect.Bottom);
  aCanvas.TextRect(tmp, tmp.Left+1, tmp.Top+1, aValue);
end;

{------------------------------------------------------------------------------}
{procedure TLMDGraphicProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  Graphic: TGraphic;
begin
  Graphic := TGraphic(GetOrdValue);
  if (Graphic = nil) or Graphic.Empty or (Graphic.Height = 0) or (Graphic.Width = 0) then
    inherited
  else
    LMDDrawGraphic(ACanvas, ARect, Graphic, GetVisualValue);
end;

{------------------------------------------------------------------------------}
{procedure TLMDPictureProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  Graphic: TGraphic;
begin
  if GetOrdValue = 0 then
    inherited
  else
  begin
    Graphic := TPicture(GetOrdValue).Graphic;
    if (Graphic = nil) or Graphic.Empty or (Graphic.Height = 0) or (Graphic.Width = 0) then
      inherited
    else
      LMDDrawGraphic(ACanvas, ARect, Graphic, GetVisualValue);
  end;
end;
{------------------------------------------------------------------------------}

var
  LMDCLBitmap:TBitmap=nil;
  LMDToolBitmap:TBitmap=nil;

function LMDCLGetBitmap:TBitmap;
begin
  if LMDCLBitmap<>nil then
    result:=LMDCLBitmap
  else
    begin
      LMDCLBitmap:=TBitmap.Create;
      LMDCLBitmap.Transparent:=True;
      LMDCLBitmap.LoadFromResourceName(hInstance, 'LMDCLNBUTTON');
      result:=LMDCLBitmap;
    end;
end;

{------------------------------------------------------------------------------}
function LMDGetToolBitmap:TBitmap;
begin
  if LMDToolBitmap<>nil then
    result:=LMDToolBitmap
  else
    begin
      LMDToolBitmap:=TBitmap.Create;
      LMDToolBitmap.Transparent:=True;
      LMDToolBitmap.LoadFromResourceName(hInstance, 'LMDTOOLIMAGES');
      result:=LMDToolBitmap;
    end;
end;

{********************* Class TLMDBrushProperty ********************************}
{------------------------------------------------------------------------------}
procedure TLMDBrushProperty.Edit;
begin
  with TLMDComBrushEditorDlg.Create(nil) do
    try
     test.Brush.Assign(TBrush(TLMDPtrUInt(Pointer(GetOrdValue))));
     SetLabels;
     If ShowModal=mrOK then
       SetOrdValue(TLMDPtrUInt(Pointer(test.Brush)));
       finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBrushProperty.PropDrawValue(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  bRect : TRect;
  tmpb:TBrush;
begin
  if not Assigned (Pointer(GetOrdValue)) then
  inherited
  else
    begin
      aCanvas.FillRect (aRect);
      bRect := aRect;
      InflateRect (bRect, -1, -1);
     tmpb:=TBrush(Pointer(GetOrdValue));
     with tmpb do
        aCanvas.TextOut(bRect.Left+  LMDPE_DEFVISUALWIDTH+2, bRect.Top, '{'+GetEnumName(TypeInfo(TBrushStyle), Ord(Style))+', '+
                        ColorToString(Color)+'}');
      aCanvas.Brush.Assign (tmpb);
      bRect.Right:=bRect.Left+LMDPE_DEFVISUALWIDTH;
      aCanvas.pen.Color:=clSilver;
      if aCanvas.Brush.Style<>bsSolid then SetBKColor(aCanvas.Handle, ColorToRGB(clSilver));
      aCanvas.FillRect (bRect);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBrushProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
begin
  DefaultPropertyDrawName(Self, ACanvas, ARect);
end;

{------------------------------------------------------------------------------}
function TLMDBrushProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************* Class TLMDDateTimeProperty **************************** }
{------------------------------------------------------------------------------}
procedure TLMDDateTimeProperty.Edit;
var
  DateTime:TLMDDateTime;
begin
  DateTime:=TLMDDateTime.Create;
  try
    DateTime.Assign(TLMDDateTime(Pointer(GetOrdValue)));
    if LMDCPGetDateTime(DateTime) then SetOrdValue(TLMDPtrUInt(Pointer(DateTime)));
    finally
    DateTime.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDDateTimeProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paSubProperties, paMultiSelect];
end;

{********************FileNameProperty******************************************}
{------------------- TLMDFileNameProperty -------------------------------------}
function TLMDFileNameProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog];
end;

{------------------------------------------------------------------------------}
Procedure TLMDFileNameProperty.Edit;
var
  OpenDialog:TOpenDialog;

begin
  OpenDialog := TOpenDialog.Create(nil);
  with opendialog do
    try
       filter:=sDefaultFilter;
       options:=[ofHideReadOnly,ofExtensionDifferent,ofPathMustExist,ofFileMustExist];
       filename:=GetStrValue;
       if execute then SetStrValue(filename);
    finally
      Free;
    end;
end;

{******************** TLMDHintProperty ****************************************}
{------------------------------------------------------------------------------}
function TLMDHintProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable, paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDHintProperty.Edit;
var
  dlg:TLMDStrEditorDlg;
  tmp:String;

begin
  dlg:=TLMDStrEditorDlg.Create(nil);
  with dlg do
    try
       tmp:=GetStrValue;
       Caption:='Hint-Editor';
       sh.Caption:='&ShortHint:';
       Str.Height:=126;

       lh.Visible:=true;
       Str.Text:=GetShortHint(tmp);
       if pos('|', tmp)>0 then lh.Text:=GetLongHint(tmp);

       Str.SelStart:=0;
       Str.SelLength:=Length(Str.Text);
       if ShowModal=mrOK then
         if Trim(lh.Text)<>'' then
           SetStrValue(str.Text+'|'+lh.Text)
         else
           SetStrValue(str.Text);
    finally
      dlg.Free;
    end;
end;

{********************* Class TLMDHotkeyProperty *******************************}
{------------------------------------------------------------------------------}
procedure TLMDHotkeyProperty.Edit;
var
  tmp:TShortCut;
begin
  tmp:=GetOrdValue;
  if LMDCPGetShortCut(tmp) then
    SetOrdValue(tmp);
end;

{------------------------------------------------------------------------------}
function TLMDHotkeyProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{********************TLMDStdCaptionProperty************************************}
{------------------------------------------------------------------------------}
function TLMDStdCaptionProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable, paDialog, paAutoUpdate];
end;

{********************TLMDStringProperty****************************************}
{------------------------------------------------------------------------------}
function TLMDStringProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect, paRevertable, paDialog];
end;

{------------------------------------------------------------------------------}
procedure TLMDStringProperty.Edit;
begin
  SetStrValue(LMDCPGetCaption(GetStrValue, MaxInt));
end;

{***************** Class TLMDCollectionItemsEditor ****************************}
{------------------------------------------------------------------------------}
procedure TLMDCollectionItemsEditor.Loaded;
var
  tmp:TBitmap;
begin
  inherited Loaded;
  tmp:=LMDCLGetBitmap;

  if not tmp.Empty then
    ImageList1.AddMasked(tmp,tmp.TransparentColor);

  FItemButton:=TToolButton.Create(Self);
  with FItemButton do
    begin
      Parent:=ToolBar1;
      ImageIndex:=4;
      Hint:='Items Editor';
      OnClick:=OpenEditor;
      Left:=ToolButton5.Left+Width+10;
    end;

  FItemMenu:=TMenuItem.Create(PopupMenu1);
  FItemMenu.Caption:='Items Editor';
  FItemMenu.OnClick:=OpenEditor;
  PopupMenu1.Items.Add(FItemMenu);
  // 7.0
  ListView1.OnDblClick:=OpenEditor;
  if Width<200 then Width:=200;
end;

{------------------------------------------------------------------------------}
procedure TLMDCollectionItemsEditor.OpenEditor(Sender:TObject);
begin
  if (ListView1.SelCount = 0) or (ListView1.SelCount > 1) then
    MessageDlg('No ore more than one Section selected.', mtWarning, [mbOk], 0)
  else
    begin
      ShowCollectionEditor(Designer, Component,
                           GetWorkCollection(ListView1.Selected.Index),
                           'Items');
    end;
end;

{***************** Class TLMDWideStringsProperty ******************************}
{----------------------- public -----------------------------------------------}
procedure TLMDWideStringsProperty.Edit;
var
  dlg: TLMDFrmWideStringsEditor;
begin
  dlg := TLMDFrmWideStringsEditor.Create(Application);
  try
    dlg.Lines := TLMDWideStrings(TLMDPtrInt(Pointer(GetOrdValue)));
    if dlg.Execute then
      SetOrdValue(TLMDPtrInt(Pointer(dlg.Lines)));
      finally
    dlg.Free;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDWideStringsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly, paMultiSelect];
end;

initialization

finalization
  if LMDCLBitmap<>nil then
    FreeAndNil(LMDCLBitmap);
  if LMDToolBitmap<>nil then
    FreeAndNil(LMDToolBitmap);
end.
