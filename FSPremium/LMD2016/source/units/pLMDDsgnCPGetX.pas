unit pLMDDsgnCPGetX;
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

pLMDDsgnCPGetX Unit (RM)
-----------------------
This unit contains "CPGetter" routines which require Borland Designtime code

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  DesignIntf, DesignEditors, VCLEditors,
  Consts, StdCtrls, ExtCtrls, Buttons, Controls, ImgList, Windows, Classes, Sysutils,
  Dialogs, Graphics, TypInfo, Forms,
  LMDPNGImageList,
  LMDCustomImageList, LMDCustomContainer, LMDBitmapList, LMDGenericList,
  LMDStringList, LMDImageList, LMDWave, LMDWaveList,
  {$IFDEF LMDCOMP12}LMDPNGImage, PNGImage,{$ENDIF}
  LMDGraphicList;

  // List paths
  // store/restore initialdir settings
  procedure LMDSaveListPath(typ:TLMDListItemClassType;const aValue:string);
  function LMDRestoreListPath(typ:TLMDListItemClassType):String;

type
  TLMDPathItemType=(piBitmap, piWave, piText, piGeneric, piAVI);

  // paths for items
  // store/restore initialdir settings
  procedure LMDSaveItemPath(typ:TLMDPathItemType;const aValue:String);
  function LMDRestoreItemPath(const typ:TLMDPathItemType):String;

  function LMDCPGetFilter(aValue:TLMDListItemClassType):String;
   //do not call this function in own projects (they require IDE design interface)
  function LMDCPGetIMLExt(FDesigner: IDesigner;
                         var aValue:TCustomImageList; var ListIndex, ItemIndex:Word):Boolean;
  function LMDCPGetIML(aValue:TCustomImageList; var ListIndex, ItemIndex:Word):Boolean;
  function LMDCPIMLAddItemsDlg(src, target:TLMDCustomImageList; MainIndex:Integer):Boolean;
  function LMDCPIMLAddItemsFromFile(const srcName:String; Target:TLMDCustomImageList; MainIndex:Integer):Boolean;overload;
  function LMDCPIMLAddItemsFromFile(const srcName:String; Target:TLMDImageListItem):Boolean;overload;

  // LMDContainer classes
  function LMDCPGetGenericList(aValue:TLMDGenericList):Boolean;
  function LMDCPGetBitmapList(aValue:TLMDBitmapList):Boolean;
  function LMDCPGetImageList(aValue:TLMDImageList):Boolean;
  function LMDCPGetWaveList(aValue:TLMDWaveList):Boolean;
  function LMDCPGetStringList(aValue:TLMDStringList):Boolean;

  function LMDCPEditGraphicList(aValue:TLMDGraphicList):Boolean;
  function LMDCPEditPNGList(aValue:TLMDPNGImageList):Boolean;
  function LMDCPGetWave(aWave:TLMDWave):Boolean;
  {$ifdef lmdcomp12}
  function LMDCPGetPNG(aBitmap:TLMDPNGObject):Boolean;
  {$endif}


implementation

uses
  Registry,
  LMDCont, pLMDCst, LMDTypes,
  pLMDCustomImageListSelectDlg, pLMDStdListEditorDlg, pLMDStdItemPropertiesEditorDlg,
  {$IFDEF LMDCOMP12}ExtDlgs, pLMDPicturePropertyEditor,{$ENDIF}
  pLMDExtImageListEditorDlg;

function LMDCPEditGraphicList(aValue:TLMDGraphicList):Boolean;
var
  ImageEditor: TLMDExtImageListEditorDlg;
begin
  // -- modal variant --
  result:=False;
  if not Assigned(aValue) then exit;
  ImageEditor := TLMDExtImageListEditorDlg.Create(nil);
  try
    with ImageEditor do
      begin
        ImageList := aValue;
        Caption := aValue.Owner.Name+'.'+aValue.Name;
        if ShowModal = mrOK then
         begin
           aValue.Assign(Graphiclist);
           result:=True;
         end;
      end;
  finally
    ImageEditor.Free;
  end;
 end;

