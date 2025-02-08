unit LMDHTMLListBoxExt;
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

LMDHTMLListBox unit (VB)
--------------------

Changes
-------
Release 11.0 (October 2010)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Menus, StdCtrls, ExtCtrls, Controls, ComCtrls, Classes,
  Graphics, Forms, LMDTypes, LMDCustomListBoxExt, LMDBase, LMDClass, LMDListBox,
  LMDHTMLUnit;

type
  {------------------------------ TLMDHTMLListBoxExt --------------------------}
  TLMDHTMLListBoxExt = class(TLMDCustomListBoxExt)
  private
    FOnLinkClick:      TLMDHTMLLinkClickEvent;
    FOnImageNeeded:    TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;
    FIsHTML:           Boolean;

    function  GetLinkColor: TColor;
    function  GetLinkPopupMenu: TPopupMenu;
    function  GetLinkStyle: TFontStyles;
    procedure SetIsHTML(const Value: boolean);
    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkPopupMenu(const Value: TPopupMenu);
    procedure SetLinkStyle(const Value: TFontStyles);
    procedure SetOnImageNeeded(const Value: TLMDHTMLImageNeededEvent);
    procedure SetOnLinkClick(const Value: TLMDHTMLLinkClickEvent);
    procedure SetOnVariableNeeded(const Value: TLMDHTMLVariableNeededEvent);
  protected
    procedure TriggerLinkClickEvent(HRef : TLMDString);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; Image : TPicture);
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString);
    procedure DrawItem(Control:TWinControl;Index:Integer;Rect:TRect;State:TOwnerDrawState); override;
    procedure InternalMouseMove(Shift: TShiftState; X, Y: Integer);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property HorzScrollBar;
    property VertScrollBar;
    property OnLinkClick : TLMDHTMLLinkClickEvent read FOnLinkClick write SetOnLinkClick;
    property OnImageNeeded : TLMDHTMLImageNeededEvent read FOnImageNeeded write SetOnImageNeeded;
    property OnVariableNeeded: TLMDHTMLVariableNeededEvent read FOnVariableNeeded write SetOnVariableNeeded;
    property IsHTML: boolean read FIsHTML write SetIsHTML default true;
    property LinkColor: TColor read GetLinkColor write SetLinkColor default def_LMDLinkColor;
    property LinkPopupMenu: TPopupMenu read GetLinkPopupMenu write SetLinkPopupMenu;
    property LinkStyle: TFontStyles read GetLinkStyle write SetLinkStyle default def_LMDLinkStyle;
  end;

implementation

uses
  Types, SysUtils, CommCtrl, Themes, LMDThemes, LMDStrings, LMDConst,
  LMDUtils, LMDProcs;

{------------------------- TLMDHTMLListBoxExt ------------------------------------}
constructor TLMDHTMLListBoxExt.Create(AOwner: TComponent);
begin
  inherited;
  FIsHTML := true;
  LB.HTMLRender.OnImageNeededEx := TriggerImageNeededEvent;
  LB.HTMLRender.OnVariableNeeded := TriggerVariableNeededEvent;
  LB.HTMLRender.Control := Self;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDHTMLListBoxExt.Destroy;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBoxExt.DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  tmpList:         TStringList;
  tmpItem:         string;
  tmpRect:         TRect;
  i, j:            Integer;
  oldflags, flags: LongInt;
