unit ElURLLabel;
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

ElURLLabel unit
---------------


Changes
-------
Release 6.0 (February 2007)
 - Initial Release

###############################################################################}

interface

uses
  SysUtils, Classes, ElVCLUtils, Windows, Messages, Controls, Graphics, ExtCtrls,
  Forms, Types,
  {$ifdef LMD_UNICODE}
  LMDUtils,
  {$endif}
  ElCLabel, ShellAPI, Menus;

type
  TElURLLabel = class(TCustomElLabel)
  private
    FShowURLInHint : Boolean;
    FVisited : Boolean;
    FVisitedColor : TColor;
//    FPopupMenu : TPopupMenu;
    FURI : string;
    FHyperLinkColour, FOldColour : TColor; //mc
    FHyperLinkStyle, FOldStyle : TFontStyles; //mc

    {$ifdef LMD_UNICODE}
    {$endif}
    procedure SetHyperLinkStyle(const Value : TFontStyles); //mc
    procedure SetHyperLinkColour(const Value : TColor); //mc
    procedure SetVisitedColor(newValue : TColor);
    procedure SetVisited(newValue : boolean);
    // vcl message handlers                                             //mc
    procedure CMMouseEnter(var Msg : TMessage); message cm_MouseEnter; //mc
    procedure CMMouseLeave(var Msg : TMessage); message cm_MouseLeave; //mc
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
  protected
    { Protected declarations }
    function GetPopupMenu : TPopupMenu; override;
    procedure OnOpen(Sender : TObject);
    procedure OnCopy(Sender : TObject);

    {$ifdef LMD_UNICODE}
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    {$endif}

  public
    { Public declarations }
    constructor Create(AOwner : TComponent); override;
    procedure Click; override;
    procedure GotoURL;
    procedure CopyURL;
    //destructor Destroy; override;
  published
    property URL : string read FURI write FURI;
    property VisitedColor : TColor read FVisitedColor write SetVisitedColor default clBlue;
    property Visited : boolean read FVisited write SetVisited default False;
    property HyperLinkColor : TColor read FHyperLinkColour write SetHyperLinkColour default clBlue; //mc
    property HyperLinkStyle : TFontStyles read FHyperLinkStyle write SetHyperLinkStyle; //mc
    property ShowURLInHint : Boolean read FShowURLInHint write FShowURLInHint default True;

    property Align;
    property Alignment;

    property Anchors;
    property Action;
    property Constraints;
    property DockOrientation;
    property Floating;
    property DragKind;

    property AutoSize;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ShowHint;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property Transparent;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

implementation

uses
  ClipBrd, LMDProcs;

{-----------}

constructor TElURLLabel.Create(AOwner : TComponent);
begin
  inherited;
  Font.Style := Font.Style + [fsUnderline];
  Font.Color := clBlue;
  VisitedColor := Font.Color;
  Cursor := crHandPoint;
  AutoSize := true;
  FShowURLInHint := True;
  HyperLinkStyle := [fsUnderline];
  HyperlinkColor := clBlue;
end;

procedure TElURLLabel.Click;
begin
  inherited;
  if FURI <> '' then
    GotoURL;
end;

procedure TElURLLabel.GotoURL;
var
  Param : String;
begin
  if Enabled then
  begin
    Param := FURI;
    LMDFireURL(Param);
    FVisited := true;
    Font.Color := VisitedColor;
  end;
end;

procedure TElURLLabel.SetVisited(newValue : boolean);
begin
  if (FVisited <> newValue) then
  begin
    FVisited := newValue;
    Repaint;
  end; {if}
end;

procedure TElURLLabel.SetVisitedColor(newValue : TColor);
begin
  if (FVisitedColor <> newValue) then
  begin
    FVisitedColor := newValue;
    if FVisited then Font.Color := newValue;
    Repaint;
  end; {if}
end; {SetVisitedColor}
(*
destructor TElURLLabel.Destroy;
begin
  if Assigned(FPopupMenu) then FPopupMenu.Free;
  inherited;
end;
*)
procedure TElURLLabel.CopyURL;
var
  CB : TClipboard;
begin
  CB := TClipboard.Create;
  CB.Open;
  CB.AsText := URL;
  CB.Close;
  CB.Free;
end;

procedure TElURLLabel.OnOpen(Sender : TObject);
begin
  GotoURL;
end;

procedure TElURLLabel.OnCopy(Sender : TObject);
begin
  CopyURL;
end;

function TElURLLabel.GetPopupMenu : TPopupMenu;
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
  if not Assigned(Result) and not (csDesigning in ComponentState) then
  begin
    Result := TPopupMenu.Create(self);
    AddMI ('&Jump to URL', OnOpen);
    AddMI ('&Copy URL', OnCopy);
  end;
end; {GetPopupMenu}

procedure TElURLLabel.CMMouseEnter(var Msg : TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    fOldStyle := font.Style;
    fOldColour := font.color;
    font.Style := FHyperLinkStyle;
    font.color := FHyperLinkColour;
  end;
end;

procedure TElURLLabel.CMMouseLeave(var Msg : TMessage);
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    font.Style := fOldStyle;
    font.color := fOldColour;
  end;
end;

procedure TElURLLabel.SetHyperLinkStyle(const Value : TFontStyles);
begin
  FHyperLinkStyle := Value;
end;

procedure TElURLLabel.SetHyperLinkColour(const Value : TColor);
begin
  FHyperLinkColour := Value;
end;

procedure TElURLLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if Enabled and ShowAccelChar and IsAccel(Message.CharCode, Caption) then
  begin
    if (FocusControl <> nil) then
      with FocusControl do
        if CanFocus then
        begin
          SetFocus;
          Message.Result := 1;
        end
    else
      Click;
  end;
end;

{$ifdef LMD_UNICODE}
procedure TElURLLabel.CMHintShow(var Message: TCMHintShow);
var
  T: WideChar;
  HintInfo : PHintInfo;

  l : integer;
  S : String;
  WS: WideString;
begin

  inherited;
  HintInfo := Message.HintInfo;

  WS := FHint;

  if HintInfo.HintControl = Self then
  begin
    if (Hint = '') and ShowURLInHint then
      WS := Self.URL;
  end;

  if WS = '' then
  begin
    HintInfo.HintStr := '';
    exit;
  end;

  if HintInfo.HintStr = GetShortHint(inherited Hint) then
  begin
    WS := LMDWideGetShortHint(WS);
    S := WS;
  end
  else
    S := WS;

  l := Length(S) + 1 + Length(WS) * 2;
  SetLength(HintInfo.HintStr, l + 4);
  Move(PChar(S)^, HintInfo.HintStr[1], Length(S) + 1);

  Move(WS[1], HintInfo.HintStr[Length(S) + 2], Length(WS) * 2);
  T := #0;
  Move(T, HintInfo.HintStr[l + 1], sizeof(T));
  T := #$FFFE;
  Move(T, HintInfo.HintStr[l + 3], sizeof(T));
end;
{$ENDIF}

end.
