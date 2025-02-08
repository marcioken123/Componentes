unit LMDCustomImageComboBox;
{$I lmdcmps.INC}

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

LMDCustomImageComboBox unit (RM)
--------------------------------
Base class for comboboxes which can be connected to imageLists.

ToDo
----
lboCalcHeight does not work, shown DropDownList always too small.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Controls, Classes, Messages, StdCtrls, ImgList,
  LMDCustomImageListBox, LMDGlyphTextLayout, LMD3DCaption, LMDCont, LMDGraph,
  LMDCustomComboBox, LMDCustomImageList, LMDBaseController;

type
  {------------------------ TLMDCustomImageComboBox ---------------------------}

  TLMDCustomImageComboBox = class(TLMDCustomComboBox)
  private
    {ImageList Support}
    FImageList:TCustomImageList;
    FListIndex:Integer;
    FChangeLink:TChangeLink;
    FDelimiter:Char;
    FDefaultItem:Integer;
    FOptions:TLMDImageBoxOptions;
    FFont3D:TLMD3DCaption;
    FLayout:TLMDGlyphTextLayout;
    //8.0
    FGlyphNumber: Byte;
    FGlyphColumn: Byte;
    //4.0
    FMultiline,
    FImagesOnly:Boolean;
    procedure SetImagesOnly(aValue:Boolean);
    procedure SetMultiline(aValue:Boolean);
    procedure UpdateEmptyList;
    function  StoreItems:Boolean;
    //--
    procedure SetDefaultItem(aValue:Integer);
    procedure SetDelimiter(aValue:Char);
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetImageIndex(Index, aValue:Integer);
    procedure SetIndex(aValue:Integer);
    procedure SetFont3D(aValue:TLMD3DCaption);
    procedure SetLayout(aValue:TLMDGlyphTextLayout);
    procedure SetOptions(aValue:TLMDImageBoxOptions);
    procedure SetGlyphNumber(const Value: Byte);
    procedure SetGlyphColumn(const Value: Byte);
    function GetImageIndex(aValue:Integer):Integer;
    function GetStringValue(aValue:Integer):String;
    {saving}
    {----}
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    {----  }

    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
  protected
    procedure DefineProperties(Filer:TFiler);override;
    procedure DrawItem(Index: Integer; aRect: TRect; State: TOwnerDrawState); override;
    function GetFieldValue:Integer;virtual;
    function GetItemString(Index:Integer):String;virtual;
    function GetImageHeight(aValue:Integer):Integer;virtual;
    function GetImageWidth(aValue:Integer):Integer;virtual;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    function IMLEmpty:Boolean;
    procedure GetIMLChange(Sender:TObject);virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Init;
    property Canvas;
    property Text;
    property CtlXP;  // compatibility
    property ImageIndexValue[Index:Integer]:Integer read GetImageIndex write SetImageIndex;
    property StringValue[Index:Integer]:String read GetStringValue;
  published
    property About;
    property Options:TLMDImageBoxOptions read FOptions write SetOptions
                     default [lboImageListOrder, lboCheckImageNr];
    property Delimiter:Char read FDelimiter write SetDelimiter default '|';
    property Font3D:TLMD3DCaption read FFont3D write SetFont3D;
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ListIndex:Integer read FListIndex write SetIndex default 0;
    property Layout:TLMDGlyphTextLayout read FLayout write SetLayout;
    property DefaultItem:Integer read FDefaultItem write SetDefaultItem default -1;
    // 8.0
    property GlyphNumber:Byte read FGlyphNumber write SetGlyphNumber default 1;
    property GlyphColumn:Byte read FGlyphColumn write SetGlyphColumn default 0;
    // 4.0
    property ImagesOnly:Boolean read FImagesOnly write SetImagesOnly default false;
    property ItemIndex;
    property Items stored StoreItems;
    property MultiLine:Boolean read FMultiline write SetMultiline default false;
    // --
    property Align;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Flat;
    property FocusControl;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property MaxLength;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    property TabOrder;
    property TabStop;
    property Visible;
    {Events}
    property OnSelect;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    property OnCloseUp;
  end;

