unit LMDCustomColorComboBox;
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

LMDCustomColorComboBox unit ()
------------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Graphics,   Messages, Classes, Dialogs, Controls, Windows, StdCtrls,
  LMDCustomComboBox;

type
  {------------------------- TLMDCustomColorBox -------------------------------}
  TLMDColorCBStyle=(csColor, csText, csColorText, csColor3DText);
  TLMDColorCBOption=(coDefaultColors,     {Show 16 default Colors in List}
                     coSystemColors,      {Show Windows System Colors in List}
                     coCustomColors,      {Show Custom Colors}
                     coAllowAnyColor,     {Every Color can be selected}
                     coAllowDialog);      {Right Mouseclick: Show Colordialog}

  TLMDColorCBOptions=set of TLMDColorCBOption;
  TLMDOnColorDialogEvent=procedure(Sender:TObject; ColorDialog:TColorDialog) of object;

  TLMDCustomColorComboBox = class(TLMDCustomComboBox)
  private
    // 6.1
    FCustomMode:Boolean;
    // ---
    FCounter:Integer;
    FCustomColors:TStringList;
    FIHeight:Integer;
    FOptions:TLMDColorCBOptions;
    FDisplayStyle:TLMDColorCBStyle;
    FDlgOptions:TColorDialogOptions;
    FOnEnterDialog,
    FOnFinishedDialog:TLMDOnColorDialogEvent;
    FContext:THelpContext;
    FOldColor: TColor;
    procedure GetChange(Sender:TObject);
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
    procedure Loaded;override;
    procedure CreateColorList;
    procedure Change; override;
    procedure DrawItem(Index:Integer; aRect:TRect; State:TOwnerDrawState);override;
    procedure DropDown; override;
    function GetColorValue:TColor;virtual;
    procedure MeasureItem(Index: Integer; var Height: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);override;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    procedure Init;
    function Execute:Boolean;  {Execute Dialog}
    function ExecuteEnh(aList:TStrings):Boolean;
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
    property CustomColors:TStrings read GetCustomColors write SetCustomColors;
    property CustomMode:Boolean read FCustomMode write SetCustomMode default false;

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
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property Flat;
    property FocusControl;
    property Font;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;

    //property Search;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property UseGlobalTimer;
    property Visible;
    property Sorted;

    {Events}
    property OnSelect;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDrag;

    property OnBeforeDialogShow:TLMDOnColorDialogEvent read FOnEnterDialog write FOnEnterDialog;
    property OnAfterDialogShow:TLMDOnColorDialogEvent read FOnFinishedDialog write FOnFinishedDialog;

    property ThemeMode;  // V9.0
    property ThemeGlobalMode; 
    // V4 enhancements
    property Anchors;
    property Constraints;
    property DragKind;
    property BiDiMode;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
    property OnContextPopup;
    property OnCloseUp;
  end;

implementation
uses
  Types, SysUtils, Consts,
  LMDConst, LMDGraph, LMDStrings, LMDUtils, LMDGraphUtils;

{******************** Class TLMDCustomColorComboBox ***************************}
{----------------------------  Private ----------------------------------------}
procedure TLMDCustomColorComboBox.GetChange(Sender:TObject);
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

      if FdisplayStyle=csColor then
        Height:=defheight+9
      else
        begin
          FIHeight:=LMDGetFontHeight(Font)+2;
          Height:=FIHeight+9;
        end;

      RecreateWnd;
      if Dummy then SetSelectedColor(old);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.FillColorList(const S:String);
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
function TLMDCustomColorComboBox.GetColor(index:Integer):TColor;
var
  data:String;
begin
  if FCustomMode and (pos('=', Items[Index])>0) then
    data:=Items.Values[items.Names[Index]]
  else
    data:=Items[Index];
  try
    result:=StringToColor(data);
  except
    result:=-1;
  end;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorComboBox.GetColorName(index:Integer):String;
