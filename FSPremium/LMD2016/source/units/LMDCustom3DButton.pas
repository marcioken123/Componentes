unit LMDCustom3DButton;
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

LMDCustom3DButton unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Graphics,
  LMDClass,
  LMDButtonBase,
  LMDGraph,
  LMDBaseGraphicButton;

type
  TLMD3DButtonBevelWidth=0..5;
  TLMDCustom3DButton=class(TLMDBaseGraphicButton)
  private
    FBevelWidth : TLMD3DButtonBevelWidth;
    FButtonFace : TLMDButtonFace;
    FPixelFormat: TLMDSavePixelFormat;
    FClipX      : TObject;
    FColorLight,
    FColorShadow,
    FColorBevel,
    FColorDisabled: TColor;
    FCompressed : Boolean;

    procedure SetBevelWidth(aValue: TLMD3DButtonBevelWidth);
    procedure SetColor(Index: Integer; aValue: TColor);
    procedure SetQuickDraw(aValue:Boolean);

    {helper for reading/writing properties from TReader, TWriter}
    procedure ReadBitmap(Stream:TStream);
    procedure ReadCount(Reader:TReader);
    procedure ReadWidth(Reader:TReader);
    procedure WriteBitmap(Stream:TStream);
    procedure WriteCount(Writer:TWriter);
    procedure WriteWidth(Writer:TWriter);
  protected
    FQuickDraw,
    FProcessRunning: Boolean;
    procedure DefineProperties(Filer:TFiler);override;
    procedure Paint;override;
    function VerifyTransparency(X, Y: Integer): Boolean; override;
    procedure DoTerminate(Sender: TObject);
    procedure GetChange(Sender: TObject); override;
    function GetPalette: HPALETTE;  override;
    function IsCustom:Boolean; override;
  public
    FKind: integer;
    procedure Set3DPics(TempUp,TempDown,TempDis,MonoUp,MonoDown,MonoDis: TBitmap);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property BevelWidth: TLMD3DButtonBevelWidth read FBevelWidth write SetBevelWidth default 2;
    property ColorLight: TColor index 0 read FColorLight write SetColor default clBtnHighlight;
    property ColorShadow: TColor index 1 read FColorShadow write SetColor default clBtnShadow;
    property ColorBevel: TColor index 2 read FColorBevel write SetColor default clBlack;
    property ColorDisabled: TColor index 3 read FColorDisabled write SetColor default clWhite;
    property QuickDraw:Boolean read FQuickDraw write SetQuickDraw default True;
  published
    // 7.0
    property ButtonLayout;
    property EnterColor;
    property EnterColorChange;
    property Glyph;
    property Font;
    property FontFX;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property NumGlyphs;
    property RepeatedClick;
    property RepeatingInterval;
    property RepeatingDelay;
    property UseCaption;
    property OnDropDown;
    // ---

    property AllowTransparency;
    property ButtonFace: TLMDButtonFace read FButtonFace write FButtonFace;
    property Compressed: Boolean read FCompressed write FCompressed default false;
    property GroupIndex;
    property Pressed;
    property DropDownMenu;
    property DropDownIndent;
    property DropDownRight;
    property PixelFormat:TLMDSavePixelFormat read FPixelFormat write FPixelFormat default spfDefault;
    property Transparent default false;
    property MultiLine;
  end;

implementation

uses
  Types, Forms, StdCtrls, Controls, SysUtils,
  LMDCustomControl, LMDCustomImageList, LMDSysIn, LMDProcs, LMDGraphUtils,
  LMDStreamUtils;

type
  TLMDButtonClipMax=0..16;

  {----------------------TLMDCustomClip----------------------------------------}
  TLMDClip = class(TObject)
  private
    HasBmp: Boolean; {default false}
    FTransparentColor: TColor;
    FCount: TLMDButtonClipMax;
    FCellBitmap: TBitmap;
    FCellWidth,
    FCellHeight: word;
    procedure SetCount(AValue: TLMDButtonClipMax);
  protected
    function GetEmpty:Boolean;
    function GetPalette:HPalette;
  public
    constructor Create;
    destructor Destroy; override;
    //procedure AddCell;
    //procedure CopyCell(SourceCell: TBitmap);
    procedure SetPicture(Index:integer; ABitmap:TBitmap);
    procedure Init;
    procedure GetPicture(Index:integer; ABitmap:TBitmap);
    property Count: TLMDButtonClipMax read FCount write SetCount;
    property Empty:Boolean read GetEmpty;
    property Height:Word read FCellHeight;
    property Palette:HPalette read GetPalette;
    property TransparentColor: TColor read FTransparentColor write FTransparentColor;
    property Width:Word read FCellWidth;
  end;

