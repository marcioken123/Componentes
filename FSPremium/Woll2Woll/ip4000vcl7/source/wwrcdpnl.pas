{
//
// Components : TwwRecordViewPanel
//
// Copyright (c) 1998 by Woll2Woll Software
//
// 8/27/98 - Support images with TDBImage
// 9/3/98 - Tab order problem fixed
// 9/18/98 - Re-assigning of parent should scan backwards in notification
// 9/20/98 - Set tab orders for checkbox
// 9/25/98 - MaximizeMemoWidth property now maximizes all blob types
// 10/1/98 - Don't restore parent if parent is being destroyed
// 10/14/98 - Fix readonly problem for horizontal style
// 10/22/98 - Respect width change in OnAfterCreateControl
// 10/23/98 - Set to first wincontrol if active control is recordpanel
// 12/23/98 - Right alignment for labels
// 3/9/99 - If Panel's readonly property for checkbox is True, the checkbox was
//          still editable.
// 12/21/99 - Fix problem where recordviewpanel is blank in some cases
// 1/5/2000 - Fix bug with picture masks for non wwdatasets in horizontal style
// 8/7/2000 - Support background image when custom framing transpancey is enabled.
//            Fixes problem where first edit control was not painting background image
//            in some random cases
// 10/5/2000  Fix design-time delete problem with record-view component
// 9/9/02 -   Don't set MaxLength when have editmask.
}

unit wwrcdpnl;

{$i wwIfDef.pas}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  wwrcdvw, db, wwdatsrc, stdctrls, wwcommon, wwdbedit, dbctrls, wwstr,
  wwframe;

type
  TwwRecordViewPanelStyle = (rvpsVertical, rvpsHorizontal);
  TwwRecordViewPanelOption =
       (rvopHideReadOnly, rvopHideCalculated, rvopUseCustomControls,
                         rvopShortenEditBox, rvopConsistentEditWidth,
                         rvopMaximizeMemoWidth, rvopUseDateTimePicker,
                         rvopLabelsBeneathControl);
  TwwRecordViewPanelOptions = Set of TwwRecordViewPanelOption;
  TwwRecordOnBeforeCreateControl =
     procedure(Sender: TObject; curField: TField; var Accept: boolean) of object;
  TwwRecordOnAfterCreateControl =
     procedure(Sender: TObject; curField: TField; Control: TControl) of object;
  TwwRecordSetControlEffects =
     procedure(Sender: TObject; curField: TField; Control: TControl;
        Frame: TwwEditFrame; ButtonEffects: TwwButtonEffects) of object;

  TwwRecordViewPanel = class(TScrollBox)
  private
     FSelected: TStrings;
     FUseTFields: boolean;
     FEditSpacing: TwwEditSpacing;
     FMargin: TwwMargin;
     FDataLink: TDataLink;
     FOptions: TwwRecordViewPanelOptions;
     FControlOptions: TwwRecordViewControlOptions;
     FLabelFont: TFont;
     FOnBeforeCreateControl: TwwRecordOnBeforeCreateControl;
     FOnAfterCreateControl: TwwRecordOnAfterCreateControl;
     FOnSetControlEffects: TwwRecordSetControlEffects;
     FReadOnlyColor: TColor;
     FStyle: TwwRecordViewPanelStyle;
     FLinesPerMemoControl: integer;
     FParentObject: TWinControl;
     FDefaultEditFrame: TwwEditFrame;

     EditStartOffset: integer;
     CustomControlList: TList;
     InApply: boolean;
     RecreateNextTime: boolean;
     ControlPositions: TList;

     FControlType: TStrings;
     FControlInfoInDataset: boolean;
     FPictureMasks: TStrings;
     FPictureMaskFromDataSet: boolean;
//     FActiveField: string;
     CurLabel: TLabel;
//     {$ifdef wwdelphi4up}
//     FShowImages: boolean;
//     {$endif}

     procedure SetDataSource(value : TDataSource);
     Function GetDataSource: TDataSource;
     Procedure SetLabelFont(val: TFont);
     Function ShowField(field: TField; curFieldReadOnly: boolean): boolean;
     Procedure AddCustomControl(CustomEdit: TWinControl);
     procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
     procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
     procedure LabelFontChanged(Sender: TObject);
     procedure SetOptions(val: TwwRecordViewPanelOptions);
     Procedure SetControlOptions(val: TwwRecordViewControlOptions);
     procedure SetStyle(val: TwwRecordViewPanelStyle);
     function IsCustomEditCell(curField: TField;
        var customEdit: TWinControl) : boolean;
     Function UseCustomControls: boolean;
     procedure AddControlPosition(Control: TControl; Left, Top, Width, Height: integer);
     procedure SetLinesPerMemoControl(val: integer);
//     {$ifdef wwdelphi4up}
//     procedure SetShowImages(val: boolean);
//     {$endif}
     procedure SetPictureMasks(val: TStrings);
     procedure SetControlType(val: TStrings);

  protected
     function IsSingleLineEditControl(EditControl: TWinControl): boolean; virtual;
     procedure DoOnBeforeCreateControl(Sender: TObject; curField: TField;
               var accept: boolean); virtual;
     procedure DoOnAfterCreateControl(Sender: TObject; curField: TField;
               Control: TControl); virtual;
     procedure DoSetControlEffects(
        Sender : TObject; curfield: TField;
        control: TControl; Frame: TwwEditFrame; ButtonEffects: TwwButtonEffects);
     procedure Notification(AComponent: TComponent;
       Operation: TOperation); override;
     Procedure DisplayVertical(Recreate: boolean);
     Procedure DisplayHorizontal(Recreate: boolean);
     procedure Resize; override;
     procedure LinkActive(Value: Boolean); virtual;
     procedure FreeNonCustomControls(DestroyControls: boolean);
     Function Apply(Recreate: boolean): boolean; virtual;
     procedure CreateParams(var Params: TCreateParams); override;
     function HasFrame(Control: TWinControl): boolean;
     function HasButtonEffects(Control: TWinControl): boolean;
     procedure CreateWnd; override;
  public
     Patch: Variant;
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
     Procedure RefreshControls;
     Procedure RecreateControls;
     Procedure ClearControls;  { Call before changing dataset at runtime }
  published
     {$ifdef wwDelphi4Up}
     property Anchors;
     property Constraints;
     {$endif}

     property ControlInfoInDataset: boolean
            read FControlInfoInDataset write FControlInfoInDataSet default True;
     property ControlType : TStrings read FControlType write SetControlType;
     property PictureMaskFromDataSet: boolean
              read FPictureMaskFromDataSet write FPictureMaskFromDataSet default True;
     property PictureMasks: TStrings read FPictureMasks write SetPictureMasks;

     property DataSource: TDataSource read GetDataSource write SetDataSource;
     property EditFrame: TwwEditFrame read FDefaultEditFrame write FDefaultEditFrame;
     property EditSpacing: TwwEditSpacing read FEditSpacing write FEditSpacing;
     property Margin: TwwMargin read FMargin write FMargin;
//     {$ifdef wwdelphi4up}
//     property ShowImages: boolean read FShowImages write SetShowImages default True;
//     {$endif}
     property Style : TwwRecordViewPanelStyle read FStyle write SetStyle default rvpsVertical;
     property Options: TwwRecordViewPanelOptions read FOptions write SetOptions
              default [rvopShortenEditBox, rvopUseCustomControls,
                       rvopMaximizeMemoWidth, rvopUseDateTimePicker];
     property ControlOptions: TwwRecordViewControlOptions read FControlOptions write SetControlOptions;
     property LabelFont: TFont read FlabelFont write SetLabelFont;
     property ReadOnlyColor: TColor read FReadOnlyColor write FReadOnlyColor default clInactiveCaptionText;
     property Selected: TStrings read FSelected write FSelected;
     property LinesPerMemoControl: integer read FLinesPerMemoControl write SetLinesPerMemoControl default 2;
//     property ActiveField: string read FActiveField write FActiveField;

     property OnBeforeCreateControl: TwwRecordOnBeforeCreateControl
              read FOnBeforeCreateControl write FOnBeforeCreateControl;
     property OnAfterCreateControl: TwwRecordOnAfterCreateControl
              read FOnAfterCreateControl write FOnAfterCreateControl;
     property OnSetControlEffects: TwwRecordSetControlEffects
              read FOnSetControlEffects write FOnSetControlEffects;
  end;

procedure Register;

implementation

uses wwriched, wwdbdatetimepicker,
{$ifdef wwDelphi6Up}
variants,
{$endif}
wwradiogroup;

type
  TwwRecordViewDataLink = class(TDataLink)
  private
    FRecordViewPanel: TwwRecordViewPanel;
  protected
    procedure ActiveChanged; override;
    procedure LayoutChanged; override;
  public
    constructor Create(ARecordViewPanel: TwwRecordViewPanel);
  end;

