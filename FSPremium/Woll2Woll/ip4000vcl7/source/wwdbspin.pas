unit Wwdbspin;
{
//
// Components : TwwDBSpinEdit
//
// Copyright (c) 1995-2001 by Woll2Woll Software
//
// 8/3/97 - Adjust top spinbutton so that its offset is at the top when
//          embedded in the grid.  Gives the bitmap more room to display properly.
//
// 10/2/97 - Fix bug with blank text for bound date
// 11/7/98 - Set modified if text needs to be ensured its in the range
// 6/7/00 - Add UpClick and DownClick events
// 9/21/00 - Fix spin transparent button problem
}

interface

{$i wwIfDef.pas}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, db, dbtables, wwdbedit, Menus, Mask, wwdatsrc,
  wwspin, wwframe, wwtypes;

type
  TwwDBSpinEdit = class(TwwDBCustomEdit)
  private
     FMinValue: Double;
     FMaxValue: Double;
     FIncrement: Double;
     FButton: TwwSpinButton;
     FEditorEnabled: Boolean;
     FButtonEffects: TwwButtonEffects;
//     FFlatButton: boolean;
//     FFlatButtonTransparent: boolean;
     FLimitEditRect: boolean;
     FBeforeUpClick: TNotifyEvent;
     FBeforeDownClick: TNotifyEvent;
     FAfterUpClick: TNotifyEvent;
     FAfterDownClick: TNotifyEvent;

     procedure WMSize(var Message: TWMSize);  message WM_SIZE;

     procedure WMPaste(var Message: TWMPaste);   message WM_PASTE;
     procedure WMCut(var Message: TWMCut);   message WM_CUT;
     procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
     procedure CMExit(var Message: TCMExit); message CM_EXIT;

     function GetValue: Double;
     function CheckValue (NewValue: Double): Double;
     procedure SetValue (NewValue: Double);
     {$ifdef wwDelphi4Up}
     procedure WMPaint(var Message: TMessage); message WM_PAINT;
     {$endif}

//     procedure SetFlatButtonTransparent(val: boolean);
//     procedure SetFlatButton(val: boolean);
//     function GetFlatButton: boolean;

  protected

//    procedure RefreshNumericText; override;
    procedure SetDisplayFormat(val: string); override;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure UpClick (Sender: TObject); dynamic;
    procedure DownClick (Sender: TObject); dynamic;

    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    Function GetIconIndent: integer; override;
    Function GetIconLeft: integer; override;
    function GetShowButton: boolean; override;
    procedure Loaded; override;
    procedure SetEditRect; override;

  public
    SkipUpdate: boolean;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    property HasFocus : boolean read FFocused;

  published
    property DisableThemes;
    {$ifdef wwDelphi4Up}
    property Anchors;
    property BiDiMode;
    property Constraints;
    {$endif}

    property EditAlignment;  // Define early before window created
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Increment: Double read FIncrement write FIncrement;
    property MaxValue: Double read FMaxValue write FMaxValue;
    property MinValue: Double read FMinValue write FMinValue;
    property Value: Double read GetValue write SetValue;
    property AutoFillDate;
    property AutoSelect;
    property AutoSize;
    property BorderStyle;
    property CharCase;
    property Color;
    property Ctl3D;
    property DataField;
    property DataSource;
    property DragCursor;
    property DragMode;
    property Enabled;
    property ButtonEffects: TwwButtonEffects read FButtonEffects write FButtonEffects;
//    property ButtonTransparent: boolean read FFlatButtonTransparent write SetFlatButtonTransparent default false;
//    property ButtonFlat : boolean read GetFlatButton write SetFlatButton default False;
    property Font;
    property Frame;
    property LimitEditRect: boolean read FLimitEditRect write FLimitEditRect default False;
    {$ifdef wwDelphi3Up}
    property ImeMode;
    property ImeName;
    {$endif}
    property MaxLength;
    {$ifdef wwDelphi4Up}
    property ParentBiDiMode;  { 2/18/99 - Case sensitive name for Builder 4 }
    {$endif}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property Picture;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UnboundDataType;
    property UsePictureMask;
    property Visible;

    property OnChange;
    property OnCheckValue;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property AfterUpClick : TNotifyEvent read FAfterUpClick write FAfterUpClick; { 8/2/00 - Events incorrect before }
    property AfterDownClick : TNotifyEvent read FAfterDownClick write FAfterDownClick;
    property BeforeUpClick : TNotifyEvent read FBeforeUpClick write FBeforeUpClick;
    property BeforeDownClick : TNotifyEvent read FBeforeDownClick write FBeforeDownClick;


  end;