{************************ Class TLMDClip **************************************}
{------------------------- Protected ------------------------------------------}
function TLMDClip.GetEmpty:Boolean;
begin
  Result:=(FCount=0) and (FCellBitmap=nil);
end;

{------------------------------------------------------------------------------}
function TLMDClip.GetPalette:HPalette;
begin
  result:=0;
  if not GetEmpty then result:=FCellBitmap.Palette;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.SetCount(AValue:TLMDButtonClipMax);
var
  Temp: TBitmap;
begin
  if FCount=aValue then exit;

  if (aValue=0) and (FCellBitmap<>nil) then init;
  if aValue=0 then exit;
  if not Assigned(FCellBitmap) then
    begin
      FCellBitmap:=TBitmap.Create;
      HasBmp:=True;
    end;

  if FCellBitmap.Width>0 then FCellWidth:=(FCellBitmap.Width div aValue);
  FCellHeight:=FCellBitmap.Height;
  Temp:=TBitmap.Create;
  try
    LMDCopyBmpSize(FCellBitmap, Temp);
    Temp.Canvas.Draw(0,0,FCellBitmap);
    FCellBitmap.Assign(Temp);
  finally
    Temp.Free;
  end;
  FCount:=AValue;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDClip.Create;
begin
  inherited Create;
  HasBmp:=False;
  FCellBitmap:=nil;
  {FCellBitmap:=TBitmap.Create;}
  FCellWidth:=0;
  FCellHeight:=0;
  FCount:=0;
end;

