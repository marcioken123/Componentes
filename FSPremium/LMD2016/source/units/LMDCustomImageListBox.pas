unit LMDCustomImageListBox;
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

LMDCustomImageListBox unit (RM)
------------------------------
Base class for listboxes which can be connected to imagelists.

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Controls, Classes, Messages, Graphics, StdCtrls, ImgList,
  LMDBaseController, LMDCustomListBox, LMDCont, LMDGraph, LMD3DCaption,
  LMDGlyphTextLayout, LMDBase, LMDCustomImageList;

type
  TLMDImageBoxOption=(lboImageListOrder, lboCheckImageNr, lboCalcHeight, lboTransparentImages);
  TLMDImageBoxOptions=set of TLMDImageBoxOption;

  {--------------------- TLMDCustomImageListBox -------------------------------------}
  TLMDCustomImageListBox=class(TLMDCustomListBox)
  private
    {ImageList Support}
    FImageList:TCustomImageList;
    FListIndex:Integer;
    FChangeLink:TChangeLink;

    FDefaultItem:Integer;
    FOptions:TLMDImageBoxOptions;
    FLayout:TLMDGlyphTextLayout;
    FDelimiter:Char;

     //4.0
    FImagesOnly:Boolean;
    FGlyphNumber: Byte;
    FGlyphColumn: Byte;
    procedure SetImagesOnly(aValue:Boolean);
    procedure UpdateEmptyList;
    function StoreItems:Boolean;
    //--

    //--
    procedure SetDefaultItem(aValue:Integer);
    procedure SetDelimiter(aValue:Char);
    procedure SetImageList(aValue:TCustomImageList);
    procedure SetImageIndex(Index, aValue:Integer);
    procedure SetIndex(aValue:Integer);
    procedure SetLayout(aValue:TLMDGlyphTextLayout);
    procedure SetOptions(aValue:TLMDImageBoxOptions);
    function GetImageIndex(aValue:Integer):Integer;

    {saving}
    {----}
    procedure ReadIdent(Reader:TReader);
    procedure WriteIdent(Writer:TWriter);
    function  CheckCont:Boolean;
    function HasControl:Boolean;
    procedure SetGlyphNumber(const Value: Byte);
    procedure SetGlyphColumn(const Value: Byte);
    {function HasIML:Boolean;}
    {----  }
  protected
    function GetStringValue(aValue:Integer):String;override;

    // LMD-Tools 6.0 - functions for specifying width and height of an item
    function GetHorzExtent(index:Integer):Integer; override;
    function GetImageHeight(aValue:Integer):Integer;virtual;
    function GetImageWidth(aValue:Integer):Integer;virtual;
    // ++ GetImageIndex to get real connected Image
    // ----

    function CanEdit:Boolean;override;
    function GetEditRect(index:Integer):TRect;override;

    procedure DefineProperties(Filer:TFiler);override;
    procedure DrawItem(Index: Integer; aRect: TRect; State: TOwnerDrawState); override;
//    function GetFieldValue:Integer;virtual;
    procedure GetIMLChange(Sender:TObject);virtual;
    function IMLEmpty:Boolean;
    procedure Loaded; override;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property CtlXP;  // compatibility
    property Canvas;
    property Text;
    property ImageIndexValue[Index:Integer]:Integer read GetImageIndex write SetImageIndex;
    property Items stored StoreItems;
    property Layout:TLMDGlyphTextLayout read FLayout write SetLayout;
    property ImageList:TCustomImageList read FImageList write SetImageList stored HasControl;
    property ListIndex:Integer read FListIndex write SetIndex default 0;
    property ImagesOnly:Boolean read FImagesOnly write SetImagesOnly default false;
    property GlyphNumber:Byte read FGlyphNumber write SetGlyphNumber default 1;
    property GlyphColumn:Byte read FGlyphColumn write SetGlyphColumn default 0;
  published
    property Ctl3D;
    property Delimiter:Char read FDelimiter write SetDelimiter default '|';
    property Options:TLMDImageBoxOptions read FOptions write SetOptions default [lboImageListOrder, lboCheckImageNr];
    property DefaultItem:Integer read FDefaultItem write SetDefaultItem default -1;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
  end;

  // only for derviced classes which used TLMDCustomImageListBox as base class before
  TLMDCustomDerivedImageListBox=class(TLMDCustomListBox)
  private
    procedure ReadChar(Reader:TReader);
    procedure ReadIdent(Reader:TReader);
    procedure ReadInteger(Reader:TReader);
  protected
    procedure DefineProperties(Filer:TFiler);override;
  end;

