{
//
// Components : TwwEditPictureForm - Design time
//
// Copyright (c) 1998-2001 by Woll2Woll Software
//
}
unit Wwprppic;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, wwdblook, StdCtrls, DB, DBTables, Wwtable, Wwdatsrc,
  Wwdbdlg, wwidlg, Mask, Wwdbedit, Wwdotdot, wwdbigrd, Buttons, ExtCtrls,
  wwpicdb, Grids, Wwdbgrid, inifiles, registry, wwedtpic, ipdsgn;

type
  TwwEditPictureForm = class(TForm)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    PictureDescription: TMemo;
    Button1: TButton;
    Button2: TButton;
    GroupBox2: TGroupBox;
    wwPictureEdit1: TwwDBEdit;
    Label1: TLabel;
    Button3: TButton;
    Status: TPanel;
    AutoFill: TCheckBox;
    Button4: TButton;
    NewPicture: TwwDBComboDlg;
    procedure NewPictureChange(Sender: TObject);
    procedure wwPictureEdit1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure wwLookupDialog1UserButton1Click(Sender: TObject;
      LookupTable: TDataSet);
    procedure wwDBLookupComboDlg1Change(Sender: TObject);
    procedure AutoFillClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NewPictureCustomDlg(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NewPictureExit(Sender: TObject);
  private
    Component: TCustomEdit;
    OrigPictureMask: string;
    OrigAutoFill: boolean;
//    ini: TIniFile;

    procedure RefreshDescription;
//    Function CreateNewPicture(ALookupTable: TTable): boolean;

  public
    { Public declarations }
  end;

var
  wwEditPictureForm: TwwEditPictureForm;

Function wwPrpEdit_PictureMask(AComponent: TwwCustomMaskEdit): boolean;
Function wwPrpEdit_PictureMaskGen(AComponent: TCustomEdit): boolean;

implementation

{$R *.DFM}

uses wwcommon, wwlocate;

Function wwPrpEdit_PictureMask(AComponent: TwwCustomMaskEdit): boolean;
begin
    result:= False;
    with TwwEditPictureForm.create(Application) do try
       Component:=AComponent;
       OrigPictureMask:= AComponent.picture.PictureMask;
       OrigAutoFill:= AComponent.picture.AutoFill;
       if ShowModal=mrOK then begin
          AComponent.Picture.PictureMask:= NewPicture.text;
          AComponent.Picture.AutoFill:= AutoFill.checked;
          result:= True;
       end
    finally
       Free;
    end;
end;

Function wwPrpEdit_PictureMaskGen(AComponent: TCustomEdit): boolean;
begin
    result:= False;
    with TwwEditPictureForm.create(Application) do try
       Component:=AComponent;
       OrigPictureMask:= wwGetControlPictureMask(AComponent);
       OrigAutoFill:= wwGetControlAutoFill(AComponent);

       if ShowModal=mrOK then begin
          wwSetControlPictureMask(AComponent, NewPicture.text);
          wwSetControlAutoFill(AComponent, AutoFill.checked);
          result:= True;
       end
    finally
       Free;
    end;
end;

procedure TwwEditPictureForm.NewPictureChange(Sender: TObject);
begin
   wwPictureEdit1.Picture.PictureMask:= NewPicture.Text;
end;

procedure TwwEditPictureForm.wwPictureEdit1Change(Sender: TObject);
begin
   if wwPictureEdit1.isValidPictureValue(wwPictureEdit1.text) then
      Status.caption:= 'Value is valid'
   else Status.caption:= 'Picture does not accept value';
end;

procedure TwwEditPictureForm.Button1Click(Sender: TObject);
begin
   if wwPictureEdit1.isValidPictureMask(NewPicture.text) then
      Status.caption:= 'Invalid Picture Syntax'
   else Status.caption:= 'Picture is valid';
end;

procedure TwwEditPictureForm.FormShow(Sender: TObject);
begin
//   wwOpenPictureDB(wwtable1);

   if Component<>Nil then begin
      NewPicture.text:= OrigPictureMask;
//      NewPicture.LookupValue:= NewPicture.Text;
      AutoFill.checked:= OrigAutoFill;
   end;

   RefreshDescription;
end;

procedure TwwEditPictureForm.Button2Click(Sender: TObject);
begin
   if Component<>Nil then begin
      NewPicture.text:= OrigPictureMask;
      AutoFill.checked:= OrigAutoFill;
   end
end;

procedure TwwEditPictureForm.wwLookupDialog1UserButton1Click(Sender: TObject;
  LookupTable: TDataSet);
begin
   with (Sender as TwwLookupDlg) do begin
      wwdbgrid1.Options:= wwdbgrid1.options + [dgEditing] - [dgRowSelect];
   end;
   LookupTable.insert;
end;

procedure TwwEditPictureForm.wwDBLookupComboDlg1Change(Sender: TObject);
begin
{   wwPictureEdit1.Picture.PictureMask:= NewPicture.Text;
   if not wwtable1.active then exit;

   if wwtable1.wwFindRecord(NewPicture.Text, 'Mask', mtExactMatch, False) then
      PictureDescription.Text:= wwtable1.FieldByName('Desc').asString
   else PictureDescription.Text:= 'Mask not found in database';
}   
{
   if wwtable1.indexName<>'iMask' then wwtable1.indexName:='iMask';
   if wwtable1.FindKey([NewPicture.Text]) then
      PictureDescription.Text:= wwtable1.FieldByName('Desc').asString
   else PictureDescription.Text:= 'Mask not found in database';
   }
end;

//Function TwwEditPictureForm.CreateNewPicture(ALookupTable: TTable): boolean;
//begin
(*
   result:= false;
   if not wwtable1.active then exit;

   Screen.cursor:= crHourGlass;
   with TwwEditMaskForm.create(Application) do begin
      Screen.cursor:= crDefault;
      if wwtable1.wwFindRecord(NewPicture.Text, 'Mask', mtExactMatch, False) then
{      if wwtable1.FindKey([NewPicture.Text]) then}
      begin
         if MessageDlg('Mask already exists.  Would you like to enter a new description for this mask?',
            mtInformation, [mbYes, mbNo], 0) = mrYes then
            PictureTable.goToCurrent(wwtable1)
         else begin
            Free;
            exit;
         end
      end
      else begin
          PictureTable.insert;
          PictureTable.FieldByName('Mask').asString:= NewPicture.Text;
      end;

      if ShowModal = mrOK then begin
         PictureTable.checkBrowseMode;
         if ALookupTable<>Nil then ALookupTable.gotoCurrent(PictureTable);
         result:= True;
      end;
      Free;
   end
*)
//end;

procedure TwwEditPictureForm.AutoFillClick(Sender: TObject);
begin
   wwPictureEdit1.Picture.AutoFill:= AutoFill.checked;
end;

procedure TwwEditPictureForm.Button3Click(Sender: TObject);
begin
   if wwPictureEdit1.isValidPictureValue(wwPictureEdit1.text) then
      Status.caption:= 'Value is valid'
   else Status.caption:= 'Picture does not accept value';
end;

procedure TwwEditPictureForm.Button4Click(Sender: TObject);
var
    Key, Value: string;
begin
   Screen.cursor:= crHourGlass;
   with TwwEditMaskForm.create(Application) do begin
      MaskEdit.Text:= NewPicture.text;
//      RefreshDescription;
      Description.text:= PictureDescription.Text;

      Screen.cursor:= crDefault;
      if ShowModal = mrOK then
      begin
         PictureDescription.text:= Description.text;
         NewPicture.Text:= MaskEdit.Text;
         Key:= PictureDescription.Text;
         Value:= NewPicture.Text;
         wwVerifyPictureKeyValue(Key,Value);
         IniPict.WriteString('Picture Masks', Key, Value);
      end;
      Free;
   end

end;

procedure TwwEditPictureForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (key=vk_f1) then wwALinkHelp(Handle, 'Picture_Masks')
end;


procedure TwwEditPictureForm.NewPictureCustomDlg(Sender: TObject);
var
    row: integer;
    masks: TStringList;
    key, value: string;
    mr: TModalResult;
begin
   with TwwPictureDialog.create(self) do begin
     masks:= TStringlist.create;
     IniPict.ReadSectionValues('Picture Masks', masks);
     for row:= 0 to masks.count-1 do begin
        stringgrid1.rowCount:= row+2;
        stringgrid1.cells[0,row+1]:= masks.Names[row];
        stringgrid1.cells[1,row+1]:= masks.values[masks.Names[row]];
        if stringgrid1.cells[1,row+1]=NewPicture.text then
           stringgrid1.row:= row+1;
     end;
     masks.free;

     mr:= ShowModal;

     if MaskChanged then
     begin
        { Strip out characters < 32 Ascii, and the = }
        IniPict.EraseSection('Picture Masks');
        for row:= 1 to StringGrid1.RowCount-1 do begin
          Key:= StringGrid1.Cells[0, row];
          Value:= StringGrid1.Cells[1, row];
          wwVerifyPictureKeyValue(Key,Value);
          IniPict.WriteString('Picture Masks', Key, Value);
        end;
     end;

     if mr=mrok then
     begin
        PictureDescription.text:= StringGrid1.cells[0, StringGrid1.Row];
        NewPicture.Text:= StringGrid1.cells[1, StringGrid1.Row];
        wwPictureEdit1.text:= '';
     end;

     free;
  end;

end;

procedure TwwEditPictureForm.RefreshDescription;
begin
   PictureDescription.Text:= wwIniGetPictureDescription(NewPicture.text);
end;

procedure TwwEditPictureForm.FormCreate(Sender: TObject);
begin
//   wwOpenPictureIni;
end;

procedure TwwEditPictureForm.FormDestroy(Sender: TObject);
begin
   IniPict.UpdateFile; //wwClosePictureIni;
end;

procedure TwwEditPictureForm.NewPictureExit(Sender: TObject);
begin
   RefreshDescription;
end;

end.

