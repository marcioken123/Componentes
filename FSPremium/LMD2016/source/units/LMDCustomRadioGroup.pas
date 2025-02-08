unit LMDCustomRadioGroup;
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

LMDCustomRadioGroup unit (RM)
----------------------------

Changes
-------
Release 8.0 (November 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Controls, Messages,
  LMDCustomButtonGroup;

type
  {------------------------- TLMDRadioGroup ----------------------------------}
  TLMDCustomRadioGroup = class(TLMDCustomButtonGroup)
  private
    procedure SetItemIndex(aValue: LongInt);
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure WMSetFocus (var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure SetButtonCount(aValue: Integer); override;
    procedure UpdateButtons; override;
  public
    constructor Create(AOwner: TComponent); override;
    property ItemIndex: LongInt read FResult write SetItemIndex default -1;
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
    property FlatGlyphs;    
    property FocusStyle;
    property FocusColor;
    property UseFocusColor;
    property Font;
    property Font3D;
    property GlyphImageList;
    property GlyphImageIndex;
    property GlyphListIndex;
    property GlyphFlat;
    property GlyphSize default 13;
    property GlyphTransparent default True;
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
  Forms, Windows,
  LMDGraph, LMDRadioGroupButton, LMDProcs;

{---------------------------------- private -----------------------------------}
procedure TLMDCustomRadioGroup.SetItemIndex(aValue:LongInt);
var
  tmp:Boolean;
begin
  if FReading then
    FResult:=aValue
  else
    begin
      tmp:=false;
      if aValue<-1 then aValue:=-1;
      if aValue>=FButtons.Count then aValue:=FButtons.Count-1;
      if FResult<>aValue then
        begin
          if FResult>=0 then
            begin
              tmp:=TLMDRadioGroupButton(FButtons[FResult]).Focused;
              TLMDRadioGroupButton(FButtons[FResult]).Checked:=False;
            end;
          FResult:=aValue;
          if FResult>=0 then
            begin
              TLMDRadioGroupButton(FButtons[FResult]).Checked:=True;
              //7.04
              if tmp and TLMDRadioGroupButton(Buttons[FResult]).CanFocus then
               TLMDRadioGroupButton(Buttons[FResult]).SetFocus;
              //---- 
            end;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRadioGroup.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and CanFocus then
      begin
        result:=1;
        if ItemIndex = -1 then
          SelectFirst
        else
          if TLMDRadioGroupButton(Buttons[ItemIndex]).CanFocus then
            TLMDRadioGroupButton(Buttons[ItemIndex]).SetFocus;
      end
    else
      inherited;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomRadioGroup.WMSetFocus (var Message: TWMSetFocus);

   procedure NextControl;
   begin
     if Assigned(Parent) and (Parent.HandleAllocated) then
       SendMessage(Parent.Handle, WM_NEXTDLGCTL, (GetKeyState(VK_SHIFT) and $8000), 0)
   end;

begin
   with Message do
    if (CanFocus and (ItemIndex<>-1)) then
      begin
        result:=1;
        if FocusedWnd=TWinControl(Buttons[ItemIndex]).Handle then
          NextControl
        else
          if TWinControl(Buttons[ItemIndex]).CanFocus then
            TWinControl(Buttons[ItemIndex]).SetFocus;
        {if FocusedWnd=TLMDRadioGroupButton(Buttons[ItemIndex]).Handle then
          NextControl
        else
          if TLMDRadioGroupButton(Buttons[ItemIndex]).CanFocus then
            TLMDRadioGroupButton(Buttons[ItemIndex]).SetFocus;}
      end
    else
      if Assigned(Parent) and (Parent.HandleAllocated) then
        SendMessage(Parent.Handle, WM_NEXTDLGCTL, (GetKeyState(VK_SHIFT) and $8000), 0)
      else
        inherited;
end;

{--------------------------------- protected ----------------------------------}
procedure TLMDCustomRadioGroup.SetButtonCount(aValue: Integer);
begin
  while FButtons.Count<aValue do
    TLMDRadioGroupButton.CreateExt(Self);
  while FButtons.Count>aValue do
    begin
      if TLMDRadioGroupButton(FButtons.Last).Focused then
        if CanFocus then SetFocus else Parent.SetFocus;
      TLMDRadioGroupButton(FButtons.Last).Free;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomRadioGroup.UpdateButtons;
var
  i: Integer;
  Btn: TLMDRadioGroupButton;
begin
  SetButtonCount(FItems.Count);
  FUpdating:=True;
  for i:=0 to Pred(FButtons.Count) do
    begin
      Btn := TLMDRadioGroupButton(FButtons[i]);
      Btn.UpdateNow(true);
      try
        Btn.Caption:=FItems[i];
        //TLMDRadioGroupButton(FButtons[i]).Alignment.Alignment:=agCenterLeft; rep JH, March 2001
        Btn.Alignment.Assign (BtnAlignment);
        Btn.ImageIndex:=FGlyphIndex;
        Btn.ListIndex:=GlyphListIndex;
        Btn.ParentColor:=True;
        Btn.ImageList:=GlyphImageList;
        Btn.GlyphTransparent:=self.GlyphTransparent;
        Btn.GlyphTransparentColor:=self.FTransparentColor;
        Btn.GlyphSize:=self.GlyphSize;
        Btn.GlyphFlat:=self.GlyphFlat;
        Btn.FocusStyle:=self.FocusStyle;
        Btn.FocusColor:=self.FocusColor;
        Btn.UseFocusColor:=self.UseFocusColor;
        Btn.Font3D.Assign(self.Font3D);
        Btn.UseBitmap:=self.UseBitmap;
        Btn.Flat:=FlatGlyphs;
        Btn.MultiLine:=self.MultiLine;
        // 8.05
        Btn.ParentBackground:=self.ParentBackground;
        // ---
        Btn.ThemeMode:=self.ThemeMode;
        //TLMDRadioGroupButton(FButtons[i]).TabStop:=self.TabStop;
        case FID of
          ciDefault:Btn.HelpContext:=0;
          ciSameAsParent:Btn.HelpContext:=self.HelpContext;
          ciAutoNumbered:Btn.HelpContext:=self.HelpContext+i+1;
        end;

      finally
        Btn.UpdateNow(False);
      end;
    end;
  if FResult>-1 then
    TLMDRadioGroupButton(FButtons[FResult]).Checked:=True;
  FUpdating:=False;
  ArrangeButtons;
end;

{--------------------------------- public -------------------------------------}
constructor TLMDCustomRadioGroup.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FGlyphTransparent:=True;
  FGlyphSize:=13;
end;

end.