procedure Register;

implementation

uses wwsystem, wwstr, wwcommon;

{$IFDEF WIN32}
{$R WWSPIN32.RES}
{$ELSE}
{$R WWSPIN.RES}
{$ENDIF}

type
  TwwComboButtonEffects = class(TwwButtonEffects)
     protected
        procedure Refresh; override;
  end;

Procedure TwwComboButtonEffects.refresh;
var c: TwwDBSpinEdit;
begin
  c:= TwwDBSpinEdit(Control);
  if c.handleallocated then begin { Don't clip if transparent button }
     if (Flat or Transparent) then
        SetWindowLong(c.handle, GWL_STYLE,
                    GetWindowLong(c.handle, GWL_STYLE) and not WS_CLIPCHILDREN)
     else
        SetWindowLong(c.handle, GWL_STYLE,
                    GetWindowLong(c.handle, GWL_STYLE) or WS_CLIPCHILDREN);
  end
end;
{  Procedure TwwComboButtonEffects.refresh;
  begin
  end;
}
constructor TwwDBSpinEdit.create(AOwner: TComponent);
var i: integer;
    myOwner: TwwSpinButton;
begin
  inherited Create(AOwner);
  FButton := TwwSpinButton.Create (Self);
  FButton.Width := 15;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  {$IFDEF WIN32}
  FButton.ControlStyle := FButton.ControlStyle + [csReplicatable] - [csFramed];
  myOwner:= FButton;
  if myOwner<>Nil then begin
     for i:= 0 to myOwner.ControlCount-1 do begin
        if myOwner.Controls[i] is TwwTimerSpeedButton then
           myOwner.Controls[i].ControlStyle:= myOwner.Controls[i].ControlStyle + [csReplicatable];
     end
  end;
  {$else}
  FButton.ControlStyle := FButton.ControlStyle - [csFramed];
  {$ENDIF}


  Text := '0';

  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1;
  FEditorEnabled := True;

  FButtonEffects:= TwwComboButtonEffects.create(self, FButton);

end;

destructor TwwDBSpinEdit.Destroy;
begin
   FButtonEffects.Free;
   FButton.Free;
   FButton:= Nil;

   inherited Destroy;
end;

procedure TwwDBSpinEdit.CMExit(var Message: TCmExit);
var OldText: string;
begin
  { 11/7/98 - Set modified if text needs to be ensured its in the range }
  if CheckValue (Value) <> Value then
  begin
    OldText:= Text;
    SetValue (CheckValue(Value));
    if Text<>OldText then Modified:= True;
  end;
  inherited;

  { 8/3/00 - Allows TSpeedButton MouseInControl to be reset }
  TwwTimerSpeedButton(FButton.Controls[0]).Enabled:= false;
  TwwTimerSpeedButton(FButton.Controls[0]).Enabled:= True;
  TwwTimerSpeedButton(FButton.Controls[1]).Enabled:= false;
  TwwTimerSpeedButton(FButton.Controls[1]).Enabled:= True;
  TwwTimerSpeedButton(FButton.Controls[0]).MouseInControl:= false;
  TwwTimerSpeedButton(FButton.Controls[1]).MouseInControl:= false;

  if ButtonEffects.flat or ButtonEffects.Transparent then
  begin
    TwwTimerSpeedButton(FButton.Controls[0]).Transparent:= true;
    TwwTimerSpeedButton(FButton.Controls[1]).Transparent:= true;
    { Unclip children so background is painted }
    SetWindowLong(handle, GWL_STYLE,
                GetWindowLong(handle, GWL_STYLE) and not WS_CLIPCHILDREN);
    invalidate;
  end;

   if ButtonEffects.Flat then
   begin
      FButton.invalidate;
      FButton.Perform(cm_mouseleave, 0, 0);  // 7/29/01 - Invalidates transparent button
   end;
end;

procedure TwwDBSpinEdit.UpClick (Sender: TObject);
var Year, Month, Day: word;
    Hour, Min, Sec, MSec: word;
    tempDate, tempTime: TDateTime;
    dateCursor: TwwDateTimeSelection;
    TimeOnly : boolean;
begin
{   DataLink.Edit;}
   SetFocus;
   If Assigned(FBeforeUpClick) then FBeforeUpClick(self);

   TimeOnly := false;
   if (not EditCanModify) or ReadOnly or ((DataLink.Field<>Nil) and DataLink.Field.readonly) then
      MessageBeep(0)
   else begin
      if (isDateField or isDateTimeField or isTimeField) then begin

         DecodeDate(Value, Year, Month, Day);
         wwDoEncodeDate(Year, Month, Day, tempDate);

         if (isTimeField) then TimeOnly := True;
         if not TimeOnly then
            tempTime:= Value - tempDate
         else
            tempTime:= Value;

         DecodeTime(Value, Hour, Min, Sec, MSec);

         dateCursor:= wwGetDateTimeCursorPosition(SelStart, Text, TimeOnly);
         case DateCursor of
            wwdsDay: Day:= wwNextDay(Year, Month, Day);
            wwdsYear: Year:= Year + 1;
            wwdsMonth: Month:= (Month mod 12) + 1;
            wwdsHour: Hour := ((Hour+1) mod 24);
            wwdsMinute: Min:= ((Min+1) mod 60);
            wwdsSecond: Sec:= ((Sec+1) mod 60);
            wwdsAMPM: if Hour>=12 then Hour:= Hour - 12 else Hour:= Hour + 12;
         end;

         if DateCursor in [wwdsDay, wwdsYear, wwdsMonth] then begin
            while True do
            begin
               if wwDoEncodeDate(Year, Month, Day, tempDate) then begin
                  Value:= tempDate + tempTime;
                  break;
               end
               else begin
                  Day:= Day - 1;
                  if Day<28 then break;
               end
            end;
         end
         else begin
            if wwDoEncodeTime(Hour, Min, Sec, MSec, tempTime) then
               if not TimeOnly then
                  Value:= int(Value)+ tempTime
               else
                  Value:= tempTime;
         end;

         wwSetDateTimeCursorSelection(dateCursor, self, TimeOnly)

      end
      else begin
         Value := Value + FIncrement;
      end;
   end;
   SetModified(True);

   If Assigned(FAfterUpClick) then FAfterUpClick(self);
end;

procedure TwwDBSpinEdit.DownClick (Sender: TObject);
var Year, Month, Day: word;
    Hour, Min, Sec, MSec: word;
    tempDate, tempTime: TDateTime;
    dateCursor: TwwDateTimeSelection;
    TimeOnly: boolean;
begin
{   DataLink.Edit;}
   TimeOnly := false;
   SetFocus;
   If Assigned(FBeforeDownClick) then FBeforeDownClick(self);

   if (not EditCanModify) or ReadOnly or ((DataLink.Field<>Nil) and DataLink.Field.readonly) then
      MessageBeep(0)
   else begin
      if (isDateField or isDateTimeField or isTimeField) then begin

         DecodeDate(Value, Year, Month, Day);
         wwDoEncodeDate(Year, Month, Day, tempDate);

         if (isTimeField) then TimeOnly := True;
         if not TimeOnly then
            tempTime:= Value - tempDate
         else
            tempTime:= Value;

         DecodeTime(Value, Hour, Min, Sec, MSec);

         dateCursor:= wwGetDateTimeCursorPosition(SelStart, Text, TimeOnly);
         case DateCursor of
            wwdsDay: Day:= wwPriorDay(Year, Month, Day);
            wwdsYear: Year:= Year - 1;
            wwdsMonth: Month:= ((Month+10) mod 12) + 1;
            wwdsHour: Hour := ((Hour+23) mod 24);
            wwdsMinute: Min:= ((Min+59) mod 60);
            wwdsSecond: Sec:= ((Sec+59) mod 60);
            wwdsAMPM: if Hour>=12 then Hour:= Hour - 12 else Hour:= Hour + 12;
         end;
         if DateCursor in [wwdsDay, wwdsYear, wwdsMonth] then begin
            while True do
            begin
               if wwDoEncodeDate(Year, Month, Day, tempDate) then begin
                  Value:= tempDate + tempTime;
                  break;
               end
               else begin
                  Day:= Day - 1;
                  if Day<28 then break;
               end
            end;
         end
         else begin
            if wwDoEncodeTime(Hour, Min, Sec, MSec, tempTime) then
               if not TimeOnly then
                  Value:= int(Value)+ tempTime
               else
                  Value:= tempTime;
         end;

         wwSetDateTimeCursorSelection(dateCursor, self, TimeOnly);

      end
      else begin
         Value := Value - FIncrement;
      end;
   end;
   SetModified(True);

   If Assigned(FAfterDownClick) then FAfterDownClick(self);
end;

procedure TwwDBSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (parent<>nil) and wwIsClass(parent.classtype, 'TwwCustomDBGrid') then begin
//  if Parent is TwwCustomDBGrid then begin
    { 6/10/98 - Support spins in grid if alt is pressed }
     if (not AllSelected) or (ssAlt in Shift) then begin
        if Key = VK_UP then UpClick (Self)
        else if Key = VK_DOWN then DownClick(Self);
        if (Key=VK_UP) or (Key=VK_DOWN) then Key:= 0;
     end
  end
  else begin
     if (Key = VK_UP) then UpClick (Self)
     else if (Key = VK_DOWN) then DownClick (Self);
     if (Key=VK_UP) or (Key=VK_DOWN) then Key:= 0;
  end;
  inherited KeyDown(Key, Shift);
  if (key=vk_delete) and (not FEditorEnabled) then begin { 7/3/97 - Ignore delete }
    key:= 0;
    MessageBeep(0)
  end;
end;

procedure TwwDBSpinEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

function TwwDBSpinEdit.IsValidChar(Key: Char): Boolean;
begin
   { 7/3/97 - Check EditorEnabled in all cases }
   if isDateTimeField or ((Field=Nil) and isDateField)
                      or ((Field=Nil) and isTimeField) then
      result:= True
   else
      Result := (Key in [DecimalSeparator, '+', '-', '0'..'9']) or
        ((Key < #32));  {changed vk_return is valid }
   if not FEditorEnabled and Result and ((Key >= #32) or
       (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
      Result := False;
end;

procedure TwwDBSpinEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style :=(Params.Style and not (ES_AUTOVSCROLL or ES_WANTRETURN) or
                   WS_CLIPCHILDREN {or ES_MULTILINE});

  if UseRightToLeftAlignment or LimitEditRect or (EditAlignment = eaRightAlignEditing) then
    Params.Style:= Params.Style or ES_MULTILINE;
  if ButtonEffects.Transparent or ButtonEffects.Flat then
     Params.Style:= Params.Style and not WS_CLIPCHILDREN;
end;

procedure TwwDBSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TwwDBSpinEdit.SetEditRect;
var
  Loc: TRect;
begin
{  if Frame.IsFrameEffective then begin
     inherited;
     exit;
  end;}
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight;
  Loc.Right := ClientWidth - FButton.Width - 2;
  if Frame.IsFrameEffective then
    Loc.Right:= Loc.Right-1;
  if BorderStyle = bsNone then begin
     Loc.Top := 2;
     Loc.Left := 2;
  end
  else begin
     Loc.Top := 0;
     Loc.Left := 0;
  end;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
end;

procedure TwwDBSpinEdit.WMSize(var Message: TWMSize);
var offset: integer;
begin
  inherited;

  if FButton <> nil then
  begin
    if (parent<>nil) and wwIsClass(parent.classtype, 'TwwCustomDBGrid') then offset:=0 else offset:=1;
//    if (parent is TwwCustomDBGrid) then offset:= 0 else offset:= 1;

    if (not NewStyleControls) or (BorderStyle = bsNone) or (not Ctl3d) then
    begin
       if Frame.IsFrameEffective then
          Fbutton.SetBounds (Width - FButton.Width - offset-1, 1, FButton.Width, ClientHeight-3)
       else
          Fbutton.SetBounds (Width - FButton.Width - offset, offset, FButton.Width, ClientHeight-offset*2);
//       FButton.SetBounds (Width - FButton.Width, offset, FButton.Width, Height-offset)
    end
    else FButton.SetBounds (Width - FButton.Width - 4, 0, FButton.Width, Height-3);
    SetEditRect;
  end;
end;

Function TwwDBSpinEdit.GetIconIndent: integer;
begin
   result:= FButton.Width;
end;

Function TwwDBSpinEdit.GetIconLeft: integer;
begin
   result:= FButton.Left - 1;
end;


procedure TwwDBSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TwwDBSpinEdit.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

function TwwDBSpinEdit.GetValue: Double;
var Date: TDateTime;
//    TempText: string;
    FloatValue: Extended;

    { 11/7/97 - Support displayformat property and still allow spinning }
    function NumericText: string;
    var TempText: string;
        pos, endpos: integer;
    begin
      TempText:= Text;
      pos:= 1;
      while (pos<=length(TempText)) and
             not (TempText[pos] in ['0'..'9', DecimalSeparator, ThousandSeparator]) do inc(pos);
      endPos:= pos;
      while (endpos<=length(TempText)) and
            (TempText[endpos] in ['0'..'9', DecimalSeparator, ThousandSeparator]) do inc(endpos);
      result:= copy(TempText, pos, endPos-pos);
    end;

begin

  if (Field is TFloatField) or (GetDisplayFormat<>'') then begin
     if (Text='') then result:= FMinValue
     else if wwStrToFloat2(Text, FloatValue, GetDisplayFormat) then
        result:= FloatValue
     else result:= FMinValue
{     else if (not wwStrToFloat(Text)) then
     begin
        TempText:= NumericText;
        TempText:= strReplaceCharWithStr(TempText, ThousandSeparator, '');
        if not (wwStrToFloat(TempText)) then
           result:= FMinValue
        else Result:= StrToFloat(TempText)
     end
     else Result := StrToFloat(Text);}
  end
  else if (Field is TIntegerField) then begin
     if (Text='') then result:= FMinValue
     else if wwStrToFloat2(Text, FloatValue, GetDisplayFormat) then
        result:= FloatValue
     else result:= FMinValue
{     if (Text='') then result:= FMinValue
     else if (not wwStrToInt(Text)) then
     begin
        TempText:= NumericText;
        TempText:= strReplaceCharWithStr(TempText, ThousandSeparator, '');
        if not (wwStrToInt(TempText)) then
           result:= FMinValue
        else Result:= StrToInt(tempText)
     end
     else Result := StrToInt(Text);
}
  end
  else if isDateField then begin
     if (Text='') or (not wwStrToDate(Text)) then
        result:= FMinValue
     else Result := StrToDate(Text);
  end
  else if isTimeField then begin
      if (Text='') or (not wwStrToTime(Text)) then
        result:= FMinValue
     else Result := StrToTime(Text);
  end
  else if isDateTimeField then begin
     if (Text='') then result:= FMinValue
     else if (not wwStrToDateTime(Text)) and (wwStrToDate(Text)) then
        Result:= StrToDate(Text)
     else if wwStrToDateTime(Text) then
        Result:= wwStrToDateTimeVal(Text)
     else if wwScanDate(Text, Date) then
        result:= Date
     else
        result:= FMinValue
  end
  else if (Text='') or (not wwStrToFloat(Text)) then begin
     result:= FMinValue;
  end
  else begin
    Result := StrToFloat(Text);
  end;

//**
{
  if isDateField then begin
     if (Text='') or (not wwStrToDate(Text)) then
        result:= FMinValue
     else Result := StrToDate(Text);
  end
  else if isTimeField then begin
      if (Text='') or (not wwStrToTime(Text)) then
        result:= FMinValue
     else Result := StrToTime(Text);
  end
  else if isDateTimeField then begin
     if (Text='') then result:= FMinValue
     else if (not wwStrToDateTime(Text)) and (wwStrToDate(Text)) then
        Result:= StrToDate(Text)
     else if wwStrToDateTime(Text) then
        Result:= wwStrToDateTimeVal(Text)
     else if wwScanDate(Text, Date) then
        result:= Date
     else
        result:= FMinValue
  end
  else if (Text='') then result:= FMinValue
  else if wwStrToFloat2(Text, FloatValue, DisplayFormat) then
     result:= FloatValue
  else result:= FMinValue;
}


end;

procedure TwwDBSpinEdit.SetValue (NewValue: Double);
var FloatValue: Extended;
begin
  if ((DataLink.Field is TIntegerField) or
     (DataLink.Field is TFloatField)) and
    (GetDisplayFormat<>'') then
  begin
     FloatValue:= CheckValue(NewValue);
     Text:=  FormatFloat(GetDisplayFormat, FloatValue);
     if HandleAllocated then SelectAll;
  end
  else if Field is TFloatField then
     Text := FloatToStr (CheckValue (NewValue))
  else if Field is TIntegerField then
     Text := IntToStr (Trunc(CheckValue (NewValue)))
  else if isDateField then
     Text := DateToStr (CheckValue(NewValue))
  else if isTimeField then
     Text := TimeToStr (CheckValue(NewValue))
  else if isDateTimeField then
  begin
     { DateTimeToStr does not show time if it is 0 }
     if (Field=Nil) and (NewValue=trunc(NewValue)) then
     begin
        Text:= DateToStr(NewValue) + ' '  + TimeToStr(0);
     end
     else Text := DateTimeToStr (CheckValue(NewValue))
  end
  else begin
     FloatValue:= CheckValue(NewValue);
     if (GetDisplayFormat<>'') then
       Text:=  FormatFloat(GetDisplayFormat, FloatValue)
     else
       Text := FloatToStr (FloatValue);
  end;
  if not ((csLoading in ComponentState) or (csDesigning in ComponentState)) then
     SetModified(True); { 11/9/98 }
end;

function TwwDBSpinEdit.CheckValue (NewValue: Double): Double;
begin
  Result := NewValue;
  if (FMaxValue <> FMinValue) or ((FMinValue<>0) or (FMaxValue<>0)) then
  begin
    if NewValue < FMinValue then
      Result := FMinValue
    else if NewValue > FMaxValue then
      Result := FMaxValue;
  end;
end;

procedure TwwDBSpinEdit.CMEnter(var Message: TCMGotFocus);
begin
{  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll; }
  inherited;
   if ButtonEffects.Flat then FButton.invalidate;
//  FButton.Flat:= ButtonEffects.Flat and ButtonEffects.Transparent;
end;

function TwwDBSpinEdit.GetShowButton: boolean;
begin
   result:= FButton.visible;
end;

{10/2/97 - Fix bug with blank text for bound date }
procedure TwwDBSpinEdit.Loaded;
begin
  inherited Loaded;
  if (Field=Nil) and (Text='0') and
     (isDateField or isDateTimeField or isTimeField) then
     Text:= '';
end;

{$ifdef wwDelphi4Up}
procedure TwwDBSpinEdit.WMPaint(var Message: TMessage);
begin
  inherited;
  FButton.Invalidate;
  FButton.Update;
end;
{$endif}

{procedure TwwDBSpinEdit.SetFlatButtonTransparent(val: boolean);
begin
   if FFlatButtonTransparent<>val then
   begin
      FFlatButtonTransparent:= val;
      FButton.Flat:= FFlatButton or FFlatButtonTransparent;
      FButton.Invalidate;
   end;
end;

procedure TwwDBSpinEdit.SetFlatButton(val: boolean);
begin
   if FFlatButton<>val then
   begin
      FFlatButton:= val;
      FButton.Flat:= FFlatButton or FFlatButtonTransparent;
      FButton.Invalidate;
   end;
end;

function TwwDBSpinEdit.GetFlatButton: boolean;
begin
   result:= FFlatButton;
end;
}

{procedure TwwDBSpinEdit.RefreshNumericText;
var FloatValue: Extended;
begin
      if DataType in [wwEdtCurrency, wwEdtNumeric] then
      begin
          FloatValue:= CheckValue(Value);
          if DisplayFormat<>'' then
             Text:=  FormatFloat(DisplayFormat, FloatValue)
          else begin
             if DataType = wwEdtCurrency then
                 Text := FloatToStrF(FloatValue, ffCurrency, 15, CurrencyDecimals)
             else
                 Text := FloatToStr (FloatValue);
          end;
      end;
end;

}

procedure TwwDBSpinEdit.SetDisplayFormat(val: string);
begin
   inherited SetDisplayFormat(val);
   SetValue (CheckValue(Value));
end;

procedure Register;
begin
{  RegisterComponents('InfoPower', [TwwDBSpinEdit]);}
end;

end.
