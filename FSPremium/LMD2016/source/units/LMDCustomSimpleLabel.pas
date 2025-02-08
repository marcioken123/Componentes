unit LMDCustomSimpleLabel;
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

LMDCustomSimpleLabel unit (RM)
------------------------------
Base class for SimpleLabel controls which replace URL and starter labels.

ToDo
----
* Unicode support (hint, jump etc.)

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics, Classes, Controls, Actnlist, Menus, ClipBrd, Messages, Forms,
  LMDGraph, LMD3DCaption, LMDBaseLabel;

type
  TLMDJumpModes = (jmInternet, jmApplication, jmNone, jmCustom);

  {-------------------TLMDCustomSimpleLabel------------------------------------}
  TLMDCustomSimpleLabel = class(TLMDBaseLabel)
  private
    FFont3D       : TLMD3DCaption;
    FJump         : String;
    FActiveColor,
    FInActiveColor: TColor;
    FUseAsJump,
    FShowURLInHint,
    FShowURLMenu,
    FJumpUnderline: Boolean;
    FJumpMode     : TLMDJumpModes;
    FCounter      : LongInt;
    function GetCounter : Longint;
    procedure SetColor(Index:Integer; aValue:TColor);
    procedure SetFont3D(aValue:TLMD3DCaption);
    procedure SetJumpUnderLine(aValue:Boolean);
    procedure ReadBoolean(Reader:TReader);
    procedure SetJumpMode(aValue : TLMDJumpModes);
    // 8.0
    procedure OnOpen(Sender : TObject);
    procedure OnCopy(Sender : TObject);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    // ----
  protected
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean);override;
    procedure DefineProperties(Filer: TFiler);override;
    // 8.0
    function GetPopupMenu : TPopupMenu; override;
    // ---
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    Procedure Paint;Override;

    property Caption;
    property ActiveColor:TColor index 0 read FActiveColor write SetColor default clPurple;
    property Jump:String read FJump write FJump;
    property InActiveColor:TColor index 1 read FInActiveColor write SetColor default clBlue;
    property JumpUnderline:Boolean read FJumpUnderLine write SetJumpUnderLine default True;
    property JumpMode : TLMDJumpModes read FJumpMode write SetJumpMode default jmNone;
    // 8.0
    property ShowURLInHint : Boolean read FShowURLInHint write FShowURLInHint default false;
    property ShowURLMenu : Boolean read FShowURLMenu write FShowURLMenu default false;
    // ---
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Click; override;
    procedure CorrectBounds;override;
    procedure ResetCounter;
    // 5.0
    procedure Execute;
    // 8.0
    procedure CopyURL;
    // ----
    property Counter:LongInt read GetCounter;
  published
    property Alignment;
    property AutoSize;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property Font3D:TLMD3DCaption read FFont3D write SetFont3d;
    property MultiLine;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Twinkle;
    property TwinkleColor;
    property TwinkleVisible;
    property TwinkleInVisible;

    // 7.0
    property UseGlobalTimer;
    // ---
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    {3.0}
    property OnMouseEnter;
    property OnMouseExit;
    {---}
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;

    {4.0}
    //properties
    property Anchors;
    property BiDiMode;
    property DragKind;
    property Constraints;
    property ParentBiDiMode;
    //events
    property OnEndDock;
    property OnStartDock;

    property OnContextPopup;
    {$IFDEF LMDCOMP9}
    property OnMouseActivate;
    {$ENDIF}

  end;

implementation

uses
  Windows, ShellApi, SysUtils,
  LMDConst, LMDProcs, LMDStrings, LMDUtils, LMDGraphUtils;

{********************* Class TLMDCustomSimpleLabel ****************************}
{----------------------- Private ----------------------------------------------}
procedure TLMDCustomSimpleLabel.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.SetColor(Index:Integer; aValue:TColor);
begin
  case Index of
    0: if aValue=FActiveColor then exit else FActiveColor:=aValue;
    1: if aValue=FInActiveColor then
         exit
       else
         begin
           FInActiveColor:=aValue;
           if FUseAsJump then Font.Color:=FInActiveColor;
         end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.SetJumpUnderLine(aValue:Boolean);
