unit LMDRTFFontComboBox;
{$I LMDCmps.inc}

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

LMDRTFFontComboBox unit (RM)
---------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, StdCtrls, Graphics, Messages,
  LMDTypes, LMDRTFRichEdit, LMDRTFBase;

type

  TLMDRichFontDevice = (fdScreen, fdPrinter, fdBoth);

  TLMDRichFontInfo = record
    FontType:{$ifdef LMDX64}LongInt;{$else}Word;{$endif}
    Charset:{$ifdef LMDX64}LongInt;{$else}Word;{$endif}
  end;

  TLMDRichFontComboBox = class(TLMDRichCustomComboBox)
  private
    TrueTypeBMP, DeviceBMP: TBitmap;
    FDevice: TLMDRichFontDevice;
    FTrueTypeOnly: Boolean;
    FUpdate: Boolean;
    FDisplayFont: Boolean;
    FHideAtPrefixedFonts: Boolean;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMFontChange(var Message: TMessage); message WM_FONTCHANGE;
    procedure SetFontName(const NewFontName: TFontName);
    function GetFontName: TFontName;
    procedure SetDevice(Value: TLMDRichFontDevice);
    procedure SetDisplayFont(Value: Boolean);
    procedure SetTrueTypeOnly(Value: Boolean);
    procedure ReadBitmaps;
    procedure ResetItemHeight;
    procedure Reset;
    procedure SetHideAtPrefixedFonts(const Value: boolean);
  protected
    procedure BuildList; virtual;
    procedure CreateWnd; override;
    procedure ChangeSettings;override;
    procedure Change; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure Loaded;override;
    procedure UpdateInfo;override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Text;

    // 7.0 - Rebuilds full fontlist
    procedure Initialize;
  published
    property Flat;
    property DropDownWidth;
    property Device: TLMDRichFontDevice read FDevice write SetDevice default fdScreen;
    property FontName: TFontName read GetFontName write SetFontName;
    property DisplayFont:Boolean read FDisplayFont write SetDisplayFont default false;
    property TrueTypeOnly: Boolean read FTrueTypeOnly write SetTrueTypeOnly default False;
    property HideAtPrefixedFonts: boolean read FHideAtPrefixedFonts write SetHideAtPrefixedFonts default false;
  end;

  TLMDRichFontSizeComboBox = class(TLMDRichCustomComboBox)
  private
    FFontName: TFontName;
    FVRES: LongInt;
    FUpdate: Boolean;
    procedure SetFontName(const NewFontName: TFontName);
    function GetFontSize: LongInt;
    procedure SetFontSize(const Value: LongInt);
  protected
    procedure BuildList; virtual;
  procedure ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer); override;
  procedure ChangeSettings;override;
    procedure Change; override;
    procedure Loaded;override;
    procedure UpdateInfo;override;
  public
    constructor Create(AOwner: TComponent); override;
    property Text;
  published
    property Flat;
    property DropDownWidth;
    property FontName: TFontName read FFontName write SetFontName;
    property FontSize: LongInt read GetFontSize write SetFontSize default 10;
  end;

implementation

uses
  RichEdit, SysUtils, Printers;

