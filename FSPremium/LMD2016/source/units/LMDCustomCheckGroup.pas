unit LMDCustomCheckGroup;
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

LMDCustomCheckGroup unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Messages, Windows, LMDCustomButtonGroup;

type
  {------------------------- TLMDCheckGroup -----------------------------------}
  TLMDCustomCheckGroup = class(TLMDCustomButtonGroup)
  private
    FNumGlyphs:Byte;
    procedure SetNumGlyphs(aValue:Byte);
    procedure SetValue(aValue: LongInt);
    procedure SetItemCheck(Index:Integer; aValue:Boolean);
    function GetItemCheck(Index:Integer):Boolean;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure UpdateButtons; override;
    procedure UpdateValue;
    procedure Paint; override;
    procedure SetButtonCount(aValue: Integer); override;
    property Value: LongInt read FResult write SetValue default 0;
  public
    property Checked[Index:Integer]:Boolean read GetItemCheck write SetItemCheck;
    constructor Create(aOwner : TComponent); override;
  published
    property About;
    property Align;
    property Alignment;
    property Bevel;
    property BtnAlignment;
    property Caption;
    property CaptionFont;
    property CaptionFont3D;
    property CaptionOffset;
    property CaptionParentFont;
    property Color;
    property Columns;
    property DragCursor;
    property DragMode;
    property Enabled;
    property FocusStyle;
    property FocusColor;
    property UseFocusColor;
    property FlatGlyphs;
    property Font;
    property Font3D;
    property GlyphImageList;
    property GlyphImageIndex;
    property GlyphListIndex;
    property GlyphNumber:Byte read FNumGlyphs write SetNumGlyphs default 3;
    property GlyphFlat;
    property GlyphSize default 13;
    property GlyphTransparent;
    property GlyphTransparentColor;
    property HelpContextBtn;
    property ImageList;
    property ImageIndex;
    property Items;
    property ItemHeight;
    property ItemOffset;
    property ListIndex;
    // 7.1
    property MultiLine;
    // ---
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowAccelChar;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property UseBitmap;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;

    // V4 enhancements
    property Anchors;
    property AutoSize;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

implementation

uses
  Controls,
  LMDCheckBox, LMDProcs, LMDGraph, LMDCustomCheckBox, LMDCheckGroupButton;

{---------------------------------- private -----------------------------------}
procedure TLMDCustomCheckGroup.SetNumGlyphs(aValue:Byte);
begin
  if aValue<>FNumGlyphs then
    begin
      FNumGlyphs:=aValue;
      GetIMLGlyphChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckGroup.SetValue(aValue:LongInt);
begin
  if IgnoreValue then
    FResult:=0
  else
    FResult:=aValue;
  if not FReading then UpdateValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckGroup.SetItemCheck(Index:Integer; aValue:Boolean);
var
  i:Integer;
begin
  if (index>-1) and (index<FButtons.Count) then
    with TLMDCheckGroupButton(FButtons[index]) do
      if Checked<>aValue then
        begin
          Checked:=aValue;
          FResult:=0;
          if (not IgnoreValue) then
            for i:=0 to Pred(FButtons.Count) do
               if TLMDCustomCheckBox(FButtons[i]).Checked then Inc(FResult, LMDExp(2, i));
        end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomCheckGroup.GetItemCheck(Index:Integer):Boolean;
begin
  result:=false;
  if (index>-1) and (index<FButtons.Count) then
    result:=TLMDCheckGroupButton(FButtons[index]).Checked;
end;

// 7.00.60
{------------------------------------------------------------------------------}
procedure TLMDCustomCheckGroup.WMSetFocus(var Message: TWMSetFocus);
begin
  if (Buttons.Count=0) or ((GetKeyState(VK_SHIFT) and $8000)<>0) then   // if no items are available or Shift+Tab
    begin
      Message.Result:=0;
      if Assigned(Parent) and (Parent.HandleAllocated) then
        SendMessage(Parent.Handle, WM_NEXTDLGCTL, (GetKeyState(VK_SHIFT) and $8000), 0);
    end
  else
    begin
      inherited;
      if TWinControl(Buttons[0]).CanFocus then
        TWinControl(Buttons[0]).SetFocus;
    end;
