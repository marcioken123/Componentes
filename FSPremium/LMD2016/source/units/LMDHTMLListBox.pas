unit LMDHTMLListBox;
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
------------------------

Changes
-------

Release 12.0 (October 2011)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Menus, StdCtrls, ExtCtrls, Controls, ComCtrls, Classes,
  Graphics, Forms, LMDTypes, LMDBase, LMDClass, LMDListBox, LMDHTMLExtListBox,
  LMDHTMLHeaderControl, LMDHTMLUnit;

type
  {----------------------------- TLMDHTMLListBox ------------------------------}
  TLMDHTMLListBox = class(TLMDListBox)
  private
    FIsHTML: Boolean;
    FOnLinkClick: TLMDHTMLLinkClickEvent;
    FOnImageNeeded: TLMDHTMLImageNeededEvent;
    FOnVariableNeeded: TLMDHTMLVariableNeededEvent;

    function  GetListBox: TLMDHTMLExtListBox;
    procedure SetIsHTML(const Value: boolean);
    function  GetLinkColor: TColor;
    function  GetLinkPopupMenu: TPopupMenu;
    function  GetLinkStyle: TFontStyles;
    procedure SetLinkColor(const Value: TColor);
    procedure SetLinkPopupMenu(const Value: TPopupMenu);
    procedure SetLinkStyle(const Value: TFontStyles);
    function  GetHeader: TLMDHTMLHeaderControl;
    procedure SetOnImageNeeded(const Value: TLMDHTMLImageNeededEvent);
    procedure SetOnLinkClick(const Value: TLMDHTMLLinkClickEvent);
    procedure SetOnVariableNeeded(const Value: TLMDHTMLVariableNeededEvent);
  protected
    procedure CreateHeader; override;
    procedure CreateLB; override;
    procedure TriggerLinkClickEvent(HRef : TLMDString);
    procedure TriggerImageNeededEvent(Sender : TObject; Src : TLMDString; Image : TPicture);
    procedure TriggerVariableNeededEvent(Sender : TObject; const aVar : TLMDString; var aVal: TLMDString);
    procedure DrawItem(Control:TWinControl;Index:Integer;Rect:TRect;State:TOwnerDrawState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property ListBox: TLMDHTMLExtListBox read GetListBox;
    property Header: TLMDHTMLHeaderControl read GetHeader;
  published
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

type
  TLMDHTMLHeaderControlH = class(TLMDHTMLHeaderControl);

type
  TLMDHTMLExtListBoxH = class(TLMDHTMLExtListBox)
  protected
    FSectionRect: TRect;
    FActiveSectionIndex: integer;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure ModifyItemRect(var ItemRect: TRect); override;
    procedure ModifyItemText(var ItemText: string); override;
  end;

  procedure TLMDHTMLExtListBoxH.ModifyItemRect(var ItemRect: TRect);
  begin
    ItemRect.Left := FSectionRect.Left;
    ItemRect.Right := FSectionRect.Right;
  end;

  procedure TLMDHTMLExtListBoxH.ModifyItemText(var ItemText: string);
  var
    tmpList: TStringList;
  begin
    tmpList:=TStringList.Create;
    try
      LMDAnsiParseToStrList(ItemText, TLMDHTMLListBox(Parent).Delimiter, tmpList);
      if (FActiveSectionIndex>=0) and (FActiveSectionIndex < tmpList.Count) then
        ItemText := tmpList[FActiveSectionIndex]
      else
      begin
        if FActiveSectionIndex > 0 then
          ItemText := '';
      end;
    finally
      tmpList.Free;
    end;
  end;

  procedure TLMDHTMLExtListBoxH.MouseMove(Shift: TShiftState; X, Y: Integer);
  begin
    if Parent.HandleAllocated then
    begin
      with TLMDHTMLHeaderControlH(TLMDHTMLListBox(Parent).Header) do
      begin
       CheckActiveSection(X, 1, true); //todo: use FExtendedSectionTrack here
       FActiveSectionIndex := ActiveSection;
       if ActiveSection >=0 then
         FSectionRect := GetItemRect(ActiveSection)
       else
         FSectionRect := Rect(0, 0, 0, 0);
      end;
    end;
    inherited;
  end;

{------------------------- TLMDHTMLListBox ------------------------------------}
constructor TLMDHTMLListBox.Create(AOwner: TComponent);
begin
  inherited;
  FIsHTML := true;
  //FExtendedSectionTrack := false;
  ListBox.HTMLRender.OnImageNeededEx := TriggerImageNeededEvent;
  ListBox.HTMLRender.OnVariableNeeded := TriggerVariableNeededEvent;
  ListBox.HTMLRender.Control := Self;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.SetIsHTML(const Value: boolean);
begin
  FIsHTML := Value;
end;

procedure TLMDHTMLListBox.SetLinkColor(const Value: TColor);
begin
  ListBox.LinkColor := Value;
end;

procedure TLMDHTMLListBox.SetLinkPopupMenu(const Value: TPopupMenu);
begin
  ListBox.LinkPopupMenu := Value;
end;

procedure TLMDHTMLListBox.SetLinkStyle(const Value: TFontStyles);
begin
  ListBox.LinkStyle := Value;
end;

procedure TLMDHTMLListBox.SetOnImageNeeded(
  const Value: TLMDHTMLImageNeededEvent);
begin
  FOnImageNeeded := Value;
  ListBox.OnImageNeeded := Value;
end;

procedure TLMDHTMLListBox.SetOnLinkClick(const Value: TLMDHTMLLinkClickEvent);
begin
  FOnLinkClick := Value;
  ListBox.OnLinkClick := Value;
end;

procedure TLMDHTMLListBox.SetOnVariableNeeded(
  const Value: TLMDHTMLVariableNeededEvent);
begin
  FOnVariableNeeded := Value;
  ListBox.OnVariableNeeded := Value;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.CreateHeader;
begin
  FHeader := TLMDHTMLHeaderControl.Create(Self);
  with FHeader do
  begin
    Parent:=Self;
    OnSectionResize:=HeaderSized;
    TabStop:=False;
    FHeader.Align:=alTop;
    FHeader.Height:=17;  // 7.01
    ThemeGlobalMode := false;
    ThemeMode := ttmPlatform;
  end;
  FHeader.Sections.Add;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.CreateLB;
begin
  FListBox:=TLMDHTMLExtListBoxH.Create(Self);
  with FListBox do
  begin
    ParentCtl3D:=False;
    Ctl3D:=False;
    Borderstyle:=bsNone;
    Parent:=Self;
    Color:=clWindow;
    OnDrawItem:=DrawItem;
    Align:=alClient;
    Multiline := true;
  end;
end;

destructor TLMDHTMLListBox.Destroy;
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  tmpList:TStringList;
  tmpItem:String;
  tmpRect:TRect;
  i,j:Integer;
  oldflags, flags:LongInt;
  lAdjustFromColor: TColor;
begin
  if [csLoading, csReading, csDestroying]*ComponentState<>[] then
    Exit;
  if (FListBoxStyle<>lbStandard) and Assigned(FOnDrawItem) then
  begin
    FOnDrawItem(Control, Index, Rect, State);
    Exit;
  end;

  lAdjustFromColor := clNone;

  with FListBox.Canvas do
  begin
    PrepareDrawItem(Rect, State, Index);
    if Assigned(FOnPrepareDrawItem) then
      FOnPrepareDrawItem(Control, Index, Rect, State);

    oldflags:=GetOptionsFlag;
    oldflags:=DrawTextBiDiModeFlags(oldflags);
    tmpItem:=FListBox.Items[Index];

    if Length(LMDAnsiTrim(tmpItem))<>0 then
    begin
      if FIsHTML then
        with ListBox.HTMLRender.Data do
        begin
          DefaultStyle := Font.Style;
          DefaultHeight := Font.Height;
          DefaultFont := Font.Name;
          Charset := Font.Charset;
          LinkColor := ListBox.LinkColor;
          LinkStyle := ListBox.LinkStyle;

          if odSelected in State then
            DefaultColor := SelectedFontColor
          else
            DefaultColor := GetThemedTextColor;
        end;

      tmpList:=TStringList.Create;
      try
        tmpRect:=Rect;

        if FHeader.Sections.Count=0 then
        begin
          flags:=oldflags or Alignments[taLeftJustify]; // 7.00.60
          tmpRect.Left:=tmpRect.Left+2;
          if IsHTML then
          begin
            if tmpRect.Right > tmpRect.Left then
            begin
              ListBox.HTMLRender.PrepareText(tmpItem, tmpRect.Right - tmpRect.Left, true);
              ListBox.HTMLRender.DrawText(FListBox.Canvas, Point(0, 0), tmpRect, lAdjustFromColor);
            end;
          end
          else
            DrawText(FListBox.Canvas.Handle, int_Ref(tmpItem), Length(tmpItem), tmpRect, flags);
        end
        else
        begin
          LMDAnsiParseToStrList(tmpItem, FDelimiter, tmpList);

          for i:=0 to Pred(tmpList.Count) do
          begin
            tmpRect.Right:=tmpRect.Left+FHeader.Sections[i].Width-1;
            if tmpRect.Right>FListBox.ClientWidth then tmpRect.Right:=FListBox.ClientWidth-1;

            if IsHTML then
            begin
              if tmpRect.Right > tmpRect.Left then
              begin
                ListBox.HTMLRender.PrepareText(tmpList[i], tmpRect.Right - tmpRect.Left, true);
                ListBox.HTMLRender.DrawText(FListBox.Canvas, Point(0, 0), tmpRect, lAdjustFromColor);
              end;
            end
            else
            begin
              flags:=oldflags or Alignments[FHeader.Sections[i].Alignment];
              tmpRect.Left:=tmpRect.Left+1;
              // 6.0 Support of Alignment
              // Extended Drawing Support
              DrawText(FListBox.Canvas.Handle, int_Ref(tmpList[i]), Length(tmpList[i]), tmpRect, flags);
            end;
            tmpRect.Left:=tmpRect.Right+1; // +1 (-1 from above:=0)
            if Pred(FHeader.Sections.Count)=i then break;
          end;

          if FGridLines in [glVertical, glBoth] then
          begin
            Pen.Width:=1;
            Pen.Style:=FGridVertStyle;
            Pen.Color:=FGridVertColor;
            j:=Rect.Left;
            for i:=0 to Pred(FHeader.Sections.Count) do
              begin
                Inc(j, FHeader.Sections[i].Width);
                if Abs(j-ClientWidth)<2 then Continue;  // don't draw last vertical line if it is last column at the left edge
                MoveTo(j-1, ClientRect.Top);
                LineTo(j-1, ClientRect.Bottom);
              end;
          end;
        end;
        if FGridLines in [glHorizontal, glBoth] then
        begin
          Pen.Width:=1;
          Pen.Style:=FGridHorzStyle;
          Pen.Color:=FGridHorzColor;
          MoveTo(Rect.Left, Rect.Bottom-1);
          LineTo(Rect.Right, Rect.Bottom-1);
        end;
      finally
        tmpList.free;
      end;
    end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLListBox.GetHeader: TLMDHTMLHeaderControl;
begin
  result := TLMDHTMLHeaderControl(FHeader);
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLListBox.GetLinkColor: TColor;
begin
  result := ListBox.LinkColor;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLListBox.GetLinkPopupMenu: TPopupMenu;
begin
  result := ListBox.LinkPopupMenu;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLListBox.GetLinkStyle: TFontStyles;
begin
  result := ListBox.LinkStyle;
end;

{ ---------------------------------------------------------------------------- }
function TLMDHTMLListBox.GetListBox: TLMDHTMLExtListBox;
begin
  result := TLMDHTMLExtListBox(FListBox);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.TriggerVariableNeededEvent(Sender: TObject;
  const aVar: TLMDString; var aVal: TLMDString);
begin
  if Assigned(FOnVariableNeeded) then
    FOnVariableNeeded(Self, aVar, aVal);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.TriggerImageNeededEvent(Sender: TObject;
  Src: TLMDString; Image: TPicture);
begin
  if (Assigned(FOnImageNeeded)) then
    FOnImageNeeded(Self, Src, Image);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHTMLListBox.TriggerLinkClickEvent(HRef: TLMDString);
begin
  if Assigned(FOnLinkClick) then
    FOnLinkClick(Self, HRef);
end;

end.