{ *************************** TLMDRichFontComboBox ****************************}

  function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
    FontType: Integer; Data: Pointer): Integer; export; stdcall;

  var
    Box: TLMDRichFontComboBox;
    info: TLMDRichFontInfo;
  begin
  Box:= TLMDRichFontComboBox(Data);
  if Box.Items.IndexOf(LogFont.lfFaceName) < 0 then
      begin
        if (Box.FTrueTypeOnly and ((FontType and TRUETYPE_FONTTYPE) = 0)) or
            (Box.HideAtPrefixedFonts and (LogFont.lfFaceName[0]='@'))      then
          begin
        { do nothing }
          end
        else
          begin
            info.FontType:=Word(FontType);
            info.Charset:=LogFont.lfCharSet;
            Box.Items.AddObject(LogFont.lfFaceName, Pointer(info));
          end;
      end;
    Result:= 1;
  end;

  function EnumFontFamiliesProc(var LogFont: TLogFont; var TextMetric:
    TTextMetric; FontType: Integer; Data: Pointer): Integer; stdcall;

  var
    Box : TLMDRichFontSizeComboBox;

    procedure AddToList(const aValue: string);
    var
      J: Integer;
      C: Boolean;
    begin
      J:= 0;
      C:= False;
    Box := TLMDRichFontSizeComboBox(Data);
    with Box do
        begin
          while (j<Items.Count) and not c do
            if StrToInt(aValue)>=StrToInt(Items[j]) then Inc(j) else c:=True;
          Items.Insert(j, aValue);
        end;
    end;

  var
    I: Integer;
    C: string;

  const
    MaxStdSizes = 16;

  const
    cSizes: array[0..MaxStdSizes - 1] of Integer = (8, 9, 10, 11, 12, 14, 16, 18,
      20, 22, 24, 26, 28, 36, 48, 72);

  begin
    Result:= 0;
  Box := TLMDRichFontSizeComboBox(Data);
  with Box do
      begin
        Items.BeginUpdate;
        try
          if (FontType and TRUETYPE_FONTTYPE = TRUETYPE_FONTTYPE) or (FontType in [0, 2]) then
            begin
              for i:= 0 to (MaxStdSizes - 1) do
                Items.Add(IntToStr(cSizes[i]));
              Result:= 0
            end;

          if (FontType and RASTER_FONTTYPE = RASTER_FONTTYPE) then
            with TextMetric do
              begin
                c:= IntToStr(Round((tmHeight - tmInternalLeading) * 72 / FVRES));
                if Items.IndexOf(c) = -1 then AddToList(c);
                Result:= 1;
              end;
        finally
          Items.EndUpdate;
        end;
    end;
  end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.BuildList;
var
  DC: HDC;
begin
  if not HandleAllocated then Exit;
  { fill list }
  Clear;
  DC:= GetDC(0);
  try
    if (FDevice = fdScreen) or (FDevice = fdBoth) then
    EnumFonts(DC, nil, @EnumFontsProc, Pointer(Self));
    if (FDevice = fdPrinter) or (FDevice = fdBoth) then
      try
        EnumFonts(Printer.Handle, nil, @EnumFontsProc, Pointer(Self));
      except
        On Exception do ;
      end;
  finally
    ReleaseDC(0, DC);
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.SetDisplayFont(Value: Boolean);
begin
  if Value<>FDisplayFont then
    begin
      FDisplayFont:=Value;
      if not (csLoading in ComponentState) then RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.SetFontName(const NewFontName: TFontName);
var
  I, Item: Integer;
begin
  if FontName <> NewFontName then
    begin
      HandleNeeded;
    { change selected item }
      I:= -1;
      for Item:= 0 to Items.Count - 1 do
        begin
        if AnsiSameText(Items[Item], NewFontName) then
        begin
              I:= Item;
              Break;
            end;
        end;
      if HandleAllocated then
        ItemIndex:= I;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDRichFontComboBox.GetFontName: TFontName;
begin
  Result:= Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.SetTrueTypeOnly(Value: Boolean);
begin
  if Value <> FTrueTypeOnly then
    begin
      FTrueTypeOnly:= Value;
      Reset;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.SetDevice(Value: TLMDRichFontDevice);
begin
  if Value <> FDevice then
    begin
      FDevice:= Value;
      Reset;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.ReadBitmaps;
begin
  { assign bitmap glyphs }
  TrueTypeBMP:= TBitmap.Create;
  TrueTypeBMP.Handle:= LoadBitmap(HInstance, 'LMDRTFTTF_FONT');
  DeviceBMP:= TBitmap.Create;
  DeviceBMP.Handle:= LoadBitmap(HInstance, 'LMDRTFPRN_FONT');
  end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.Reset;
var
  SaveName: string;
begin
  if HandleAllocated then
    begin
      FUpdate:= True;
      try
        SaveName:= FontName;
        BuildList;
        FontName:= SaveName;
      finally
        FUpdate:= False;
        if FontName <> SaveName then Change;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.ResetItemHeight;
var
  nuHeight: Integer;
  DC: HDC;
  SaveFont: HFont;
  Metrics: TTextMetric;