end;

{--------------------------------- protected ----------------------------------}
procedure TLMDCustomCheckGroup.SetButtonCount(aValue: Integer);
begin
  while FButtons.Count<aValue do
    TLMDCheckGroupButton.CreateExt(Self);
  while FButtons.Count>aValue do
     begin
       if TLMDCheckGroupButton(FButtons.Last).Focused then
         if CanFocus then SetFocus else Parent.SetFocus;
       TLMDCheckGroupButton(FButtons.Last).Free;
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckGroup.UpdateButtons;
var
  i: Integer;
  Btn: TLMDCheckGroupButton;
begin
  SetButtonCount(FItems.Count);
  for i:=0 to Pred(FButtons.Count) do
    begin
      Btn := TLMDCheckGroupButton(FButtons[i]);
      Btn.UpdateNow(true);
      try
        Btn.Caption:=FItems[i];
        //TLMDCheckGroupButton(FButtons[i]).Alignment.Alignment:=agCenterLeft; rep JH, March 2001
        Btn.Alignment.Assign (BtnAlignment);
        Btn.GlyphTransparent:=self.FGlyphTransparent;
        Btn.GlyphTransparentColor:=self.GlyphTransparentColor;
        Btn.GlyphSize:=self.GlyphSize;
        Btn.GlyphFlat:=self.GlyphFlat;
        Btn.ImageList:=GlyphImageList;
        Btn.ParentColor:=True;
        Btn.GlyphNumber:=self.FNumGlyphs;
        Btn.ListIndex:=GlyphListIndex;
        Btn.ImageIndex:=FGlyphIndex;
        Btn.FocusStyle:=self.FocusStyle;
        Btn.FocusColor:=self.FocusColor;
        Btn.UseFocusColor:=self.UseFocusColor;
        Btn.Font3D.Assign(self.Font3D);
        Btn.UseBitmap:=self.UseBitmap;
        Btn.MultiLine:=self.MultiLine;
        Btn.Flat:=FlatGlyphs;
        // 8.05
        Btn.ParentBackground:=self.ParentBackground;
        // ---
        Btn.ThemeMode := self.ThemeMode;
        // 6.12.10
        Btn.TabStop:=self.TabStop;
        case FID of
          ciDefault:Btn.HelpContext:=0;
          ciSameAsParent:Btn.HelpContext:=self.HelpContext;
          ciAutoNumbered:Btn.HelpContext:=self.HelpContext+i+1;
        end;
      finally
        Btn.UpdateNow(false);
      end;
    end;
    UpdateValue;
  ArrangeButtons;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckGroup.UpdateValue;
var
  i:Integer;
  tmp,v:LongInt;
  Btn: TLMDCheckGroupButton;
begin
   FUpdating:=True;
   if csPaintCopy in ControlState then
     v:=GetFieldValue
   else
     v:=FResult;
   if v<0 then v:=0;

   if (not IgnoreValue) then
     for i:=0 to Pred(FButtons.Count) do
       begin
         Btn := TLMDCheckGroupButton(FButtons[i]);
         Btn.UpdateNow(true);
         tmp:=LMDExp(2, i);
         Btn.Checked:=(tmp and v = tmp);
         Btn.UpdateNow(false);
       end;
   FUpdating:=False;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomCheckGroup.Paint;
begin
  inherited Paint;
end;

{ ------------------------------- public ------------------------------------- }
constructor TLMDCustomCheckGroup.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);

  FGlyphSize:=13;
  FGlyphTransparent:=False;
  FNumGlyphs:=3;
end;

end.