implementation
uses
  Types, SysUtils, Graphics,
  LMDBase, LMDGraphUtils, LMDUtils, LMDStrings, LMDImageList, LMDBitmapList,
  LMDImageListConnector, LMDClass;

{************************ Class TLMDCustomImageComboBox ******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomImageComboBox.SetDefaultItem(aValue:Integer);
begin
  if FDefaultItem<>aValue then
    begin
      FDefaultItem:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetDelimiter(aValue:Char);
begin
  if aValue<>FDelimiter then
    begin
      FDelimiter:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetImageList(aValue:TCustomImageList);
begin
  if FImageList<>nil then
    FImageList.UnRegisterChanges(FChangeLink);
  FImageList:=aValue;
  if FImageList<>nil then
    begin
      FImageList.RegisterChanges(FChangeLink);
      FImageList.FreeNotification(Self);
    end;
  GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetImageIndex(index, aValue:Integer);
begin
  if(Index<Items.Count) and (Index>-1) then
    begin
      Items[Index] := LMDAnsiGetFirstString(Items[Index], FDelimiter)+FDelimiter+InttoStr(aValue);
      if HandleAllocated then Repaint;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetImagesOnly(aValue:Boolean);
begin
  if FImagesOnly<>aValue then
    begin
      FImagesOnly:=aValue;
      if FImagesOnly then
        UpdateEmptyList
      else
        Items.Clear;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetMultiline(aValue:Boolean);
begin
  if aValue<>FMultiline then
    begin
      FMultiline:=aValue;
      if not (csDesigning in Componentstate) then Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetIndex(aValue:Integer);
begin
  if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  if FImageList<>nil then
    GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetLayout(aValue:TLMDGlyphTextLayout);
begin
  FLayout.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetOptions(aValue:TLMDImageBoxOptions);
begin
  if aValue <> FOptions then
  begin
    FOptions:=aValue;
    if (lboCalcHeight in FOptions) then
      Style := csOwnerDrawVariable
    else
      Style := csOwnerDrawFixed;
    if not (csLoading in ComponentState) then
      RecreateWnd;{GetIMLChange(self);}
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetGlyphNumber(const Value: Byte);
begin
  if (Value<>FGlyphNumber) and (Value>0) then
    begin
      FGlyphNumber := Value;
      if FGlyphColumn>=FGlyphNumber then
        FGlyphColumn:=FGlyphNumber-1;
      if FImageList<>nil then
        GetIMLChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.SetGlyphColumn(const Value: Byte);
begin
  if (Value<>FGlyphColumn) and (Value<FGlyphNumber) then
    begin
      FGlyphColumn := Value;
      if FImageList<>nil then
        GetIMLChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.GetImageIndex(aValue:Integer):Integer;
var
  tmp:String;
begin
  result:=-1;
  if IMLEmpty then exit;

  if lboImageListOrder in FOptions then
    begin
      if (aValue<Items.Count) and (aValue<LMDIMLCount(FImageList, FListIndex)) then
        result:=aValue;
    end
  else
    try
      tmp:=LMDAnsiGetSecondString(Items[aValue], FDelimiter);
      if tmp<>Items[aValue] then
        result:=StrToInt(tmp)
      else
        if FDefaultItem<>-1 then result:=FDefaultItem;
    except
      On Exception do ;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.GetImageWidth(aValue:Integer):Integer;
begin
  result:=0;
  if IMLEmpty then exit;
  if LMDIsSingleItemImageList(FImageList) then
    result:=LMDIMLItemWidth(FImageList, GetImageIndex(aValue))
  else
    result:=LMDIMLItemWidth(FImageList, FListIndex);
  // 7.0
  if FGlyphNumber>1 then
    result:=result div FGlyphNumber;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.GetImageHeight(aValue:Integer):Integer;
begin
  result:=0;
  if IMLEmpty then exit;
  if LMDIsSingleItemImageList(FImageList) then
    result:=LMDIMLItemHeight(FImageList, GetImageIndex(aValue))
  else
    result:=LMDIMLItemHeight(FImageList, FListIndex);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.GetStringValue(aValue:Integer):String;
begin
  result:='';
  if aValue<Items.Count then
    result:=LMDAnsiGetFirstString(Items[aValue], FDelimiter);
    end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.StoreItems:Boolean;
begin
  result:=not FImagesOnly;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.UpdateEmptyList;
var
  i:Integer;
begin
  if csLoading in ComponentState then exit;
  if FImagesOnly then
    try
      Items.BeginUpdate;
      Items.Clear;
      if not IMLEmpty then
        for i:=0 to Pred(LMDIMLCount(FImageList, FListIndex)) do Items.Add('');
    finally
      Items.EndUpdate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.CNDrawItem(var Message: TWMDrawItem);
var
  state: TOwnerDrawState;
  dis:   TDrawItemStruct;
begin
  dis := Message.DrawItemStruct^;

  with dis do
  begin
    state := TOwnerDrawState(LongRec(itemState).Lo);

    Canvas.Handle := hDC;
    Canvas.Font   := Font;
    Canvas.Brush  := Brush;

    if UseThemeMode = ttmPlatform then
    begin
      Canvas.Brush.Color := GetThemedBkColor;
      Canvas.Font.Color  := GetThemedFontColor;
    end;

    if (Integer(itemID) >= 0) and (odSelected in state) then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color  := clHighlightText
    end;

    Canvas.FillRect(rcItem);
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, state);
    if odFocused in state then
      DrawFocusRect(hDC, rcItem);

    Canvas.Handle := 0;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.WMNCHitTest(var Message:TWMNCHitTest);
