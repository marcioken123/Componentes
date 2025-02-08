unit LMDButtonListData;
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

LMDButtonListData unit (RM)
---------------------------

ToDo: Drawing of custom CheckBoxes/RadioButtons

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}
interface

uses
  Graphics, Messages, Classes,  Dialogs, Controls, Windows, StdCtrls,
  LMDCustomImageListBox, LMDClass;

type

  TLMDButtonListMode=(blCheckBox, blCheckBox3State, blRadioButton);

  // for reuse in ComboBox version...
  {********************* TLMDButtonListData ***********************************}
  TLMDButtonListData=class
  private
    FData    : TObject;//LongInt;
    FState   : TCheckBoxState;
    FDisabled: Boolean;
    procedure SetChecked(Check: Boolean);
    function GetChecked: Boolean;
  public
    class function GetDefaultState: TCheckBoxState;
    property Data:TObject read FData write FData;
    property Checked: Boolean read GetChecked write SetChecked;
    property State: TCheckBoxState read FState write FState;
    property Disabled: Boolean read FDisabled write FDisabled;
  end;

procedure LMDDrawButtonListItem(Control: TWinControl; Canvas:TCanvas;r:TRect;aState: TCheckBoxState; BtnMode:TLMDButtonListMode;
                                aEnabled:Boolean; BtnFlat:Boolean=False; BtnDefault:Boolean=True; BtnXPTheme: TLMDThemeMode = ttmPlatform);
// Bitmask helper
function LMDBtnMakeSaveState(State: TCheckBoxState; Disabled: Boolean): TObject;
function LMDBtnGetSaveState(aObject: TObject): TCheckBoxState;
function LMDBtnGetSaveDisabled(aObject: TObject): Boolean;

implementation

uses
  Types, Consts,
  Themes, {$IFDEF LMDCOMP16}System.UITypes,{$endif}
  LMDThemes,LMDUtils, LMDGraph, LMDGraphUtils;

{------------------------------------------------------------------------------}
function LMDBtnMakeSaveState(State: TCheckBoxState; Disabled: Boolean): TObject;
begin
  Result := TObject(integer((Byte(State) shl 16) or Byte(Disabled)));
end;

{------------------------------------------------------------------------------}
function LMDBtnGetSaveState(aObject: TObject): TCheckBoxState;
begin
  Result := TCheckBoxState(Byte(Integer(AObject) shr 16));
end;

{------------------------------------------------------------------------------}
function LMDBtnGetSaveDisabled(aObject: TObject): Boolean;
begin
  Result := Boolean(Integer(AObject) and $FF);
end;

{------------------------------------------------------------------------------}
procedure LMDDrawButtonListItem(Control: TWinControl; Canvas:TCanvas;r:TRect;aState: TCheckBoxState; BtnMode:TLMDButtonListMode;
                                aEnabled:Boolean; BtnFlat:Boolean=False; BtnDefault:Boolean=True; BtnXPTheme: TLMDThemeMode = ttmPlatform);
var
  DrawState: Integer;
  DrawRect: TRect;
  OldBrushColor: TColor;
  OldBrushStyle: TBrushStyle;
  OldPenColor: TColor;
  Rgn, SaveRgn: HRgn;
  FCheckWidth, FCheckHeight:Integer;
  stateId : Integer;
  button  : TThemedButton;
  lThemeMode: TLMDThemeMode;
begin
  lThemeMode := LMDThemeServices.UseTheme(BtnXPTheme);
  if BtnDefault then
    begin
      FCheckWidth:=LMDApplication.CheckDefWidth;
      FCheckHeight:=LMDApplication.CheckDefHeight;
    end
  else
    begin
      // add custom width here
      FCheckWidth:=LMDApplication.CheckCustomWidth;
      FCheckHeight:=LMDApplication.CheckCustomHeight;
    end;

  SaveRgn := 0;
  DrawRect.Left := R.Left + (R.Right - R.Left - FCheckWidth) div 2;
  DrawRect.Top := R.Top + (R.Bottom - R.Top - FCheckHeight) div 2;
  DrawRect.Right := DrawRect.Left + FCheckWidth;
  DrawRect.Bottom := DrawRect.Top + FCheckHeight;

  if BtnDefault or (not Assigned(LMDApplication.CheckBitmap)) then
    begin
      if not (lThemeMode = ttmNone) then
        begin
          if BtnMode=blRadioButton then
            case AState of
              cbChecked: button := tbRadioButtonCheckedNormal;
              cbUnchecked: button := tbRadioButtonUncheckedNormal;
            else
              button := tbRadioButtonCheckedNormal;
            end
          else
            case AState of
              cbChecked: button := tbCheckBoxCheckedNormal;
              cbUnchecked: button := tbCheckBoxUncheckedNormal;
            else
              button := tbCheckBoxMixedNormal;
            end;
          LMDThemeServices.DrawElement(lThemeMode, Canvas.Handle, button, DrawRect);
          exit;
        end;

      case AState of
        cbChecked:
          if BtnMode in [blCheckBox, blCheckBox3State] then
            DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED
          else
            DrawState := DFCS_BUTTONRADIO or DFCS_CHECKED;
        cbUnchecked:
          if BtnMode in [blCheckBox, blCheckBox3State] then
            DrawState := DFCS_BUTTONCHECK
          else
            DrawState := DFCS_BUTTONRADIO;
        else // cbGrayed
          DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
      end;
      if not AEnabled then
        DrawState := DrawState or DFCS_INACTIVE;

      with Canvas do
        begin
          if BtnFlat then
            if BtnMode in [blCheckBox, blCheckBox3State] then
              begin
                SaveRgn := CreateRectRgn(0,0,0,0);
                GetClipRgn(Handle, SaveRgn);
                with DrawRect do
                  Rgn := CreateRectRgn(Left + 2, Top + 2, Right - 2, Bottom - 2);
                SelectClipRgn(Handle, Rgn);
                DeleteObject(Rgn);
              end
            else
              DrawState := DrawState or DFCS_FLAT;
          DrawFrameControl(Handle, DrawRect, DFC_BUTTON, DrawState);
          if BtnFlat and (BtnMode in [blCheckBox, blCheckBox3State]) then
            begin
              SelectClipRgn(Handle, SaveRgn);
              DeleteObject(SaveRgn);
              OldBrushStyle := Brush.Style;
              OldBrushColor := Brush.Color;
              OldPenColor := Pen.Color;
              Brush.Style := bsClear;
              Pen.Color := clBtnShadow;
              with DrawRect do
                Rectangle(Left + 1, Top + 1, Right - 1, Bottom - 1);
              Brush.Style := OldBrushStyle;
              Brush.Color := OldBrushColor;
              Pen.Color := OldPenColor;
            end;
        end;
    end
  else
    begin
      stateID:=(Ord(aState)*2)+(1-Ord(aEnabled));
      LMDBmpDrawExt(Canvas, DrawRect,LMDApplication.CheckBitmap.Canvas, Rect(stateID*FCheckWidth,0,(stateID+1)*FCheckWidth,FCheckHeight), DSF_TRANSPARENCY, LMDApplication.CheckBitmap.TransparentColor, 0, nil)
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDButtonListData.SetChecked(Check: Boolean);
begin
  if Check then FState := cbChecked else FState := cbUnchecked;
end;

{------------------------------------------------------------------------------}
function TLMDButtonListData.GetChecked: Boolean;
begin
  Result := FState = cbChecked;
end;

{------------------------------------------------------------------------------}
class function TLMDButtonListData.GetDefaultState: TCheckBoxState;
begin
  Result := cbUnchecked;
end;

end.
