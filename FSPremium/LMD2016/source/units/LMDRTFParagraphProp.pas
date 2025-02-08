unit LMDRTFParagraphProp;
{$I LMDCmps.inc}

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

LMDRTFParagraphProp unit (RM)
-----------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Buttons,
  {$ifdef LMDCOMP16}
  UITypes,
  {$endif}
  LMDRTFRichEdit;

type
{ **************************  TfrmParagraph  ***************************** }
  TLMDRichfrmParagraph = class(TForm)
    btnTabstops: TButton;
    btnCancel: TButton;
    btnOK: TButton;
    lblJustify: TLabel;
    lblHeading: TLabel;
    Bevel1: TBevel;
    lblMargins: TLabel;
    lblLeftMargin: TLabel;
    lblRightMargin: TLabel;
    lblFirstLine: TLabel;
    lblIndentAt: TLabel;
    Bevel2: TBevel;
    lblIntervals: TLabel;
    lblBefore: TLabel;
    lblAfter: TLabel;
    lblLineSpacing: TLabel;
    lblValue: TLabel;
    cbxJustify: TComboBox;
    cbxHeading: TComboBox;
    edtLeftMargin: TEdit;
    edtRightMargin: TEdit;
    udLeftMargin: TUpDown;
    udRightMargin: TUpDown;
    cbxIndent: TComboBox;
    edtIndentAt: TEdit;
    udIndentAt: TUpDown;
    edtBeforeInterval: TEdit;
    edtAfterInterval: TEdit;
    udBeforeInterval: TUpDown;
    udAfterInterval: TUpDown;
    cbxLineSpacing: TComboBox;
    edtLineSpacingValue: TEdit;
    udLineSpacingValue: TUpDown;
    Bevel3: TBevel;
    procedure cbxShadingColorDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure FormCreate(Sender: TObject);
    procedure cbxShadingStyleDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbxJustifyDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbxHeadingDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure cbxIndentChange(Sender: TObject);
    procedure cbxLineSpacingChange(Sender: TObject);
    procedure edtDigitsKeyPress(Sender: TObject; var Key: Char);
    procedure udLeftMarginChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
  private
  public
    { Public declarations }
    class function Execute(aParagraph: TLMDParaAttributes; aRichEdit: TLMDCustomRichEdit): Boolean;
  end;

implementation
uses
  LMDRTFConst, LMDRTFTabsProp, LMDRTFBase, LMDConversion;

{$R *.DFM}

{ **************************  TfrmParagraph  ***************************** }
{ ------------------------------------------------------------------------- }
function ColorToBorderColor(aColor: TColor; aState: TOwnerDrawState): TColor;

type
  TColorQuad = record
    Red, Green, Blue, Alpha: Byte;
  end;

begin

  if (TColorQuad(AColor).Red > 192) or (TColorQuad(AColor).Green > 192) or
    (TColorQuad(AColor).Blue > 192) then
    Result:= clBlack
  else

    if (odSelected in aState) then
      Result:= clWhite
    else
      Result:= AColor;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichfrmParagraph.cbxJustifyDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  ShapeWidth = 16;
var
  ARect: TRect;
  Text: array[0..255] of Char;
  Bmp: TBitmap;
  Size : Integer;
begin
  ARect:= Rect;
  Inc(ARect.Top, 1);
  Inc(ARect.Left, 2);
  ARect.Right:= ARect.Left + ShapeWidth;
  ARect.Bottom:= ARect.Top + ShapeWidth;
  with (Control as TComboBox).Canvas do
    begin
      FillRect(Rect);
      Pen.Color:= ColorToBorderColor(ColorToRGB(clBlack), State);
      Bmp:= TBitmap.Create;
      try
        Bmp.LoadFromResourceName(HInstance, 'LMDRTFJUSTIFY_' + IntToStr(Index));
        Draw(aRect.Left, aRect.Top, Bmp);
      finally
        Bmp.Free;
      end;
    StrPCopy(Text, TComboBox(Control).Items[Index]);
      Size := StrLen(Text);
    Rect.Left:= Rect.Left + ShapeWidth + 6;
      DrawText(Handle, Text, Size, Rect, DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX));
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichfrmParagraph.cbxHeadingDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Text: array[0..255] of Char;
  Size: Integer;
