unit LMDCustomColorListBox;
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

LMDCustomColorListBox unit ()
-----------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics, Messages, Classes, Dialogs, Controls, Windows, StdCtrls,
  LMDCustomColorComboBox, LMDCustomImageListBox;

type

  TLMDCustomColorListBox = class(TLMDCustomDerivedImageListBox)
  private
    FCounter:Integer;
    // 6.1
    FCustomMode:Boolean;
    // ---
    FCustomColors:TStringList;
    FOptions:TLMDColorCBOptions;
    FDisplayStyle:TLMDColorCBStyle;
    FDlgOptions:TColorDialogOptions;
    FOnEnterDialog,
    FOnFinishedDialog:TLMDOnColorDialogEvent;
    FContext:THelpContext;
    procedure GetChange(Sender:TObject);reintroduce;
    procedure FillColorList(const S:String);
    function GetCustomColors:TStrings;
    function GetSelectedColor:TColor;
    function GetSelectedColorName:String;
    function GetColor(index:Integer):TColor;
    function GetColorName(index:Integer):String;
    procedure SetCustomMode(aValue:Boolean);
    procedure SetCustomColors(aValue:TStrings);
    procedure SetDisplayStyle(aValue:TLMDColorCBStyle);
    procedure SetOptions(aValue:TLMDColorCBOptions);
    procedure SetSelectedColor(aValue:TColor);
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
  protected
    procedure CreateColorList; virtual;
    procedure DrawItem(Index:Integer; aRect:TRect; State:TOwnerDrawState);override;
    function GetColorValue:TColor;virtual;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
    procedure Loaded;override;
    procedure DoSelect; override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function Execute:Boolean;  {Execute Dialog}
    function ExecuteEnh(aList:TStrings):Boolean;
    // 7.0
    procedure Init;
    // ---
    procedure LoadCustomColors(IniFile:TObject; const Section:String);
    procedure SaveCustomColors(IniFile:TObject; const Section:String);
    property Colors[index:Integer]:TColor read GetColor;
    property CtlXP; // compatibility
    // 6.1
    property ColorName[index:Integer]:String read GetColorName;
    property SelectedColorName:String read GetSelectedColorName;
    // ---
    property SelectedColor:TColor read GetSelectedColor write SetSelectedColor;
    property Text;
  published
    property About;
    property CustomMode:Boolean read FCustomMode write SetCustomMode default false;
    property CustomColors:TStrings read GetCustomColors write SetCustomColors;
    property DlgOptions:TColorDialogOptions read FDlgOptions write FDlgOptions;
    property DlgHelpContext:THelpContext read FContext write FContext;
    property DisplayStyle:TLMDColorCBStyle read FDisplayStyle write SetDisplayStyle
                                           default csColorText;
    property Options:TLMDColorCBOptions read FOptions write SetOptions
                                        default [coDefaultColors, coAllowAnyColor];
    property Color;
    property Ctl3D;

    property DragMode;
    property DragCursor;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;

    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property Sorted;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    {Events}
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
    property OnStartDrag;

    property OnBeforeDialogShow:TLMDOnColorDialogEvent read FOnEnterDialog write FOnEnterDialog;
    property OnAfterDialogShow:TLMDOnColorDialogEvent read FOnFinishedDialog write FOnFinishedDialog;

    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
  end;

implementation
uses
  Types, SysUtils, Consts,
  LMDGraph, LMDStrings, LMDUtils, LMDGraphUtils;