begin
  DC:= GetDC(0);
  try
    SaveFont:= SelectObject(DC, Font.Handle);
    GetTextMetrics(DC, Metrics);
    SelectObject(DC, SaveFont);
  finally
    ReleaseDC(0, DC);
  end;
  nuHeight:= Metrics.tmHeight + 2;
  if nuHeight < TrueTypeBMP.Height then nuHeight:= TrueTypeBMP.Height;
  ItemHeight:= nuHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.WMFontChange(var Message: TMessage);
begin
  inherited;
  Reset;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
  RecreateWnd;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDRichFontComboBox.CreateWnd;
var
  OldFont: string;
begin
  OldFont:= FontName;
  inherited CreateWnd;
  BuildList;
  SetFontName(OldFont);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.Change;
begin
  if not FUpdate then
    begin
      if not (csLoading in ComponentState) then
        inherited Change;
      if csDesigning in ComponentState then exit;
      if not DroppedDown then
        ChangeSettings;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.ChangeSettings;
//var
  //Format: TCharFormat2;
//  tmp:TFont;
begin
  if csLoading in ComponentState then exit;
  if Assigned(RichEditControl) and not RichEditControl.ReadOnly then
    begin
{
      tmp:=TFont.Create;
      tmp.Charset:=DEFAULT_CHARSET;
      tmp.Name:=FontName;
      tmp.Size:=RichEditControl.SelAttributes.Size;
}
//      if RichEditControl.SelLength=0 then
      RichEditControl.SelAttributes.Name := FontName;
      //RichEditControl.SelAttributes.Charset := DEFAULT_CHARSET;
      //RichEditControl.SelAttributes.Assign(tmp);
      if RichEditControl.CanFocus then
        RichEditControl.SetFocus;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Bitmap: TBitmap;
  BmpWidth: Integer;
  info:TLMDRichFontInfo;
  Text: array[0..255] of Char;
begin
  with Canvas do
    begin
      FillRect(Rect);
      BmpWidth:= 20;
      info:=TLMDRichFontInfo(Items.Objects[Index]);
      if (info.FontType and TRUETYPE_FONTTYPE) <> 0 then
        Bitmap:= TrueTypeBMP
      else if (info.FontType and DEVICE_FONTTYPE) <> 0 then
        Bitmap:= DeviceBMP
      else
        Bitmap:= nil;
      if Bitmap <> nil then
        begin
          BmpWidth:= Bitmap.Width;
        BrushCopy(Bounds(Rect.Left + 2, (Rect.Top + Rect.Bottom -
            Bitmap.Height)
            div 2, Bitmap.Width, Bitmap.Height), Bitmap, Bounds(0, 0,
            Bitmap.Width,
            Bitmap.Height), Bitmap.TransparentColor);
        end;
    { uses DrawText instead of TextOut in order to get clipping against
      the combo box button   }
    StrPCopy(Text, Items[Index]);
    Rect.Left:=Rect.Left+BmpWidth+6;

      if not Enabled then
        Canvas.Font.Color:=clGrayText;

      if DroppedDown and FDisplayFont then
        begin
          if info.CharSet=SYMBOL_CHARSET then
            begin
              Canvas.Font.Name:=Font.Name;
            DrawText(Canvas.Handle, Text, StrLen(Text), Rect, DT_SINGLELINE or
                                                                DT_VCENTER or DT_NOPREFIX);
            exit;
            end

          else
           Canvas.Font.Name:=Items[Index];
        end;
    DrawText(Canvas.Handle, Text, StrLen(Text), Rect, DT_SINGLELINE or
               DT_VCENTER or DT_NOPREFIX);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.Loaded;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.UpdateInfo;
begin
  if Assigned(RichEditControl) then
    try
      FUpdate:=True;
      if HandleAllocated and Visible then
        FontName:= RichEditControl.SelAttributes.Name
      else
        FontName:= RichEditControl.Font.Name
    finally
      FUpdate:=false;
    end;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRichFontComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDevice:= fdScreen;
  Style:= csOwnerDrawFixed;
  Sorted:= True;
  FUpdate:= False;
  ReadBitmaps;
  ResetItemHeight;
end;

