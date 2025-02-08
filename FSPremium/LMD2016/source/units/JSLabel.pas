{ Summary
  Unit contains the class that is used for the Expando control. }
unit JSLabel;

interface

{$I lmddlgcmps.inc}

uses
  Classes, Controls, Messages, Windows, Graphics, StdCtrls, JSTypes;

type
  { Summary
    Class that implements properties specific for a label type control.
    Description
    The TJSCustomLabel class implements an AutoSize property and the ability to paint text.<p />
    A TJSCustomLabel control can also receive keyboard focus.                                    }
  TJSCustomLabel = class(TCustomControl)
  private
    FAutoSize: Boolean;
    FCaption: TJSString;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure SetCaption(const Value: TJSString);
  protected
    { Summary
      Resizes the label when the text changes.
      Description
      When the text in the label or the font changes, AdjustBounds is implicitly called. It redraws the
      text in the client area, and then resizes the label if the AutoSize property is true.<p />
      <p />
      Override AdjustBounds to make additional adjustments when the text changes.                       }
    procedure AdjustBounds; dynamic;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    { Summary
      Renders the text in the client area.
      Description
      When the label needs to draw itself, DoDrawText is implicitly called. DoDrawText uses the Windows API
      function, DrawText, to render the caption in the client area.<p />
      <p />
      The first parameter, Rect, specifies the boundaries of the text within the client area. The second
      parameter, Flags, specifies how the text is aligned within those boundaries, how tab characters are
      handled, etc. See the Microsoft Windows API DrawText function for all the possible values of Flags.<p />
      <p />
      Override DoDrawText to render text differently.                                                          }
    procedure DoDrawText(var ARect: TRect; AFlags: Longint); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Paint; override;
    { Summary
      Sets the AutoSize property.
      Description
      SetAutoSize is the protected access method for the AutoSize property. It is exposed as a protected
      method so descendants can override it to change the implementation of the AutoSize property.       }
    procedure SetAutoSize(Value: Boolean);{$IFNDEF DELPHI5} override;{$ENDIF DELPHI5}
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
  public
    constructor Create(AOwner: TComponent); override;
    { Summary
      Determines whether the size of the label automatically resizes to accommodate the text.
      Description
      Use AutoSize to make the label adjust its size automatically so the client area accommodates the
      height and width of the text. When AutoSize is false, the label is fixed in size. When AutoSize is
      true, the size of the label readjusts whenever the text changes. The size of the label is also
      readjusts when the Font property changes.                                                          }
    property AutoSize: Boolean read FAutoSize write SetAutoSize default True;
    { Summary
      Specifies a text string that identifies the control to the user.
      Description
      Use Caption to specify the text string that labels the control.<p />
      <p />
      To underline a character in a Caption that labels a component, include an ampersand (&amp;) before the
      character. This type of character is called an accelerator character. The user can then select the
      component by pressing Alt while typing the underlined character. To display an ampersand character in
      the caption, use two ampersands (&amp;&amp;).                                                          }
    property Caption: TJSString read FCaption write SetCaption;
  end;

  { Summary
    Default control for displaying the possibility of additional information about the dialog is possible
    to be displayed.
    Description
    This control is referred to as the Expando control.<p />
    <p />
    The control implements the ability to paint a specific glyph image depending on the current state of
    the Enabled and/or Expanded properties.                                                               }
  TJSCustomMoreLabel = class(TJSCustomLabel)
  private
    FGlyph: TPicture;
    FSpacing: Integer;
    FExpanded: Boolean;
    FMouseInControl: Boolean;
    FOnCollapsed: TNotifyEvent;
    FOnExpanded: TNotifyEvent;
    procedure SetGlyph(const Value: TPicture);
    procedure SetSpacing(const Value: Integer);
    procedure SetExpanded(const Value: Boolean);
    procedure SetMouseInControl(const Value: Boolean);
  protected
    procedure AdjustBounds; override;
    { Summary
      Respond to a user clicking on the control.
      Description
      The click method calls the controls OnClick event if assigned. The Expanded property is also toggled
      when the click method is called.                                                                     }
    procedure Click; override;
    procedure CMMouseenter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseleave(var Message: TMessage); message CM_MOUSELEAVE;
    { Summary
      OnCollapsed event dispatcher.
      Description
      OnCollapsed is called when the Expanded property of the control is False. }
    procedure DoCollapsed; virtual;
    { Summary
      Renders the text in the client area.
      Description
      When the label needs to draw itself, DoDrawText is implicitly called. DoDrawText uses the Windows API
      function, DrawText, to render the caption in the client area.<p />
      <p />
      The first parameter, Rect, specifies the boundaries of the text within the client area. The second
      parameter, Flags, specifies how the text is aligned within those boundaries, how tab characters are
      handled, etc. See the Microsoft Windows API DrawText function for all the possible values of Flags.<p />
      <p />
      Override DoDrawText to render text differently.                                                          }
    procedure DoDrawText(var ARect: TRect; AFlags: Integer); override;
    { Summary
      OnExpanded event dispatcher.
      Description
      OnExpanded is called when the Expanded property of the control is True. }
    procedure DoExpanded; virtual;
    { Summary
      Call the Click method when the space key is pressed.
      Description
      When the user presses the space key the Click method is called to toggle the Expanded state of the
      control.                                                                                           }
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Paint; override;
    { Summary
      Method that sets the Glyph property to the correct image depending on the current control state.
      Description
      Method that sets the Glyph property to the correct image depending on the current control state.<p />
      <p />
      Override this method to use custom images in a descendant control.                                    }
    procedure UpdateGlyph; virtual;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    property MouseInControl: Boolean read FMouseInControl write SetMouseInControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    { Glyph image that is used to indicate whether the control has
      been expanded or is currently collapsed.                     }
    property Glyph: TPicture read FGlyph write SetGlyph;
    { Summary
      Spacing between the Glyph and the start of the control Caption.
      Description
      Spacing between the Glyph and the start of the control Caption.<p />
      <p />
      <b>Default Value</b> 4 pixels                                        }
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    { Property is True when the control has been expanded. This property helps control what image is set in the Glyph property. }
    property Expanded: Boolean read FExpanded write SetExpanded default False;
    { Called when the label has been collapsed. }
    property OnCollapsed: TNotifyEvent read FOnCollapsed write FOnCollapsed;
    { Called when the label has been expanded. }
    property OnExpanded: TNotifyEvent read FOnExpanded write FOnExpanded;
  end;

  { Summary
    Default control for displaying the possibility of additional information about the dialog is possible
    to be displayed.
    Description
    This control is referred to as the Expando control.                                                   }
  TJSMoreLabel = class(TJSCustomMoreLabel)
  published
    { Summary
      Determines how the control aligns within its container (parent control).
      Description
      Use Align to align a control to the top, bottom, left, or right of a form or panel and have it remain
      there even if the size of the form, panel, or component that contains the control changes. When the
      parent is resized, an aligned control also resizes so that it continues to span the top, bottom,
      left, or right edge of the parent.<p />
      <p />
      For example, to use a panel component with various controls on it as a tool palette, change the
      panel's Align value to alLeft. The value of alLeft for the Align property of the panel guarantees
      that the tool palette remains on the left side of the form and always equals the client height of the
      form.<p />
      <p />
      The default value of Align is alNone, which means a control remains where it is positioned on a form
      or panel.<p />
      <p />
      <b>Tip</b>: If Align is set to alClient, the control fills the entire client area so that it is
      impossible to select the parent form by clicking it. In this case, select the parent by selecting the
      control on the form and pressing Esc, or by using the Object Inspector.<p />
      Any number of child components within a single parent can have the same Align value, in which case
      they stack up along the edge of the parent. The child controls stack up in z-order. To adjust the
      order in which the controls stack up, drag the controls into their desired positions.<p />
      <p />
      <b>Note</b>: To cause a control to maintain a specified relationship with an edge of its parent, but
      not necessarily lie along one edge of the parent, use the Anchors property instead.                   }
    property Align;
    { Summary
      Specifies how the control is anchored to its parent.
      Description
      Use Anchors to ensure that a control maintains its current position relative to an edge of its
      parent, even if the parent is resized. When its parent is resized, the control holds its position
      relative to the edges to which it is anchored.<p />
      <p />
      If a control is anchored to opposite edges of its parent, the control stretches when its parent is
      resized. For example, if a control has its Anchors property set to [akLeft, akRight], the control
      stretches when the width of its parent changes.<p />
      <p />
      Anchors is enforced only when the parent is resized. Thus, for example, if a control is anchored to
      opposite edges of a form at design time and the form is created in a maximized state, the control is
      not stretched because the form is not resized after the control is created.<p />
      <p />
      <b>Note</b>: If a control should maintain contact with three edges of its parent (hugging one side of
      the parent and stretching the length of that side), use the Align property instead. Unlike Anchors,
      Align allows controls to adjust to changes in the size of other aligned sibling controls as well as
      changes to the parent's size.                                                                         }
    property Anchors;
    property AutoSize;
    { <alias JSGraphics.TJSCaptionControl.BiDiMode>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                     }
    property BiDiMode;
    property Caption;
    { <alias JSGraphics.TJSCaptionControl.Color>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                  }
    property Color;
    { Set the expanded property to control the way the glyph appears. }
    property Expanded;
    { <alias JSGraphics.TJSCaptionControl.Font>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                 }
    property Font;
    { <alias JSGraphics.TJSCaptionControl.Height>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                   }
    property Height;
    { <alias JSGraphics.TJSCaptionControl.ParentBiDiMode>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                           }
    property ParentBiDiMode;
    { <alias JSGraphics.TJSCaptionControl.ParentColor>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                        }
    property ParentColor;
    property Spacing;
    { <alias JSGraphics.TJSCaptionControl.Visible>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                    }
    property Visible;
    { <alias JSGraphics.TJSCaptionControl.Width>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                  }
    property Width;
    { <alias JSGraphics.TJSCaptionControl.OnClick>
      
      Summary
      Add a summary here...
      Description
      Add a description here...                    }
    property OnClick;
    { Called when the label has been expanded. }
    property OnExpanded;
    { Called when the label has been collapsed. }
    property OnCollapsed;
  end;

implementation

uses
  {$IFDEF THEMES}Themes, {$ENDIF THEMES}SysUtils, Forms, Math, JSGraphUtil, JSUnicode;

{$R mbimg.res}

function IsMouseButtonPressed: Boolean;
begin
  Result := not (((GetAsyncKeyState(VK_RBUTTON)and $8000)=0) and
            ((GetAsyncKeyState(VK_LBUTTON)and $8000)=0));
end;

{ TJSCustomLabel }

constructor TJSCustomLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable, csOpaque];
  Width := 65;
  Height := 17;
  {$IFNDEF DELPHI5}
  {$IFDEF THEMES}
  ParentBackground := False;
  {$ENDIF THEMES}
  {$ENDIF DELPHI5}
  Color := clBtnFace;
  FAutoSize := True;
