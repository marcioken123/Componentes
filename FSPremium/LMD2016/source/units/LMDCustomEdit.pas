unit LMDCustomEdit;
{$I lmdcmps.INC}

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

LMDCustomEdit unit (JH)
-----------------------

singleline textinput control

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Types, LMDTypes, LMDUtils, LMDClass, LMDGraph, LMDSBtn,
  LMDBase, LMDCustomControl, LMDBaseEdit, LMDButtonBase, LMDEditAutoComplete;

type
  TLMDOnBtnClick = procedure (Sender, Btn : TObject; index : Integer) of object;

  TLMDCustomEdit = class(TLMDBaseEdit)
  private
    FPasswordChar      : Char;
    FSpecialText       : TLMDString;
    FAutoSize          : Boolean;
    FCustomButtons     : TLMDSpecialButtons;
    FCustomButtonWidth : Integer;
    FCustomButtonStyle : TLMDUserButtonStyle;
    FAutoComplete      : TLMDEditAutoComplete;
    FOnBtnClick        : TLMDOnBtnClick;
    FCustomXP          : Boolean;
    FCueBanner         : TLMDString;
    FPainting,
    FIsEmpty           : Boolean;
    FPaintRectWB       : TRect;

    procedure SetPasswordChar (aValue : Char);
    procedure SetAutoSize (aValue : Boolean); reintroduce;
    procedure SetCustomButtons (aValue : TLMDSpecialButtons);
    procedure SetCustomButtonWidth (aValue : Integer);
    procedure SetCustomButtonXP(const Value: Boolean);
    procedure SetAutoComplete (aValue : TLMDEditAutoComplete);
    procedure ReadOldBtnStyle(Reader:TReader);
    (*    procedure WMKeyDown(var Msg : TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Msg : TWMKeyUp); message WM_KEYUP;*)
    procedure CMFontChanged(var Message:TMessage);message CM_FONTCHANGED;
    procedure CMLMDBevelChanged(var Message:TMessage);message CM_LMDBEVELCHANGED;
    procedure WMKillFocus(var Msg : TWMKillFocus); message WM_KILLFOCUS;
    //EM_XXX message handling (everthing which is not explicitly named here is already done in TLMDBaseEdit
    procedure EMGETPASSWORDCHAR (var Message : TMessage); message EM_GETPASSWORDCHAR;
    procedure EMSETPASSWORDCHAR (var Message : TMessage); message EM_SETPASSWORDCHAR;
    procedure SetCueBanner(const Value: TLMDString);
    procedure SetIsEmpty(const Value: Boolean);
    function  GetPasswordChar: Char;
  protected
    procedure Notification (AComponent: TComponent; Operation: TOperation); override;
    function BackOneMore: Boolean; override;
    function CalcMousePos(Pos : TSmallPoint) : LongInt; override;
    function CalcMouseCol(XPos : Integer) : Integer; override;
    function CalcMouseRow(YPos : Integer) : Integer; override;
    // 7.0
    procedure DefineProperties(Filer:TFiler);override;
    // ---
    procedure DoThemeChanged;override;
    procedure GetCommandKey (var KeyCode : Word; Shift : TShiftState); override;
    procedure GetIMLChange(Sender: TObject); override;

    procedure CreateSpecialText(var s : TLMDString); virtual;
    procedure ChangedText (At : Integer); override;
    procedure FinishedSetSelText; override;
    procedure HandleInsertText (at : Integer;var aValue : TLMDString); override;
    procedure SetNewText; override;
    procedure GetNewText; override;
    procedure RedefineTextColor(C: TCanvas); virtual;
    function  GetThemedTextColor: TColor;
    procedure DrawEditText(from : Integer); overload; override;
    procedure DrawEditText(from : Integer; const aTxt: TLMDString); reintroduce; overload; //virtual;
    procedure CorrectBounds; virtual;
    procedure DoAClick (Btn : TObject; index : Integer); virtual;
    procedure UpdateCustomButtonsThemeMode; virtual;
    function AllowCopyPaste : Boolean; override;
    procedure DrawSpecialTextBackground (aCanvas: TCanvas; aRect: TRect); virtual; //JH March 2002

    procedure SetCustomButtonsXPMode(const Value: TLMDThemeMode);
    procedure SetCaret; override;
    procedure SetCustomButtonStyle (aValue : TLMDUserButtonStyle);virtual;

    property SpecialText : TLMDString read FSpecialText write FSpecialText;
    property AutoComplete: TLMDEditAutoComplete read FAutoComplete write SetAutoComplete;

    property IsEmpty: Boolean read FIsEmpty write SetIsEmpty default false;

    procedure Loaded; override;
    function ShowCueBanner: boolean; virtual;
    procedure Paint; override;
    procedure PaintCueBanner(Canvas : TCanvas); virtual;
    function RedrawOnEnter: Boolean; override;
    function RedrawOnExit: Boolean; override;
    procedure ModifyPaintRect; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure BtnClick (index : Integer);
    procedure SetBorders;
    procedure CorrectWidth; virtual;
    property Text;
    property PasswordChar : Char read GetPasswordChar write SetPasswordChar;
    property CustomButtons : TLMDSpecialButtons read FCustomButtons write SetCustomButtons;
    property CustomButtonWidth : Integer read FCustomButtonWidth write SetCustomButtonWidth default 16;
    property CustomButtonsStyle : TLMDUserButtonStyle read FCustomButtonStyle write SetCustomButtonStyle default ubsIntegrated;
    property CustomButtonStyle : TLMDUserButtonStyle read FCustomButtonStyle write SetCustomButtonStyle;
    property CustomButtonParentCtlXP: Boolean read FCustomXP write SetCustomButtonXP default true;
    property ReadOnly;
    property OnBtnClick : TLMDOnBtnClick read FOnBtnClick write FOnBtnClick;
  published
    property AutoSize : Boolean read FAutoSize write SetAutoSize default false;
    property CueBanner: TLMDString read FCueBanner write SetCueBanner;
    property DraggingAllowed;    
    property Font;
    property CharCase;
    property Font3D;

    property MaxLength;
    property HideSelection;
    property AutoSelect;
    property OEMConvert;
    property ParentFont;
    property Options;

  end;