{------------------------------------------------------------------------------}
destructor TLMDRichFontComboBox.Destroy;
begin
  TrueTypeBMP.Free;
  DeviceBMP.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontComboBox.Initialize;
begin
  RecreateWnd;
end;

{ ************************ TLMDRichFontSizeComboBox ***************************}
{ ----------------------------- private -------------------------------------- }
procedure TLMDRichFontSizeComboBox.SetFontName(const NewFontName: TFontname);
var
  oldFS: LongInt;
begin
  if FFontName <> NewFontName then
    begin
      FFontName:= NewFontName;
      oldFS:= FontSize;
      BuildList;
      FontSize:= oldFS;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontSizeComboBox.SetFontSize(const Value: Integer);
var
 i:LongInt;
begin
  if (csLoading in ComponentState) {or (csDesigning in ComponentState)} then
    Text:=IntToStr(value)
  else
    begin
      if not (csLoading in ComponentState) then
        if Items.Count=0 then
          BuildList;
      try
        Text:=Inttostr(Value);
        i:=StrToInt(Text);
        if (i<4) then Text:='10';
        if (i>1000) then Text:='1000';

      except
        On Exception do Text:='10';
      end;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRichFontSizeComboBox.GetFontSize: LongInt;
var
  E: LongInt;
begin
  Val(Text,Result,E);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontSizeComboBox.BuildList;
var
  DC: HDC;
begin
  Items.Clear;
  if FFontName = '' then exit;

  DC:= GetDC(0);
  try
    FVRES:= GetDeviceCaps(DC, LOGPIXELSY);
  EnumFontFamilies(DC, PChar(FFontName), @EnumFontFamiliesProc, LPARAM(self));
  {no entries? maybe printer font?}
    if Items.Count = 0 then
      begin
        try
          FVRES:= GetDeviceCaps(Printer.Handle, LOGPIXELSY);
        EnumFontFamilies(Printer.Handle, PChar(FFontName), @EnumFontFamiliesProc, LPARAM(self));
        except
          On Exception do ;
        end;
      end;
  finally
    ReleaseDC(0, DC);
  end;
end;

{ --------------------------- protected -------------------------------------- }

procedure TLMDRichFontSizeComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWnd; ComboProc: Pointer);

begin
  with Message do
    case Msg of
      WM_CHAR:
        with TWMKey(Message) do
        begin
            case CharCode of
              $30..$39: FUpdate:=True;
            end;
          end;
    end;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontSizeComboBox.Loaded;
begin
  inherited Loaded;
  if not Assigned(RichEditControl) then
    begin
      FontSize:=FontSize;
      SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(0, 0));
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontSizeComboBox.Change;
begin
  if csLoading in ComponentState then exit;
  inherited;
  if not DroppedDown then
    if FUpdate then
      FUpdate:=false
    else
      ChangeSettings;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontSizeComboBox.ChangeSettings;
begin
  if csLoading in ComponentState then exit;
  if Assigned(RichEditControl) and not RichEditControl.ReadOnly then
    begin
      RichEditControl.SelAttributes.Size:=FontSize;
      if RichEditControl.CanFocus then
        RichEditControl.SetFocus;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichFontSizeComboBox.UpdateInfo;
begin
  if Assigned(RichEditControl) then
    if HandleAllocated and Visible then
      begin
        FontName:=RichEditControl.SelAttributes.Name;
        FontSize:=RichEditControl.SelAttributes.Size;
        //if not Visible then
          SendMessage(Handle, CB_SETEDITSEL, 0, MakeLParam(0, 0));
      end
    else
      begin
        FontName:=RichEditControl.Font.Name;
        FontSize:=RichEditControl.Font.Size;
      end;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRichFontSizeComboBox.Create(AOwner: TComponent);
begin
  inherited;
  //inherited Text:= IntToStr(Font.Size);
  FFontName:= Font.Name;
  FUpdate:=false;
end;

procedure TLMDRichFontComboBox.SetHideAtPrefixedFonts(
  const Value: boolean);
begin
  if Value <> FHideAtPrefixedFonts then
    begin
      FHideAtPrefixedFonts := Value;
      Reset;
    end;
end;

end.