end;

procedure TJSCustomLabel.DoDrawText(var ARect: TRect; AFlags: Longint);

  procedure DrawDisabledStyle(const ACaption: string);
  begin
    OffsetRect(ARect, 1, 1);
    Canvas.Font.Color := clBtnHighlight;
    JSDrawText(Canvas.Handle, ACaption, Font, ARect, AFlags);
    OffsetRect(ARect, -1, -1);
    Canvas.Font.Color := clBtnShadow;
    JSDrawText(Canvas.Handle, ACaption, Font, ARect, AFlags);
  end;

var
  lStr: TJSString;
begin
  inherited;
  lStr := Caption;
  AFlags := DrawTextBiDiModeFlags(AFlags);
  Canvas.Font := Font;
  AFlags := AFlags and not DT_EXPANDTABS;
  if BiDiMode = bdLeftToRight then
    inc(ARect.Left, 2)
  else
    ARect.Left := 2;
  if not Enabled then
  begin
    DrawDisabledStyle(LStr);
  end
  else
  begin
    JSDrawText(Canvas.Handle, lStr, Font, ARect, AFlags);
  end;
end;

procedure TJSCustomLabel.Paint;
const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  lRect: TRect;
  lDrawStyle: Longint;
  lCalcRect: TRect;
begin
  Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(ClientRect);
  Canvas.Brush.Style := bsClear;
  lRect := ClientRect;
  inc(lRect.Left, 2);
  lDrawStyle := DT_EXPANDTABS or DT_SINGLELINE or DT_VCENTER or Alignments[taLeftJustify];
  DoDrawText(lRect, lDrawStyle);
  if Focused then
  begin
    Canvas.Pen.Color := clBlack;
    Canvas.Brush.Style := bsSolid;
    lCalcRect := Rect(0, 0, 0, 0);
    JSDrawText(Canvas.Handle, Caption, Font, lCalcRect, DT_EXPANDTABS or DT_SINGLELINE or Alignments[taLeftJustify] or DT_CALCRECT, True);
    if BiDiMode = bdLeftToRight then
    begin
      dec(lRect.Left, 2);
      lRect.Right := lRect.Left + lCalcRect.Right + 4;
    end
    else
    begin
      inc(lRect.Right, 2);
      lRect.Left := lRect.Right - 4 - (lCalcRect.Right - lCalcRect.Left);
    end;
    Inc(LRect.Top, 2);
    lRect.Bottom := lRect.Top + lCalcRect.Bottom + 1;
    if LRect.Bottom > ClientRect.Bottom then
      LRect.Bottom := ClientRect.Bottom;
    Canvas.DrawFocusRect(lRect);
    Canvas.Brush.Style := bsClear;
  end;