implementation

uses
  UxTheme, Themes, LMDThemes, LMDSysIn, LMDGraphUtils, LMDStrings;

{ ------------------------------- private ------------------------------------ }
procedure TLMDCustomEdit.SetPasswordChar (aValue : Char);
begin
  FPasswordChar := aValue;
  ChangedText(1);
end;

procedure TLMDCustomEdit.UpdateCustomButtonsThemeMode;
var
  i: integer;
begin
  if FCustomXP then
    SetCustomButtonsXPMode(ThemeMode)
  else
    begin
      for i:=0 to FCustomButtons.Count-1 do
        FCustomButtons.Items[i].Btn.Perform({$IFNDEF LMDCOMP7}$031A{$ELSE}WM_ThemeChanged{$ENDIF}, 0, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetAutoSize (aValue : Boolean);
begin
  if aValue <> FAutoSize then
    begin
      FAutoSize := aValue;
      if HandleAllocated then
      begin
        CorrectBounds;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomEdit.SetCustomButtons (aValue : TLMDSpecialButtons);
begin
  FCustomButtons.Assign (aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomEdit.SetCustomButtonWidth (aValue : Integer);
begin
  if aValue <> FCustomButtonWidth then
    begin
      FCustomButtonWidth := aValue;
      if self.Parent <> nil then
        SendMessage (self.Handle, WM_SIZE, 0, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetCustomButtonXP(const Value: Boolean);
begin
  if Value<>FCustomXP then
    begin
      FCustomXP:=Value;
      if FCustomXP then
        SetCustomButtonsXPMode(FThemeMode);
      DoThemeChanged;  
    end;
end;

procedure TLMDCustomEdit.SetIsEmpty(const Value: Boolean);
begin
  if IsEmpty = Value then
    Exit;

  BeginUpdate;
  try
    FIsEmpty := Value;
  finally
    EndUpdate(true);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetCustomButtonStyle (aValue : TLMDUserButtonStyle);
begin
  if aValue <> FCustomButtonStyle then
    begin
      FCustomButtonStyle := aValue;
      if not (csLoading in ComponentState) and not IsUpdating then
        SendMessage (self.Handle, WM_SIZE, 0, 0);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetAutoComplete (aValue : TLMDEditAutoComplete);
begin
  FAutoComplete := aValue;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.ReadOldBtnStyle(Reader: TReader);
var
  tmp:Boolean;
begin
  tmp:=false;
  LMDButtonReadExtStyle(Reader, FCustomButtonStyle, tmp);
  if tmp <> FCustomButtons.Items[0].Btn.CtlXP then
    FCustomButtons.Items[0].Btn.CtlXP := tmp;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.GetCommandKey (var KeyCode : Word; Shift : TShiftState);
begin

  if KeyCode = VK_UP then //added JH Nov 03
    KeyCode := VK_LEFT;
  if KeyCode = VK_DOWN then //added JH Nov 03
    KeyCode := VK_RIGHT;

  inherited GetCommandKey (KeyCode, Shift);
  if KeyCode = VK_RETURN then
    if Assigned (FAutoComplete) and (aaControlReturn in FAutoComplete.AddUnknownOn) then
      FAutoComplete.Add (self, Text);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetCaret;
var
  x, l : Integer;
begin
  if not Focused then exit;

  if not Caret.Enabled then Exit;
  //pre calc x pos
  SetTextCharacterExtra (Canvas.Handle, Font3D.Tracing);

  x := FTextRect.Left;
  l := 0;
  case Alignment of
    taLeftJustify  : l := FTextRect.Left;
    taRightJustify : begin
                       l := FTextRect.Right - LMDGetTextWidth (Canvas, FSpecialText);
                       x := FTextRect.Right;
                     end;
    taCenter       : begin
                       l := FTextRect.Left + (FTextRect.Right - FTextRect.Left - LMDGetTextWidth (Canvas, FSpecialText)) div 2;
                       x := FTextRect.Left + (FTextRect.Right - FTextRect.Left) div 2;
                     end;
  end;

  case Font3D.Style of
    tdRaisedShadow,
    tdRaised : inc (l, Font3D.LightDepth);
    tdSunkenShadow,
    tdSunken : inc (l, Font3D.ShadowDepth);
  end;

  dec(l, 1);

  if Length (FSpecialText) >0 then
    x := LMDGetTextWidth (Canvas, System.Copy(FSpecialText, 1, FCurrentChar-1)) - FHiddenLeft + l;

  if Font3D.Style in [tdExtrude, tdExtrudeEnh] then
    if Font3D.Orientation in [toTopLeft, toBottomLeft] then
      x := x + Font3D.ShadowDepth;
  //check whether x pos is visible or not
  //if not make it visible
  if x > FTextRect.Right then
    begin
      x := x - FTextRect.Right + FTextRect.Left;
      FHiddenLeft := FHiddenLeft + x + 2;
      DrawEditText(-1);
    end;
  if (x < FTextRect.Left) and (FHiddenLeft <> 0) then
    begin
      x := Abs(x) + FTextRect.Left;
      FHiddenLeft := FHiddenLeft - x - 2;
      if FHiddenLeft < 0 then
        FHiddenLeft := 0;
      DrawEditText(-1);
    end;
  //reset x (for the case that FSpecialText is empty)
  x := l;

  //calc caret pos and set it
  if Length (FSpecialText) >0 then
    x := LMDGetTextWidth (Canvas, System.Copy(FSpecialText, 1, FCurrentChar-1)) - FHiddenLeft + l;
  if Font3D.Style in [tdExtrude, tdExtrudeEnh] then
    if Font3D.Orientation in [toTopLeft, toBottomLeft] then
      x := x + Font3D.ShadowDepth;
  SetLMDCaretPos (x+1, FTextRect.Top);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetCustomButtonsXPMode(const Value: TLMDThemeMode);
var
  i:Integer;
begin
  for i:=0 to FCustomButtons.Count-1 do
    FCustomButtons.Items[i].Btn.ThemeMode := Value;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.BackOneMore: Boolean;
begin
  result := Assigned (FAutoComplete) and (FAutoComplete.Enabled) and (amText in FAutoComplete.Mode);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetNewText;
begin
  FLineEnd := Length(Text);
  SelLength := 0;
  ChangedText (1);
  if self.Focused then
    SetCaret;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.GetNewText;
begin
end;

function TLMDCustomEdit.GetPasswordChar: Char;
begin
  Result := FPasswordChar;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.GetThemedTextColor: TColor;
{$IFDEF LMDCOMP16}
const
  C_STATES: array[Boolean, Boolean] of TThemedEdit = (
    (teEditTextDisabled,
     teEditTextDisabled),
    (teEditTextNormal,
     teEditTextReadOnly)
  );
var
  dtls: TThemedElementDetails;
{$ENDIF}
begin
  {$IFDEF LMDCOMP16}
  if (UseThemeMode = ttmPlatform) and StyleServices.Enabled and
     TStyleManager.IsCustomStyleActive then
  begin
    dtls := StyleServices.GetElementDetails(C_STATES[Enabled, ReadOnly]);
    if not StyleServices.GetElementColor(dtls, ecTextColor, Result) then
      Result := clWindowText;
  end
  else
  {$ENDIF}
    Result := Font.Color;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.CalcMousePos(Pos : TSmallPoint) : LongInt;
var
  i, l : Integer;
begin
  i := 1;

  l := 0;
  SetTextCharacterExtra (Canvas.Handle, Font3D.Tracing);
  case Alignment of
    taLeftJustify  : l := FTextRect.Left;
    taRightJustify : begin
                       l := FTextRect.Right - LMDGetTextWidth (Canvas, FSpecialText);
                     end;
    taCenter       : begin
                       l := FTextRect.Left + (FTextRect.Right - FTextRect.Left - LMDGetTextWidth (Canvas, FSpecialText)) div 2;
                     end;
  end;

  while (l+(LMDGetTextWidth(Canvas, System.Copy(FSpecialText, 1, i))-FHiddenLeft-
         LMDGetTextWidth(Canvas, System.Copy(FSpecialText, i, 1)) div 2) < Pos.X) and
        (i < Length (FSpecialText)+1) do
    inc(i);
  result := i;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.CalcMouseCol(XPos : Integer) : Integer;
begin
  result := 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.CalcMouseRow(YPos : Integer) : Integer;
begin
  result := 0;
end;

(*{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.WMKeyDown(var Msg : TWMKeyDown);
begin
  inherited;
  case Msg.CharCode of
     VK_END : if Canvas.TextWidth (Text) > FTextRect.Right - FtextRect.Left then
                 begin
//                   FHiddenLeft := Canvas.TextWidth (Text) - (FTextRect.Right - FtextRect.Left) div 2;
//                   DrawText(-1);
                 end;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.WMKeyUp(var Msg : TWMKeyUp);
begin
  inherited;
end;*)

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.CMFontChanged(var Message:TMessage);
begin
  inherited;
  CorrectBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.CMLMDBevelChanged(var Message:TMessage);
begin
  inherited;
  CorrectBounds;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.WMKillFocus(var Msg : TWMKillFocus);
begin
  inherited;
  if Assigned (FAutoComplete) and (aaControlExit in FAutoComplete.AddUnknownOn) then
    FAutoComplete.Add (self, Text);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.EMGETPASSWORDCHAR (var Message : TMessage);
begin  //EM_GETPASSWORDCHAR
  //returns the password char
  Message.result := Ord (FPasswordChar);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.EMSETPASSWORDCHAR (var Message : TMessage);
begin  //EM_SETPASSWORDCHAR
  PasswordChar := Char(Message.wParam);
end;

{ ------------------------------ public -------------------------------------- }
procedure TLMDCustomEdit.DrawEditText(from: Integer; const aTxt: TLMDString);
var
  i : HRGN;
  mr,
  ml,
  j, y2,
  x1, x2 : Integer;
  lPaintRect,
  aRect,
  hRect : TRect;
  wasVisible : Boolean;
  myCanvas : TCanvas;
  style: TLMDDrawTextStyle;
begin
  if not Focused and ShowCueBanner and (FCueBanner <> '') then
  begin
    PaintCueBanner(Canvas);
    Exit;
  end;

  wasVisible := Caret.Enabled;
  x2 := 0; x1 := 0; i := 0;//just for the compiler
  Caret.Disable;

  if (FOutBuffered and (FBack <> nil)) then
    myCanvas := FBack.Canvas
  else
    myCanvas := Canvas;

  try
    myCanvas.Font := GetFont;
    myCanvas.Font.Color := GetThemedTextColor;

    if FPainting then
      lPaintRect := FPaintRectWB
    else
      lPaintRect := FPaintRect;

    RepaintBack(lPaintRect);

    //added JH March 2002
    DrawSpecialTextBackground(myCanvas, lPaintRect);
    aRect := FTextRect; //19.11.99 JH !!

    //if there is FSpecialText to be hidden on the left
    if FHiddenLeft <> 0 then
    begin
      with aRect do
        i := CreateRectRgn (Left, Top, Right, Bottom);
      SelectObject (myCanvas.Handle, i);
      Dec(aRect.Left, FHiddenLeft);
    end;

    SetTextCharacterExtra (myCanvas.Handle, Font3D.Tracing);
    case Alignment of
      taCenter : inc (aRect.Left, (aRect.Right - aRect.Left - LMDGetTextWidth (myCanvas, aTxt)) div 2);
      taRightJustify : aRect.Left := (aRect.right - LMDGetTextWidth (myCanvas, aTxt));
    end;

    hRect := aRect;
    mr := 0; //mr, ml needed for painting selection -> set to zero here because used in and after the next if statement
    ml := 0;

    if (SelLength <> 0) and (not FNoSelection) then
    begin
      for j := 1 to Length (aTxt) do
      begin //step through the FSpecialText
        //selection starts => remember screen x1 pos
        if (j = SelStart) then
        begin
          x1 := hRect.Left;
          //set selection end to selction start
          x2 := x1;
        end;

        //next paint at a new pos
        hRect.Left := aRect.Left + LMDGetTextWidth (myCanvas, System.Copy(aTxt, 1, j));

        //selection ends => remember screen x2 pos
        if (j = SelStart + SelLength - 1 ) then
          x2 := hRect.Left;
      end; // end of for j

      //if selection ends out of visible area let it end before
      if x2 > aRect.Right then
        x2 := aRect.Right ;

      case Font3D.Style of
        tdExtrude      : mr := Font3D.ShadowDepth;
        tdRaised       : mr := Font3D.LightDepth;
        tdExtrudeEnh,
        tdRaisedShadow : begin
                           mr := Font3D.LightDepth;
                           ml := Font3D.ShadowDepth;
                         end;
        tdSunken       : ml := Font3D.LightDepth;
        tdSunkenShadow : begin
                           mr := Font3D.ShadowDepth;
                           ml := Font3D.LightDepth;
                         end;
      end;

      myCanvas.Brush.Color := HighLightBack;

      y2 := hRect.Top + RowHeight (FSpecialText) + mr + ml;
      if y2 > FTextRect.Bottom then
        y2 := FTextRect.Bottom;

      if (Font3D.Style <> tdExtrudeEnh) or
         (Font3D.Orientation in [toTopRight, toBottomRight]) then
        myCanvas.FillRect(Rect(x1 + mr, hRect.Top, x2 + mr, y2))
      else
        myCanvas.FillRect(Rect(x1 + mr + ml, hRect.Top, x2 + mr + ml, y2))
    end;

    if not IsEmpty then
      Style := TLMDDrawTextStyle(Enabled)
    else
      Style := dtDisabled;

    RedefineTextColor(myCanvas); // Required by LMD.Grid package.
    myCanvas.Refresh;
    LMDDrawTextExt(myCanvas, aTxt, Font3D, aRect,
                   DT_SINGLELINE or DT_NOPREFIX,
                   [Style], nil);

    if (SelLength <> 0) and not FNoSelection then
    begin
      myCanvas.Font.Color := HighLightText;
      LMDDrawTextExt (myCanvas,
                      System.Copy(aTxt, SelStart, SelLength),
                      Font3D,
                      Rect (x1, aRect.Top, x2 + mr + ml, aRect.Bottom),
                      DT_SINGLELINE or DT_NOPREFIX,
                      [Style],
                      nil);
    end;

    //if there was FSpecialText to be hidden reset the aRect
    if FHiddenLeft <> 0 then
      DeleteObject (i);

    if FOutBuffered and (FBack <> nil) then
      Canvas.CopyRect (lPaintRect, myCanvas, lPaintRect);

  finally
    if wasVisible then
      Caret.Enable;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.DrawEditText(from: Integer);
begin
  //  7.0 RM
  //if (csLoading in ComponentState) then exit;  // this was old code
  if isUpdating or ([csReading, csLoading, csDestroying]*ComponentState<>[]) or not HandleAllocated then exit;
  // ---
  DrawEditText (from, FSpecialText);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.CorrectWidth;
begin
  SetBounds(Left, Top, RowWidth(Text) + RowWidth('Q'), Height);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.CorrectBounds;
var
  i, j : Integer;
begin
  Canvas.Font.Assign (GetFont);
  if FAutoSize then
    begin
      if Bevel.Mode = bmWindows then
        i := 5 + 5 * RowHeight ('Qp') div 4
      else
        i := Bevel.BevelExtend * 2 + 5*RowHeight ('Qp') div 4;
      if Width < FCustomButtons.Count * FCustomButtonWidth + 30 then
        j := FCustomButtons.Count * FCustomButtonWidth + 30
      else
        j := Width;
      SetBounds (Left, Top, j, i);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.DoAClick (Btn : TObject; index : Integer);
begin
  if Assigned (FOnBtnClick) then
    FOnBtnClick (self, Btn, index);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.DoThemeChanged;
begin
  inherited;
  UpdateCustomButtonsThemeMode;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.AllowCopyPaste : Boolean;
begin
  result := (FPasswordChar = #0) and Inherited AllowCopyPaste;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.DrawSpecialTextBackground (aCanvas: TCanvas; aRect: TRect);
begin
  //do nothing here, can be used for drawing additional special text background graphics
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.Loaded;
begin
  inherited Loaded;
  CorrectBounds;
  UpdateCustomButtonsThemeMode;
end;

{ ---------------------------------------------------------------------------- }
constructor TLMDCustomEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);

  FIsEmpty := false;

  FAutoSize   := false;
  FCursor2EndOnSelectAll := true;
  FCustomButtons := TLMDSpecialButtons.Create (self, true);
  FCustomButtonWidth := 16;
  FCustomButtonStyle := ubsIntegrated;
  FCustomXP := IsThemed;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDCustomEdit.Destroy;
begin
  FreeAndNil(FCustomButtons);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.Notification (AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification (AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FAutoComplete) then
    FAutoComplete := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.BtnClick (index : Integer);
begin
  if CustomButtons.Count >= index then
    CustomButtons[index].DoClick;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.Paint;
begin
  if ([csReading, csLoading]*ComponentState<>[]) or IsUpdating  then exit;
  FPainting := true;
  inherited Paint;
  DrawEditText(-1);
  FPainting := false;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.ModifyPaintRect;
begin
  inherited ModifyPaintRect;
  FPaintRectWB := FPaintRect;
  if FCustomButtons.Count > 0 then
  begin
    dec (FPaintRect.Right, FCustomButtons.Count * (FCustomButtonWidth));
    if (Bevel.Mode <> bmWindows) or IsThemed then
      dec (FPaintRect.Right, 1);
  end;
  SetBorders;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetBorders;
var
  i : Integer;
  lCorrection: boolean;
begin
  lCorrection := (Bevel.Mode <> bmWindows) or IsThemed;
  for i := 0 to FCustomButtons.Count-1 do
    begin
      FCustomButtons.Items[i].Btn.Style := FCustomButtonStyle;
      if lCorrection then
        FCustomButtons.Items[i].Btn.Top := FPaintRect.Top + 1
      else
        FCustomButtons.Items[i].Btn.Top := 0; //JH June 02, non XP, Bevel = bmWindows
                                              //otherwise btn offset on switching from theme to classic
      FCustomButtons.Items[i].Btn.Width := FCustomButtonWidth;
      FCustomButtons.Items[i].Btn.Height := FPaintRect.Bottom - FPaintRect.Top;
      FCustomButtons.Items[i].Btn.Left := FPaintRect.Right + i * (FCustomButtonWidth);
      if lCorrection then
        with FCustomButtons.Items[i].Btn do
          Height := Height - 2;
    end;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDCustomEdit.CreateSpecialText(var s : TLMDString);
var
  i : LongInt;
begin
  s := '';
  if FPasswordChar = #0 then
    s := FText
  else
  begin
    SetLength(s, Length (FText));
    for i := 1 to Length (FText) do
      s[i] := TLMDChar(FPasswordChar);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineProperty('CustomButtonStyle', ReadOldBtnStyle, nil, false);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.ChangedText (At : Integer);
begin
  FIsEmpty := false;
  CreateSpecialText (FSpecialText);
  inherited ChangedText(At);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.FinishedSetSelText;
begin
  inherited FinishedSetSelText;
  if Assigned (FAutoComplete) then FAutoComplete.autoCompleteText (self, Text);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.HandleInsertText (at : Integer;var aValue : TLMDString);
begin
  inherited HandleInsertText (at, aValue);
  {if Alignment in [taRightJustify, taCenter] then
  begin
  end;}
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.SetCueBanner(const Value: TLMDString);
begin
  if FCueBanner <> Value then
    begin
      FCueBanner := Value;
      Invalidate;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.PaintCueBanner(Canvas: TCanvas);
var
  LDetails: TThemedElementDetails;
  LOldColor: TColor;
  LDrawRect: TRect;
  LAddVistaBorder: Integer;
  BkMode: integer;
begin
  LDetails.Element := teEdit;
  LDetails.Part := EP_EDITTEXT;
  LDetails.State := 8;

  LDrawRect.Left := FTextRect.Left;
  LDrawRect.Top  := FTextRect.Top;
  LDrawRect.Right := FTextRect.Right;
  LDrawRect.Bottom := FTextRect.Bottom;
  BkMode := SetBkMode(canvas.handle, 1 {TRANSPARENT});
  if IsThemed and LMDSIWindowsVistaUp then
  begin
    LAddVistaBorder := 0;
    //if not Multiline then
    //  LAddVistaBorder := GetSystemMetrics(smXEdge[Ctl3D]);
    Inc(LDrawRect.Left, LAddVistaBorder);
    Inc(LDrawRect.Top, LAddVistaBorder);
    LMDThemeServices.DrawThemeText(UseThemeMode, Canvas.Handle, LDetails, FCueBanner, Length(FCueBanner), 0, 0, LDrawRect);
  end
  else
  begin
    LOldColor := Canvas.Font.Color;
    Canvas.Font.Color := clGray;
    LMDExtTextOut(Canvas, LDrawRect.Left, LDrawRect.Top, ETO_CLIPPED, @LDrawRect, FCueBanner, Length(FCueBanner));
    Canvas.Font.Color := LOldColor;
  end;
  SetBkMode(canvas.handle, BkMode);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.RedefineTextColor(C: TCanvas);
begin
  // Do nothing.
end;

function TLMDCustomEdit.RedrawOnEnter: Boolean;
begin
  result := Length(FCueBanner) <> 0;
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.RedrawOnExit: Boolean;
begin
  result := (IsThemed and Flat) or (Length(FCueBanner) <> 0);
end;

{ ---------------------------------------------------------------------------- }
function TLMDCustomEdit.ShowCueBanner: boolean;
begin
  result := (Text = '');
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDCustomEdit.GetIMLChange(Sender: TObject);
var
  i: integer;
begin
  inherited;
  for i := 0 to CustomButtons.Count - 1 do
    begin
      if ImageList <> nil then
        if (FCustomButtons.Items[i].ImageIndex > ImageList.Count - 1) then
          FCustomButtons.Items[i].ImageIndex := -1;
      FCustomButtons.Items[i].ImageList := ImageList;
    end;
end;


end.