begin
  with TComboBox(Control).Canvas do
    begin
      FillRect(Rect);
    StrPCopy(Text, TComboBox(Control).Items[Index]);
      Size := StrLen(Text);
    Rect.Left:= Rect.Left + 2;
      DrawText(Handle, Text, Size, Rect,
        DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX));
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichfrmParagraph.cbxShadingColorDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  ColorWidth = 16;
var
  ARect: TRect;
  Text: array[0..255] of Char;
  Size: Integer;
  Safer: TColor;
begin
  ARect:= Rect;
  Inc(ARect.Top, 2);
  Inc(ARect.Left, 2);
  Dec(ARect.Bottom, 2);
  ARect.Right:= ARect.Left + ColorWidth;
  with TComboBox(Control).Canvas do
    begin
      FillRect(Rect);
      Safer:= Brush.Color;
      Pen.Color:=
        ColorToBorderColor(ColorToRGB(TColor(TComboBox(Control).Items.Objects[Index])), State);
      Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      if TColor(TComboBox(Control).Items.Objects[Index]) <> clNone then
        Brush.Color:= TColor(TComboBox(Control).Items.Objects[Index])
      else
        Brush.Color:= clWindow;
      try
        InflateRect(ARect, -1, -1);
        FillRect(ARect);
      finally
        Brush.Color:= Safer;
      end;
    StrPCopy(Text, TComboBox(Control).Items[Index]);
      Size := StrLen(Text);
    Rect.Left:= Rect.Left + ColorWidth + 6;
      DrawText(Handle, Text, Size, Rect, DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX));
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichfrmParagraph.cbxIndentChange(Sender: TObject);
begin
  edtIndentAt.Enabled:= cbxIndent.ItemIndex <> 0;

  if  cbxIndent.ItemIndex = 2 then
    udIndentAt.Max := udLeftMargin.Position
  else
    udIndentAt.Max := 1000;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichfrmParagraph.cbxLineSpacingChange(Sender: TObject);
begin
  edtLineSpacingValue.Enabled:= cbxLineSpacing.ItemIndex > 2
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichfrmParagraph.cbxShadingStyleDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  ShapeWidth = 16;
var
  ARect: TRect;
  Text: array[0..255] of Char;
  Size: Integer;
  Bmp: TBitmap;
begin
  ARect:= Rect;
  Inc(ARect.Top, 1);
  Inc(ARect.Left, 2);
  ARect.Right:= ARect.Left + ShapeWidth;
  ARect.Bottom:= ARect.Top + ShapeWidth;
  with TComboBox(Control).Canvas do
    begin
      FillRect(Rect);
      Pen.Color:= ColorToBorderColor(ColorToRGB(clBlack), State);
      Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      InflateRect(ARect, -1, -1);
      if Index <> 0 then
        begin
          Bmp:= TBitmap.Create;
          try
            Bmp.LoadFromResourceName(HInstance, 'LMDRTFSHAPE_' + IntToStr(Index));
            Draw(aRect.Left, aRect.Top, Bmp);
          finally
            Bmp.Free;
          end;
        end;
    StrPCopy(Text, TComboBox(Control).Items[Index]);
      Size := StrLen(Text);
    Rect.Left:= Rect.Left + ShapeWidth + 6;
      DrawText(Handle, Text, Size, Rect, DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX));
    end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRichfrmParagraph.FormCreate(Sender: TObject);

  {procedure InitColorCombo(aCombo: TComboBox);
  const
    ColorValues: array[0..16] of TColor = (clNone,
      clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray,
      clSilver, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);
  var
    I: Integer;
  begin
    aCombo.Items.BeginUpdate;
    try
      aCombo.Items.Clear;
      for I:= 0 to 16 do
        begin
          aCombo.Items.AddObject(Copy(ColorToString(ColorValues[I]), 3, MaxInt),
            TObject(ColorValues[I]));
        end;
    finally
      aCombo.Items.EndUpdate;
      aCombo.ItemIndex:= 0;
    end;
  end;}