implementation
uses
  Forms, SysUtils, Types,
  LMDClass, LMDProcs, LMDUtils, LMDStrings, LMDCustomControl, LMDBitmapList,
  LMDImageList, LMDImageListConnector,  LMDGraphUtils;

{************************ Class TLMDCustomImageListBox ************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustomImageListBox.SetDefaultItem(aValue:Integer);
begin
  if FDefaultItem<>aValue then
    begin
      FDefaultItem:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetDelimiter(aValue:Char);
begin
  if aValue<>FDelimiter then
    begin
      FDelimiter:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetImageList(aValue:TCustomImageList);
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
procedure TLMDCustomImageListBox.SetImageIndex(index, aValue:Integer);
begin
  if(Index<Items.Count) and (Index>-1) then
    begin
      Items[Index] := LMDAnsiGetFirstString(Items[Index], FDelimiter) + FDelimiter + IntToStr(aValue);
      if HandleAllocated then Repaint;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetIndex(aValue:Integer);
begin
  if (aValue=FListIndex) or (aValue<0) then exit else FListIndex:=aValue;
  if FImageList<>nil then GetIMLChange(nil);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetGlyphNumber(const Value: Byte);
begin
  if (Value<>FGlyphNumber) and (Value>0) then
    begin
      FGlyphNumber := Value;
      if FGlyphColumn>=FGlyphNumber then
        FGlyphColumn:=FGlyphNumber-1;
      if FImageList<>nil then GetIMLChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetGlyphColumn(const Value: Byte);
begin
  if (Value<>FGlyphColumn) and (Value<FGlyphNumber) then
    begin
      FGlyphColumn := Value;
      if FImageList<>nil then GetIMLChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetLayout(aValue:TLMDGlyphTextLayout);
begin
  FLayout.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetOptions(aValue:TLMDImageBoxOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      if (lboCalcHeight in FOptions) then
        begin
          inherited ItemAutoHeight:=True
        end
      else
        begin
          inherited ItemAutoHeight:=False;
        end;
      if not (csLoading in ComponentState) then RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageListBox.GetImageIndex(aValue:Integer):Integer;
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
function TLMDCustomImageListBox.GetImageWidth(aValue:Integer):Integer;
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
function TLMDCustomImageListBox.GetImageHeight(aValue:Integer):Integer;
begin
  result:=0;
  if IMLEmpty then exit;
  if LMDIsSingleItemImageList(FImageList) then
    result:=LMDIMLItemHeight(FImageList, GetImageIndex(aValue))
  else
    result:=LMDIMLItemHeight(FImageList, FListIndex);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageListBox.GetStringValue(aValue:Integer):String;
begin
  result:='';
  if aValue<Items.Count then
    result:=LMDAnsiGetFirstString(Items[aValue], FDelimiter);
    end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.ReadIdent(Reader:TReader);
begin
  SetImageList(LMDReadGlobalIdent(Reader));
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.WriteIdent(Writer:TWriter);
begin
  LMDWriteGlobalIdent(Writer, FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageListBox.CheckCont:Boolean;
begin
  result:=LMDIsGlobalIdent(FImageList);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageListBox.HasControl:Boolean;
begin
  result:=(FImageList<>nil) and (FImageList.Owner<>LMDContainer);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.SetImagesOnly(aValue:Boolean);
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
function TLMDCustomImageListBox.StoreItems:Boolean;
begin
  result:=not FImagesOnly;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.UpdateEmptyList;
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

{-------------------------- Protected -----------------------------------------}
function TLMDCustomImageListBox.GetHorzExtent(index:Integer):Integer;
var
  aRect:TRect;
begin
  aRect:=Rect(0,0,0,0);
  LMDDrawTextCalcExt(Canvas, Items[Index], Font3D, aRect, Font, false, false, 0, DT_EXPANDTABS);
  result:=aRect.Right-aRect.Left+2+Layout.OffsetX;
  if IMLEmpty or (FLayout.AlignText2Glyph in [taTop, taTopLeft, taBottom, taBottomLeft]) then exit;
  inc(result, GetImageWidth(Index)+Layout.Spacing);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.DrawItem(Index: Integer; aRect: TRect;
  State: TOwnerDrawState);
var
  tmp:Integer;
  ts:String;
  tmp1:TRect;
  flags:LongInt;
  tmpb:TBitmap;
  extd:TLMDDrawTextStyles;

  // 7.0
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
  Dec(aRect.Right,Margin);
  Inc(aRect.Left, Margin);
  Dec(aRect.Bottom);

  extd:=[TLMDDrawTextStyle(Enabled)];

  // 7.0
  if Multiline then
    Include(extd, dtRectClip);
  // ----

  flags:=DT_NOPREFIX;
  flags:=flags or DrawTextBiDiModeFlags(flags);

  if LargeTextOptions in [lbltEndEllipsis, lbltPathEllipsis] then
  begin
    Include(extd, dtRectClip);
    case LargeTextOptions of
      lbltEndEllipsis:  Flags:=Flags or DT_END_ELLIPSIS;
      lbltPathEllipsis: Flags:=Flags or DT_PATH_ELLIPSIS;
    end;
  end;

  if lboCheckImageNr in FOptions then
    ts := LMDAnsiGetFirstString(GetStringValue(Index), FDelimiter)
  else
    ts := Items[Index];

  tmp  := ImageIndexValue[Index];
  tmp1 := Rect(0,0,0,0);

  if (tmp>-1) then
  begin
    tmpb := TBitmap.Create;
    try
      if LMDIsSingleItemImageList(FImageList) and (FImageList is TLMDCustomImageList) then
        LMDIMLItemBitmap(ImageList, tmp,0, tmpb)
      else
        LMDIMLItemBitmap(ImageList, FListIndex,tmp, tmpb);

      if FGlyphNumber > 1 then
      begin
        tmp1 := Rect(0,0, tmpb.width, tmpb.Height);
        tmp1 := CorrectRect(tmp1);

        if LMDIsSingleItemImageList(FImageList) then
          LMDDrawTextAndGlyphExt(Canvas, ts, Font3D, aRect, tmpb.Canvas,
                                 tmp1, nil, LMDIMLTransparentColor(FImageList, tmp, 0),
                                 FLayout, Multiline, false, lboTransparentImages in FOptions,
                                 extd, flags)
        else
          LMDDrawTextAndGlyphExt(Canvas, ts, Font3D, aRect, tmpb.Canvas,
                                 tmp1, nil, LMDIMLTransparentColor(FImageList, FListIndex, tmp),
                                 FLayout, Multiline, false, lboTransparentImages in FOptions,
                                 extd, flags)
      end
      else
        LMDDrawTextAndGlyph(Canvas, ts, Font3D, aRect, tmpb,  nil,
                            FLayout, Multiline, false, lboTransparentImages in FOptions,
                            extd, flags);
    finally
      tmpb.Free;
    end;
  end
  else
    LMDDrawTextAndGlyphExt(Canvas, ts, Font3D, aRect,
                           nil, tmp1, nil, clBlack, FLayout, Multiline,
                           false, false, [TLMDDrawTextStyle(Enabled)], flags);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageListBox.CanEdit:Boolean;
begin
  // In imagesOnly mode Imagelistbox is a virtual listbox
  result:=not (ImagesOnly or VirtualMode);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomImageListBox.GetEditRect(index:Integer):TRect;
begin
  result:=ItemRect(Index);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty(IDS_INTERNAL, ReadIdent, WriteIdent, CheckCont);
end;

{------------------------------------------------------------------------------}
function TLMDCustomImageListBox.IMLEmpty:Boolean;
begin
  result:=(FImageList=nil) or (LMDIMLCount(FImageList, 0)=0); //and replaced by or JH 09.12.99
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.GetIMLChange(Sender:TObject);
begin
  if (sender=Font3D) or (sender=FLayout) then
    begin
      if LargeTextOptions=lbltHorzScrollBar then
        InitHorzExtent;
      if HandleAllocated then RecreateWnd;
    end
  else
    begin
      RecreateWnd;
      if FImagesOnly then UpdateEmptyList;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.Loaded;
begin
  inherited Loaded;
  if FImagesOnly then UpdateEmptyList;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.MeasureItem(Index: Integer; var Height: Integer);
var
  tmp, tmp1:Integer;
  ts:String;
  cRect:TRect;
begin
  if (index=-1) then
    begin
      inherited;
      exit;
    end;

  tmp:=-1;
  tmp1:=0;

  if (GetImageHeight(Index)>0) then
    begin
      tmp:=GetImageHeight(Index);
      tmp1:=tmp+FLayout.Spacing+2+FLayout.OffsetY;
    end;

  if lboCheckImageNr in FOptions then
    ts:=LMDAnsiGetFirstString(Items[index], FDelimiter)
    else
    ts := Items[Index];

  if ts<>'' then
    begin
      if Multiline then
        begin
          cRect:=Rect(0,0,ClientWidth-GetImageWidth(index)-4,0);
          LMDDrawTextCalc(ts, Font3D, cRect, Font, MultiLine, false, 0, DT_EXPANDTABS or DT_WORDBREAK);
        end
      else
        begin
          cRect:=Rect(0,0,0,0);
          LMDDrawTextCalc(ts, Font3D, cRect, Font, MultiLine, false, 0, DT_EXPANDTABS);
        end;

      if FLayout.AlignText2Glyph in [taTop, taTopLeft, taBottom, taBottomLeft] then
        tmp:=tmp1+cRect.Bottom
      else
        if cRect.Bottom>tmp then
          tmp:=cRect.Bottom;
   end;

  if tmp>Height then
    Height:=tmp
  else
    Height:=ItemHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomImageListBox.Notification(aComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(aComponent, Operation);
  if (Operation=opRemove) then
    if (aComponent=FImageList) then SetImageList(nil);
end ;

{------------------------- Public----------------------------------------------}
constructor TLMDCustomImageListBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FListIndex:=0;
  FImageList:=nil;
  FChangeLink:=TChangeLink.Create;
  FChangeLink.OnChange:=GetIMLChange;

  FDefaultItem:=-1;
  FDelimiter:='|';
  FOptions:=[lboImageListOrder,lboCheckImageNr];
  FGlyphColumn:=0;
  FGlyphNumber:=1;

  FLayout:=TLMDGlyphTextLayout.Create;
  FLayout.OnChange:=GetIMLChange;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomImageListBox.Destroy;
begin
  FChangeLink.OnChange:=nil;
  FLayout.OnChange:=nil;
  FLayout.Free;
  FChangeLink.Free;
  inherited Destroy;
end;

{***************** Class TLMDCustomDerivedImageListBox ************************}
{------------------------------------------------------------------------------}
procedure TLMDCustomDerivedImageListBox.ReadIdent(Reader:TReader);
begin
  Reader.ReadIdent;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDerivedImageListBox.ReadChar(Reader:TReader);
begin
  Reader.ReadChar;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDerivedImageListBox.ReadInteger(Reader:TReader);
begin
  Reader.ReadInteger;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomDerivedImageListBox.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('DefaultItem', ReadInteger, nil, false);
  Filer.DefineProperty('Delimiter', ReadChar, nil, false);
  Filer.DefineProperty('Options', ReadIdent, nil, false);
end;

end.
