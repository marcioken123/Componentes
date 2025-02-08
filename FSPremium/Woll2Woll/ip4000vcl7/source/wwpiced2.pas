{
//
// Components : TwwEditPictureMaskDlg - Design time
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
unit Wwpiced2;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, wwdblook, Wwdbdlg, ExtCtrls, Buttons, DB,
  DBTables, Wwtable, wwidlg, wwdbedit, Mask, Wwdotdot,
  inifiles, registry, wwedtpic, ipdsgn;
  
type
  TwwEditPictureMaskdlg = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Panel1: TPanel;
    AllowInvalidCheckbox: TCheckBox;
    AutoFillCheckbox: TCheckBox;
    PictureDescription: TMemo;
    PictureMaskLabel: TLabel;
    DesignMaskButton: TButton;
    UsePictureMask: TCheckBox;
    PictureMaskEdit: TwwDBComboDlg;
    procedure PictureMaskEditChange(Sender: TObject);
    procedure PictureMaskEditCloseUp(Sender: TObject;
      LookupTable: TDataSet; FillTable: TDataset; modified: Boolean);
    procedure PictureMaskEditInitDialog(Dialog: TwwLookupDlg);
    procedure FormShow(Sender: TObject);
    procedure DesignMaskButtonClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PictureMaskEditCustomDlg(Sender: TObject);
    procedure PictureMaskEditExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
//    ini: TIniFile;
//    procedure RecreateIniFile;
    procedure RefreshDescription;
    procedure VerifyKeyValue(var Key, Value: string);
  public
    MyComponent: TwwCustomMaskEdit;
  end;

  Function wwPrpEdit_PictureMask2(AComponent: TwwCustomMaskEdit): boolean;
  Function wwPrpEdit_PictureMask3(Picture: TwwDBPicture; TempParent: TWinControl): boolean;

var
  wwEditPictureMaskdlg: TwwEditPictureMaskdlg;

implementation

{$R *.DFM}
uses wwprppic, wwcommon, wwdatsrc, wwlocate;

Function wwPrpEdit_PictureMask2(AComponent: TwwCustomMaskEdit): boolean;
var component: TwwCustomMaskEdit;
begin
    result:= False;
    with TwwEditPictureMaskDlg.create(Application) do try
       Component:=AComponent;
       MyComponent:= component;

       if ShowModal=mrOK then begin
          component.Picture.PictureMask:= PictureMaskEdit.text;
          component.Picture.AutoFill:= AutoFillCheckbox.checked;
          component.Picture.AllowInvalidExit:= AllowInvalidCheckbox.checked;
          component.UsePictureMask:= UsePictureMask.checked;
          result:= True;
       end
    finally
       Free;
    end;
end;

Function wwPrpEdit_PictureMask3(Picture: TwwDBPicture; TempParent: TWinControl): boolean;
var component: TwwCustomMaskEdit;
begin
   component:= TwwCustomMaskEdit.create(tempParent);
   try
      component.visible:= False;
      component.parent:= TempParent;
      with component.picture do begin
         PictureMask:= Picture.PictureMask;
         AutoFill:= Picture.AutoFill;
         AllowInvalidExit:= Picture.AllowInvalidExit;
      end;
      result:= wwPrpEdit_PictureMask(component);
      if result then
      begin
         with component.picture do begin
          Picture.PictureMask:= PictureMask;
          Picture.AutoFill:= AutoFill;
          Picture.AllowInvalidExit:= AllowInvalidExit;
         end
      end;
   finally
      component.Free;
   end
end;

procedure TwwEditPictureMaskdlg.PictureMaskEditChange(Sender: TObject);
begin
//   if not wwtable1.active then exit;
{
   if wwtable1.wwFindRecord(PictureMaskEdit.Text, 'Mask', mtExactMatch, False) then
      PictureDescription.Text:= wwtable1.FieldByName('Desc').asString
   else PictureDescription.Text:= 'Mask not found in database';
}
{   if not wwtable1.active then exit;
   if wwtable1.indexName<>'iMask' then wwtable1.indexName:='iMask';
   if wwtable1.FindKey([PictureMaskEdit.Text]) then
      PictureDescription.Text:= wwtable1.FieldByName('Desc').asString
   else PictureDescription.Text:= 'Mask not found in database';
}
end;

procedure TwwEditPictureMaskdlg.PictureMaskEditCloseUp(Sender: TObject;
  LookupTable: TDataSet; FillTable: TDataset; modified: Boolean);
begin
    if modified then begin
       PictureDescription.text:= lookupTable.fieldByName('Desc').asString;
    end
end;

procedure TwwEditPictureMaskdlg.PictureMaskEditInitDialog(Dialog: TwwLookupDlg);
begin
{   if not wwtable1.active then exit;

   if not wwtable1.wwFindRecord(PictureMaskEdit.Text, 'Mask', mtExactMatch, False) then
   begin
      wwtable1.indexFieldName:= 'Desc';
      wwtable1.First;
   end
   else wwtable1.indexFieldName:= 'Desc';
   wwtable1.FieldByName('Desc').index:= 0;

{   if not wwtable1.active then exit;
   wwtable1.indexName:='iMask';
   if not wwtable1.FindKey([PictureMaskEdit.Text]) then
   begin
      wwtable1.indexName:= 'iDesc';
      wwtable1.First;
   end
   else wwtable1.indexName:= 'iDesc';
}
end;

procedure TwwEditPictureMaskdlg.FormShow(Sender: TObject);
begin
//   wwOpenPictureDB(wwtable1);

   AllowInvalidCheckbox.checked:= MyComponent.Picture.AllowInvalidExit;
   PictureMaskEdit.text:= MyComponent.Picture.PictureMask;
   AutoFillCheckbox.checked:= MyComponent.Picture.AutoFill;
   UsePictureMask.checked:= MyComponent.UsePictureMask;

   if (MyComponent is TwwDBCustomEdit) then
      with TwwDBCustomEdit(MyComponent) do
         if (datasource<>Nil) and (datasource.dataset<>Nil) then begin
            if (wwPdxPictureMask(datasource.dataset, dataField)<>'') then
            begin
               PictureMaskEdit.enabled:= False;
               PictureMaskLabel.caption:= '&Picture Mask (From Paradox Table)';
               PictureMaskEdit.ShowButton:= False;
               DesignMaskButton.enabled:= False;
            end;
            AllowInvalidCheckbox.checked:= False;
            AllowInvalidCheckbox.enabled:= False;
         end;

   RefreshDescription;

end;

procedure TwwEditPictureMaskdlg.DesignMaskButtonClick(Sender: TObject);
var component: TwwCustomMaskEdit;
begin
   component:= TwwCustomMaskEdit.create(self);
   with component do begin
      component.visible:= False;
      component.parent:= self;
      with component.picture do begin
         PictureMask:= PictureMaskEdit.Text;
         AutoFill:= AutoFillCheckbox.checked;
         AllowInvalidExit:= AllowInvalidCheckbox.checked;
      end;

      if wwPrpEdit_PictureMask(component) then
      begin
         with component.picture do begin
            PictureMaskEdit.Text:= PictureMask;
            AutoFillCheckbox.checked:= AutoFill;
            AllowInvalidCheckbox.checked:= AllowInvalidExit;
         end;
      end;
//      RecreateIniFile;

      Free;
   end
end;
procedure TwwEditPictureMaskdlg.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=vk_f1) then wwALinkHelp(Handle, 'Picture_Masks')
end;

procedure TwwEditPictureMaskdlg.PictureMaskEditCustomDlg(Sender: TObject);
var
    row: integer;
    masks: TStringList;
    key, value: string;
    mr: TModalResult;
begin
   with TwwPictureDialog.create(self) do begin
     masks:= TStringlist.create;
     iniPict.ReadSectionValues('Picture Masks', masks);
     for row:= 0 to masks.count-1 do begin
        stringgrid1.rowCount:= row+2;
        stringgrid1.cells[0,row+1]:= masks.Names[row];
        stringgrid1.cells[1,row+1]:= masks.values[masks.Names[row]];
        if stringgrid1.cells[1,row+1]=PictureMaskEdit.text then
           stringgrid1.row:= row+1;
     end;
     masks.free;

     mr:= showmodal;

     if MaskChanged then
     begin
        { Strip out characters < 32 Ascii, and the = }
        IniPict.EraseSection('Picture Masks');
        for row:= 1 to StringGrid1.RowCount-1 do begin
          Key:= StringGrid1.Cells[0, row];
          Value:= StringGrid1.Cells[1, row];
          VerifyKeyValue(Key,Value);
          IniPict.WriteString('Picture Masks', Key, Value);
        end;
     end;

     if mr=mrOK then
     begin
        PictureDescription.text:= StringGrid1.cells[0, StringGrid1.Row];
        PictureMaskEdit.Text:= StringGrid1.cells[1, StringGrid1.Row];
     end;

     free;
  end;
//  ini.free;

end;

procedure TwwEditPictureMaskdlg.PictureMaskEditExit(Sender: TObject);
begin
   RefreshDescription;
end;

procedure TwwEditPictureMaskDlg.RefreshDescription;
begin
   PictureDescription.Text:= wwIniGetPictureDescription(PictureMaskEdit.text);
end;


procedure TwwEditPictureMaskdlg.FormCreate(Sender: TObject);
begin
//   RecreateIniFile;
end;

{procedure TwwEditPictureMaskdlg.RecreateIniFile;
var ipreg: TRegIniFile;
    FileName: string;
begin
   ipreg := TRegIniFile.create('');
   FileName:= ipreg.ReadString('\Software\Woll2Woll\InfoPower', 'Masks IniFile', 'InfoPowerMasks.ini') + '\InfoPowerMasks.ini';
   ipreg.free;
   ini.Free;
   ini:= TIniFile.create(FileName);
end;
}
procedure TwwEditPictureMaskdlg.FormDestroy(Sender: TObject);
begin
//  ini.free;
//  ini:= nil;
//   IniPict.update;
end;

procedure TwwEditPictureMaskDlg.VerifyKeyValue(var Key, Value: string);
var i: integer;
    tempValue: string;
begin
   for i:= 1 to length(Key) do
     if (ord(key[i])<32) or (key[i]='=') then key[i]:= ' ';
   tempValue:= '';

   for i:= 1 to length(Value) do
      if not (ord(Value[i])<32) or (Value[i]='=') then tempValue:= tempValue + Value[i];
   Value:= tempValue;
end;




end.