{ ---------------------------------------------------------------------------- }
{function LMDCPEditBitmapList(aEditor: TComponentEditor; aValue: TLMDBitmapList = nil):Boolean;
begin
  result := true;
  try
    if LMDBitmapListEditorDlg = nil then
      LMDBitmapListEditorDlg := TLMDBitmapListEditorDlg.Create(Application);
    with LMDBitmapListEditorDlg do
      begin
        Comp := aEditor.Component;
        Designer := aEditor.Designer;
        if aValue = nil then
          ImageList := TLMDBitmapList(aEditor.Component)
        else
          ImageList := TLMDBitmapList(aValue);
        Show;
        BringToFront;
        LMDBitmapListEditorDlg.Caption := Comp.Owner.Name+'.'+Comp.Name;
      end;
  finally
  end;

  // -- modal variant --
  //ImageEditor := TLMDBitmapListEditorDlg.Create(nil);
  //try
  //  with ImageEditor do
  //    begin
  //      ImageList:=aValue;
  //      SetLabels(-Ord(aValue.Count=0), True);
  //      {lb.SetFocus;}
  //      if Showmodal=mrOK then
  //       begin
  //         aValue.Assign(ImageList);
  //         result:=True;
  //       end;
  //    end;
  //finally
  //  ImageEditor.Free;
  //end;
//end;

{ ---------------------------------------------------------------------------- }
function LMDCPEditPNGList(aValue:TLMDPNGImageList):Boolean;
var
  ImageEditor: TLMDExtImageListEditorDlg;
begin
  // -- modal variant --
  result:=False;
  if not Assigned(aValue) then exit;
  ImageEditor := TLMDExtImageListEditorDlg.Create(nil);
  try
    with ImageEditor do
      begin
        ImageList := aValue;
        Caption := aValue.Owner.Name+'.'+aValue.Name;
        if ShowModal = mrOK then
         begin
           aValue.Assign(PNGImageList);
           result:=True;
         end;
      end;
  finally
    ImageEditor.Free;
  end;
 end;

{ ---------------------------------------------------------------------------- }
procedure LMDSaveListPath(typ:TLMDListItemClassType;const aValue:string);
var
  ini:TRegIniFile;
begin
  Ini:=TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Editors');
  with ini do
    try
      WriteString(LMDListGetTypeName(typ), 'Path', aValue);
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDRestoreListPath(typ:TLMDListItemClassType):String;
var
  ini:TRegIniFile;
begin
  result:='';
  Ini:=TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Editors');
  try
    result:=ini.ReadString(LMDListGetTypeName(typ),'Path' , '');
  finally
    ini.Free;
  end;
end;

const
  LMDItemTypes:array[TLMDPathItemType] of String=('Bitmap', 'Wave', 'Text', 'Default', 'AVI');

{ ---------------------------------------------------------------------------- }
procedure LMDSaveItemPath(typ:TLMDPathItemType;const aValue:String);
var
  ini:TRegIniFile;
begin
  Ini:=TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Shared');
  with ini do
    try
      WriteString('Paths', LMDItemTypes[typ], aValue);
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDRestoreItemPath(const typ:TLMDPathItemType):String;
var
  ini:TRegIniFile;
begin
  result:='';
  Ini:=TRegIniFile.Create(LMDTOOLS_REGISTRYPATH+'\Shared');
  try
    result:=ini.ReadString('Paths', LMDItemTypes[typ], '');
  finally
    ini.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetFilter(aValue:TLMDListItemClassType):String;
begin
  result:='';
  case aValue of
    icImageList, icImageListItem:result:='Image';
    icWave:result:='Wave';
    icGeneric:result:='Generic';
    icBitmap:result:='Bitmap';
    icStringList:result:='String';
  end;

  if result<>'' then result:=result+'List-Files (*'+LMDICGetSUFFIX(aValue, True)+')|*'+LMDICGetSUFFIX(aValue, True);
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetGenericList(aValue:TLMDGenericList):Boolean;
var
  sEditor: TLMDStdListEditorDlg;
begin
  result:=False;
  sEditor:=TLMDStdListEditorDlg.Create(nil);
  try
    sEditor.SetType(icGeneric);
    sEditor.GenericList.Assign(aValue);
    sEditor.SetLabels(-1, true);
    if sEditor.Showmodal=mrOK then
      begin
        aValue.Assign(sEditor.GenericList);
        result:=True;
      end;
  finally
    sEditor.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetStringList(aValue:TLMDStringList):Boolean;
var
  sEditor: TLMDStdListEditorDlg;
begin
  result:=False;
  sEditor:=TLMDStdListEditorDlg.Create(nil);
  try
    sEditor.SetType(icStringList);
    sEditor.StringList:=aValue;
    sEditor.SetLabels(-1, true);
    if sEditor.Showmodal=mrOK then
      begin
        aValue.Assign(sEditor.StringList);
        result:=True;
      end;
  finally
    sEditor.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetBitmapList(aValue:TLMDBitmapList):Boolean;
var
  sEditor: TLMDStdListEditorDlg;
begin
  result:=False;
  sEditor:=TLMDStdListEditorDlg.Create(nil);
  try
    sEditor.SetType(icBitmap);
    sEditor.BitmapList.Assign(aValue);
    sEditor.SetLabels(-1, true);
    if sEditor.Showmodal=mrOK then
      begin
        aValue.Assign(sEditor.BitmapList);
        result:=True;
      end;
  finally
    sEditor.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetImageList(aValue:TLMDImageList):Boolean;
var
  sEditor: TLMDStdListEditorDlg;
begin
  result:=False;
  sEditor:=TLMDStdListEditorDlg.Create(nil);
  try
    sEditor.SetType(icImageList);
    sEditor.ImageList.Assign(aValue);
    sEditor.SetLabels(-1, true);
    if sEditor.Showmodal=mrOK then
      begin
        aValue.Assign(sEditor.ImageList);
        result:=True;
      end;
  finally
    sEditor.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetWaveList(aValue:TLMDWaveList):Boolean;
var
  sEditor: TLMDStdListEditorDlg;
begin
  result:=False;
  sEditor:=TLMDStdListEditorDlg.Create(nil);
  try
    sEditor.SetType(icWave);
    sEditor.WaveList.Assign(aValue);
    sEditor.SetLabels(-1, true);
    if sEditor.Showmodal=mrOK then
      begin
        aValue.Assign(sEditor.WaveList);
        result:=True;
      end;
  finally
    sEditor.Free;
  end;
end;
{ ---------------------------------------------------------------------------- }
(*function LMDCPGetGraphicList(aValue:TLMDGraphicList):Boolean;
var
  ImageEditor: TLMDGraphicListEditorDlg;
begin
  result:=False;
  ImageEditor := TLMDGraphicListEditorDlg.Create(nil);
  try
    with ImageEditor do
      begin
        GraphicList.Graphics.Assign(AValue.Graphics);
        if ShowModal = mrOK then
         begin
           aValue.Graphics.Assign(GraphicList.Graphics);
           result:=True;
         end;
      end;
  finally
    ImageEditor.Free;
  end;
end;*)

{ ---------------------------------------------------------------------------- }
function LMDCPGetIMLExt(FDesigner: IDesigner; var aValue:TCustomImageList;
                        var ListIndex, ItemIndex:Word):Boolean;
var
  dlg:TLMDCustImgListSelectDlg;
begin
  result:=false;
  dlg:=TLMDCustImgListSelectDlg.Create(nil);
  with dlg do
    try
      Design:=FDesigner;
      FImageList:=aValue;
      if FDesigner<>nil then
        AddImageLists;
      SetLabels;
      try
        if (aValue is TLMDBitmapList) or (aValue is TLMDGraphicList) or (aValue is TLMDPNGImageList) then
          lv.ItemIndex:=ListIndex
        else
          begin
            SetListIndex(ListIndex);
            lv.ItemIndex:=ItemIndex;
          end
      except
      end;

      if ShowModal=mrOK then
        begin
          aValue:=FImageList;
          if (aValue is TLMDBitmapList) or (aValue is TLMDGraphicList) or (aValue is TLMDPNGImageList) then
            begin
              aValue:=FImageList;
              if lv.ItemIndex<>-1 then
                ListIndex:=lv.ItemIndex;
              result:=True;
            end
          else
            begin
              aValue:=FImageList;
              if (cmb.ItemIndex<>-1) then
                ListIndex:=cmb.ItemIndex;
              if (lv.ItemIndex<>-1) then
                ItemIndex:=lv.ItemIndex;
              result:=True;
            end;
        end;
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetIML(aValue:TCustomImageList; var ListIndex, ItemIndex:Word):Boolean;
var
  tmp:TCustomImageList;
begin
  tmp:=aValue;
  result:=LMDCPGetIMLExt(nil, tmp, ListIndex, ItemIndex);
end;

{ ---------------------------------------------------------------------------- }
function LMDCPIMLAddItemsDlg(src, target:TLMDCustomImageList; MainIndex:Integer):Boolean;
var
  dlg:TLMDCustImgListSelectDlg;
  i:Integer;
  tmp:TLMDImageListItem;
  bmp:TBitmap;

begin
  result:=false;
  if (src=nil) or (target=nil) then exit;
  dlg:=TLMDCustImgListSelectDlg.Create(Application);
  bmp:=nil;
  with dlg do
    try
      MultiSelect:=True;
      ImageList:=src;
      SetLabels;

      if not LMDIsSingleItemImageList(src) then
        SetListIndex(0);

      lv.ItemIndex:=0;

      if ShowModal=mrOK then
        begin
          if lv.SelCount=0 then exit;
          if not (src is TLMDBitmapList) then bmp:=TBitmap.Create;
          for i:=0 to Pred(lv.Items.Count) do
             if lv.Selected[i] then
               if src is TLMDBitmapList then
                 TLMDBitmapList(target)[target.Add(nil)].Assign(TLMDBitmapList(src)[i])
               else
                 begin
                   tmp:=TLMDImageList(target)[MainIndex];
                   TLMDImageList(src)[cmb.ItemIndex].GetBitmap(i, bmp);
                   tmp.AddMasked(bmp, bmp.TransparentColor)
                 end;
          result:=True;
        end;
    finally
      Free;
      if bmp<>nil then bmp.Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPIMLAddItemsFromFile(const srcName:String; Target:TLMDCustomImageList; MainIndex:Integer):Boolean;overload;
var
  FImageList:TLMDCustomImageList;
begin
  if Target is TLMDBitmapList then
    FImageList:=TLMDBitmapList.Create(nil)
  else
    FImageList:=TLMDImageList.Create(nil);

  with FImageList do
    try
      FImageList.LoadFromFile(srcName);
      result:=LMDCPIMLAddItemsDlg(FImageList, target, MainIndex);
    finally
      Free;
    end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPIMLAddItemsFromFile(const srcName:String; Target:TLMDImageListItem):Boolean;overload;
var
  FIML:TLMDImageList;
  dlg:TLMDCustImgListSelectDlg;
  i:Integer;
  bmp:TBitmap;
begin
  bmp:=nil;
  result:=false;
  FIML:=TLMDImageList.Create(nil);
  try
    FIML.LoadFromFile(srcName);
    dlg:=TLMDCustImgListSelectDlg.Create(Application);
    with dlg do
      try
        MultiSelect:=True;
        ImageList:=FIML;
        SetLabels;
        SetListIndex(0);
        lv.ItemIndex:=0;
        if ShowModal=mrOK then
          begin
            if lv.SelCount=0 then exit;
            bmp:=TBitmap.Create;
            for i:=0 to Pred(lv.Items.Count) do
            if lv.Selected[i] then
              begin
                FIML[cmb.ItemIndex].GetBitmap(i, bmp);
                Target.AddMasked(bmp, bmp.TransparentColor)
              end;
            result:=True;
         end;
    finally
      Free;
      if bmp<>nil then bmp.Free;
    end;
  finally
    FIML.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
function LMDCPGetWave(aWave:TLMDWave):Boolean;
begin
  result:=false;
  with TLMDStdItemForm.Create(nil) do
    try
      Caption:='Wave Editor';
      nb.ActivePage:='WaveStandAlone';
      cWave.Assign(aWave);
      SetLabels;
      if ShowModal=mrOK then
        begin
          aWave.Assign(cWave);
          result:=true;
        end;
    finally
      Free;
    end;
end;

{------------------------------------------------------------------------------}
{$ifdef lmdcomp12}
function LMDCPGetPNG(aBitmap:TLMDPNGObject):Boolean;
var
  ImageEditor: TLMDPicturePropertyEditorDlg;
begin
  ImageEditor := TLMDPicturePropertyEditorDlg.Create(nil);
  with ImageEditor do
  try
    OpenPictureDialog.DefaultExt := GraphicExtension(TPNGImage);
    OpenPictureDialog.FileName := '*.' + OpenPictureDialog.DefaultExt;
    OpenPictureDialog.Filter := GraphicFilter(TPNGImage);
    if Assigned(aBitmap) and not aBitmap.Empty then
      Image.Picture.Assign(aBitmap);
    if ShowModal = mrOk then
    begin
      if Image.Picture.Graphic = nil then
        result := false
      else
      begin
        aBitmap.Assign(PNGImage);
        result := true;
      end
    end
    else
      result := true;
  finally
    ImageEditor.Free;
  end;
end;
{$endif}

end.
