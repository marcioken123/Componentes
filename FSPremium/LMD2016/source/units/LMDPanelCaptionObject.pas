unit LMDPanelCaptionObject;
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

LMDPanelCaptionObject unit (RM)
-------------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Controls,
  Forms,
  Graphics,
  Messages,
  StdCtrls,
  LMDBase,
  LMDClass,
  LMDGraph,
  LMDObject;

const
  //def_CaptionButtonReduce=3;
  def_CaptionHeight=18;
  def_CaptionFontSize=10;
  //def_GroupScrollBar=16;

type

  TLMDPanelCaptionButton=(pcsHelp, pcsMinMax, pcsClose);
  TLMDPanelCaptionButtons=set of TLMDPanelCaptionButton;
  TLMDPanelCaptionDrawMode=(pcdWindows, pcdNormal, pcdOwnerDraw);

  TLMDPanelCaptionObject = Class(TLMDObject)
  private
    FOwner:TComponent;
    FVisible: Boolean;
    FPosition: TLMDPosition;
    FHeight: Integer;
    FColor: TColor;
    FPaintMode: TLMDPanelCaptionDrawMode;
    FInActiveColor: TColor;
    FFontSize: Integer;
    FFontActiveColor: TColor;
    FFontInActiveColor: TColor;
    FFontName: TFontName;
    FAlignment: TLMDAlignment;
    FButtons: TLMDPanelCaptionButtons;
    FCaptionGap,
    FButtonGap: Byte;

    function IsCustom:Boolean;
    procedure SetVisible(const Value: Boolean);
    procedure SetPosition(const Value: TLMDPosition);
    procedure SetHeight(const Value: Integer);
    procedure SetColor(const Value: TColor);
    procedure SetPaintMode(const Value: TLMDPanelCaptionDrawMode);
    procedure SetInActiveColor(const Value: TColor);
    procedure SetFontActiveColor(const Value: TColor);
    procedure SetFontInActiveColor(const Value: TColor);
    procedure SetFontName(const Value: TFontName);
    procedure SetFontSize(const Value: Integer);
    procedure SetAlignment(const Value: TLMDAlignment);
    procedure SetButtons(const Value: TLMDPanelCaptionButtons);
    procedure SetCaptionGap(const Value: Byte);
    procedure SetButtonGap(const Value: Byte);
  protected
    procedure Change;override;
    procedure ChangeExt;
  public
    constructor Create;reintroduce;overload;
    constructor Create(aOwner:TComponent);reintroduce;overload;
    destructor Destroy;override;
    procedure Assign(Source: TPersistent);override;
  published
    property ButtonGap:Byte read FButtonGap write SetButtonGap default 1;
    property CaptionGap:Byte read FCaptionGap write SetCaptionGap default 2;
    property Buttons:TLMDPanelCaptionButtons read FButtons write SetButtons default [pcsClose];
    property Alignment:TLMDAlignment read FAlignment write SetAlignment default agCenterLeft;
    property PaintMode:TLMDPanelCaptionDrawMode read FPaintMode write SetPaintMode default pcdWindows;
    property ActiveColor:TColor read FColor write SetColor default clActiveCaption;
    property InActiveColor:TColor read FInActiveColor write SetInActiveColor default clInActiveCaption;
    property FontName:TFontName read FFontName write SetFontName stored IsCustom;
    property FontSize:Integer read FFontSize write SetFontSize default def_CaptionFontSize;
    property FontActiveColor:TColor read FFontActiveColor write SetFontActiveColor default clCaptionText;
    property FontInActiveColor:TColor read FFontInActiveColor write SetFontInActiveColor default clInactiveCaptionText;
    property Height:Integer read FHeight write SetHeight default def_CaptionHeight;
    property Position:TLMDPosition read FPosition write SetPosition default fsTop;
    property Visible:Boolean read FVisible write SetVisible default true;
  end;

implementation
uses
  LMDCaptionPanel;

{ TLMDPanelCaption }
{ *************************** Private *****************************************}
{------------------------------------------------------------------------------}
function TLMDPanelCaptionObject.IsCustom: Boolean;
begin
  result:=FFontName<>'Arial';
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetAlignment(const Value: TLMDAlignment);
begin
  if FAlignment<>Value then
    begin
      FAlignment := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetButtonGap(const Value: Byte);