begin
  if FCustomMode and (pos('=', Items[Index])>0) then
    result:=Items.Names[Index]
  else
    result:=Items[Index];
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorComboBox.GetSelectedColorName:String;
begin
  result:=Text;
  if pos('=', result)>0 then
    result:=LMDAnsiGetFirstString(result, '=');
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorComboBox.GetCustomColors:TStrings;
begin
  result:=FCustomColors;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorComboBox.GetSelectedColor:TColor;
var
  data:String;
begin
  result := -1;
  if (Text='') or (Text = IDS_COLORCOMBOBOXCUSTOM) then exit;
  if FCustomMode and (pos('=', Text)>0) then
    data:=LMDAnsiGetSecondString(Text, '=')
  else
    data:=Text;
  try
    result:=StringToColor(data);
  except
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.SetCustomMode(aValue:Boolean);
begin
  if aValue<>FCustomMode then
    begin
      FCustomMode:=aValue;
      if not (csLoading in ComponentState) then
        GetChange(FCustomColors);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.SetCustomColors(aValue:TStrings);
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
procedure TLMDCustomColorComboBox.SetDisplayStyle(aValue:TLMDColorCBStyle);
begin
  if aValue<>FDisplayStyle then
    begin
      FDisplayStyle:=aValue;
      GetChange(nil);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.SetOptions(aValue:TLMDColorCBOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      if not FCustomMode then
        CreateColorList;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.SetSelectedColor(aValue:TColor);
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
      temp:=ColorToString(aValue);
      if temp=Text then exit;
      ItemIndex := Items.indexof(temp);
      if Itemindex=-1 then
        if (coAllowAnyColor in FOptions) and (aValue <> clNone) then
          begin
            i := Items.IndexOf(IDS_COLORCOMBOBOXCUSTOM);
            if i >= 0 then
              begin
                Items[i] := temp;
                Items.Add(IDS_COLORCOMBOBOXCUSTOM);
                ItemIndex := i;
              end
            else
              ItemIndex:=Items.Add(temp);
          end;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  GetChange(nil);
end;

{--------------------- Protected ----------------------------------------------}
procedure TLMDCustomColorComboBox.CreateColorList;
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
                 Items.Add(HexDisplayPrefix + LMDAnsiFillString(8 - Length(Value), '0')+Value);
             end;
        end;
    end;
  if not FCustomMode and (coAllowDialog in Options) and (Items.IndexOf(IDS_COLORCOMBOBOXCUSTOM) < 0) then
    Items.Add(IDS_COLORCOMBOBOXCUSTOM);
  if old<>-1 then SelectedColor:=old;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.Change;
begin
  if (Items[ItemIndex] = IDS_COLORCOMBOBOXCUSTOM) and (coAllowDialog in Options) then
    begin
      Execute;
    end
  else
    inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.DrawItem(Index:Integer; aRect:TRect;
  State:TOwnerDrawState);
var
  temp:LongInt;
  tmpStr:String;
  tmp:TRect;
  lDisplayStyle: TLMDColorCBStyle;
begin
  if Index = -1 then
    Exit; //added April 02, JH

  with Canvas do
  begin
    if odSelected in State then
    begin
      Brush.Color := clHighlight;
      Font.Color  := clHighlightText;
    end
    else
    begin
      Brush.Color := GetThemedBkColor; // Color;

      if oddisabled in State then
        Font.Color := clInactiveCaption
      else
        Font.Color := GetThemedFontColor; // Self.Font.Color;
    end;

    FillRect(aRect);

    if odFocused in State then DrawFocusRect(aRect);

    if csPaintCopy in ControlState then
    begin
      temp:=GetColorValue;
      tmpstr:=ColorToString(temp);
    end
    else if pos('=', Items[Index])>0 then
    begin
      tmpstr:=Items.Names[index];
      if pos('cl',Items[Index])>0 then
        IdentToColor(Items.Values[tmpstr], temp)
      else
        temp:=StrToInt(Items.Values[tmpstr]);
    end
    else if Items[index]<>'' then
    begin
      if Copy(Items[index], 1, Length(HexDisplayPrefix)) = HexDisplayPrefix then
        temp:=StrToInt(Items[index])
      else
        IdentToColor(Items[Index], temp);
      if FDisplayStyle<>csColor then
        if Items[index][1]='c' then
          tmpstr:=copy(items[index], 3, 100)
        else
          tmpstr:=Items[index];
    end;

    if temp = clNone then
      Exit;

    brush.color := temp;
    Brush.Style := bsSolid;

    lDisplayStyle := FDisplayStyle;
    if not FCustomMode and (coAllowDialog in Options) and
       (Items[Index] = IDS_COLORCOMBOBOXCUSTOM) then
      lDisplayStyle := csText;

    case lDisplayStyle of
      csColor:
        with aRect do
          Rectangle(Left+3, Top+3, Right-3, Bottom - 3);
      csText:
      begin
        brush.Style:=bsClear;
        TextRect(aRect, aRect.Left+2, aRect.Top+2, tmpstr);
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
        TextRect(aRect, temp+6, aRect.Top+2, tmpstr);
      end;
    end;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.DropDown;
begin
  FOldColor := GetSelectedColor;
  inherited;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.Loaded;
begin
  inherited Loaded;
  Init;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.Init;
begin
  CreateColorList;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorComboBox.GetColorValue;
begin
  result:=clNone;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.MeasureItem(Index: Integer; var Height: Integer);
begin
  if FDisplayStyle=csColor then
    Height:=defheight-1 //changed 2409JH old:+0
  else
    Height:=FIHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.MouseDown(Button: TMouseButton;
          Shift: TShiftState; X, Y: Integer);
begin
  if not FCustomMode and (Button=mbRight) and not (csDesigning in ComponentState) and (coAllowDialog in FOptions) then
    Execute
  else
    inherited MouseDown(Button, Shift, X, Y);
end;

{---------------------Public---------------------------------------------------}
constructor TLMDCustomColorComboBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FCustomColors:=TStringList.Create;
  FCustomColors.OnChange:=GetChange;
  FOptions:=[coDefaultColors, coAllowAnyColor];
  FDisplayStyle:=csColorText;
  Style:=csOwnerDrawVariable;
  GetChange(nil);
end;

{------------------------------------------------------------------------------}
destructor TLMDCustomColorComboBox.Destroy;
begin
  FCustomColors.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDCustomColorComboBox.ExecuteEnh(aList:TStrings):Boolean;
var
  dlg:TColorDialog;
begin
  result := false; //May 02, JH
  if FCustomMode then exit;
  dlg:=TColorDialog.Create(self);
  try
    with Dlg do
      begin
        CustomColors.Assign(aList);
        Options := FDlgOptions;
        Color := SelectedColor;

        HelpContext:=FContext;
        if Assigned(FOnEnterDialog) then FOnEnterDialog(self, dlg);
        result := Execute;
        if result then
          begin
            aList.Assign(CustomColors);
            SelectedColor := Color;
          end
        else
          begin
            if FOldColor = -1 then
              ItemIndex := -1
            else
              SelectedColor := FOldColor;
          end;

        if Assigned(FOnFinishedDialog) then FOnFinishedDialog(self, dlg);
      end;
  finally
    dlg.Free;
  end;

end;

{------------------------------------------------------------------------------}
function TLMDCustomColorComboBox.Execute:Boolean;
begin
  result:=ExecuteEnh(FCustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.LoadCustomColors(IniFile:TObject; const Section:String);
begin
  LMDLoadCustomColorList(IniFile, Section, FCustomColors);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomColorComboBox.SaveCustomColors(IniFile:TObject; const Section:String);
begin
  LMDSaveCustomColorList(IniFile, Section, FCustomColors);
end;

end.
