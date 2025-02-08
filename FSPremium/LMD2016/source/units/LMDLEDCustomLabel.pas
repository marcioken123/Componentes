unit LMDLEDCustomLabel;
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

LMDLEDCustomLabel unit ()
-------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls, Graphics,
  LMDGraphicControl, LMDLED;

type
  {------------------------------- TLMDLEDLabel ----------------------------------}
  TLMDLEDCustomLabel = class(TLMDGraphicControl)
  private
    FAutosize:Boolean;
    FDigits:Byte;
    FLED:TLMDLED;
    FValue:LongInt;
    FStyle:TLMDLEDStyle;
    procedure SetAutosize(aValue:Boolean); reintroduce; 
    procedure SetByte(aValue:Byte);
    procedure SetLED(aValue:TLMDLED);
    procedure SetStyle(aValue:TLMDLEDStyle);
    procedure SetValue(aValue:LongInt);
    procedure CalcBoundsRect;
    procedure CMTextChanged(var Message: TMessage);message CM_TEXTCHANGED;
    procedure CMColorChanged(var Message: TMessage);message CM_COLORCHANGED;
  protected
    procedure GetChange(Sender:TObject);override;
    function GetLabelText:String;virtual;
    procedure Loaded;override;
    procedure Paint; override;
    function ValueString(aValue:LongInt):String;
    property Value:LongInt read FValue write SetValue default 0;
  public
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
    property Caption;
  published
    property About;
    property Align;
    property AutoSize:Boolean read FAutosize write SetAutosize default false;
    property Bevel;
    property Color default clBlack;
    property DragCursor;
    property DragMode;
    property Digits:Byte read FDigits write SetByte default 2;
    property Enabled;
    property LED:TLMDLED read FLED write SetLED;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Style:TLMDLEDStyle read FStyle write SetStyle default lsString;
    property Transparent default false;
    property Visible;
    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;

    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseExit;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}
  end;

implementation
uses
  Types, SysUtils,
  LMDStrings;

{------------------------ Private ---------------------------------------------}
procedure TLMDLEDCustomLabel.SetAutosize(aValue:Boolean);
begin
  if aValue<>FAutosize then
    begin
      FAutosize:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.SetByte(aValue:Byte);
begin
  if (aValue<>FDigits) and (aValue<>0) then
    begin
      FDigits:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.SetLED(aValue:TLMDLED);
begin
  FLED.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.SetStyle(aValue:TLMDLEDStyle);
begin
  if aValue<>FStyle then
    begin
      FStyle:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.SetValue(aValue:LongInt);
begin
  if (aValue<>FValue) then
    begin
      FValue:=aValue;
      if FStyle=lsInteger then Paint;{InvalidateControl;}
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.CalcBoundsRect;
var
  tmp:String;
begin
  tmp:=GetLabelText;
  with FLED.CalcBoundsRect(tmp, Bevel.BevelExtend) do
    begin
      Width:=Right;
      Height:=Bottom;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.CMColorChanged(var Message: TMessage);
begin
  inherited;
  FLED.BackColor:=Color;
  {GetChange(nil);}
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.CMTextChanged(var Message: TMessage);
begin
  inherited;
  GetChange(nil);
end;

{-------------------------- Protected -----------------------------------------}
procedure TLMDLEDCustomLabel.GetChange(Sender :TObject);
begin
  if FAutoSize then CalcBoundsRect;
  inherited GetChange(nil);
end;

{------------------------------------------------------------------------------}
function TLMDLEDCustomLabel.GetLabelText:String;
begin
  if FStyle=lsInteger then result:=ValueString(FValue) else result:=Caption;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.Loaded;
begin
  inherited Loaded;
  {$IFDEF LMDTOOLS10}
  if FLED.Digits<>2 then FDigits:=FLED.Digits;
  if FLED.BackColor<>clBlack then Color:=FLED.BackColor;
  if FLED.Caption<>'' then Caption:=FLED.Caption;
  if FLED.Transparent<>false then Transparent:=True;
  if FLED.Style<>lsString then FStyle:=lsInteger;
  if FLED.Value<>0 then FValue:=FLED.Value;
  {$ENDIF}
  if FAutoSize then CalcBoundsRect;
end;

{------------------------------------------------------------------------------}
procedure TLMDLEDCustomLabel.Paint;
var
  tmp:TBitmap;
  aRect, bRect:TRect;
  str:String;

begin

  if csLoading in ComponentState then exit;
  str:=GetLabelText;

  aRect:=Bevel.Paintbevel(Canvas, ClientRect, Transparent);
  if IsRectEmpty(aRect) then exit;

  tmp:=TBitmap.Create;
  with tmp do
    try
      with aRect do bRect:=Rect(0,0, Right-Left, Bottom-Top);
      Height:=bRect.Bottom;
      Width:=bRect.Right;
      Canvas.Brush.Style:=bsSolid;
      Canvas.Brush.Color:=Self.Color;
      Canvas.FillRect(bRect);
      FLED.BackColor:=Self.Color;
      FLED.PaintLED(Canvas, bRect, Str, Enabled, True);

      if self.Transparent then
        begin
          tmp.Transparent:=True;
          tmp.TransparentColor:=self.Color;
        end;
      Self.Canvas.Draw(aRect.Left,aRect.Top, tmp);
    finally
      tmp.Free;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDLEDCustomLabel.ValueString(aValue:LongInt):String;
var
  l:Integer;
begin
  l:=Length(IntToStr(aValue));
  if l>FDigits then
    result:=LMDAnsiFillString(FDigits, '-')
  else
    result:=LMDAnsiFillString(FDigits-l, '0')+IntToStr(aValue);
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDLEDCustomLabel.Create(AOwner :TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FLED := TLMDLED.Create;
  FLED.OnChange := GetChange;
  FDigits:=2;
  FAutosize := False;
  FStyle:=lsString;
  DisableTransMode;
  Color:=clBlack;
end;

{------------------------------------------------------------------------------}
destructor TLMDLEDCustomLabel.Destroy;
begin
  FLED.OnChange := nil;
  FLED.Free;
  inherited destroy;
end;

end.
 