{******************** Class TLMDCustomColorListBox ***************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDCustomColorListBox.GetChange(Sender:TObject);
var
  dummy:Boolean;
  old:TColor;

begin
  if Sender=FCustomColors then
    CreateColorList
  else
    begin
      dummy:=False;

      old:=-1;
      if Text<>'' then
        begin
          old:=GetSelectedColor;
          dummy:=True;
        end;

      RecreateWnd;
      if Dummy then SetSelectedColor(old);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.FillColorList(const S:String);
begin
  if s<>'clNone' then
    begin
      case FCounter of
        0..15: if coDefaultColors in FOptions then Items.Add(S);
      else
        if (coSystemColors in FOptions) then Items.Add(S);
      end;
    end;
  Inc(FCounter);
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.GetColor(index:Integer):TColor;
var
  data:String;
begin
  if FCustomMode and (pos('=', Items[Index])>0) then
    data:=Items.Values[items.Names[Index]]
  else
  begin  
    if Items[Index] = '-' then
      data := 'clNone'
    else
      data := Items[Index];
  end;
  try
    result:=StringToColor(data);
  except
    result:=-1;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.GetColorName(index:Integer):String;
begin
  if FCustomMode and (pos('=', Items[Index])>0) then
    result:=Items.Names[Index]
  else
    result:=Items[Index];
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.GetSelectedColorName:String;
begin
  result:='';
  if ItemIndex>-1 then
    begin
      if FCustomMode and (pos('=', Items[ItemIndex])>0) then
        result:=Items.Names[ItemIndex]
      else
        result:=Items[ItemIndex];
    end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.GetCustomColors:TStrings;
begin
  result:=FCustomColors;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.GetSelectedColor:TColor;
var
  data:String;
begin
  result:=-1;
  If ItemIndex = -1 then exit;
  data:=Items[ItemIndex];
  if FCustomMode and (pos('=', data)>0) then
    data:=LMDAnsiGetSecondString(data, '=');
  try
    result:=StringToColor(data);
  except
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.SetCustomMode(aValue:Boolean);
begin
  if aValue<>FCustomMode then
    begin
      FCustomMode:=aValue;
      if not (csLoading in ComponentState) then
        GetChange(FCustomColors);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.SetCustomColors(aValue:TStrings);
var
  ColorPrefix, ColorTags, Value:String;
  i:Integer;

begin
  if FCustomMode then
    FCustomColors.Assign(aValue)
  else
    begin
      FCustomColors.OnChange:=nil;
      try
        FCustomColors.Clear;
        ColorPrefix := SColorPrefix;
        ColorTags := SColorTags;
        for I := 0 to MaxCustomColors - 1 do
          begin
            Value := aValue.Values[ColorPrefix + ColorTags[I + 1]];
            if Value <> '' then
              begin
                try
                  value:=copy(value, 1,6);
                  StrToInt(value);
                  FCustomColors.Values[ColorPrefix + ColorTags[I + 1]]:=value;
                except
                  on exception do ;
                end;
              end;
          end;
        CreateColorList;
      finally
        FCustomColors.OnChange:=GetChange;
      end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.SetDisplayStyle(aValue:TLMDColorCBStyle);
begin
  if aValue<>FDisplayStyle then
    begin
      FDisplayStyle:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.SetOptions(aValue:TLMDColorCBOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      if not FCustomMode then
        CreateColorList;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.SetSelectedColor(aValue:TColor);
var
  temp:String;
  i:Integer;
begin
  if FCustomMode then
    begin
      if aValue=SelectedColor then exit;
      for i:=0 to FCustomColors.Count-1 do
        if aValue=Colors[i] then
          begin
            ItemIndex:=i;
            break;
          end;
    end
  else
    begin
      temp:=ColorTOString(aValue);
      if temp=Text then exit;

      ItemIndex:=items.indexof(temp);
      if Itemindex=-1 then
        if (coAllowAnyColor in FOptions) and (aValue<>clNone) then
          ItemIndex:=Items.Add(temp);
    //  Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  GetChange(nil);
end;

{--------------------- Protected ----------------------------------------------}
procedure TLMDCustomColorListBox.CreateColorList;
var
  ColorPrefix, ColorTags, Value:String;
  i:Integer;
  old:TColor;

begin
  if Itemindex<>-1 then old:=SelectedColor else old:=-1;
  Items.Clear;
  FCounter:=0;

  if FCustomMode then
    Items.Assign(FCustomColors)
  else
    begin
      if (coDefaultColors in FOptions) or (coSystemColors in FOptions) then
        GetColorValues(FillColorList);

      if (coCustomColors in FOptions) and (FCustomColors.Count>0) then
        begin
           ColorPrefix :=SColorPrefix;
           ColorTags := SColorTags;
           for I := 0 to MaxCustomColors - 1 do
             begin
               Value := FCustomColors.Values[ColorPrefix + ColorTags[I + 1]];
               if (Value <> '') and (Value<>'FFFFFFFF') then
                 Items.Add('$'+LMDAnsiFillString(8-Length(Value), '0')+Value);
             end;
        end;
    end;
  if old<>-1 then SelectedColor:=old;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.DrawItem(Index:Integer; aRect:TRect;
                                     State:TOwnerDrawState);
var
  temp:LongInt;
  tmpStr:String;
  tmp:TRect;
  flags : Word;
  styles : TLMDDrawTextStyles;

begin
  Dec(aRect.Right, Margin);
  Inc(aRect.Left, Margin);
  Dec(aRect.Bottom);

  with Canvas do
    begin
      if csPaintCopy in ControlState then
        begin
          temp:=GetColorValue;
          tmpstr:=ColorToString(temp);
        end
      else
        // Color definition in new Style?
        if pos('=', Items[Index])>0 then
          begin
            tmpstr:=Items.Names[index];
            if pos('cl',Items[Index])>0 then
              IdentToColor(Items.Values[tmpstr], temp)
            else
              temp:=StrToInt(Items.Values[tmpstr]);
          end
        else
          if Items[index]<>'' then
            begin
              if Items[index][1]='$' then
                temp:=StrToInt(Items[index])
              else
              begin
                if Items[index] = '-' then
                  temp := clNone
                else
                  IdentToColor(Items[Index], temp);
              end;
              if FDisplayStyle<>csColor then
                if Items[index][1]='c' then
                  tmpstr:=copy(items[index], 3, 100)
                else
                  tmpstr:=Items[index];
            end;

      if temp=clNone then
      begin
        Pen.Color := clBtnShadow;
        MoveTo(aRect.Right, aRect.Top + ((aRect.Bottom - aRect.Top) div 2));
        LineTo(aRect.Left - 2, aRect.Top + ((aRect.Bottom - aRect.Top) div 2));
        exit;
      end;
      brush.color:=temp;
      Brush.Style := bsSolid;

      flags:=DT_SINGLELINE or DT_NOPREFIX;
      flags:=flags or DrawTextBiDiModeFlags(flags);

      styles := [TLMDDrawTextStyle(Enabled), dtClip];

      case FDisplayStyle of
        csColor:with aRect do Rectangle(Left+3, Top+3, Right-3, Bottom - 3);
        csText:
          begin
            brush.Style:=bsClear;
            inc(arect.left, 2);
            inc(arect.Top, 2);
          end;
        csColorText, csColor3DText:
          begin
            with aRect do
              begin
                temp:=Left+8+(Bottom-Top);
                tmp:=Rect(Left+4, Top+2, temp, Bottom-2);
                if FDisplayStyle=csColor3DText then
                  begin
                    FillRect(tmp);
                    LMDDrawStdFrame(Canvas, tmp, lsSingleRaised, 0);
                  end
                else
                  Rectangle(tmp.Left, tmp.Top, tmp.Right, tmp.Bottom);
              end;
            brush.Style:=bsClear;
            arect.left := temp + 6;
            inc(arect.Top, 2);
          end;
      end;
      LMDDrawTextExt (Canvas, tmpStr, Font3D, aRect, flags, styles, nil);
    end;

end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.Loaded;
begin
  inherited Loaded;
  CreateColorList;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.Init;
begin
  CreateColorList;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.DoSelect;
begin
  inherited DoSelect;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.GetColorValue;
begin
  result:=clNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.MeasureItem(Index: Integer; var Height: Integer);
begin
{  if FDisplayStyle=csColor then
    Height:=defheight-1 //changed 2409JH old:+0
  else
    Height:=FIHeight;}
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.MouseDown(Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
  if (Button=mbRight) and not (csDesigning in ComponentState) and (coAllowDialog in FOptions) then
    Execute
  else
    inherited MouseDown(Button, Shift, X, Y);
end;

{---------------------Public---------------------------------------------------}
constructor TLMDCustomColorListBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FCustomColors:=TStringList.Create;
  FCustomColors.OnChange:=GetChange;
  FOptions:=[coDefaultColors, coAllowAnyColor];
  FDisplayStyle:=csColorText;
//  Style:=csOwnerDrawVariable;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomColorListBox.Destroy;
begin
  FCustomColors.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.ExecuteEnh(aList:TStrings):Boolean;
var
  dlg:TColorDialog;

begin
  result:=false;
  if FCustomMode then exit;
  dlg:=TColorDialog.Create(self);
  try
    with Dlg do
      begin
        CustomColors.Assign(aList);
        Options:=FDlgOptions;
        Color:=SelectedColor;
        HelpContext:=FContext;
        if Assigned(FOnEnterDialog) then FOnEnterDialog(self, dlg);
        result:=Execute;
        if result then
          begin
            aList.Assign(CustomColors);
            SelectedColor:=Color;
          end;
        if Assigned(FOnFinishedDialog) then FOnFinishedDialog(self, dlg);
      end;
  finally
    dlg.Free;
  end;

end;

{------------------------------------------------------------------------------}
function TLMDCustomColorListBox.Execute:Boolean;
begin
  result:=ExecuteEnh(FCustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.LoadCustomColors(IniFile:TObject; const Section:String);
begin
  LMDLoadCustomColorList(IniFile, Section, FCustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorListBox.SaveCustomColors(IniFile:TObject; const Section:String);
begin
  LMDSaveCustomColorList(IniFile, Section, FCustomColors);
end;

end.
 
