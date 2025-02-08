unit LMDFontSizeListBox;
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

LMDFontSizeListBox unit ()
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Messages, Graphics, Controls,
  LMDFontComboBox, LMDFontSizeComboBox, LMDFontListBox, LMDCustomImageListBox;

type
  TLMDFontSizeListBox = class(TLMDCustomDerivedImageListBox)
  private
    FFontName:TFontName;
    FFontControl:TWinControl;
    FUseNearest:Boolean;
    FDefaultSize,
    VRES, CHECK, FSIZE:Integer;
    //procedure SetEditorEnabled(aValue:Boolean);
    procedure SetFontControl (aValue : TWinControl);
    procedure SetFontComboControl(aValue : TLMDFontComboBox);
    function GetFontComboControl : TLMDFontComboBox;
    procedure SetFontListControl(aValue : TLMDFontListBox);
    function GetFontListControl : TLMDFontListBox;
    procedure SetSelected(aValue:Integer);
    procedure SetFont(const aValue:TFontName);
    procedure GetNearestValue(var aValue:Integer);
    function GetSelected:Integer;
    function CheckValue(aValue:Integer):Integer;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMFontChange(var Message: TMessage); message CM_FONTCHANGE;
    protected
    procedure CreateWnd; override;
    procedure CreateFontSizeList;
    procedure GetFontChange(Sender:TObject);
    procedure InitHeight;
    function IsValidChar(Key:Char):Boolean;
    procedure Loaded;override;
    procedure KeyPress(var Key:Char); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Init;
    property FontSize:Integer read GetSelected write SetSelected;
  published
    property About;
    property DefaultSize:Integer read FDefaultSize write FDefaultSize default 10;
    property FontCombo:TLMDFontComboBox read GetFontComboControl write SetFontComboControl;
    property FontList:TLMDFontListBox read GetFontListControl write SetFontListControl;
    property FontName:TFontName read FFontName write SetFont;
    property UseNearestSize:Boolean read FUseNearest write FUseNearest default false;
  end;

  TLMDLabeledFontSizeListBox = class(TLMDFontSizeListBox)
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
  SysUtils, StdCtrls, Printers, Forms,
  LMDUtils;

const
  MaxStdSizes=16;

{******************** Class TLMDFontSizeListBox ******************************}

function EnumFontFamiliesProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data:Pointer): Integer; stdcall;

  procedure AddToList(const aValue:String);
  var
    j:Integer;
    c:Boolean;
  begin
    j:=0;
    c:=False;

    with TLMDFontSizeListBox(Data) do

      begin
        while (j<Items.Count) and not c do
          if StrToInt(aValue)>=StrToInt(Items[j]) then Inc(j) else c:=True;
        Items.Insert(j, aValue);
      end;
  end;

var
  i:Integer;
  c:String;
const
  csizes:array[0..MaxStdSizes-1] of Integer=(8,9,10,11,12,14,16,18,20,22,24,26,28,36,48,72);

begin
  result:=0;

  with TLMDFontSizeListBox(Data) do

    begin
      if (FontType and TRUETYPE_FONTTYPE=TRUETYPE_FONTTYPE) or (FontType in [0,2]) then
        begin
          For i:=0 to (MaxStdSizes-1) do Items.Add(IntToStr(Csizes[i]));
          result:=0
        end;

      if (FontType and RASTER_FONTTYPE=RASTER_FONTTYPE)
      {or (FontType and DEVICE_FONTTYPE=DEVICE_FONTTYPE)} then
        with TextMetric do
          begin
            c:=IntToStr(Round((tmHeight-tmInternalLeading)*72 / VRES));
            if Items.IndexOf(c)=-1 then AddToList(c);
            result:=1;
          end;
    end
end;

{for setNearestValue}

function EnumNearestSizeProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data:Pointer): Integer; stdcall;

var
  CSize:Integer;
begin

  with TLMDFontSizeListBox(Data) do

    if (FontType and TRUETYPE_FONTTYPE=TRUETYPE_FONTTYPE) or (FontType in [0,2]) then
      begin
        FSize:=Check;
        result:=0
      end
    else
      with TextMetric do
        begin
          CSize:=Round((tmHeight-tmInternalLeading)*72 / VRES);
          if (FSIZE=0) or (Abs(CSize-CHECK)<(Abs(FSIZE-CHECK))) then FSIZE:=CSize;
          result:=1;
        end
end;

{--------------------------- Private ------------------------------------------}
procedure TLMDFontSizeListBox.SetFontControl (aValue : TWinControl);
begin
  if aValue <> FFontControl then
    begin
      if FFontControl <> nil then
        begin
          if FFontControl is TLMDFontComboBox then
            TLMDSpecialFontComboBox(FFontControl).OnFontChange:=nil;
           if FFontControl is TLMDFontListBox then
            TLMDSpecialFontListBox(FFontControl).OnFontChange:=nil;
          end;
      FFontControl := aValue;
      if FFontControl <> nil then
        begin
          if FFontControl is TLMDFontComboBox then
            TLMDSpecialFontComboBox(FFontControl).OnFontChange:=GetFontChange
          else
            TLMDSpecialFontListBox(FFontControl).OnFontChange:=GetFontChange;
          FFontControl.FreeNotification(Self);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.SetFontComboControl(aValue : TLMDFontComboBox);
