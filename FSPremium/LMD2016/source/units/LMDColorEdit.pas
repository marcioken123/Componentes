unit LMDColorEdit;
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

LMDColorEdit unit ()
--------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Graphics, Dialogs, Types,
  LMDClass, LMDCustomBrowseEdit;

type
  { ----------------------- TLMDColorEdit ------------------------------------ }
  TLMDColorEditPaint = (ceText, ceColoredText, ceTextColor, ceColorText, ceColor);

  TLMDColorEdit = class(TLMDCustomBrowseEdit)
  private
    FOptions      : TColorDialogOptions;
    FCustomColors : TStrings;
    FPaint        : TLMDColorEditPaint;
    FColorBarHeight,
    FColorBarWidth: Integer;

    procedure SetCustomColors (aValue : TStrings);
    procedure SetPaintStyle (aValue : TLMDColorEditPaint);
    procedure SetInteger (index : Integer; aValue : Integer);
    function GetSelColor : TColor;
    procedure SetColor(aValue : TColor);
  protected
    procedure DoBrowse; override;
    procedure DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect); override;
    procedure DrawEditText(from : Integer); override;
    procedure ModifyTextRect; override;
  public
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;

  published
    property Options : TColorDialogOptions read FOptions write FOptions default [];
    property CustomColors : TStrings read FCustomColors write SetCustomColors;
    property ColorBarWidth : Integer index 0 read FColorBarWidth write SetInteger default 30;
    property ColorBarHeight : Integer index 1 read FColorBarHeight write SetInteger default -1;
    property PaintStyle : TLMDColorEditPaint read FPaint write SetPaintStyle default ceText;
    property SelectedColor : TColor read GetSelColor write SetColor;
  end;

  TLMDLabeledColorEdit = class(TLMDColorEdit)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property LabelPosition;
    property LabelSpacing;
    property LabelSync;
    property EditLabel;
  end;

implementation
uses
  Forms, SysUtils, Themes,
  LMDButtonBase, LMDBase, LMDThemes;

{ ---------------------------------- private --------------------------------- }
procedure TLMDColorEdit.SetCustomColors (aValue : TStrings);
begin
  FCustomColors.Assign (aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorEdit.SetPaintStyle (aValue : TLMDColorEditPaint);
begin
  if aValue <> FPaint then
    begin
      FPaint := aValue;
      case FPaint of
        ceColor : ReadOnly := true;
      end;
      GetChange(nil);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorEdit.SetInteger (index, aValue : Integer);
begin
  case index of
    0 : if aValue <> FColorBarWidth then
          begin
            FColorBarWidth := aValue;
            GetChange(nil);
          end;
    1 : if aValue <> FColorBarHeight then
          begin
            FColorBarHeight := aValue;
            GetChange(nil);
          end;
  end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDColorEdit.GetSelColor : TColor;
begin
  try
    if Text <> '' then
      result := StringToColor (Text)
    else
      begin
        Text := 'clRed';
        result := clRed;
      end;
  except
    Text := 'clRed';
    result := clRed;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorEdit.SetColor(aValue : TColor);
begin
  Text := ColorToString (aValue);
end;

{ ---------------------------------- protected ------------------------------- }
procedure TLMDColorEdit.DoBrowse;
var
  cd : TColorDialog;
begin
  cd := TColorDialog.Create (Application);
  try
    cd.Options := FOptions;
    cd.CustomColors.Assign (FCustomColors);
    try
      cd.Color:=StringToColor(Text);
    except
      On Exception do ;
    end;
    if Assigned (OnBeforeBrowse) then OnBeforeBrowse (cd);
    if cd.Execute then
      begin
        Text := ColorToString (cd.Color);
        if Assigned(OnDlgChange) then OnDlgChange(self);
      end;
    if Assigned(OnBrowse) then OnBrowse(cd);
  finally
    cd.Free;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorEdit.DrawThemeBevel(aTheme: TLMDThemeMode; aCanvas: TCanvas; aRect: TRect);
var
  box : TThemedEdit;
begin
  //control always is "read only"!!
  box := teEditTextNormal;
  if Focused then box := teEditTextFocused;
  if MouseAbove then box := teEditTextHot;
  //if GetReadOnly then box := teEditTextReadOnly;
  if not Enabled then box := teEditTextDisabled;
  LMDThemeServices.DrawElement(aTheme, aCanvas.Handle, box, aRect);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorEdit.ModifyTextRect;
begin
  inherited ModifyTextRect;
  case FPaint of
    ceText, ceColoredText:; //do nothing
    ceColorText : Inc (FTextRect.Left, FColorBarWidth);
    ceTextColor : Dec (FTextRect.Right, FColorBarWidth);
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDColorEdit.DrawEditText(from : Integer);
var
  OldFontColor : TColor;
  i : Integer;
begin
  OldFontColor := Font.Color;
  Font.OnChange := nil;
  if FPaint = ceColoredText then
    try
      if Text <> '' then
        Font.Color := StringToColor (Text)
      else
        begin
          Text := 'clRed';
          Font.Color := clRed;
        end;
    except
      Text := 'clRed';
      Font.Color := clRed;
    end;

  inherited DrawEditText(from);

  if csLoading in ComponentState then exit;
  try

    try
      if Text <> '' then
        Canvas.Brush.Color := StringToColor (Text)
      else
        begin
          Text := 'clRed';
          Canvas.Brush.Color := clRed;
        end;
    except
      Text := 'clRed';
      Canvas.Brush.Color := clRed;
    end;

    if FColorBarHeight = -1 then
      i := FPaintRect.Bottom - FPaintRect.Top
    else
      i := FColorBarHeight;
    case FPaint of
      ceColorText : with FPaintRect do
                       Canvas.Rectangle (Left, Top, Left + FColorBarWidth, Top + i);
      ceTextColor : with FPaintRect do
                       Canvas.Rectangle (Right - FColorBarWidth, Top, Right, Top + i);
      ceColor : with FPaintRect do
                   Canvas.Rectangle (Left, Top, Right, Top + i);
    end;
  finally
    Font.Color := OldFontColor;
    Font.OnChange := GetChange;
  end;
end;

{ ---------------------------------- public ---------------------------------- }
constructor TLMDColorEdit.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  LMDGetGlyphKind(CustomButtons.Items[0].Glyph, gkColor);
  FCustomColors := TStringList.Create;
  FColorBarWidth := 30;
  FColorBarHeight := -1;
  FPaint := ceText;
  ReadOnly := true;
  FOptions := [];
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDColorEdit.Destroy;
begin
  FCustomColors.Free;
  inherited Destroy;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledColorEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