constructor TwwRecordViewDataLink.Create(ARecordViewPanel: TwwRecordViewPanel);
begin
  inherited Create;
  FRecordViewPanel:= ARecordViewPanel;
end;

procedure TwwRecordViewDataLink.LayoutChanged;
begin
//  FRecordViewPanel.LinkActive(Active);
end;

procedure TwwRecordViewDataLink.ActiveChanged;
begin
   FRecordViewPanel.RecreateControls;
end;

procedure TwwRecordViewPanel.LinkActive(Value: Boolean);
begin
   Apply(True);
end;

constructor TwwRecordViewPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDataLink:= TwwRecordViewDataLink.create(self);
  FEditSpacing:= TwwEditSpacing.create;
  FParentObject:= Nil;
  with FEditSpacing do begin
     VerticalView:= TwwVertEditSpacing.create;
     VerticalView.BetweenRow:= 2;
     VerticalView.BetweenLabelEdit:= 5;
     VerticalView.Owner:= self;
     HorizontalView:= TwwHorzEditSpacing.create;
     HorizontalView.BetweenRow:= 2;
     HorizontalView.BetweenLabelEdit:= 1;
     HorizontalView.BetweenEditsInRow:= 5;
     HorizontalView.LabelIndent:= 1;
     HorizontalView.Owner:= self;
  end;

  FMargin:= TwwMargin.create;
  with FMargin do begin
     LeftOffset:= 5;
     RightOffset:=5;
     TopOffset:= 5;
     BottomOffset:=5;
     Owner:= self;
  end;

  FOptions:= [rvopShortenEditBox, rvopUseCustomControls,
              rvopMaximizeMemoWidth, rvopUseDateTimePicker];
//  FShowImages:= True;
  FLabelFont:= TFont.create;
  FLabelFont.OnChange := LabelFontChanged;
//  FCaption:= 'Record View';
  FReadOnlyColor:= clInactiveCaptionText;
  FStyle:= rvpsVertical;
  FSelected:= TStringList.create;
  FUseTFields:= False;
  CustomControlList:= TList.create;
  ControlPositions:= TList.create;
  FLinesPerMemoControl:= 2;

  FControlType:= TStringList.create;
  FControlInfoInDataset:= True;
  FPictureMasks:= TStringList.create;
  FPictureMaskFromDataSet:= True;

  Patch:= VarArrayCreate([0, 1], varVariant);
  Patch[0]:= False;
  Patch[1]:= True;

  FDefaultEditFrame:= TwwEditFrame.create(self);
end;

type
  TControlPosition = class
     control: TControl;
     Left, Top, Width, Height: integer;
  end;


destructor TwwRecordViewPanel.Destroy;
var i: integer;
begin
  FDefaultEditFrame.Free;
  FDataLink.free;
  FDataLink:= nil;
  FEditSpacing.Free;
  FMargin.Free;
  FLabelFont.Free;
  FSelected.Free;
  FreeNonCustomControls(True);
  for i:= 0 to CustomControlList.count-1 do TwwCustomControlItem(CustomControlList[i]).Free;
  CustomControlList.Free;
  CustomControlList:= nil; // 10/5/00
  for i:= 0 to ControlPositions.count-1 do TControlPosition(ControlPositions[i]).Free;
  ControlPositions.Free;
  FControlType.Free;
  FPictureMasks.Free;

  inherited destroy;
end;


procedure TwwRecordViewPanel.SetDataSource(value : TDataSource);
var OldControlCount: integer;
begin
   OldControlCount:= ControlCount;
   FDataLink.dataSource:= value;
   if (ControlCount=OldControlCount) then
     LinkActive(FDataLink.Active);
end;

Function TwwRecordViewPanel.GetDataSource: TDataSource;
begin
   Result:= FdataLink.dataSource as TDataSource;
end;

procedure TwwRecordViewPanel.setLabelFont(val: TFont);
begin
    FLabelFont.assign(Val);
    Apply(False);
end;

procedure TwwRecordViewPanel.DoSetControlEffects(
   Sender : TObject; curfield: TField;
   control: TControl; Frame: TwwEditFrame; ButtonEffects: TwwButtonEffects);
begin
   if Assigned(FOnSetControlEffects) then
      FOnSetControlEffects(Sender, curfield, control, Frame, ButtonEffects);
end;

procedure TwwRecordViewPanel.DoOnAfterCreateControl(
    Sender: TObject; curField: TField; Control: TControl);
var ButtonEffects: TwwButtonEffects;
    Frame: TwwEditFrame;
//    OldHeight: integer;


 procedure UpdatePositions;
 begin
   if (style=rvpshorizontal) then begin
      if (Control is TwwRadioGroup) and TwwRadioGroup(Control).ShowGroupCaption then
      begin
         curLabel.visible:= False;
         control.top:= curlabel.top;
         TwwRadioGroup(control).caption:= curlabel.caption;
      end;
      if (rvopLabelsBeneathControl in Options) then
      begin
         if not (control is TLabel) then
         begin
            control.top:= curLabel.Top;
            curLabel.Top:=
              control.top + control.Height + EditSpacing.HorizontalView.BetweenLabelEdit-1;
         end
      end;
   end;
{
   if (rvopLabelsBeneathControl in Options) and (style=rvpsHorizontal) then
   begin
      if not (control is TLabel) then
      begin
         control.top:= curLabel.Top;
         curLabel.Top:=
            control.top + control.Height + EditSpacing.HorizontalView.BetweenLabelEdit-1;
      end
   end;
}
 end;

begin
   ButtonEffects:= TwwButtonEffects.Get(Control);
   Frame:= TwwEditFrame.Get(Control);

   if ButtonEffects<>nil then with buttoneffects do begin
      transparent:= rvcTransparentButtons in ControlOptions;
      flat:= rvcFlatButtons in ControlOptions;
   end;
   if Frame<>nil then Frame.Assign(EditFrame);

   try
     if (Frame<>nil) then
        DoSetControlEffects(Sender, curfield, control, Frame, ButtonEffects);

//      OldHeight:= Control.Height;
      if Assigned(FOnAfterCreateControl) then
         FOnAfterCreateControl(Sender, curfield, control);
      {if Control.Height<>OldHeight then }
      UpdatePositions;
   finally
   end;


end;

procedure TwwRecordViewPanel.DoOnBeforeCreateControl(
    Sender: TObject; curField: TField; var accept: boolean);
begin
   if Assigned(FOnBeforeCreateControl) then
      FOnBeforeCreateControl(Sender, curfield, accept);
end;


procedure TwwRecordViewPanel.FreeNonCustomControls(DestroyControls: boolean);
var i, j: integer;
   DeleteControl: boolean;
   customItem: TwwCustomControlItem;
begin
   for i:= ControlCount-1 downto 0 do begin
      DeleteControl:= True;
      if Controls[i].owner<>self then DeleteControl:= False;

      for j:= 0 to CustomControlList.count-1 do begin
         customItem:= TwwCustomControlItem(CustomControlList[j]);
         if Controls[i]=CustomItem.control then
         begin
            DeleteControl:= False;
            if (Controls[i].Owner is TWinControl) then
            begin
               Controls[i].visible:= CustomItem.Oldvisible;
               Controls[i].left:= CustomItem.left;
               Controls[i].top:= CustomItem.top;
               Controls[i].width:= CustomItem.width;
               Controls[i].height:= CustomItem.height;
               wwSetControlDataSource(TWinControl(Controls[i]), nil);
               wwSetControlDataField(TWinControl(Controls[i]), '');

               if HasButtonEffects(TWinControl(Controls[i])) then
               begin
                  TwwButtonEffects.Get(Controls[i]).Transparent:= customItem.ButtonTransparent;
                  TwwButtonEffects.Get(Controls[i]).Flat:= customItem.ButtonFlat;
               end;

               if (CustomItem.OldParent=Nil) or { 10/1/98 }
                  not (csDestroying in CustomItem.OldParent.ComponentState) then
                  Controls[i].parent:= CustomItem.OldParent //ValidParentForm(self)
            end;
            break;
         end
      end;
      if DeleteControl then begin
         if DestroyControls then Controls[i].Free
         else begin
            if Controls[i] is TWinControl then
            begin
               if not wwSetControlDataField(controls[i] as TWinControl, '') then continue;
            end
         end
      end
   end;

   for i:= 0 to CustomControlList.count-1 do TwwCustomControlItem(CustomControlList[i]).Free;
   CustomControlList.Clear;

end;

Function TwwRecordViewPanel.UseCustomControls: boolean;
begin
  result:= (rvopUseCustomControls in Options)
{         and
      not (csDesigning in ComponentState)}
end;

procedure TwwRecordViewPanel.AddControlPosition(Control: TControl; Left, Top, Width, Height: integer);
var cp: TControlPosition;
begin
    cp:= TControlPosition.create;
    cp.Control:= Control;
    cp.Left:= Left;
    cp.Top:= Top;
    cp.Height:= Height;
    cp.Width:= Width;
    ControlPositions.Add(cp);
