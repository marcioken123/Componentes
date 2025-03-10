unit rcdpnldemo2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, wwriched, wwrcdpnl, Db, DBTables, Wwtable, Wwdatsrc,
  Buttons, wwDialog, wwrcdvw, Grids, wwDataInspector, wwframe, Mask,
  wwdbedit, Wwdotdot, wwdblook;

type
  TRecordViewPanelForm2 = class(TForm)
    wwDataSource1: TwwDataSource;
    wwTable1: TwwTable;
    wwRecordViewPanel1: TwwRecordViewPanel;
    wwDBRichEdit1: TwwDBRichEdit;
    wwDBRichEdit2: TwwDBRichEdit;
    Options: TwwDataInspector;
    SpeedButton1: TSpeedButton;
    wwTable2: TwwTable;
    wwDBLookupCombo1: TwwDBLookupCombo;
    procedure FrameEnabledChanged(Sender: TwwDataInspector;
      Item: TwwInspectorItem; NewValue: String);
    procedure FocusStyleChanged(Sender: TwwDataInspector;
      Item: TwwInspectorItem; NewValue: String);
    procedure TransparentChanged(Sender: TwwDataInspector;
      Item: TwwInspectorItem; NewValue: String);
    procedure NonFocusStyleCanged(Sender: TwwDataInspector;
      Item: TwwInspectorItem; NewValue: String);
    procedure BorderChanged(
      Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
    procedure OptionsCalcDataPaintText(Sender: TwwDataInspector;
      Item: TwwInspectorItem; var PaintText: String);
    procedure LabelsBeneathControlChanged(Sender: TwwDataInspector;
      Item: TwwInspectorItem; NewValue: String);
    procedure LayoutChanged(Sender: TwwDataInspector;
      Item: TwwInspectorItem; NewValue: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecordViewPanelForm2: TRecordViewPanelForm2;

implementation

{$R *.DFM}

procedure TRecordViewPanelForm2.FrameEnabledChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
var i: Integer;
   FrameEffects: TwwEditFrame; { Defined in wwframe unit }
   FrameEnabled: boolean;
begin
   FrameEnabled:= (NewValue = 'True');
   with wwRecordViewPanel1 do
   begin
      EditFrame.Enabled:= FrameEnabled;
      wwrecordviewpanel1.recreateControls;
   end;

   with Item do for i:= 0 to Items.count-1 do
      Items[i].visible:= FrameEnabled;

   with wwRecordViewPanel1 do begin
      for i:= 0 to controlcount-1 do begin
         FrameEffects := TwwEditFrame.Get(Controls[i]);
         if (FrameEffects<>nil) and (Controls[i] is TCustomEdit) then begin
           if FrameEnabled then { Custom framing needs borderstyle as bsNone }
             TEdit(Controls[i]).BorderStyle:= bsNone
           else
             TEdit(Controls[i]).BorderStyle:= bsSingle;
         end;
      end;
      Invalidate;
    end;


end;

procedure TRecordViewPanelForm2.FocusStyleChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
   with wwRecordViewPanel1 do
   begin
      EditFrame.FocusStyle:= TwwEditFocusStyle(strtoint(NewValue));
      recreateControls;
   end
end;

procedure TRecordViewPanelForm2.TransparentChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
   with wwRecordViewPanel1 do
   begin
      EditFrame.Transparent:= NewValue='True';
      recreateControls;
   end
end;

procedure TRecordViewPanelForm2.NonFocusStyleCanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
   with wwRecordViewPanel1 do
   begin
      EditFrame.NonFocusStyle:= TwwEditFocusStyle(strtoint(NewValue));
      recreateControls;
   end
end;

procedure TRecordViewPanelForm2.BorderChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
var NewBorderStyle: TwwEditFrameEnabledSet;
begin
   if Item.Caption='Left' then NewBorderStyle:= [efLeftBorder]
   else if Item.Caption = 'Right' then NewBorderStyle:= [efRightBorder]
   else if Item.Caption = 'Top' then NewBorderStyle:= [efTopBorder]
   else if Item.Caption = 'Bottom' then NewBorderStyle:= [efBottomBorder];

   with wwRecordViewPanel1 do
   begin
      if Item.ParentItem.Caption = 'Non-focus Borders' then
      begin
        if Item.checked then
           EditFrame.NonFocusBorders:= EditFrame.NonFocusBorders + NewBorderStyle
        else
           EditFrame.NonFocusBorders:= EditFrame.NonFocusBorders - NewBorderStyle
      end
      else begin
        if Item.checked then
           EditFrame.FocusBorders:= EditFrame.FocusBorders + NewBorderStyle
        else
           EditFrame.FocusBorders:= EditFrame.FocusBorders - NewBorderStyle
      end;
      recreateControls;
   end;
   Sender.InvalidateRow(Sender.GetRowByItem(Item.ParentItem)); { Invalidate parent item }

end;

procedure TRecordViewPanelForm2.OptionsCalcDataPaintText(
  Sender: TwwDataInspector; Item: TwwInspectorItem; var PaintText: String);
var CurItem: TwwInspectorItem;
begin
   { Paint parent nodes based on child node }
   if (Item.Caption = 'Non-focus Borders') or
      (Item.Caption = 'Focus Borders') then
   begin
      CurItem:= Item.GetFirstChild;
      PaintText:= '';
      while CurItem<>nil do begin
         if curItem.checked then
         begin
            if PaintText<>'' then PaintText:= PaintText + ',';
            PaintText:= PaintText + curItem.Caption;
         end;
         CurItem:= CurItem.GetNextSibling;
      end;
      PaintText:= '[' + PaintText + ']';
   end;
end;

procedure TRecordViewPanelForm2.LabelsBeneathControlChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
   if Item.checked then
      wwRecordViewPanel1.Options:=
        wwRecordViewPanel1.Options + [rvopLabelsBeneathControl]
   else
      wwRecordViewPanel1.Options:=
        wwRecordViewPanel1.Options - [rvopLabelsBeneathControl]
end;

procedure TRecordViewPanelForm2.LayoutChanged(
  Sender: TwwDataInspector; Item: TwwInspectorItem; NewValue: String);
begin
    if NewValue='1' then wwRecordViewPanel1.style:= rvpsHorizontal
    else wwRecordViewPanel1.style:= rvpsVertical;
    Sender.GetItemByCaption('Labels Beneath Edit Controls').visible:=
       (NewValue='1')
end;

end.