end;

procedure TJSCustomLabel.SetCaption(const Value: TJSString);
begin
  if FCaption <> Value then
  begin
    FCaption := Value;
    Invalidate;
    AdjustBounds;
  end;
end;

procedure TJSCustomLabel.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  if Button = mbLeft then
  begin
    SetFocus;
    Invalidate;
  end;
end;

procedure TJSCustomLabel.AdjustBounds;
var
  lDC: HDC;
  lRect: TRect;
  lWidth: Integer; // Current control width
  lLeft: Integer; // New control left position when BiDiMode <> bdLeftToRight
begin
  if not AutoSize then
    Exit;
  if not (csReading in ComponentState) and (Parent <> nil) then
  begin
    lRect := Rect(0, 0, 0, 0);
    lDC := GetDC(0);
    try
      Canvas.Handle := lDC;
      DoDrawText(lRect, (DT_EXPANDTABS or DT_CALCRECT));
      Canvas.Handle := 0;
    finally
      ReleaseDC(0, lDC);
    end;
    if BiDiMode = bdLeftToRight then
      SetBounds(Left, Top, lRect.Right, lRect.Bottom)
    else
    begin
      lWidth := Width;
      if lWidth <> lRect.Right then
      begin
        lLeft := lWidth - lRect.Right;
        SetBounds(Left + lLeft, Top, lRect.Right, lRect.Bottom);
      end
      else
        SetBounds(Left, Top, lRect.Right, lRect.Bottom);
    end;
  end;