begin
  if [csLoading, csReading, csDestroying] * ComponentState<>[] then
    Exit;
  if (FListBoxStyle <> lbStandard) and Assigned(FOnDrawItem) then
  begin
    FOnDrawItem(Control, Index, Rect, State);
    Exit;
  end;

  with FListBox.Canvas do
  begin
    PrepareDrawItem(Rect, State, Index);
    if Assigned(FOnPrepareDrawItem) then
      FOnPrepareDrawItem(Control, Index, Rect, State);

    oldflags := GetOptionsFlag;
    oldflags := DrawTextBiDiModeFlags(oldflags);
    tmpItem  := FListBox.Items[Index];

    if Length(LMDAnsiTrim(tmpItem)) <> 0 then
    begin
      if FIsHTML then
        with LB.HTMLRender.Data do
        begin
          DefaultStyle   := Font.Style;
          DefaultHeight  := Font.Height;
          DefaultFont    := Font.Name;
          Charset        := Font.Charset;
          LinkColor      := LB.LinkColor;
          LinkStyle      := LB.LinkStyle;
          if odSelected in State then
            DefaultColor := SelectedFontColor
          else
            DefaultColor := GetThemedTextColor;
        end;

      tmpList := TStringList.Create;
      try
        tmpRect := Rect;
        if FHeader.Sections.Count = 0 then
        begin
          flags        := oldflags or Alignments[taLeftJustify]; // 7.00.60
          tmpRect.Left := tmpRect.Left + 2;

          if FIsHTML then
          begin
            if tmpRect.Right > tmpRect.Left then
            begin
              LB.HTMLRender.PrepareText(tmpItem, tmpRect.Right - tmpRect.Left, true);
              LB.HTMLRender.DrawText(FListBox.Canvas, Point(0, 0), tmpRect, clNone);
            end;
          end
          else
            DrawText(FListBox.Canvas.Handle, int_Ref(tmpItem), Length(tmpItem), tmpRect, flags);
        end
        else
        begin
          LMDAnsiParseToStrList(tmpItem, FDelimiter, tmpList);

          for i := 0 to Pred(tmpList.Count) do
          begin
            tmpRect.Right := tmpRect.Left + FHeader.Sections[i].Width - 1;
            if tmpRect.Right > FListBox.ClientWidth then
              tmpRect.Right := FListBox.ClientWidth - 1;

            flags        := oldflags or Alignments[FHeader.Sections[i].Alignment];
            tmpRect.Left := tmpRect.Left + 1;

            if FIsHTML then
            begin
              if tmpRect.Right > tmpRect.Left then
              begin
                LB.HTMLRender.PrepareText(tmpList[i], tmpRect.Right - tmpRect.Left, true);
                LB.HTMLRender.DrawText(FListBox.Canvas, Point(0, 0), tmpRect, clNone);
              end;
            end
            else
              DrawText(FListBox.Canvas.Handle, int_Ref(tmpList[i]), Length(tmpList[i]), tmpRect, flags);

            tmpRect.Left := tmpRect.Right + 1; // +1 (-1 from above:=0)
            if Pred(FHeader.Sections.Count) = i then
              Break;
          end;

          if FGridLines in [glVertical, glBoth] then
          begin
            Pen.Width := 1;
            Pen.Style := FGridVertStyle;
            Pen.Color := FGridVertColor;
            j         := Rect.Left;

            for i := 0 to Pred(FHeader.Sections.Count) do
            begin
              Inc(j, FHeader.Sections[i].Width);
              if Abs(j - ClientWidth) < 2 then
                Continue;  // don't draw last vertical line if it is last column at the left edge
              MoveTo(j - 1, ClientRect.Top);
              LineTo(j - 1, ClientRect.Bottom);
            end;
          end;
        end;

        if FGridLines in [glHorizontal, glBoth] then
        begin
          Pen.Width := 1;
          Pen.Style := FGridHorzStyle;
          Pen.Color := FGridHorzColor;
          MoveTo(Rect.Left, Rect.Bottom - 1);
          LineTo(Rect.Right, Rect.Bottom - 1);
        end;
      finally
        tmpList.free;
      end;
    end;
  end;
end;


function TLMDHTMLListBoxExt.GetLinkColor: TColor;
begin
  Result := LB.LinkColor;
end;

function TLMDHTMLListBoxExt.GetLinkPopupMenu: TPopupMenu;
begin
  result := LB.LinkPopupMenu;
end;

function TLMDHTMLListBoxExt.GetLinkStyle: TFontStyles;
begin
  result := LB.LinkStyle;
end;


procedure TLMDHTMLListBoxExt.InternalMouseMove(Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
end;

procedure TLMDHTMLListBoxExt.SetIsHTML(const Value: boolean);
begin
  FIsHTML := Value;
end;

procedure TLMDHTMLListBoxExt.SetLinkColor(const Value: TColor);
begin
  LB.LinkColor := Value;
end;

procedure TLMDHTMLListBoxExt.SetLinkPopupMenu(const Value: TPopupMenu);
begin
  LB.LinkPopupMenu := Value;
end;

procedure TLMDHTMLListBoxExt.SetLinkStyle(const Value: TFontStyles);
begin
  LB.LinkStyle := Value;
end;

procedure TLMDHTMLListBoxExt.SetOnImageNeeded(
  const Value: TLMDHTMLImageNeededEvent);
begin
  FOnImageNeeded := Value;
  LB.OnImageNeeded := Value;
end;

procedure TLMDHTMLListBoxExt.SetOnLinkClick(
  const Value: TLMDHTMLLinkClickEvent);
begin
  FOnLinkClick := Value;
  LB.OnLinkClick := Value;
end;

procedure TLMDHTMLListBoxExt.SetOnVariableNeeded(
  const Value: TLMDHTMLVariableNeededEvent);
begin
  FOnVariableNeeded := Value;
  LB.OnVariableNeeded := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBoxExt.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBoxExt.TriggerImageNeededEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBoxExt.TriggerLinkClickEvent(HRef: TLMDString);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, HRef);
end;

end.