{------------------------------------------------------------------------------}
destructor TLMDClip.Destroy;
begin
  if Assigned(FCellBitmap) then
    FreeAndNil(FCellBitmap);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
{procedure TLMDClip.AddCell;
begin
  if not assigned(FCellBitmap) then
    begin
      FCellBitmap:=TBitmap.Create;
      HasBmp:=True;
    end;
  Inc(FCount);
  FCellBitmap.Width:=FCellWidth*FCount;
  FCellBitmap.Height:=FCellHeight;
end;

{------------------------------------------------------------------------------}
{procedure TLMDClip.CopyCell(SourceCell: TBitmap);
begin
  if not Assigned(SourceCell) then exit;
  if not Assigned(FCellBitmap) then
    begin
      FCellBitmap:=TBitmap.Create;
      HasBmp:=True;
    end;
  FCellBitmap.Assign(SourceCell);
  FCellWidth:=FCellBitmap.Width div FCount;
  FCellHeight:=FCellBitmap.Height;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.Init;
begin
  HasBmp:=False;
  if Assigned(FCellBitmap) then FreeAndNil(FCellBitmap);
  FCellWidth:=0;
  FCellHeight:=0;
  FCount:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.SetPicture(Index:integer; aBitmap:TBitmap);
var
  oldw: integer;
begin
  if not Assigned(aBitmap) then exit;
  if not Assigned(FCellBitmap) then
    begin
      FCellBitmap:=TBitmap.Create;
      HasBmp:=True;
    end;
  if Index<0 then Index:=0;
  if FCount-1<Index then
    begin
      if Index=0 then
        begin
          FCellWidth:=aBitmap.Width;
          FCellHeight:=aBitmap.Height;
        end;
      Count:=Index+1;
    end;
  try
    if index=0 then
      begin
        oldw:=FCellBitmap.Width;
        FCellBitmap.assign(aBitmap);
        FCellBitmap.Width:=oldw;
      end
    else
      FCellBitmap.Canvas.Draw(Index*FCellWidth,0,aBitmap);
  except;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDClip.GetPicture(Index:integer; aBitmap:TBitmap);
begin

  if not assigned(aBitmap) then exit;
  if not assigned(FCellBitmap) then exit;
  if Index<0 then Index:=0;
  if (Pred(FCount)<Index) or (FCellBitmap.Width=0) then exit;

  try
    with aBitmap do
      begin
        Width:=FCellWidth;
        Height:=FCellHeight;
        SelectPalette(Canvas.Handle, FCellBitmap.Palette, True);
        RealizePalette(Canvas.Handle);
        Canvas.CopyRect(Rect(0,0,FCellWidth,FCellHeight),FCellBitmap.Canvas,
          Rect(Index*FCellWidth,0,(Index+1)*FCellWidth,FCellHeight));
      end;
  except;
  end;

end;
{********************** Class TLMDCustom3DButton ******************************}
{------------------------- Private --------------------------------------------}
procedure TLMDCustom3DButton.SetBevelWidth(aValue: TLMD3DButtonBevelWidth);
begin
  if aValue<>FBevelWidth then
    begin
      FBevelWidth:=aValue;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.SetColor(Index: Integer; aValue: TColor);
begin
  case index of
    0: if FColorLight<>aValue then FColorLight:=aValue else exit;
    1: if FColorShadow<>aValue then FColorShadow:=aValue else exit;
    2: if FColorBevel<>aValue then FColorBevel:=aValue else exit;
    3: if FColorDisabled<>aValue then FColorDisabled:=aValue else exit;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.SetQuickDraw(aValue:Boolean);
begin
  if aValue<>FQuickDraw then
    begin
      FQuickDraw:=aValue;
      Invalidate;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.ReadBitmap(Stream:TStream);
begin
  with TLMDClip(FClipX) do
    begin
      if not Assigned(FCellBitmap) then
        begin
          FCellBitmap:=TBitmap.Create;
          HasBmp:=True;
        end;
      FCompressed:=Boolean(stReadByte(Stream));
      stReadBitmap(Stream, FCellBitmap, FCompressed);
      FCellHeight:=FCellBitmap.Height;
   end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.ReadCount(Reader:TReader);
begin
  TLMDClip(FClipX).Count:=Reader.ReadInteger;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.ReadWidth(Reader:TReader);
begin
  TLMDClip(FClipX).FCellWidth:=Reader.ReadInteger;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.WriteBitmap(Stream:TStream);
begin
  stWriteByte(Stream, Ord(FCompressed));
  stWriteBitmap(Stream, TLMDClip(FClipX).FCellBitmap, FCompressed, LMDPixelFormatColors[FPixelFormat]);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.WriteCount(Writer:TWriter);
begin
  Writer.WriteInteger(TLMDClip(FClipX).Count);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.WriteWidth(Writer:TWriter);
begin
  Writer.WriteInteger(TLMDClip(FClipX).FCellWidth);
end;

{------------------------- Protected ------------------------------------------}
procedure TLMDCustom3DButton.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  with TLMDClip(FClipX) do
    begin
      Filer.DefineProperty('CellCount', ReadCount, WriteCount, TLMDClip(FClipX).Count<>0);
      Filer.DefineProperty('CellWidth', ReadWidth, WriteWidth, TLMDClip(FClipX).Count<>0);
      Filer.DefineBinaryProperty('CellBitmap', ReadBitmap, WriteBitmap, TLMDClip(FClipX).Count<>0);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.Paint;
var
  TempBmp,
  TempCell,
  MonoCell: TBitmap;
  aRect:TRect;
begin
  if TLMDClip(FClipX).Empty then
    begin
      if not Transparent then FillControl;
      aRect:=Rect(0,0,Width,Height);
      Canvas.Pen.Color:=clBtnText;
      Canvas.Brush.Style:=bsClear;
      Canvas.Rectangle(0,0,Width,Height);
      DrawGlyphAndText(Canvas, aRect);
      exit;
    end;

  TempBmp:=TBitmap.Create;
  TempCell:=TBitmap.Create;
  MonoCell:=TBitmap.Create;
  try
    TempBmp.Width:=Width;
    TempBmp.Height:=Height;
    TempCell.Width:=TLMDClip(FClipX).FCellWidth;
    TempCell.Height:=TLMDClip(FClipX).FCellHeight;
    MonoCell.Width:=TLMDClip(FClipX).FCellWidth;
    MonoCell.Height:=TLMDClip(FClipX).FCellHeight;
    with TempBmp do
      begin
        TempBmp.Canvas.Brush.Color:=self.Color;
        if CheckOptimized then
          BackDrawArea(tempbmp.Canvas, ClientRect, Point(0,0))   // 7.0.61 RM
        else
          TempBmp.Canvas.FillRect(ClientRect);
        if not Enabled then
          begin
            TLMDClip(FClipX).GetPicture(2,TempCell);
            TLMDClip(FClipX).GetPicture(5,MonoCell);
          end
        else
          case FState of
            bsUp, bsMouseOver:
              begin
                TLMDClip(FClipX).GetPicture(0,TempCell);
                TLMDClip(FClipX).GetPicture(3,MonoCell);
              end;
            bsDown, bsOptionSet, bsDropDownOpen:
              begin
                TLMDClip(FClipX).GetPicture(1,TempCell);
                TLMDClip(FClipX).GetPicture(4,MonoCell);
              end;
          end;
        LMDBmpDrawExt(TempBmp.Canvas, ClientRect, TempCell.Canvas, ClientRect,
                      DSF_TRANSPARENCY_MASK, TempCell.Canvas.Pixels[0,Height-1], 0, MonoCell.Canvas);

        aRect:=Rect(0,0,Width,Height);
        if FState in [bsDown, bsOptionSet, bsDropDownOpen] then OffsetRect(aRect,1,1);
      end;

    DrawGlyphAndText(TempBmp.Canvas, aRect);

    if not QuickDraw and not ((aoAutoRealizePalette in LMDApplication.Options) and (LMDSIColorDepth<9)) then
      begin
        SelectPalette(Canvas.Handle, TLMDClip(FClipX).FCellBitmap.Palette, True);
        RealizePalette(Canvas.Handle);
      end;

    Canvas.Draw(0,0,TempBmp);
  finally
    TempBmp.Free;
    TempCell.Free;
    MonoCell.Free;
  end;

end;

{------------------------------------------------------------------------------}
function TLMDCustom3DButton.VerifyTransparency(X, Y: Integer): Boolean;
begin
  Result:=True;
  if not assigned(TLMDClip(FClipX).FCellBitmap) then exit;
  with TLMDClip(FClipX) do
    if FCellBitmap.Canvas.Pixels[X+(3*FCellWidth),Y]=clBlack then
      Result:=True else Result:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.DoTerminate(Sender: TObject);
begin
  {FDoTerminate:=True;}
  TForm(TButton(Sender).Parent).Close;
  FProcessRunning:=False;
end;

{------------------------------------------------------------------------------}
function TLMDCustom3DButton.GetPalette: HPALETTE;
begin
  result:=TLMDClip(FClipX).Palette;
end;

{------------------------------------------------------------------------------}
function TLMDCustom3DButton.IsCustom:Boolean;
begin
  result:=not HasIML;
end;

{------------------------- Public ---------------------------------------------}
procedure TLMDCustom3DButton.Set3DPics(TempUp,TempDown,TempDis,
          MonoUp,MonoDown,MonoDis: TBitmap);
begin
  with TLMDClip(FClipX) do
    if not TempUp.Empty then
      begin
        if FCellBitmap=nil then
          begin
            FCellBitmap:=TBitmap.Create;
            HasBmp:=True;
          end;
        FCount:=6;
        FCellBitmap.Width:=TempUp.Width*6;
        FCellWidth:=TempUp.Width;
        FCellHeight:=TempUp.Height;
        FCellBitmap.Height:=TempUp.Height;
        SetPicture(0,TempUp); SetPicture(1,TempDown);
        SetPicture(2,TempDis); SetPicture(3,MonoUp);
        SetPicture(4,MonoDown); SetPicture(5,MonoDis);
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustom3DButton.GetChange(Sender: TObject);
begin
  Invalidate;{Repaint;}
end;

{------------------------------------------------------------------------------}
constructor TLMDCustom3DButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCompressed:=False;
  FQuickDraw:=True;
  ControlStyle:=ControlStyle+[csOpaque]-[csClickEvents];
  Transparent:=False;
  FClipX:=TLMDClip.Create;
  FButtonFace:=TLMDButtonFace.Create;
  FBevelWidth:=2;
  FColorLight:=clBtnHighlight;
  FColorShadow:=clBtnShadow;
  FColorBevel:=clBlack;
  FColorDisabled:=clWhite;
  Width:=50;
  Height:=50;
end;

{------------------------------------------------------------------------------}
destructor TLMDCustom3DButton.Destroy;
begin
  if FProcessRunning then
    repeat
      Application.ProcessMessages
    until FProcessRunning=False;
  TLMDClip(FClipX).Free;
  FButtonFace.Free;
  {if assigned(FPicture) then FPicture.Free;}
  inherited Destroy;
end;

end.
 