begin
  cbxJustify.ItemIndex:= 0;
  cbxLineSpacing.ItemIndex:= 0;

  Caption:= IDRTF_PARAGRAPH;
  lblJustify.Caption:= IDRTF_JUSTIFY;
  cbxJustify.Items.CommaText:= IDRTF_JUSTIFIES;
  //lblHeading.Caption:= IDRTF_HEADING;
  //cbxHeading.Items.CommaText:= IDRTF_HEADINGS;

  lblMargins.Caption:= IDRTF_MARGINS;
  lblLeftMargin.Caption:= IDRTF_LEFT;
  lblRightMargin.Caption:= IDRTF_RIGHT;
  lblFirstLine.Caption:= IDRTF_FIRSTLINE;
  lblIndentAt.Caption:= IDRTF_INDENTAT;
  cbxIndent.Items.CommaText:= IDRTF_INDENTS;

  lblIntervals.Caption:= IDRTF_INTERVALS;
  lblBefore.Caption:= IDRTF_BEFORE;
  lblAfter.Caption:= IDRTF_AFTER;
  lblLineSpacing.Caption:= IDRTF_LINESPACING;
  cbxLineSpacing.Items.CommaText:= IDRTF_SPACINGS;
  lblValue.Caption:= IDRTF_VALUE;

  btnTabstops.Caption:= IDRTF_TABSTOPS;
  btnOK.Caption:= IDRTF_OK;
  btnCancel.Caption:= IDRTF_CANCEL;
end;

{ ------------------------------------------------------------------------- }

class function TLMDRichfrmParagraph.Execute(aParagraph: TLMDParaAttributes;
  aRichEdit: TLMDCustomRichEdit): Boolean;
type
  TConvertFunc = function(aValue: double): double;
var
  CnvFrom, CnvTo: TConvertFunc;
  Ratio: integer;

  function  ConvertTo(aPointsValue: integer): integer;
  begin
    if  aPointsValue = 0  then
      Result := 0
    else
    if  Assigned(CnvTo) then
      Result := Round(CnvTo(aPointsValue) * Ratio)
    else
      Result := aPointsValue * Ratio;
  end;

  function  ConvertFrom(aSomeValue: integer): integer;
  begin
    if  aSomeValue = 0  then
      Result := 0
    else
    if  Assigned(CnvFrom) then
      Result := Round(CnvFrom(aSomeValue / Ratio))
    else
      Result := aSomeValue div Ratio;
  end;

const
  AlignArray: array [0..Ord(High(TLMDParaAlignment))] of TLMDParaAlignment =
  (paLeftJustify, paCenter, paRightJustify{, paJustify});
  AlignArrayBack: array[TLMDParaAlignment] of LongInt = (0, 2, 1{, 3});
var
  S: string;
var
  T: TLMDRichfrmParagraph;
  I: integer;
begin
  if Assigned(aRichEdit) then
    begin
      T := TLMDRichfrmParagraph.Create(aRichEdit);
      aRichEdit.PrepareDialog(t);
    end
  else
    T := TLMDRichfrmParagraph.Create(Application);

  CnvFrom := nil;
  CnvTo := nil;
  Ratio := 1;
  S := LMDUnitsToString(aRichEdit.Measurement);
  T.Caption := Format('%s  (%s)', [IDRTF_PARAGRAPH, S]);