begin
  SetFontControl (aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.SetFontListControl(aValue : TLMDFontListBox);
begin
  SetFontControl (aValue);
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeListBox.GetFontComboControl : TLMDFontComboBox;
begin
  result := nil;
  if FFontControl is TLMDFontComboBox then
    result := TLMDFontComboBox (FFontControl);
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeListBox.GetFontListControl : TLMDFontListBox;
begin
  result := nil;
  if FFontControl is TLMDFontListBox then
    result := TLMDFontListBox (FFontControl);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.SetSelected(aValue:Integer);
var
  i:integer;
  b:Boolean;
  c:String;
begin
  {if FontSize=aValue then exit;}
  if FFontName='' then
    Text:=''
  else
    try
      b:=False;
      aValue:=CheckValue(aValue);
      c:=IntToStr(aValue);
      for i:=0 to Pred(Items.Count) do
        if CompareText(c, Items[i])=0 then
           begin
             ItemIndex:=i;
             b:=True;
             break;
           end;
      if not b then ItemIndex:=-1;

      Text:=InttoStr(aValue);
//      Change;
    except
      on Exception do ItemIndex:=-1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.SetFont(const aValue:TFontName);
var
  old:Integer;
begin
  if FFontName<>aValue then
    begin
      old:=GetSelected;
      FFontName:=aValue;
      CreateFontSizeList;
      SetSelected(old);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.GetNearestValue(var aValue:Integer);
var
  DC:HDC;

  procedure DoGetValue;

  var
    buffer:array[0..255] of Char;

  begin

    StrPCopy(Buffer, FFontName);

    vres:=GetDeviceCaps(DC, LOGPIXELSY);
    CHECK:=aValue; FSIZE:=0;

    EnumFontFamilies(DC, Buffer, @EnumNearestSizeProc, LPARAM(self));

    {no entries? maybe printer font?}
    if FSIZE=0 then
      begin
        vres:=GetDeviceCaps(Printer.Handle, LOGPIXELSY);

        EnumFontFamilies(Printer.Handle, Buffer, @EnumNearestSizeProc,
                         LPARAM(self));

      end;
    aValue:=FSIZE;
  end;

begin
  if (FFontName='') or (csDesigning in ComponentState) then exit;

  DC:=GetDC(0);
  try
    DoGetValue;
  finally
    ReleaseDC(0, DC);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeListBox.GetSelected:Integer;
begin
  result:=-1;
  if ItemIndex <> -1 then
    try
      result:=StrToInt(Items[ItemIndex]);
    except
      on exception do ;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeListBox.CheckValue(aValue:Integer):Integer;
begin
  if (aValue<1) or (aValue>999) or (FFontName='') then aValue:=FDefaultSize;
  if FUseNearest then GetNearestValue(aValue);
  result:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.CreateFontSizeList;
var
  DC:HDC;

  procedure DoList;

  var
    buffer:array[0..255] of Char;

  begin

    StrPCopy(Buffer, FFontName);

    vres:=GetDeviceCaps(DC, LOGPIXELSY);

    EnumFontFamilies(DC, Buffer, @EnumFontFamiliesProc,
                     LPARAM(self));

    {no entries? maybe printer font?}
    if Items.Count=0 then
      begin
        vres:=GetDeviceCaps(Printer.Handle, LOGPIXELSY);

        EnumFontFamilies(Printer.Handle, Buffer, @EnumFontFamiliesProc,
                         LPARAM(self));

      end;
  end;

begin
  if csDesigning in ComponentState then exit;
  Items.BeginUpdate;
  try
    Items.Clear;
    if FFontName='' then exit;
    DC:=GetDC(0);
    try
      DoList;
    finally
      ReleaseDC(0, DC);
    end;
  finally
    Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.InitHeight;
begin
{  if LMDGetFontHeight(Font)<defBufferHeight then
    ItemHeight:=defbufferHeight
  else}
    ItemHeight:=LMDGetFontHeight(Font)+1;
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.CMExit(var Message: TCMExit);
begin
  inherited;

  if FFontName='' then
    begin
      text:='';
      exit;
    end;

  if ItemIndex<>-1 then SetSelected(StrToInt(Items[ItemIndex]));
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  InitHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.CMFontChange(var Message: TMessage);
var
  Old:TFontName;
begin
  Old:=FontName;
  inherited;
  InitHeight;
  SetFont(Old);
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFontSizeListBox.CreateWnd;
var
  Old:TFontName;
begin
  Old:=FontName;
  inherited CreateWnd;
  SetFont(Old);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.GetFontChange(Sender:TObject);
begin
  if FFontControl is TLMDFontComboBox then
    FontName:=TLMDFontComboBox(FFontControl).SelectedFont
  else
    FontName:=TLMDFontListBox(FFontControl).SelectedFont;
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeListBox.IsValidChar(Key: Char): Boolean;
var
  ValidChar: set of AnsiChar;
begin
  ValidChar:=['+','-','0'..'9'];
  result:=(AnsiChar(Key) in ValidChar) or (Key < #32);
  {if not FEditorEnabled and Result and
     ((Key>=#32) or (Key=Char(VK_BACK)) or (Key=Char(VK_DELETE))) then
    result:=false;}
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.KeyPress(var Key: Char);
begin
  if (not IsValidChar(Key)) or (FFontName='') then
    begin
      Key:=#0;
      MessageBeep(0)
    end;
  if Key<>#0 then
    begin
      inherited KeyPress(Key);
      if (Key=Char(VK_RETURN)) or (Key=Char(VK_ESCAPE)) then
        begin
          GetParentForm(Self).Perform(CM_DIALOGKEY, Byte(Key), 0);
          if Key=Char(VK_RETURN) then Key := #0;
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.Loaded;
begin
  inherited Loaded;
  Init;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFontSizeListBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=ControlStyle-[csSetCaption];
  FFontControl:=nil;
  FDefaultSize:=10;
  Sorted:=False;
//  Style:=csDropDown;
end;

{------------------------------------------------------------------------------}
destructor TLMDFontSizeListBox.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeListBox.Init;
begin
  CreateFontSizeList;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledFontSizeListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;
end.