begin
  if csDesigning in ComponentState then
    DefaultHandler(Message)
  else
   inherited;
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDCustomImageComboBox.DrawItem(Index: Integer; aRect: TRect;
  State: TOwnerDrawState);
var
  tmp:Integer;
  ts: string;
  tmp1:TRect;
  flags:LongInt;
  tmpb:TBitmap;

  // 8.0
  function CorrectRect(const Value:TRect):TRect;
  var
    w:Integer;
  begin
    w:=(Value.Right-value.Left) div FGlyphNumber;
    result:=Rect(Value.Left+(FGlyphColumn*w), Value.Top, Value.Left+((FGlyphColumn+1)*w), Value.Bottom);
    // if we get calculated an invalid rect, correct it to original rect
    if (result.Left<Value.Left) or (result.Right>Value.Right) then result:=Value;
  end;

begin
  //Dec(Rect.Right,14);
  Inc(aRect.Left);
  Dec(aRect.Bottom);

  if csPaintCopy in ControlState then
  begin
    tmp := GetFieldValue;
    ts  := GetItemString(tmp);
    tmp := ImageIndexValue[tmp];
  end
  else
  begin
    ts  := GetItemString(Index);
    tmp := ImageIndexValue[Index];
  end;

  tmp1  := Rect(0,0,0,0);
  flags := DT_NOPREFIX;
  flags := DrawTextBiDiModeFlags(flags);

  if (tmp > -1) then
  begin
    tmpb := TBitmap.Create;
    try
      if LMDIsSingleItemImageList(FImageList) and
         (FImageList is TLMDCustomImageList) then
        LMDIMLItemBitmap(FImageList, tmp,0, tmpb)
      else
        LMDIMLItemBitmap(FImageList, FListIndex,tmp, tmpb);

      if FGlyphNumber > 1 then
      begin
        tmp1 := Rect(0,0, tmpb.width, tmpb.Height);
        tmp1 := CorrectRect(tmp1);

        if LMDIsSingleItemImageList(FImageList) then
          LMDDrawTextAndGlyphExt(Canvas, ts, FFont3D, aRect, tmpb.Canvas,
                                 tmp1, nil, LMDIMLTransparentColor(FImageList, tmp, 0),
                                 FLayout, FMultiline, false, lboTransparentImages in FOptions,
                                 [TLMDDrawTextStyle(Enabled)], flags)
        else
          LMDDrawTextAndGlyphExt(Canvas, ts, FFont3D, aRect, tmpb.Canvas,
                                 tmp1, nil, LMDIMLTransparentColor(FImageList, FListIndex, tmp),
                                 FLayout, FMultiline, false, lboTransparentImages in FOptions,
                                 [TLMDDrawTextStyle(Enabled)], flags)

      end
      else
        LMDDrawTextAndGlyph(Canvas, ts, FFont3D, aRect, tmpb, nil,
                             FLayout, FMultiline, false, lboTransparentImages in FOptions,
                             [TLMDDrawTextStyle(Enabled)], flags)
    finally
      tmpb.Free;
    end;
  end
  else
    LMDDrawTextAndGlyphExt(Canvas, ts, FFont3D, aRect,
                           nil, tmp1, nil, clBlack, FLayout, FMultiline,
                           false, false, [TLMDDrawTextStyle(Enabled)], flags);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.IMLEmpty:Boolean;