(*
  case  aRichEdit.Measurement of
    unPoints:
      begin
        S := 'Points';
      end;
    unInches:
      begin
        S := 'Inches x 100';
//        Ratio := 10;
//        CnvFrom := LMDRichInchesToPoints;
//        CnvTo := LMDRichPointsToInches;
      end;
    unMillimeters:
      begin
        S := 'Millimeters';
//        CnvFrom := LMDRichMillimetersToPoints;
//        CnvTo := LMDRichPointsToMillimeters;
      end;
  end;
*)
//  T.lblMargins.Caption := Format('%s (%s) ', [IDRTF_MARGINS, S]);

  { Indents & Justify }
  T.cbxJustify.ItemIndex:= AlignArrayBack[aParagraph.Alignment];
  //T.cbxHeading.ItemIndex:= aParagraph.HeadingStyle;
  T.udLeftMargin.Position:= aParagraph.LeftIndent;
  T.udRightMargin.Position:= aParagraph.RightIndent;
{
  T.udLeftMargin.Position:= ConvertTo(aParagraph.FirstIndent + aParagraph.LeftIndent);
  T.udRightMargin.Position:= ConvertTo(aParagraph.RightIndent);
}
  T.cbxLineSpacing.ItemIndex:= Ord(aParagraph.LineSpacingRule);
  T.udLineSpacingValue.Position:= ConvertTo(aParagraph.LineSpacing);
  if aParagraph.FirstIndent > 0 then
    T.cbxIndent.ItemIndex:= 1
  else if aParagraph.FirstIndent < 0 then
    T.cbxIndent.ItemIndex:= 2
  else
    T.cbxIndent.ItemIndex := 0;
  T.udIndentAt.Position := Abs(aParagraph.FirstIndent);
  T.cbxIndentChange(nil);
  T.udBeforeInterval.Position := ConvertTo(aParagraph.SpaceBefore);
  T.udAfterInterval.Position := ConvertTo(aParagraph.SpaceAfter);
  T.cbxLineSpacingChange(nil);

  case T.ShowModal of
    mrOK:
      begin
       { Indents & Justify }
        aParagraph.Alignment:= AlignArray[T.cbxJustify.ItemIndex];
        //aParagraph.HeadingStyle:= T.cbxHeading.ItemIndex;
        if  T.cbxIndent.ItemIndex = 1 then
          I := T.udIndentAt.Position
        else
        if  T.cbxIndent.ItemIndex = 2 then
          I := -T.udIndentAt.Position
        else
          I := 0;
        aParagraph.SetParagraphIndent(T.udLeftMargin.Position, I);
//        aParagraph.FirstIndent:= ConvertFrom(T.udLeftMargin.Position -
//          aParagraph.LeftIndent);
        aParagraph.RightIndent:= ConvertFrom(T.udRightMargin.Position);
//        if T.cbxIndent.ItemIndex = 1 then
//          aParagraph.LeftIndent:= -ConvertFrom(T.udIndentAt.Position)
{
        else if T.cbxIndent.ItemIndex = 2 then
          aParagraph.LeftIndent:= ConvertFrom(T.udIndentAt.Position)
        else
          aParagraph.LeftIndent:= 0;
}
        aParagraph.SpaceBefore:= ConvertFrom(T.udBeforeInterval.Position);
        aParagraph.SpaceAfter:= ConvertFrom(T.udAfterInterval.Position);
        aParagraph.LineSpacingRule:=
          TLMDLineSpacingRule(T.cbxLineSpacing.ItemIndex);
        if T.cbxLineSpacing.ItemIndex > 2 then
          aParagraph.LineSpacing:= ConvertFrom(T.udLineSpacingValue.Position);
        Result:= true;
      end;
    mrCancel:
      Result:= false; { nothing to do }
    mrYes:
      Result:= TLMDRichfrmTabs.Execute(aParagraph, aRichEdit);
  else
    Result:= false;
  end;
  T.Free;
end;

procedure TLMDRichfrmParagraph.edtDigitsKeyPress(Sender: TObject;
  var Key: Char);
begin
  if  AnsiChar(Key) in ['0'..'9', chr(VK_BACK)] then
  else
    Key := #0;
end;

procedure TLMDRichfrmParagraph.udLeftMarginChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  if  (cbxIndent.ItemIndex = 2) and (NewValue >= 0) then
    begin
      if  NewValue < udIndentAt.Position  then
        udIndentAt.Position := NewValue;

      udIndentAt.Max := NewValue;
    end;
end;

end.