end;

procedure TJSCustomLabel.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  Invalidate;
end;

procedure TJSCustomLabel.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  SetFocus;
  Invalidate;
end;

procedure TJSCustomLabel.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
  AdjustBounds;
end;

procedure TJSCustomLabel.CMDialogChar(var Message: TCMDialogChar);
begin
  if IsAccel(Message.CharCode, Caption) and CanFocus then
  begin
    SetFocus;
    if Focused then
      Click;
    Message.Result := 1;
  end
  else
    inherited;
end;

procedure TJSCustomLabel.CMFontChanged(var Message: TMessage);
begin
  inherited;
  AdjustBounds;
end;

procedure TJSCustomLabel.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    Invalidate;
    AdjustBounds;
  end;
end;

{ TJSCustomMoreLabel }

procedure TJSCustomMoreLabel.AdjustBounds;
var
  lDC: HDC;
  lRect: TRect;
  lWidth: Integer; // Current control width
  lLeft: Integer; // New control left position when BiDiMode <> bdLeftToRight
begin
  if not AutoSize then
    Exit;
  if not (csReading in ComponentState) and (Parent <> nil) then
  begin
    lRect := Rect(0, 0, 0, 0);
    lDC := GetDC(0);
    try
      Canvas.Handle := lDC;
      DoDrawText(lRect, (DT_EXPANDTABS or DT_CALCRECT));
      Canvas.Handle := 0;
    finally
      ReleaseDC(0, lDC);
    end;
    if ValidPicture(FGlyph) then
    begin
      inc(lRect.Right, FGlyph.Width + Spacing);
      lRect.Bottom := Max(lRect.Bottom, FGlyph.Height);
    end;
    if BiDiMode = bdLeftToRight then
      SetBounds(Left, Top, lRect.Right, lRect.Bottom)
    else
    begin
      lWidth := Width;
      if lWidth <> lRect.Right then
      begin
        lLeft := lWidth - lRect.Right;
        SetBounds(Left + lLeft, Top, lRect.Right, lRect.Bottom);
      end
      else
        SetBounds(Left, Top, lRect.Right, lRect.Bottom);
    end;
  end;