begin
  result:=(FImageList=nil) or (LMDIMLCount(FImageList, FListIndex)=0); //formally and -> replaced 09.12.99 JH
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.GetFieldValue:Integer;
begin
   result:=-1;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageComboBox.GetItemString(Index:Integer):String;
begin
  result:='';
  If FImagesOnly then exit;
  if lboCheckImageNr in FOptions then
    result:=LMDAnsiGetFirstString(Items[index], FDelimiter)
    else
    result:=Items[Index];
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.GetIMLChange(Sender:TObject);
begin
  if (sender=FFont3D) or (sender=FLayout) then
    Invalidate
  else
    begin
      if FImagesOnly then
        UpdateEmptyList;
      if lboCalcHeight in FOptions then
        RecreateWnd
      else
        Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.MeasureItem(Index: Integer; var Height: Integer);
var
  tmp, tmp1:Integer;
  ts:String;
  cRect:TRect;
begin
  if (index=-1) or (index=Itemindex) then exit;

  if csPaintCopy in ControlState then
    ts:=GetItemString(GetFieldValue)
  else
    ts:=GetItemString(Index);

  tmp:=-1;
  tmp1:=-1;

  if not IMLEmpty then
    begin
      tmp1:=ImageIndexValue[Index];
      if tmp1<>-1 then
        begin
          if LMDIsSingleItemImageList(FImageList) then
            begin
              tmp:=LMDIMLItemHeight(FImageList, tmp1)+2;
              tmp1:=LMDIMLItemWidth(FImageList, tmp1)+FLayout.Spacing+2;
            end
          else
            begin
              tmp:=LMDIMLItemHeight(FImageList, FListIndex)+2;
              tmp1:=LMDIMLItemWidth(FImageList, FListIndex)+FLayout.Spacing+2;
            end
        end
      else
        tmp1:=0;
    end;

  if FMultiline then
    begin
      {if lboCheckImageNr in FOptions then
        ts:=LMDAnsiGetFirstString(Items[index], FDelimiter)
      else
        ts:=Items[Index];}

      if ts<>'' then
        begin
          cRect:=Rect(0,0,Width-14-tmp1,0);
          LMDDrawTextCalc(ts, FFont3D, cRect, Font, MultiLine, false, 0, DT_EXPANDTABS or DT_WORDBREAK);
        end;
      if cRect.Bottom>tmp then tmp:=cRect.Bottom;
    end;

  if tmp>Height then
    Height:=tmp;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.Loaded;
begin
  inherited Loaded;
  Init;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.Init;
begin
  if FImagesOnly then
    UpdateEmptyList;
  //if lboCalcHeight in FOptions then
  //  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageComboBox.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FImageList) then SetImageList(nil);
end ;

{------------------------- Public----------------------------------------------}
constructor TLMDCustomImageComboBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FListIndex:=0;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;
  FGlyphColumn:=0;
  FGlyphNumber:=1;
  FDelimiter:='|';
  FDefaultItem:=-1;
  FOptions:=[lboImageListOrder,lboCheckImageNr];
  FFont3D:=TLMD3DCaption.Create;
  FFont3D.OnChange:=GetIMLChange;
  FLayout:=TLMDGlyphTextLayout.Create;
  FLayout.OnChange:=GetIMLChange;
  Style:=csOwnerDrawFixed;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomImageComboBox.Destroy;
begin
  FFont3D.Free;
  FLayout.Free;
  FChangeLink.Free;
  inherited Destroy;
end;

end.