begin
  if aValue<>FJumpUnderLine then
    begin
      FJumpUnderLine:=aValue;
      if FUseAsJump then Font.Style:=Font.Style+[fsUnderline];
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.SetJumpMode(aValue:TLMDJumpModes);
begin
  if aValue<>FJumpMode then
    begin
      FJumpMode:=aValue;

      if (csLoading in ComponentState) and not (FJumpMode in [jmInternet, jmApplication, jmCustom]) then exit;
      if {FJumpMode = jmInternet} (FJumpMode In [jmInternet, jmApplication, jmCustom]) then
        begin
          ResetCounter;
          if not (csDesigning in ComponentState) then Cursor:=crHandPoint;
        end
      else
        begin
          if not (csDesigning in ComponentState) then Cursor:=crDefault;
          Font.Color:=clBlack;
          if FJumpUnderLine then Font.Style:=Font.Style-[fsUnderline];
        end;

    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomSimpleLabel.GetCounter : Longint;
begin
  result := FCounter;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.OnOpen(Sender : TObject);
var
  tmp:TPopupMenu;
begin
  tmp:=GetPopupMenu;
  Click;
  FreeAndNil(tmp);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.OnCopy(Sender : TObject);
var
  tmp:TPopupMenu;
begin
  tmp:=GetPopupMenu;
  CopyURL;
  FreeAndNil(tmp);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.ReadBoolean(Reader:TReader);
begin
  FUseAsJump:=Reader.ReadBoolean;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.CMHintShow(var Message: TCMHintShow);
var
  HintInfo: PHintInfo;
  buffer: String;
begin
  inherited;
  if (Hint <> '') or (not ShowURLInHint) or (FJumpMode <> jmInternet) then exit;
  HintInfo := Message.HintInfo;
  if HintInfo.HintControl = Self then
    begin
      if LMDAnsiTrim(FJump) <> '' then
        buffer:=FJump
      else
        buffer:=GetLabelText;
      HintInfo.HintStr := buffer;
    end;
end;

{----------------------- Protected --------------------------------------------}
procedure TLMDCustomSimpleLabel.ActionChange(Sender: TObject; CheckDefaults: Boolean);
begin
  if FJumpMode=jmCustom then
    inherited ActionChange(Sender, CheckDefaults);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.Loaded;
begin
  inherited Loaded;
  if FUseAsJump then FJumpMode := jmInternet;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties( Filer ) ;
  Filer.DefineProperty( 'UseAsJump', ReadBoolean, nil, false );
end;

{------------------------------------------------------------------------------}
function TLMDCustomSimpleLabel.GetPopupMenu: TPopupMenu;

  procedure AddMI (const Caption: string; OnClick: TNotifyEvent);
  var
    Item : TMenuItem;
  begin
    Item := TMenuItem.Create(self);
    Item.Caption := Caption;
    Item.OnClick := OnClick;
    Result.Items.Add(Item);
  end;

begin
  Result := inherited GetPopupMenu;
  if (not FShowURLMenu) or (FJumpMode<>jmInternet) or Assigned(Result) or
     (csDesigning in ComponentState) then exit;
  Result := TPopupMenu.Create(self);
  AddMI (IDS_OPENURL, OnOpen);
  AddMI (IDS_COPYURL, OnCopy);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.CorrectBounds;
var
  aRect:TRect;
  flags:LongInt;
  lAuto: boolean;
begin
  // 7.0.61 Align Test
  lAuto := (FControl = nil) and AutoSize or (FControl <> nil);
  if (Align=alNone) and lAuto and not IsUpdating and ([csLoading, csReading]*ComponentState=[]) then //VB June 2009
    begin
      aRect:=GetClientRect;
      flags:=GetOptionsFlag;
      flags:=flags or DrawTextBiDiModeFlags(flags);
      if not Multiline then              //Added VB Oct 2009
        flags := flags or DT_SINGLELINE;

      LMDDrawTextCalcExt(Canvas, GetLabelText, FFont3D, aRect, Font, MultiLine,
                         ShowAccelChar, 0, flags);
      SetBounds(Left, Top, aRect.Right, aRect.Bottom);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.Click;
  function  i_ShellExecute(const URL: string): integer;
  begin

  Result := ShellExecute(Application.Handle, nil,
                       int_Ref(URL), nil, nil, SW_NORMAL );

  end;