end;

procedure TJSCustomMoreLabel.Click;
begin
  inherited;
  Expanded := not Expanded;
end;

procedure TJSCustomMoreLabel.CMMouseenter(var Message: TMessage);
begin
  inherited;
  MouseInControl := True;
end;

procedure TJSCustomMoreLabel.CMMouseleave(var Message: TMessage);
begin
  inherited;
  MouseInControl := False;
end;

constructor TJSCustomMoreLabel.Create(AOwner: TComponent);
begin
  inherited;
  FGlyph := TPicture.Create;
  FSpacing := 4;
  Height := 20;
  Width := 200;
  FMouseInControl := False;
  UpdateGlyph;
  Expanded := False;
  TabStop := True;
  ParentFont := True;
end;

destructor TJSCustomMoreLabel.Destroy;
begin
  FreeAndNil(FGlyph);
  inherited;
end;

procedure TJSCustomMoreLabel.UpdateGlyph;
begin
  if not FExpanded then
  begin
    if not Enabled then
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHOWCOLD')
    else if IsMouseButtonPressed and MouseInControl then
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHOWPRESS')
    else if MouseInControl then
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHOWHOT')
    else
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_SHOWCOLD');
  end
  else
  begin
    if not Enabled then
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_HIDECOLD')
    else if IsMouseButtonPressed and MouseInControl then
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_HIDEPRESS')
    else if MouseInControl then
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_HIDEHOT')
    else
      FGlyph.Bitmap.LoadFromResourceName(hInstance, 'JSD_HIDECOLD');
  end;
  FGlyph.Bitmap.Transparent := True;
end;

procedure TJSCustomMoreLabel.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  Message.Result := 1;
end;

procedure TJSCustomMoreLabel.DoCollapsed;
begin
  if Assigned(FOnCollapsed) then
    FOnCollapsed(Self);
end;

procedure TJSCustomMoreLabel.DoDrawText(var ARect: TRect; AFlags: Integer);
begin
  if ValidPicture(FGlyph) then
  begin
    if BiDiMode = bdLeftToRight then
      ARect.Left := ARect.Left + FGlyph.Graphic.Width + FSpacing
    else
      ARect.Right := ARect.Right - (FGlyph.Graphic.Width + FSpacing);
  end;
  inherited;
end;

procedure TJSCustomMoreLabel.DoExpanded;
begin
  if Assigned(FOnExpanded) then
    FOnExpanded(Self);
end;

procedure TJSCustomMoreLabel.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = VK_SPACE then
    Click;
end;

procedure TJSCustomMoreLabel.Paint;
begin
  inherited;
  UpdateGlyph;
  if ValidPicture(Glyph) then
  begin
    if BiDiMode = bdLeftToRight then
      Canvas.Draw(0, 0, FGlyph.Graphic)
    else
      Canvas.Draw(Width - FGlyph.Graphic.Width, 0, FGlyph.Graphic);
  end;
end;

procedure TJSCustomMoreLabel.SetExpanded(const Value: Boolean);
begin
  if FExpanded <> Value then
  begin
    FExpanded := Value;
    if FExpanded then
      DoExpanded
    else
      DoCollapsed;
    Invalidate;
  end;
end;

procedure TJSCustomMoreLabel.SetGlyph(const Value: TPicture);
begin
  FGlyph.Assign(Value);
  Invalidate;
end;

procedure TJSCustomMoreLabel.SetMouseInControl(const Value: Boolean);
begin
  if FMouseInControl <> Value then
  begin
    FMouseInControl := Value;
    Invalidate;
  end;
end;

procedure TJSCustomMoreLabel.SetSpacing(const Value: Integer);
begin
  if FSpacing <> Value then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

end.