begin
  if FButtonGap<>Value then
    begin
      FButtonGap := Value;
      ChangeExt;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetButtons(const Value: TLMDPanelCaptionButtons);
begin
  if FButtons<>Value then
    begin
      FButtons := Value;
      ChangeExt;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetCaptionGap(const Value: Byte);
begin
  if Value<>FCaptionGap then
    begin
      FCaptionGap := Value;
      ChangeExt;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetColor(const Value: TColor);
begin
  if Value<>FColor then
    begin
      FColor := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetFontActiveColor(const Value: TColor);
begin
  if Value<>FFontActiveColor then
    begin
      FFontActiveColor := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetFontInActiveColor(const Value: TColor);
begin
  if Value<>FFontInActiveColor then
    begin
      FFontInActiveColor := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetFontName(const Value: TFontName);
begin
  if Value<>FFontName then
    begin
      FFontName := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetFontSize(const Value: Integer);
begin
  if Value<>FFontSize then
    begin
      FFontSize := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetHeight(const Value: Integer);
begin
  if Value<>FHeight then
    begin
      FHeight := Value;
      ChangeExt;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetInActiveColor(const Value: TColor);
begin
  if FInActiveColor<>Value then
    begin
      FInActiveColor := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetPaintMode(const Value: TLMDPanelCaptionDrawMode);
begin
  if FPaintMode<>Value then
    begin
      FPaintMode := Value;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetPosition(const Value: TLMDPosition);
begin
  if Value<>FPosition then
    begin
      FPosition := Value;
      ChangeExt;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.SetVisible(const Value: Boolean);
begin
 if Value<>FVisible then
    begin
      FVisible := Value;
      GetChange(nil);
    end;
end;

{ *************************** Protected ***************************************}
{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.Change;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.ChangeExt;
begin
  if (FOwner<>nil) and TWinCOntrol(FOwner).HandleAllocated and TWinControl(FOwner).Visible then
    TLMDCaptionPanel(FOwner).Change;
end;

{ *************************** Public ******************************************}
{------------------------------------------------------------------------------}
constructor TLMDPanelCaptionObject.Create;
begin
  inherited Create;
  FOwner:=nil;
  FCaptionGap:=2;
  FButtonGap:=1;
  FAlignment:=agCenterLeft;
  FPosition:=fsTop;
  FHeight:=def_CaptionHeight;
  FColor:=clActiveCaption;
  FInactiveColor:=clInActiveCaption;
  FFontActiveColor:=clCaptionText;
  FFontInActiveColor:=clInactiveCaptionText;
  FFontName:='Arial';
  FFontSize:=def_CaptionFontSize;
  FVisible:=True;
  FButtons:=[pcsClose];
end;

{------------------------------------------------------------------------------}
constructor TLMDPanelCaptionObject.Create(aOwner: TComponent);
begin
  Create;
  FOwner:=aOwner;
end;

{------------------------------------------------------------------------------}
destructor TLMDPanelCaptionObject.Destroy;
begin
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDPanelCaptionObject.Assign(Source: TPersistent);
var
  S: TLMDPanelCaptionObject;
begin
  if Source=self then exit;
  if Source is TLMDPanelCaptionObject then
    begin
      S := TLMDPanelCaptionObject(Source);
      FButtonGap:=S.ButtonGap;
      FCaptionGap:=S.CaptionGap;
      FButtons:=S.Buttons;
      FAlignment:=S.Alignment;
      FPaintMode:=S.PaintMode;
      FColor:=S.ActiveColor;
      FInActiveColor:=S.InActiveColor;
      FFontName:=S.FontName;
      FFontSize:=S.FontSize;
      FFontActiveColor:=S.FontActiveColor;
      FFontInActiveColor:=S.FontInActiveColor;
      FHeight:=S.Height;
      FPosition:=S.Position;
      FVisible:=S.Visible;
      Change;
      Exit;
    end;
  inherited Assign(Source);
end;

initialization

end.