var
  buffer:string;

begin
   Case FJumpMode Of
     jmInternet : begin
                    if LMDAnsiTrim(FJump)<>'' then
                      buffer:=FJump
                    else
                      buffer:=GetLabelText;
                    if not LMDFireURL(buffer) then
                      begin
                        FJumpMode := jmNone;
                        Enabled:=False;
                      end;
                  end;
     jmApplication: begin
                      if LMDAnsiTrim(FJump)<>'' then
                        buffer:=FJump
                      else
                        buffer:=GetLabelText;
                      i_ShellExecute(buffer);
                    end;
    else
      inherited Click;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if (FJumpMode In [jmInternet, jmApplication, jmCustom]) and (Button=mbLeft) then
     begin
       INC(FCounter);
       Font.Color:=FActiveColor;
     end;
   inherited MouseDown(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   if FUseAsJump and (Button=mbLeft) then Font.Color:=FInActiveColor;
   inherited MouseUp(Button, Shift, X, Y);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.Paint;
var
  aRect: TRect;
  flags: Word;
  text:  string;
begin
  if Painting or (csLoading in ComponentState) then
    Exit;

  if GetEmpty then
  begin
    if csDesigning in ComponentState then DrawDashedFrame;
    Exit;
  end;

  text:=GetLabelText;

  Painting:=True;
  try
    aRect:=ClientRect;

    {check, if TransparentFlag is set - if no, fill the client-rect...}
    if not Transparent then
      FillControl;

    flags:=0;
    flags:=DrawTextBiDiModeFlags(flags);

    if not MultiLine then
      flags:=flags or DT_SINGLELINE
    else
      if not (Alignment in [agTopLeft, agTopCenter, agTopRight]) then
        aRect:=LMDAlignTextRect(Alignment, text, FFont3D, aRect, Font,
                                MultiLine, ShowAccelChar, flags);

    {Flags for DrawText}
    flags:=flags or DT_EXPANDTABS or DT_WORDBREAK or TLMDAlignFlags[Alignment] or GetOptionsFlag;

    if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;

    Canvas.Brush.Color := Color;
    Canvas.Font.Color  := GetThemedTextColor; // Was Font.Color;

    if FTwinkleFlag then
      LMDDrawTextExt(Canvas, text, FFont3D, aRect, flags,
                    [TLMDDrawTextStyle(Enabled)], nil)
    else
      if TwinkleColor <> clNone then
        begin
          Canvas.Font.Color := TwinkleColor;
          LMDDrawTextExt(Canvas, text, FFont3D, aRect, flags,
                         [TLMDDrawTextStyle(Enabled)], nil)
        end;
  finally
    Painting:=False;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDCustomSimpleLabel.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FFont3D:=TLMD3DCaption.Create;
  FFont3D.OnChange:=FontChange;
  FInActiveColor:=clBlue;
  FActiveColor:=clPurple;
  FJumpUnderLine:=True;
  FJumpMode := jmNone;
  FUseAsJump:=False;
  FCounter := 0;
end;

{------------------------------------------------------------------------------}
Destructor TLMDCustomSimpleLabel.Destroy;
begin
  FFont3D.OnChange:=nil;
  FFont3D.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.CopyURL;
var
  CB : TClipboard;
begin
  CB := TClipboard.Create;
  try
    CB.Open;
    if LMDAnsiTrim(FJump)<>'' then
      CB.AsText := FJump
    else
      CB.AsText := GetLabelText;
    CB.Close;
  finally
    CB.Free;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.Execute;
begin
  if (FJumpMode In [jmInternet, jmApplication, jmCustom]) then
    begin
      INC(FCounter);
      Font.Color:=FActiveColor;
     end;
  Click;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomSimpleLabel.ResetCounter;
begin
  FCounter := 0;
  Font.Color:=FInActiveColor;
  if FJumpUnderLine then Font.Style:=Font.Style+[fsUnderline];
end;

end.