end;

Procedure TwwRecordViewPanel.DisplayVertical(Recreate: boolean);
const FixedEditWidthConst=0;
var
    LabelWidth, MaxLabelWidth, MaxEditWidth: integer;
    APos, i, j, numFields: integer;
    curFieldDisplayWidth: integer;
    curFieldDisplayLabel: wwSmallString;
    curFieldReadOnly: boolean;
    curField: TField;
    curLabel: Tlabel;
    customEdit: TWinControl;
    checkbox: TwwDBCheckBox;
    EditHeight: integer;
    FixedEditWidth: integer;
    accept: boolean;
    PrevTop: integer;
    checkboxOn, checkboxOff: wwSmallString;
    Bitmap: TBitmap;
    curEditControl: TControl;
    NextTabOrder: integer;
    tempWidth: integer;
    tempControlCount: integer;

    ControlPositionLeft, ControlPositionTop,
    ControlPositionWidth, ControlPositionHeight: integer;
    cp: TControlPosition;
    EditControl: TWinControl;
    ShowingVertScrollBar: boolean;
    OldWidth: integer;
    BackgroundImage: boolean;

    Function CreateEditControl(EditControl: TWinControl): boolean;
    var
       tempMask: string;
       tempAutoFill: boolean;
       tempUsePictureMask: boolean;
    begin
        result:= False;

        if EditControl is TwwDBCustomEdit then
        begin
            if wwGetPictureControl(self)=self then { Picture masks do not come from dataset }
            begin
               wwPictureByField(self, curField.FieldName, False,
                   tempMask, tempAutoFill, tempUsePictureMask);
               with TwwDBEdit(EditControl).Picture do
               begin
                  PictureMaskFromDataSet:= False;
                  PictureMask:= tempMask;
                  AutoFill:=tempAutoFill;
               end
            end
        end;

        with EditControl do begin
           if recreate then begin
              curLabel.FocusControl:= EditControl;
              visible:= False;
              parent:= self;
              if not wwSetControlDataSource(EditControl, self.datasource) then exit;
              if not wwSetControlDataField(EditControl, curField.fieldName) then exit;

              if curFieldReadonly or curField.calculated then
              begin
                 TEdit(EditControl).color:= ReadOnlyColor;
                 EditControl.tabStop:= False;
              end;

              if EditControl is TwwDBEdit then
              begin
                 if curField is TStringField then  {7/29/97 - Limit length to field size }
                    if curField.editmask='' then // 9/9/02
                      TEdit(EditControl).maxlength:= curField.Size;
              end;

           end;

           if isSingleLineEditControl(EditControl) then
              TempWidth:= (curFieldDisplayWidth+1) * Bitmap.Canvas.TextWidth('0') + 3
           else
              TempWidth:= FixedEditWidth; //Self.width - EditStartOffset - Margin.RightOffset;

           if EditControl is TwwDBDateTimePicker then
           begin
              TempWidth:=
                    TempWidth + TwwDBDateTimePicker(EditControl).Button.Width
           end;

           if rvopShortenEditBox in Options then begin
              if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
           end;
           if rvopConsistentEditWidth in Options then begin
              if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth;
           end;

           ControlPositionLeft:= EditStartOffset; {EditPosition.LeftOffset + LabelWidth + 5;}
           ControlPositionTop:= PrevTop;

           if IsSingleLineEditControl(EditControl) then
              ControlPositionHeight:= EditControl.Height
           else
              ControlPositionHeight:= Bitmap.Canvas.TextHeight('0') * LinesPerMemoControl + 8; {2 lines of Memo}
           { 11/11/99 - Only set enabled to false if recreating control }
           if Recreate and CurFieldReadOnly then enabled:=False;
       end;

       if not Recreate then begin
          if rvopShortenEditBox in Options then begin
             if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
          end;

          if rvopConsistentEditWidth in Options then begin
             if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth; //!!!
          end;

          ControlPositionWidth:= TempWidth;
          ControlPositionHeight:= EditControl.Height;

          AddControlPosition(EditControl, ControlPositionLeft, ControlPositionTop,
                             ControlPositionWidth, ControlPositionHeight);
       end
       else begin
          EditControl.Left:= ControlPositionLeft;
          EditControl.Top:= ControlPositionTop;
          EditControl.Height:= ControlPositionHeight;

          OldWidth:= EditControl.Width; { 10/22/98 - Respect width change }
          DoOnAfterCreateControl(self, curField, EditControl);
          if EditControl.Width<>OldWidth then TempWidth:= EditControl.Width; { 10/22/98 }

          if rvopShortenEditBox in Options then begin
             if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
          end;

          if rvopConsistentEditWidth in Options then begin
             if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth; //!!
          end;

          EditControl.Width:= TempWidth;
       end;

       MaxEditWidth:= wwmax(MaxEditWidth, TempWidth);
       PrevTop:= Prevtop + EditControl.Height + EditSpacing.VerticalView.BetweenRow;
       EditHeight := EditControl.Height;

       EditControl.tabOrder:= NextTabOrder; {9/3/98 - Fix tab order problem }
       inc(NextTabOrder);
       result:= True;

       if recreate then curField.FreeNotification(self);

    end;


begin
   tempControlCount:= 0;
   for i:= 0 to ControlCount-1 do
      if Controls[i].owner=self then inc(TempControlCount);
   if TempControlCount=0 then Recreate:= True;

   if FDataLink.Active or (DataSource=Nil) or (Datasource.dataset=Nil) then
   begin
      if (Recreate) then FreeNonCustomControls(True);
      if (DataSource=nil) or (Datasource.dataset=nil) or (not Datasource.dataset.active) then begin
         exit;
      end
   end
   else begin
