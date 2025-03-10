unit DataInspectorU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, wwriched, Grids, wwdatainspector, Db, DBTables, Wwtable,
  Wwdatsrc, ExtCtrls, wwdbdatetimepicker, Buttons,
  wwSpeedButton, wwDBNavigator, wwclearpanel,
  Wwdbgrid, ImgList, Mask, wwdbedit, Wwdotdot,
  Wwdbcomb, wwrich, ExtDlgs, Wwintl;

type
  TDataInspectorDemo = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwTable1FirstName: TStringField;
    wwTable1LastName: TStringField;
    wwTable1MiddleName: TStringField;
    wwTable1Street: TStringField;
    wwTable1City: TStringField;
    wwTable1State: TStringField;
    wwTable1Zip: TStringField;
    wwTable1Country: TStringField;
    wwTable1PhoneNumber: TStringField;
    wwTable1FaxNumber: TStringField;
    wwTable1Company: TStringField;
    wwTable1JobTitle: TStringField;
    wwTable1EmployeeNo: TFloatField;
    wwTable1StartDateTime: TDateTimeField;
    wwTable1StartDate: TDateField;
    wwTable1NumberOrders: TFloatField;
    wwTable1WorkingHourStartTime: TTimeField;
    wwTable1WorkingHourEndTime: TTimeField;
    wwTable1PayType: TStringField;
    wwTable1PayRate: TFloatField;
    wwTable1Supervisor: TStringField;
    wwTable1SSN: TStringField;
    wwTable1RichEdit: TMemoField;
    wwTable1Sabatical: TStringField;
    wwTable1Memo: TMemoField;
    wwTable1Name: TStringField;
    wwDataInspector1: TwwDataInspector;
    wwTable1Address: TStringField;
    wwTable1EmploymentData: TStringField;
    wwTable1ContactInformation: TStringField;
    wwTable1Salary: TStringField;
    wwTable1Schedule: TStringField;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBNavigator1Refresh: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    wwDBComboDlg1: TwwDBComboDlg;
    Button1: TButton;
    Button2: TButton;
    wwDBRichEdit2: TwwDBRichEdit;
    OptionsInspector: TwwDataInspector;
    OpenPictureDialog1: TOpenPictureDialog;
    ImageList1: TImageList;
    wwIntl1: TwwIntl;
    Image1: TImage;

    procedure wwTable1CalcFields(DataSet: TDataSet);
    procedure BitmapEnabledChanged(ObjView: TwwDataInspector;
      ObjItem: TwwInspectorItem; NewValue: String);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure wwDBRichEdit2InitDialog(Form: TForm);
    procedure wwDataInspector1BeforePaint(Sender: TwwDataInspector);
    procedure wwDataInspector1DrawCaptionCell(Sender: TwwDataInspector;
      ObjItem: TwwInspectorItem; ASelected: Boolean; ACellRect: TRect;
      var ACaptionRect: TRect; var DefaultTextDrawing: Boolean);
    procedure wwDataInspector1AfterSelectCell(Sender: TwwDataInspector;
      ObjItem: TwwInspectorItem);
    procedure ExpandClick(Sender: TwwDataInspector;
      Item: TwwInspectorItem);
    procedure ExpandGlyphChanged(
      Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
    procedure CollapseGlyphChanged(
      Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
    procedure HideShowDataChanged(
      Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
    procedure CustomPaintingOptionsChanged(
      Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
    procedure wwDataInspector1BeforeSelectCell(Sender: TwwDataInspector;
      ObjItem: TwwInspectorItem; var CanSelect: Boolean);
    procedure OptionsInspectorCalcDataPaintText(Sender: TwwDataInspector;
      Item: TwwInspectorItem; var PaintText: String);
    procedure LabelLineStyleChanged(
      Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
    procedure DataLineStyleChanged(
      Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataInspectorDemo: TDataInspectorDemo;
  OldItem : TwwInspectorItem;

implementation

{$R *.DFM}

procedure TDataInspectorDemo.wwTable1CalcFields(DataSet: TDataSet);
begin
  with DataSet do begin
    FieldByName('Name').AsString:= FieldByName('FirstName').AsString+' '+
                          FieldByName('MiddleName').AsString+' '+
                          FieldByName('LastName').AsString;
    FieldByName('Address').AsString:=FieldByName('Street').AsString+#13#10+
                         FieldByName('City').AsString+', '+
                         FieldByName('State').AsString+', '+
                         FieldByName('Zip').AsString+#13#10+
                         FieldByName('Country').AsString;
    FieldByName('Salary').AsString:= '$'+FieldByName('PayRate').AsString+' '+
                          FieldByName('PayType').AsString;
    FieldByName('Schedule').AsString:= FieldByName('WorkingHourStartTime').AsString+'->'+
                          FieldByName('WorkingHourEndTime').AsString;
    end;
end;

procedure TDataInspectorDemo.BitmapEnabledChanged(
  ObjView: TwwDataInspector; ObjItem: TwwInspectorItem; NewValue: String);
begin
   wwDataInspector1.invalidate;
end;

procedure TDataInspectorDemo.Button1Click(Sender: TObject);
var curItem: TwwInspectorItem;
begin
   with wwdatainspector1 do
   begin
      curItem:= GetFirstChild;
      while curItem<>nil do begin
         curItem.expanded:= false;
         curItem:= curItem.GetNext;
      end
   end
end;

procedure TDataInspectorDemo.Button2Click(Sender: TObject);
var curItem: TwwInspectorItem;
begin
   with wwdatainspector1 do
   begin
      curItem:= GetFirstChild;
      while curItem<>nil do begin
         curItem.expanded:= True;
         curItem:= curItem.GetNext;
      end
   end
end;

procedure TDataInspectorDemo.wwDBRichEdit2InitDialog(Form: TForm);
begin
  TwwRichEditForm(form).richedit1.color:= clyellow;
end;

procedure TDataInspectorDemo.wwDataInspector1BeforePaint(Sender: TwwDataInspector);
var i, j: integer;
begin
   if not OptionsInspector.GetItemByTagString('Bitmap').checked then exit;

   with Image1 do
      for i := 0 to (Sender.Width div Picture.Width) do
         for j := 0 to (Sender.Height div Picture.Height) do
            Sender.Canvas.Draw(i*Picture.Width, j*Picture.Height,Picture.Bitmap);
end;

procedure TDataInspectorDemo.wwDataInspector1DrawCaptionCell(Sender: TwwDataInspector;
  ObjItem: TwwInspectorItem; ASelected: Boolean; ACellRect: TRect;
  var ACaptionRect: TRect; var DefaultTextDrawing: Boolean);
   function IsChildOfActiveNode:Boolean;
   var curitem:TwwInspectorItem;
   begin
      result := False;
      curitem := ObjItem;
      while (curitem <> nil) do begin
         if (curitem = Sender.ActiveItem) and (ObjItem <> Sender.ActiveItem) then begin
            result := True;
            break;
         end;
         curitem := curitem.parentitem;
      end;
   end;
begin
  with OptionsInspector do begin
    if IsChildOfActiveNode and  //Highlight Font of the Children of Active Item
       (GetItemByCaption('Highlight Children Of Active Node').EditText = 'True') then
       Sender.Canvas.Font.Color := clYellow
    else if (ObjItem = Sender.ActiveItem) and //Highlight Font of Active Item
       (GetItemByCaption('Highlight Active Node Font').EditText = 'True') then
       Sender.Canvas.Font.Color := clHighlight;

                     // Mark in Times in Red when worker has worked over 8 hours
    if (GetItemByCaption('Mark OverTime in Red').EditText = 'True') then begin
       if ((Frac(wwTable1WorkingHourEndTime.asDateTime)-
            Frac(wwTable1WorkingHourStartTime.asDateTime))>Frac(StrToDateTime('8:00'))) then
          if (ObjItem.Caption = 'Start Time') or (ObjItem.Caption = 'End Time') then
          begin
             Sender.Canvas.Brush.Color := clRed;
             Sender.Canvas.FillRect(ACellRect);
          end;
    end;
  end;
end;

procedure TDataInspectorDemo.wwDataInspector1AfterSelectCell(Sender: TwwDataInspector;
  ObjItem: TwwInspectorItem);
begin
  if OptionsInspector.GetItemByCaption('Highlight Children Of Active Node').EditText = 'False' then exit;
  //Invalidate Children of Current Active Node
  (Sender as TwwDataInspector).Invalidate;
  (Sender as TwwDataInspector).Update;
end;

procedure TDataInspectorDemo.ExpandClick(Sender: TwwDataInspector;
  Item: TwwInspectorItem);
begin
  OpenPictureDialog1.Title := 'Load Expand Glyph';
  if OpenPictureDialog1.Execute then begin
     wwDataInspector1.ButtonOptions.ExpandGlyph.LoadFromFile(OpenPictureDialog1.FileName);
     TEdit(Sender.ActiveEdit).Text := OpenPictureDialog1.FileName;
     wwDataInspector1.invalidate;
  end;
end;

procedure TDataInspectorDemo.ExpandGlyphChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
    if NewValue = '' then Exit;
    with wwDataInspector1.ButtonOptions.ExpandGlyph do begin
        Width := ImageList1.Width;
        Height := ImageList1.Height;
        Transparent := False;
        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(Rect(0,0,Width,Height));
        imagelist1.Draw(Canvas,0,0,StrToInt(NewValue));
    end;
    wwDataInspector1.invalidate;
    Sender.InvalidateRow(Sender.GetRowByItem(Item.ParentItem)); { Invalidate parent item }
end;

procedure TDataInspectorDemo.CollapseGlyphChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
    if NewValue = '' then Exit;
    with wwDataInspector1.ButtonOptions.CollapseGlyph do begin
        Width := ImageList1.Width;
        Height := ImageList1.Height;
        Transparent := False;
        Canvas.Brush.Color := clWhite;
        Canvas.FillRect(Rect(0,0,Width,Height));
        imagelist1.Draw(Canvas,0,0,StrToInt(NewValue));
    end;
    wwDataInspector1.invalidate;
    Sender.InvalidateRow(Sender.GetRowByItem(Item.ParentItem)); { Invalidate parent item }
end;

procedure TDataInspectorDemo.HideShowDataChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
  if NewValue = 'True' then begin
    wwDataInspector1.GetItemByCaption(Item.TagString).Visible := True;
    if Item.TagString = 'Employment Data' then
    begin
       (Sender as TwwDataInspector).GetItemByCaption('Show Salary').Visible := True;
       (Sender as TwwDataInspector).GetItemByCaption('Show Schedule').Visible := True;
    end;
  end
  else begin
    wwDataInspector1.GetItemByCaption(Item.TagString).Visible := False;
    if Item.TagString = 'Employment Data' then
    begin
       (Sender as TwwDataInspector).GetItemByCaption('Show Salary').Visible := False;
       (Sender as TwwDataInspector).GetItemByCaption('Show Schedule').Visible := False;
    end;
  end;
end;

procedure TDataInspectorDemo.CustomPaintingOptionsChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
  wwDataInspector1.invalidate;
end;

procedure TDataInspectorDemo.wwDataInspector1BeforeSelectCell(
  Sender: TwwDataInspector; ObjItem: TwwInspectorItem;
  var CanSelect: Boolean);
begin
  OldItem := Sender.ActiveItem;
end;

procedure TDataInspectorDemo.OptionsInspectorCalcDataPaintText(
  Sender: TwwDataInspector; Item: TwwInspectorItem; var PaintText: String);
  var CurItem:TwwInspectorItem;
begin
   { Paint parent nodes based on child node }
   if (Item.Caption = 'Line Style') or
      (Item.Caption = 'Custom Glyphs') then
   begin
      CurItem:= Item.GetFirstChild;
      PaintText:= '';
      while CurItem<>nil do begin
         if PaintText<>'' then
            PaintText:= PaintText + ',';
         PaintText:= PaintText + curItem.DisplayText;
         CurItem:= CurItem.GetNextSibling;
      end;
      PaintText:= '[' + PaintText + ']';
   end;
end;

procedure TDataInspectorDemo.LabelLineStyleChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
   wwDataInspector1.LineStyleCaption:= TwwDataInspectorLineStyle(strtoint(NewValue));
   Sender.InvalidateRow(Sender.GetRowByItem(Item.ParentItem)); { Invalidate parent item }
end;

procedure TDataInspectorDemo.DataLineStyleChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
   wwDataInspector1.LineStyleData:= TwwDataInspectorLineStyle(strtoint(NewValue));
   Sender.InvalidateRow(Sender.GetRowByItem(Item.ParentItem)); { Invalidate parent item }
end;

end.