//      if (Recreate) then FreeNonCustomControls; { If inactive then don't show controls }
      exit;
   end;

   PrevTop:= Margin.TopOffset;

   if (selected.count=0) then numFields:= DataSource.DataSet.FieldCount
   else numFields:= Selected.count;

   Bitmap:= TBitmap.create;
   ControlPositions.Clear;

   try
      MaxLabelWidth:= 0;
      Bitmap.Canvas.Font := LabelFont;
      for i:= 0 to numFields-1 do begin
         if (Selected.count=0) or FuseTFields then begin
            curField:= DataSource.dataset.fields[i];
            curFieldDisplayLabel:= curField.DisplayLabel;
            curFieldReadOnly:= curfield.ReadOnly;
         end
         else begin
            APos:= 1;
            curField:= DAtaSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then begin
               strGetToken(Selected[i], #9, APos);
               curFieldDisplayLabel:= strGetToken(Selected[i], #9, APos);  { 6/4/97}
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T');
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;
         MaxLabelWidth:= wwMax(MaxLabelWidth,
                          Bitmap.Canvas.TextWidth(curFieldDisplayLabel));
      end;

      LabelWidth:= MaxLabelWidth;
      Bitmap.Canvas.Font := Font;
            { Limit form length }
      EditStartOffset:= Margin.LeftOffset + labelWidth + EditSpacing.VerticalView.BetweenLabelEdit;

      { Compute desired form length }
      MaxEditWidth:= 0;
      curFieldDisplayWidth:= 0;

      for i:= 0 to numFields-1 do begin
         if (Selected.count=0) or FuseTFields then
         begin
            curField:= DataSource.dataset.fields[i];
            curFieldDisplayWidth:= curField.DisplayWidth;
            curFieldReadOnly:= curField.ReadOnly;
         end
         else begin
            APos:= 1;
            curField:= DataSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then
            begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               strGetToken(Selected[i], #9, APos); { Display label }
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T')
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;

         MaxEditWidth:= wwmax(MaxEditWidth,
               (CurFieldDisplayWidth+1) * Bitmap.Canvas.TextWidth('0') + 3);
      end;

      MaxEditWidth:= 0;
      EditHeight:= 8;
      NextTabOrder:= 0;
      FixedEditWidth:= Width - (EditStartOffset + Margin.RightOffset + FixedEditWidthConst);
      if BorderStyle=bsSingle then FixedEditWidth:= FixedEditWidth - 4;

      for i:= 0 to numFields-1 do begin
         if (Selected.count=0) or FuseTFields then
         begin
            curField:= DAtaSource.dataset.fields[i];
            curFieldDisplayWidth:= curField.displayWidth;
            curFieldDisplayLabel:= curField.displayLabel;
            curFieldReadOnly:= curField.readonly;
         end
         else begin
            APos:= 1;
            curField:= DAtaSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               curFieldDisplayLabel:= strGetToken(Selected[i], #9, APos);  { 6/4/97}
               curFieldReadOnly :=strGetToken(Selected[i], #9, APos) = 'T'
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;

         accept:= True;
         if Recreate then
            DoOnBeforeCreateControl(self, curField, accept);
         if not accept then continue;

         curLabel:= nil;
         curEditControl:= nil;

         if (not Recreate)  then begin
            for j:= 0 to CustomControlList.count-1 do begin
               TwwCustomControlItem(CustomControlList[j]).control.parent:= self;
            end;
            for j:= 0 to ControlCount-1 do begin
               if TControl(Controls[j]) is TWinControl then begin
                  if wwEqualStr(wwGetControlDataField(TWinControl(Controls[j])),
                                curField.fieldname) then
                  begin
                     curEditControl:= Controls[j];
                     break;
                  end
               end
            end;
            if curEditControl<>Nil then begin
               for j:= 0 to ControlCount-1 do begin
                  if TControl(Controls[j]) is TLabel then begin
                     curLabel:= TLabel(Controls[j]);
                     if TLabel(Controls[j]).FocusControl=curEditControl then
                     begin
                        curLabel:= TLabel(Controls[j]);
                        break;
                     end
                  end
               end
            end
            else continue; { 3/11/99 - No edit control exists for this field }
         end;

         if curLabel=Nil then begin
            if (rvopUseCustomControls in Options) and
               wwIsCheckbox(self, curField, checkboxOn, checkboxOff) then
               curLabel:= TwwLabel.create(self)
            else
               curLabel:= TLabel.create(self);
         end;
         self.curlabel:= curLabel;

         with curLabel do begin
            if recreate then begin
              parent:= self;
//              AutoSize:= True; { 12/23/98 - Right alignment for labels }
              AutoSize:= False;
              Width:= LabelWidth;

              font:= self.labelFont;
              Caption:= strReplaceChar(curfieldDisplayLabel, '~', ' ');
              alignment:= taRightJustify;
            end
            else begin
              if AutoSize<>False then AutoSize:= False;
              if Width<>LabelWidth then Width:= LabelWidth;
              if Alignment<>taRightJustify then alignment:= taRightJustify;
            end;

            font:= self.labelFont;

            ControlPositionLeft:= Margin.LeftOffset;
            if (rvopUseCustomControls in Options) and
               wwIsCheckbox(self, curField, checkboxOn, checkboxOff) then
               ControlPositionTop:= PrevTop + 1
            else
               ControlPositionTop:= PrevTop + 4;

            if recreate then
            begin
               Left:= ControlPositionLeft;
               Top:= ControlPositionTop;
            end
            else AddControlPosition(curLabel,
                      ControlPositionLeft, ControlPositionTop, curlabel.Width, curLabel.Height);
         end;

         if Recreate then
         begin
            if rvcTransparentLabels in ControlOptions then curLabel.transparent:= true;
            DoOnAfterCreateControl(self, curField, curLabel);
         end;

         if (rvopUseCustomControls in Options) and
            wwIsCheckbox(self, curField, checkboxOn, checkboxOff) then
         begin
            if (not Recreate) and (curEditControl<>Nil) then
            begin
               checkbox:= TwwDBCheckBox(curEditControl);
               ControlPositionLeft:= EditStartOffset;
               ControlPositionTop:= PrevTop;
               AddControlPosition(CheckBox, ControlPositionLeft, ControlPositionTop,
                                   Checkbox.Width, Checkbox.Height);
            end
            else begin
               checkbox:= TwwDBCheckBox.create(self);
               checkbox.LabelControl:= curLabel;
               curLabel.FocusControl:= checkBox;
               with checkbox do begin
                 parent:= self;
                 datasource:= self.DataSource;
                 datafield:= curfield.fieldName;
                 caption:= '';
                 valueChecked:= checkboxOn;
                 valueUnchecked:= checkboxOff;
                 Width:= 17;
                 left:= EditStartOffset; {EditPosition.LeftOffset + LabelWidth + 5;}
                 Top:= PrevTop;

                 if curFieldReadOnly or Field.calculated then
                 begin
                    tabStop:= False;
                    Enabled:=False; { 3/9/99 - Readonly checkbox }
                 end;
              end;
              if Recreate then
                 DoOnAfterCreateControl(self, curField, checkbox);
            end;

            MaxEditWidth:= wwmax(MaxEditWidth, checkbox.Width);
            PrevTop:= Prevtop + checkbox.Height + EditSpacing.VerticalView.BetweenRow;
            EditHeight:= checkbox.Height;

            { 9/20/98 - Set tab orders for checkbox }
            checkbox.TabOrder:= NextTabOrder;  { 3/11/99 - Previously didn't have checkbox.taborder }
            inc(NextTabOrder);
         end
         else if UseCustomControls and
            IsCustomEditCell(curField, customEdit) then
         with TEdit(CustomEdit) do begin
            curLabel.FocusControl:= CustomEdit;

            if Recreate then begin
               AddCustomControl(CustomEdit);
               parent:= self;
               if not wwSetControlDataSource(customEdit, datasource) then continue;
               if not wwSetControlDataField(customEdit, '') then continue;
               if not wwSetControlDataField(customEdit, curField.fieldName) then continue;
            end
            else parent:= self;

//            visible:= True; { Causes custom control's to flicker when coming up }
            Ctl3d:= True;
            if not HasFrame(customEdit) then BorderStyle:= bsSingle;
            ControlPositionLeft:= EditStartOffset;
            ControlPositionTop:= PrevTop;

            if (wwisclass(customedit.classtype,'TwwCustomRichEdit')) then
               TempWidth:= FixedEditWidth
            else
               TempWidth:= (curFieldDisplayWidth+1) * Bitmap.Canvas.TextWidth('0') + 3;

            if rvopShortenEditBox in Options then begin
               if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
            end;
            if rvopConsistentEditWidth in Options then begin
               if TempWidth<FixedEditWidth then TempWidth:= FixedEditWidth;
            end;

            TEdit(CustomEdit).HandleNeeded;

            if not Recreate then begin
               ControlPositionWidth:= TempWidth;
               ControlPositionHeight:= CustomEdit.Height;
               AddControlPosition(CustomEdit, ControlPositionLeft, ControlPositionTop,
                                 TempWidth, ControlPositionHeight);
            end
            else begin
               Left:= ControlPositionLeft;
               Top:= ControlPositionTop;
               OldWidth:= CustomEdit.Width; { 10/22/98 - Respect width change }
               if (Patch[0]=True) and curFieldReadOnly then
               begin
                  CustomEdit.tabStop:= not curFieldReadOnly;
                  CustomEdit.enabled:= not curFieldReadOnly;
                  TEdit(CustomEdit).Color:= ReadOnlyColor;
               end;
               DoOnAfterCreateControl(self, curField, CustomEdit);
               if CustomEdit.Width<>OldWidth then TempWidth:= CustomEdit.Width; { 10/22/98 }
               customEdit.Width:= TempWidth;
            end;

            MaxEditWidth:= wwmax(MaxEditWidth, TempWidth);
            PrevTop:= Prevtop + customEdit.Height + EditSpacing.VerticalView.BetweenRow;
            EditHeight:= customEdit.Height;

            tabOrder:= NextTabOrder;
            inc(NextTabOrder);
         end
         else if (curField is TDateTimeField) and
                 (rvopUseDateTimePicker in Options) then
         begin
            if recreate or (curEditControl=Nil) then
               EditControl:= TwwDBDateTimePicker.create(self)
            else EditControl:= TwwDBDateTimePicker(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (not (csDesigning in ComponentState)) and
            wwIsRichEditField(curField, True) then begin
            if recreate or (curEditControl=Nil) then EditControl:= TwwDBRichEdit.create(self)
            else EditControl:= TwwDBRichEdit(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftMemo) then begin
            if recreate or (curEditControl=Nil) then
            begin
               if EditFrame.IsFrameEffective then
                  EditControl:= TwwDBEditMemo.create(self)
               else
                  EditControl:= TwwDBMemo.create(self)
            end
            else EditControl:= TWinControl(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftGraphic) then begin { 8/27/98 - Support images }
            if recreate or (curEditControl=Nil) then editControl:= TDBImage.create(self)
            else EditControl:= TWinControl(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else begin
            if recreate or (curEditControl=Nil) then begin
               EditControl:= TwwDBEdit.create(self);
               EditControl.controlStyle:= EditControl.ControlStyle + [csNoDesignVisible];
            end
            else EditControl:= TWinControl(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
      end;

      PrevTop := PrevTop + Margin.BottomOffset - EditSpacing.VerticalView.BetweenRow;

      VertScrollBar.Margin:= 6;
      VertScrollBar.Increment:= EditHeight + EditSpacing.VerticalView.BetweenRow;
      VertScrollBar.Range := PrevTop;

      { Shrink edit controls to fit panel width }
      if (Height<PrevTop) then
      begin
          {$ifdef wwDelphi4up}
          ShowingVertScrollBar:= True;
          {$else}
          ShowingVertScrollBar:= False; { Skip Delphi 4 specific code for setting horz scroll range }
          {$endif}
          FixedEditWidth:= FixedEditWidth - GetSystemMetrics(SM_CXHThumb);
          if Recreate then begin
            for j:= 0 to ControlCount-1 do begin
               if TControl(Controls[j]) is TWinControl then begin
                  curEditControl:= Controls[j];
                  if ((rvopShortenEditBox in Options) or
                      (rvopConsistentEditWidth in Options) or
                      (not isSingleLineEditControl(TWinControl(curEditControl)))) then
                     if (curEditControl.Width>FixedEditWidth) then
                     begin
                        curEditControl.Width:= FixedEditWidth;
                     end
               end;
            end
          end
          else begin
             for j:= 0 to ControlPositions.count-1 do
             begin
                cp:= TControlPosition(ControlPositions[j]);
                with cp do
                begin
                   if Control is TWinControl then
                   begin
                     if ((rvopShortenEditBox in Options) or
                         (rvopConsistentEditWidth in Options) or
                         (not isSingleLineEditControl(TWinControl(Control)))) then
                        if (Width>FixedEditWidth) then
                        begin
                           Width:= FixedEditWidth;
                        end;
                   end
                end
             end
          end;

          if ((rvopShortenEditBox in Options) or
             (rvopConsistentEditWidth in Options)) then
             MaxEditWidth:= wwMin(MaxEditWidth, FixedEditWidth)
          else begin
             MaxEditWidth:= 0;
             for j:= 0 to ControlPositions.count-1 do
             begin
                cp:= TControlPosition(ControlPositions[j]);
                MaxEditWidth:= wwMax(MaxEditWidth, cp.width);
             end
          end
      end
      else ShowingVertScrollBar:= False;

      HorzScrollBar.Margin:= 6;
      if (rvopConsistentEditWidth in Options) then
         HorzScrollBar.Range := MaxEditWidth
      else begin
         HorzScrollBar.Range :=
            EditStartOffset + MaxEditWidth + Margin.RightOffset;
         if ShowingVertScrollBar then
            HorzScrollBar.Range:=
               HorzScrollBar.Range - GetSystemMetrics(SM_CXHThumb);
      end;

      for i:= 0 to ControlPositions.count-1 do
      begin
         cp:= TControlPosition(ControlPositions[i]);
         with cp do
         begin
            if (Control is TWinControl) then
               SetWindowPos ((control as TWinControl).Handle, 0,
                 left, top, width, height, SWP_NOACTIVATE)
            else
               control.SetBounds(left, top, width, height);
         end
      end;

      BackgroundImage:= False;  // 8/7/00
      for i:= 0 to ControlCount-1 do
      begin
         if (Controls[i] is TGraphicControl) and
            not (Controls[i] is TLabel) then
         begin
            BackgroundImage:=True;
         end
      end;

      for i:= 0 to ControlCount-1 do
      begin
         Controls[i].visible:= True;
         if Patch[1] and EditFrame.enabled and EditFrame.Transparent and BackgroundImage then
            Update; // 8/6/00 - Need to complete imager painting if present
      end;

      { Set focus to first wincontrol }
{      if Focused and Recreate then
      begin
         for i:= 0 to ControlCount-1 do
         begin
            if Controls[i] is TWinControl then
            begin
               TWinControl(Controls[i]).setFocus;
               break;
            end
         end;
      end
}
   finally
      Bitmap.Free;
      for i:= 0 to ControlPositions.count-1 do TControlPosition(ControlPositions[i]).Free;
      ControlPositions.Clear;
   end;
end;

function TwwRecordViewPanel.IsSingleLineEditControl(EditControl: TWinControl): boolean;
begin
   result:= ((EditControl is TwwDBEdit) or (EditControl is TwwDBDateTimePicker));
end;


Procedure TwwRecordViewPanel.DisplayHorizontal(Recreate: boolean);
const FixedEditWidthConst=0;
var
    OrigMaxEditWidth, MaxEditWidth: integer;
    APos, i, j, numFields: integer;
    curFieldDisplayWidth: integer;

    curFieldEditWidth: integer;
    curFieldLabelWidth: integer;
    curFieldDisplayLabel: wwSmallString;
    curFieldReadOnly: boolean;
    RealMaxLineWidth, MaxLineWidth,curLineWidth: integer;
    LastEditHeight:integer;
    LastLabelHeight:integer;
    curField: TField;
    curLabel: Tlabel;
    customEdit: TWinControl;
    wwDbEdit: TwwDBEdit;
    checkbox: TwwDBCheckBox;
    FixedEditWidth: integer;
    accept: boolean;
    PrevTop: integer;
    checkboxOn, checkboxOff: wwSmallString;
    Bitmap: TBitmap;
    curEditControl: TControl;
    NextTabOrder: integer;
    TempWidth: integer;
    TempControlCount: integer;
    PanelWidth: integer;
    ControlPositionLeft, ControlPositionTop,
    ControlPositionWidth, ControlPositionHeight: integer;
    cp: TControlPosition;
    EditControl: TWinControl;
    ShowingVertScrollBar: boolean;
    OldWidth: integer;
    BackgroundImage: boolean;

  Function GetControlPosition(control: TControl): TControlPosition;
  var i: integer;
  begin
     result:= nil;
     for i:= 0 to ControlPositions.count-1 do
        if TControlPosition(ControlPositions[i]).Control=control then
           result:= TControlPosition(ControlPositions[i]);
  end;


  procedure UpdateTopPosition(Height: integer; var TopPosition: integer);
  begin
      if (rvopLabelsBeneathControl in Options) and (style=rvpsHorizontal) then
      begin
         TopPosition:= GetControlPosition(curLabel).Top;
         GetControlPosition(curLabel).Top:=
            TopPosition + Height + EditSpacing.HorizontalView.BetweenLabelEdit-1;
      end
  end;


    Function CreateEditControl(EditControl: TWinControl): boolean;
    var
       tempMask: string;
       tempAutoFill: boolean;
       tempUsePictureMask: boolean;
    begin
        result:= False;
        { 1/5/2000 - Fix bug with picture masks for non wwdatasets }
        if EditControl is TwwDBCustomEdit then
        begin
            if wwGetPictureControl(self)=self then { Picture masks do not come from dataset }
            begin
               wwPictureByField(self, curField.FieldName, False,
                   tempMask, tempAutoFill, tempUsePictureMask);
               with TwwDBEdit(EditControl).Picture do
               begin
                  PictureMaskFromDataSet:= False;
                  PictureMask:= tempMask;
                  AutoFill:=tempAutoFill;
               end
            end
        end;

        with EditControl do begin
           if recreate then begin
              curLabel.FocusControl:= EditControl;
              visible:= False;
              parent:= self;
              if not wwSetControlDataSource(EditControl, self.datasource) then exit;
              if not wwSetControlDataField(EditControl, curField.fieldName) then exit;

              if curFieldReadonly or curField.calculated then
              begin
                 TEdit(EditControl).color:= ReadOnlyColor;
                 EditControl.tabStop:= False;
              end;

              if (EditControl is TwwDBEdit) then
              begin
                 if curField is TStringField then  {7/29/97 - Limit length to field size }
                    if curField.editmask='' then // 9/9/02
                       TEdit(EditControl).maxlength:= curField.Size;
              end;

           end;

           ControlPositionleft:= EditStartOffset+curLineWidth;
           ControlPositiontop:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+curlabel.Height;
           TempWidth:= (curFieldDisplayWidth+1) * Bitmap.Canvas.TextWidth('0') + 3;
           if EditControl is TwwDBDateTimePicker then
           begin
              TempWidth:=
                    TempWidth + TwwDBDateTimePicker(EditControl).Button.Width
           end;

           if not IsSingleLineEditControl(EditControl) then
           begin
              if (rvopMaximizeMemoWidth in Options) then begin
                 ControlPositionleft:= EditStartOffset;
                 ControlPositionTop:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+curlabel.Height;
                 TempWidth:= wwMax(OrigMaxEditWidth, FixedEditWidth);
              end
           end;

           if (rvopShortenEditBox in Options) and (TempWidth>FixedEditWidth) then
              TempWidth:= FixedEditWidth;

           if IsSingleLineEditControl(EditControl) then
              ControlPositionHeight:= EditControl.Height
           else
              ControlPositionHeight:= Bitmap.Canvas.TextHeight('0') * LinesPerMemoControl + 8; {2 lines of Memo}
           if Recreate and CurFieldReadOnly then enabled:=False;
       end;

       if not Recreate then begin
          ControlPositionWidth:= TempWidth;
          ControlPositionHeight:= EditControl.Height;
          UpdateTopPosition(ControlPositionHeight, ControlPositionTop);
          AddControlPosition(EditControl, ControlPositionLeft, ControlPositionTop,
                             ControlPositionWidth, ControlPositionHeight);
       end
       else begin
          EditControl.Left:= ControlPositionLeft;
          EditControl.Top:= ControlPositionTop;
          EditControl.Height:= ControlPositionHeight;
          OldWidth:= EditControl.Width; { 10/22/98 }
          DoOnAfterCreateControl(self, curField, EditControl);
          if EditControl.Width<>OldWidth then { 10/22/98 }
             TempWidth:= EditControl.Width;

          if (rvopShortenEditBox in Options) and (TempWidth>FixedEditWidth) then
              TempWidth:= FixedEditWidth;
          EditControl.Width:= TempWidth;
       end;

       curFieldEditWidth:= TempWidth;
       MaxEditWidth:= wwmax(MaxEditWidth, TempWidth);
       LastEditHeight:= wwMax(LastEditHeight, EditControl.Height);

       EditControl.tabOrder:= NextTabOrder; {9/3/98 - Fix tab order problem }
       inc(NextTabOrder);
       result:= True;

       if recreate then curField.FreeNotification(self);

    end;


begin
   tempControlCount:= 0;
   for i:= 0 to ControlCount-1 do
      if Controls[i].owner=self then inc(TempControlCount);
   if TempControlCount=0 then Recreate:= True;

   if FDataLink.Active or (DataSource=Nil) or (Datasource.dataset=Nil) then
   begin
      if (Recreate) then FreeNonCustomControls(True);
      if (DataSource=nil) or (Datasource.dataset=nil) then exit;
   end
   else begin
//      if (Recreate) then FreeNonCustomControls; { If inactive then don't show controls }
      exit;
   end;

   PrevTop:= Margin.TopOffset;

   if (selected.count=0) then numFields:= DataSource.DataSet.FieldCount
   else numFields:= Selected.count;

   Bitmap:= TBitmap.create;
   ControlPositions.Clear;

   try
      Bitmap.Canvas.Font := Font;

      { Compute desired form length }
      MaxEditWidth:= 0;
      RealMaxLineWidth:= 0;
      curFieldDisplayWidth:= 0;

      for i:= 0 to numFields-1 do begin
         if (Selected.count=0)then
         begin
            curField:= DataSource.dataset.fields[i];
            curFieldDisplayWidth:= curField.DisplayWidth;
            curFieldReadOnly:= curfield.ReadOnly;
         end
         else begin
            APos:= 1;
            curField:= DataSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield<>nil then begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               strGetToken(Selected[i], #9, APos); { Display label }
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T')
            end
         end;
         if not ShowField(curfield, curFieldReadOnly) then continue;

         MaxEditWidth:= wwmax(MaxEditWidth,
               (CurFieldDisplayWidth+1) * Bitmap.Canvas.TextWidth('0') + 3);
      end;
      OrigMaxEditWidth:= MaxEditWidth;

      { Limit form length }
      EditStartOffset:= Margin.LeftOffset;

      MaxEditWidth:= 0;
      lastEditHeight := 0;
      lastLabelHeight := 0;
      CurLineWidth:= 0;
      NextTabOrder:= 0;

      FixedEditWidth:= Width - (EditStartOffset + Margin.RightOffset + FixedEditWidthConst);
      if BorderStyle=bsSingle then FixedEditWidth:= FixedEditWidth - 4;

      MaxLineWidth:= FixedEditWidth;
//      MinEditHeight:= 21;

      for i:= 0 to numFields-1 do begin
         APos:= 1;
         if (Selected.count=0) or FUseTFields then
         begin
            curField:= DataSource.dataset.fields[i];
            curFieldDisplayWidth:= curfield.DisplayWidth;
            curFieldDisplayLabel:= curField.displayLabel;
            curFieldReadOnly:= curfield.ReadOnly; { 10/14/98 }
         end
         else begin
            curField:= DataSource.dataset.findField(strGetToken(Selected[i], #9, APos));
            if curfield = nil then begin
               {NEW LINE}
               curLineWidth := 0;
               PrevTop := PrevTop + EditSpacing.HorizontalView.BetweenLabelEdit+
                          LastEditHeight + EditSpacing.HorizontalView.BetweenRow +
                          LastLabelHeight;{New Top Value}
               LastEditHeight := 0;
               continue;
            end
            else begin
               curFieldDisplayWidth:= strToInt(strGetToken(Selected[i], #9, APos));
               curFieldDisplayLabel:= strGetToken(Selected[i], #9, APos);
               curFieldReadOnly := (strGetToken(Selected[i], #9, APos) = 'T');
            end
         end;

         if not ShowField(curfield, curFieldReadOnly) then continue;

         Bitmap.Canvas.Font := LabelFont;
         curFieldLabelWidth := (Bitmap.Canvas.TextWidth(curFieldDisplayLabel));
         Bitmap.Canvas.Font := Font;

         if (rvopMaximizeMemoWidth in Options) and
            ((wwIsCustomEditCell(self, wwGetOwnerFrameOrForm(self), curField, customEdit) and
             wwisclass(customedit.classtype,'TwwCustomRichEdit'))
             or (curField is TBlobField)) then { 9/25/98 }
            curFieldEditWidth:= FixedEditWidth
         else
            curFieldEditWidth:= (curFieldDisplayWidth+1) * Bitmap.Canvas.TextWidth('0') + 3;

         if (curlineWidth > 0) and
            (curLineWidth + EditSpacing.HorizontalView.BetweenEditsInRow +
             wwmax(curFieldEditWidth,curFieldLabelWidth+EditSpacing.HorizontalView.LabelIndent) >= MaxLineWidth-8) then
         begin
            {Won't fit on current line so go to next line}
            curLineWidth := 0;
            PrevTop := PrevTop + EditSpacing.HorizontalView.BetweenLabelEdit +
                       EditSpacing.HorizontalView.BetweenRow + LastEditHeight + LastLabelHeight;{New Top Value}
            LastEditHeight := 0;
         end;

         accept:= True;
         if Recreate then
            DoOnBeforeCreateControl(Self, curField, accept);
         if not accept then continue;

         curLabel:= nil;
         curEditControl:= nil;

         if (not Recreate)  then begin
            for j:= 0 to CustomControlList.count-1 do begin
               TwwCustomControlItem(CustomControlList[j]).control.parent:= self;
            end;
            for j:= 0 to ControlCount-1 do begin
               if TControl(Controls[j]) is TWinControl then begin
                  if wwEqualStr(wwGetControlDataField(TWinControl(Controls[j])),
                                curField.fieldname) then
                  begin
                     curEditControl:= Controls[j];
                     break;
                  end
               end
            end;
            if curEditControl<>Nil then begin
               for j:= 0 to ControlCount-1 do begin
                  if TControl(Controls[j]) is TLabel then begin
                     curLabel:= TLabel(Controls[j]);
                     if TLabel(Controls[j]).FocusControl=curEditControl then
                     begin
                        curLabel:= TLabel(Controls[j]);
                        break;
                     end
                  end
               end
            end
            else continue; { 3/11/99 - No edit control exists for this field }
         end;

         if curLabel=Nil then begin
            if (rvopUseCustomControls in Options) and
               wwIsCheckbox(self, curField, checkboxOn, checkboxOff) then
               curLabel:= TwwLabel.create(self)
            else
               curLabel:= TLabel.create(self);
         end;
         self.curlabel:= curLabel;

         with curLabel do begin
            if recreate then begin
              parent:= self;
              AutoSize:= True;
              font:= self.labelFont;
              Caption:= strReplaceChar(curfieldDisplayLabel, '~', ' ');
              alignment:= taLeftJustify;
            end
            else begin
              if AutoSize<>True then AutoSize:= True;
              if Alignment<>taLeftJustify then alignment:= taLeftJustify;
            end;

            font:= self.labelFont;

            ControlPositionLeft:= Margin.LeftOffset+ CurLineWidth+EditSpacing.HorizontalView.LabelIndent;
            ControlPositionTop:= PrevTop;
            if recreate then
            begin
               Left:= ControlPositionLeft;
               Top:= ControlPositionTop;
            end
            else AddControlPosition(curLabel,
                      ControlPositionLeft, ControlPositionTop, curlabel.Width, curLabel.Height);
         end;

         if Recreate then
         begin
            if rvcTransparentLabels in ControlOptions then curLabel.transparent:= true;
            DoOnAfterCreateControl(self, curField, curLabel);
         end;
         LastLabelHeight := curLabel.height;
         curFieldLabelWidth := curlabel.width+EditSpacing.HorizontalView.LabelIndent;

         if (rvopUseCustomControls in Options) and
            wwIsCheckbox(self, curField, checkboxOn, checkboxOff) then
         begin
            if (not Recreate) and (curEditControl<>Nil) then
            begin
               checkbox:= TwwDBCheckBox(curEditControl);
               ControlPositionLeft:= EditStartOffset+curLineWidth;
               ControlPositionTop:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+ curlabel.Height;
               UpdateTopPosition(Checkbox.height, ControlPositionTop);
               AddControlPosition(CheckBox, ControlPositionLeft, ControlPositionTop,
                                   Checkbox.Width, Checkbox.Height);
            end
            else begin
              checkbox:= TwwDBCheckBox.create(self);
              checkbox.LabelControl:= curLabel;
              curLabel.FocusControl:= checkBox;
              with checkbox do begin
                 parent:= self;
                 datasource:= self.DataSource;
                 datafield:= curfield.fieldName;
                 caption:= '';
                 valueChecked:= checkboxOn;
                 valueUnchecked:= checkboxOff;
                 Width:= 17;
                 left:= EditStartOffset+curLineWidth;
                 Top:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+ curlabel.Height;
                 if curFieldReadonly or Field.calculated then
                 begin
                    tabStop:= False;
                    Enabled:=False; { 3/9/99 - Readonly checkbox }
                 end;
              end;
              if Recreate then
                 DoOnAfterCreateControl(self, curField, checkbox);
            end;
            curFieldEditWidth := checkbox.Width;
            MaxEditWidth:= wwmax(MaxEditWidth, checkbox.Width);
            LastEditHeight:= wwMax(LastEditHeight,checkbox.Height);
            Checkbox.Height:= LastEditHeight;

            { 9/20/98 - Set tab orders for checkbox }
            checkbox.TabOrder:= NextTabOrder;  { 3/11/99 - Previously didn't have checkbox.taborder }
            inc(NextTabOrder);
         end
         else if useCustomControls and
            IsCustomEditCell(curField, customEdit) then
         with TEdit(CustomEdit) do begin
            curLabel.FocusControl:= CustomEdit;
            parent:= self;

            if Recreate then begin
               AddCustomControl(CustomEdit);
               if not wwSetControlDataSource(customEdit, datasource) then continue;
               if not wwSetControlDataField(customEdit, '') then continue;
               if not wwSetControlDataField(customEdit, curField.fieldName) then continue;
            end;

//            visible:= True; { Causes custom control's to flicker when coming up }
            Ctl3d:= True;
            if not HasFrame(customEdit) then BorderStyle:= bsSingle;

            ControlPositionLeft:= EditStartOffset+curLineWidth;
            ControlPositionTop:= PrevTop+EditSpacing.HorizontalView.BetweenLabelEdit+curlabel.Height;

            if (customEdit is TwwRadioGroup) and TwwRadioGroup(CustomEdit).ShowGroupCaption then
            begin
               LastLabelHeight := 0;
            end;
            if wwIsClass(customedit.classtype,'TwwCustomRichEdit') and
               (rvopMaximizeMemoWidth in Options) then
               TempWidth:= wwMax(OrigMaxEditWidth, FixedEditWidth)
            else
               TempWidth:= (curFieldDisplayWidth+1) * Bitmap.Canvas.TextWidth('0') + 3;

            if rvopShortenEditBox in Options then begin
               if TempWidth>FixedEditWidth then TempWidth:= FixedEditWidth;
            end;

            TEdit(CustomEdit).HandleNeeded;

//            if Recreate then
//               DoOnAfterCreateControl(self, curField, customEdit);

            if not Recreate then begin
               ControlPositionWidth:= TempWidth;
               ControlPositionHeight:= CustomEdit.Height;
               UpdateTopPosition(ControlPositionHeight, ControlPositionTop);
               AddControlPosition(CustomEdit, ControlPositionLeft, ControlPositionTop,
                                 TempWidth, ControlPositionHeight);
            end
            else begin
               Left:= ControlPositionLeft;
               Top:= ControlPositionTop;
               OldWidth:= CustomEdit.Width; { 10/22/98 }

               if (Patch[0]=True) and curFieldReadOnly then
               begin
                  CustomEdit.tabStop:= not curFieldReadOnly;
                  CustomEdit.enabled:= not curFieldReadOnly;
                  TEdit(CustomEdit).Color:= ReadOnlyColor;
               end;

               DoOnAfterCreateControl(self, curField, CustomEdit);
               if CustomEdit.Width<>OldWidth then { 10/22/98 }
                  TempWidth:= CustomEdit.Width;
               customEdit.Width:= TempWidth;
            end;

            curFieldEditWidth := TempWidth; //customEdit.Width;
            MaxEditWidth:= wwmax(MaxEditWidth, curFieldEditWidth);
            LastEditHeight:= wwMax(LastEditHeight,customEdit.Height);
            tabOrder:= NextTabOrder;
            inc(NextTabOrder);
         end
         else if (curField is TDateTimeField) and
                 (rvopUseDateTimePicker in Options) then
         begin
            if recreate or (curEditControl=Nil) then
               EditControl:= TwwDBDateTimePicker.create(self)
            else EditControl:= TwwDBDateTimePicker(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (not (csDesigning in ComponentState)) and
            wwIsRichEditField(curField, True) then begin
            if recreate then EditControl:= TwwDBRichEdit.create(self)
            else EditControl:= TWinControl(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftMemo) then begin
            if recreate then begin
               if EditFrame.IsFrameEffective then
                  EditControl:= TwwDBEditMemo.create(self)
               else
                  EditControl:= TwwDBMemo.create(self)
            end
            else EditControl:= TWinControl(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else if (curField.dataType = ftGraphic) then begin { 8/27/98 - Support images }
            if recreate then editControl:= TDBImage.create(self)
            else EditControl:= TWinControl(curEditControl);
            if not CreateEditControl(EditControl) then continue;
         end
         else begin
            if recreate or (curEditControl=Nil) then begin
               EditControl:= TwwDBEdit.create(self);
               EditControl.controlStyle:= EditControl.ControlStyle + [csNoDesignVisible];
            end
            else EditControl:= TWinControl(curEditControl);

            if not CreateEditControl(EditControl) then continue;

         end;
         curLineWidth := curLineWidth + wwmax(curFieldEditWidth,curFieldLabelWidth)+
                         EditSpacing.HorizontalView.BetweenEditsInRow;
         realMaxLineWidth:= wwmax(realMaxLineWidth, curLineWidth - EditSpacing.HorizontalView.BetweenEditsInRow);
      end;

      PrevTop := PrevTop + EditSpacing.HorizontalView.BetweenLabelEdit +
                 LastEditHeight + LastLabelHeight + Margin.BottomOffset; {New Top Value}

      Self.VertScrollBar.Margin:= 6;
      Self.VertScrollBar.Range := PrevTop;

      { Shrink edit controls to fit panel width }
      if (Height-5<PrevTop) then
      begin
          {$ifdef wwDelphi4up}
          ShowingVertScrollBar:= True;
          {$else}
          ShowingVertScrollBar:= False; { Skip Delphi 4 specific code for setting horz scroll range }
          {$endif}
          FixedEditWidth:= FixedEditWidth - GetSystemMetrics(SM_CXHThumb);
          if Recreate then begin
            for j:= 0 to ControlCount-1 do begin
               if TControl(Controls[j]) is TWinControl then begin
                  curEditControl:= Controls[j];
                  if ((rvopShortenEditBox in Options) or
                      (rvopConsistentEditWidth in Options) or
                      (not isSingleLineEditControl(TWinControl(curEditControl)))) then
                     if (curEditControl.Width>FixedEditWidth) then
                         curEditControl.Width:= FixedEditWidth
               end;
            end
          end
          else begin
             for j:= 0 to ControlPositions.count-1 do
             begin
                cp:= TControlPosition(ControlPositions[j]);
                with cp do
                begin
                   if Control is TWinControl then
                   begin
                      if ((rvopShortenEditBox in Options) or
                         (rvopConsistentEditWidth in Options) or
                         (not isSingleLineEditControl(TWinControl(Control)))) then
                        if (Width>FixedEditWidth) then
                           Width:= FixedEditWidth
                   end
                end
             end
         end;
         MaxEditWidth:= 0;
         for j:= 0 to ControlPositions.count-1 do
         begin
            cp:= TControlPosition(ControlPositions[j]);
            MaxEditWidth:= wwMax(MaxEditWidth, cp.width);
         end
      end
      else ShowingVertScrollBar:= False;

      for i:= 0 to ControlPositions.count-1 do
      begin
         cp:= TControlPosition(ControlPositions[i]);
         with cp do
         begin
            if Control is TWinControl then
               SetWindowPos ((control as TWinControl).Handle, 0,
                 left, top, width, height, SWP_NOACTIVATE)
            else
               control.SetBounds(left, top, width, height);
         end
      end;

      self.HorzScrollBar.Margin:= 6;
      if rvopShortenEditBox in Options then
         MaxEditWidth:= wwMin(MaxEditWidth, FixedEditWidth);

      self.HorzScrollBar.Range := EditStartOffset + MaxEditWidth + Margin.RightOffset;
      if ShowingVertScrollBar then
         HorzScrollBar.Range:=
            HorzScrollBar.Range - GetSystemMetrics(SM_CXHThumb);

      BackgroundImage:= False; //  8/7/00
      for i:= 0 to ControlCount-1 do
      begin
         if (Controls[i] is TGraphicControl) and
            not (Controls[i] is TLabel) then
         begin
            BackgroundImage:=True;
         end
      end;

      for i:= 0 to ControlCount-1 do
      begin
         Controls[i].visible:= True;
         if Patch[1] and EditFrame.enabled and EditFrame.Transparent and BackgroundImage then
            Update;
      end;

      { Set focus to first wincontrol }
{      if Focused and Recreate then
      begin
         for i:= 0 to ControlCount-1 do
         begin
            if Controls[i] is TWinControl then
            begin
               TWinControl(Controls[i]).setFocus;
               break;
            end
         end;
      end;
}

   finally
      Bitmap.Free;
      for i:= 0 to ControlPositions.count-1 do TControlPosition(ControlPositions[i]).Free;
      ControlPositions.Clear;
   end;
end;

Function TwwRecordViewPanel.ShowField(field: TField; curFieldReadOnly: boolean): boolean;
begin
   if field=nil then result:= False
   else if (rvopHideReadOnly in Options) and curFieldReadOnly then result:= False
   else if (rvopHideCalculated in Options) and field.calculated then result:= False
   else result:= True;
end;

Procedure TwwRecordViewPanel.AddCustomControl(CustomEdit: TWinControl);
var customItem: TwwCustomControlItem;
begin
   customItem:= TwwCustomControlItem.create;
   with customItem do begin
      Control:= CustomEdit;
      Left:= CustomEdit.Left;
      Width:= CustomEdit.Width;
      Top:= CustomEdit.Top;
      Height:= CustomEdit.Height;
      OldParent:= CustomEdit.Parent;
      OldVisible:= customEdit.visible;
   end;
   CustomControlList.add(customItem);
end;

procedure TwwRecordViewPanel.Notification(AComponent: TComponent;
  Operation: TOperation);
var j: integer;
   customItem: TwwCustomControlItem;
   RemovedControl: boolean;
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (AComponent is TField) then
  begin
     {$ifdef wwdelphi4up}
     if (csDesigning in ComponentState) then
     { Don't do at runtime as if attached to paramaterized query it gets cleared , 10/10/99}
       FreeNonCustomControls(True);
     {$else}
     if not (csDesigning in ComponentState) then
        FreeNonCustomControls(True)
     {$endif}
  end
  else if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil
  else if (Operation = opRemove) and (FParentObject<>Nil) and
    (AComponent = FParentObject) then FParentObject := nil;

  { 3/5/98 - OldParent is destroyed so reset oldparent value }
  if (Operation = opRemove) and (CustomControlList<>nil) then // 10/5/00 - Fix design-time delete problem
  begin
     RemovedControl:= False;
     for j:= CustomControlList.count-1 downto 0 do begin { 9/18/98 - Scan backwards }
//     for j:= 0 to CustomControlList.count-1 do begin
         customItem:= TwwCustomControlItem(CustomControlList[j]);
         if AComponent = customItem.oldParent then
            customItem.oldParent:= GetParentForm(self);
         if AComponent = customItem.control then
         begin
            CustomControlList.delete(j);
            RecreateNextTime:= True;
            RemovedControl:= True;
         end
     end;

     if RemovedControl and (csDesigning in ComponentState) and
        not (csDestroying in ComponentState) then RecreateControls;
  end
end;

Function TwwRecordViewPanel.Apply(Recreate: boolean): boolean;
begin
   Result := false;
   if csLoading in ComponentState then Exit;
   if InApply then exit;

   InApply:= True;

   VertScrollBar.Position:= 0;
   HorzScrollBar.Position:= 0;
   if (Style = rvpsVertical) then
      DisplayVertical(Recreate)
   else
      DisplayHorizontal(Recreate);

   { 10/23/98 - Set to first wincontrol if active control is panel }
   if Recreate and (Screen.ActiveControl=self) then
   begin
      PostMessage(GetParentForm(self).Handle, WM_NEXTDLGCTL, 0, 0);
   end;

   InApply:= False;
   result:= True;
   RecreateNextTime:= False;
end;

procedure TwwRecordViewPanel.Resize;
begin
  inherited;
  if visible then Apply(RecreateNextTime);
end;

procedure TwwRecordViewPanel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  Apply(False);
end;

procedure TwwRecordViewPanel.LabelFontChanged(Sender: TObject);
begin
  Apply(False);
end;

Procedure TwwRecordViewPanel.RefreshControls;
begin
   Apply(False);
end;

//Procedure TwwRecordViewPanel.FreeControls;
//begin
//   Apply(True);
//end;

procedure TwwRecordViewPanel.RecreateControls;
type tdblword = record
   lo: word;
   hi: word;
end;
var dblword: TDblWord;
    i: integer;
begin
   { Clear datafield to allow dataset to change }
   for i:= 0 to ControlCount-1 do
   begin
      if (Controls[i] is TWinControl) and (Controls[i].owner=self) then
      begin
         wwSetControlDataField(Controls[i] as TWinControl, '');
      end;
   end;

   RecreateNextTime:= True;
   dblword.lo:= width;
   dblword.hi:= height;
   PostMessage(Handle, WM_SIZE, SIZE_RESTORED, longint(dblword));
end;

//{$ifdef wwdelphi4up}
//procedure TwwRecordViewPanel.SetShowImages(val: boolean);
//begin
//   if val<>FShowImages then
//   begin
//      FShowImages:= val;
//      Apply(True);
//   end;
//end;
//{$endif}

Procedure TwwRecordViewPanel.SetOptions(val: TwwRecordViewPanelOptions);
begin
   if val<>FOptions then
   begin
      FOptions:= val;
      Apply(True);
   end
end;

Procedure TwwRecordViewPanel.SetControlOptions(val: TwwRecordViewControlOptions);
begin
   if val<>FControlOptions then
   begin
      FControlOptions:= val;
      Apply(True);
   end
end;

Procedure TwwRecordViewPanel.SetStyle(val: TwwRecordViewPanelStyle);
begin
   if val<>FStyle then
   begin
      FStyle:= val;
      if csLoading in ComponentState then
        Apply(False)
      else
        Apply(True);
//      Parent.Invalidate;
   end
end;

procedure TwwRecordViewPanel.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params.WindowClass do
    style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

function TwwRecordViewPanel.IsCustomEditCell(
        curField: TField;
        var customEdit: TWinControl) : boolean;
begin
   result:= wwIsCustomEditCell(self, wwGetOwnerFrameOrForm(self), curField, customEdit);
   if not result then begin
      result:= wwIsCustomEditCell(self, datasource.dataset.owner, curField, customEdit);
   end
end;

procedure TwwRecordViewPanel.SetLinesPerMemoControl(val: integer);
begin
   if (val<>FLinesPerMemoControl) and (val>0) then
   begin
      FLinesPerMemoControl:= val;
      Apply(True);
   end
end;

procedure TwwRecordViewPanel.WMSetFocus(var Message: TWMSetFocus);
//var i: integer;
begin
  inherited;

{ 10/23/98 - Done later now after all controls created }
  { Set focus to first wincontrol }
{  if Focused then
  begin
     for i:= 0 to ControlCount-1 do
     begin
        if Controls[i] is TWinControl then
        begin
           TWinControl(Controls[i]).setFocus;
           break;
        end
     end;
  end}
end;

Procedure TwwRecordViewPanel.ClearControls;  { Call before changing dataset at runtime }
begin
   FreeNonCustomControls(True);
end;

function TwwRecordViewPanel.HasFrame(Control: TWinControl): boolean;
var frame: TwwEditFrame;
begin
    frame:= TwwEditFrame.Get(Control);
    result:= (frame<>nil) and frame.enabled;
end;

function TwwRecordViewPanel.HasButtonEffects(Control: TWinControl): boolean;
begin
    result:= TwwButtonEffects.Get(Control)<>nil;
end;

procedure TwwRecordViewPanel.SetPictureMasks(val: TStrings);
begin
   FPictureMasks.assign(val);
end;

procedure TwwRecordViewPanel.SetControlType(val: TStrings);
begin
   FControlType.assign(val);
end;

procedure TwwRecordViewPanel.CreateWnd;
var i: integer;
begin
   { 12/21/99 - Move setting visible to false to before inherited call }
   { This is because with parent as tframe the controls get created in the call to inherited }
   for i:= 0 to ControlCount-1 do begin  { Hide child controls so no flicker }
      if Controls[i].visible then Controls[i].visible:= false;
   end;
   inherited;
end;


procedure Register;
begin
  RegisterComponents('InfoPower', [TwwRecordViewPanel]);
end;

end.

