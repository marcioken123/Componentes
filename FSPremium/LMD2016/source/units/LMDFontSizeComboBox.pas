unit LMDFontSizeComboBox;
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

LMDFontSizeComboBox unit ()
---------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Messages, Graphics, Controls,
  LMDFontComboBox, LMDFontListBox, LMDCustomComboBox;

type
  TLMDSpecialFontComboBox = class(TLMDFontComboBox)
  public
    property OnFontChange;
  end;

  TLMDSpecialFontListBox = class(TLMDFontListBox)
  public
    property OnFontChange;
  end;

  TLMDFontSizeComboBox = class(TLMDCustomComboBox)
  private
    FFontName:TFontName;
    FFontControl : TWinControl;
    FEditorEnabled,
    FUseNearest:Boolean;
    FDefaultSize,
    VRES, CHECK, FSIZE:Integer;
    procedure SetEditorEnabled(aValue:Boolean);

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
    procedure GetChange(Sender:TObject);
    procedure InitHeight;
    function IsValidChar(Key:Char):Boolean;
    procedure KeyPress(var Key:Char); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Init;
    property CtlXP; // compatiblity
    property FontSize:Integer read GetSelected write SetSelected;
  published
    property About;
    property Color;
    property Ctl3D;
    property DefaultSize:Integer read FDefaultSize write FDefaultSize default 10;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property EditorEnabled: Boolean read FEditorEnabled write SetEditorEnabled default True;
    property Enabled;
    property Flat;
    property FocusControl;
    property Font;
    property FontCombo:TLMDFontComboBox read GetFontComboControl write SetFontComboControl;
    property FontList:TLMDFontListBox read GetFontListControl write SetFontListControl;
    property FontName:TFontName read FFontName write SetFont;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property ThemeMode;
    property ThemeGlobalMode;
    property UseNearestSize:Boolean read FUseNearest write FUseNearest default false;
    property UseGlobalTimer;
    property Visible;

   {Events}
   property OnSelect;
   property OnChange;
   property OnClick;
   property OnDblClick;
   property OnDragDrop;
   property OnDragOver;
   property OnDropDown;
   property OnEditClick;
   property OnEndDrag;
   property OnEnter;
   property OnExit;
   property OnKeyDown;
   property OnKeyPress;
   property OnKeyUp;
   property OnStartDrag;

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

  TLMDLabeledFontSizeComboBox = class(TLMDFontSizeComboBox)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ItemIndex;
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

{******************** Class TLMDFontSizeComboBox ******************************}

function EnumFontFamiliesProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: DWORD; Data:Pointer): Integer; stdcall;

var
  FontSizeComboBox: TLMDFontSizeComboBox;

  procedure AddToList(const aValue:String);
  var
    j:Integer;
    c:Boolean;
  begin
    j:=0;
    c:=False;
    with FontSizeComboBox do
      begin
        while (j<Items.Count) and not c do
          if StrToInt(aValue)>=StrToInt(Items[j]) then
            Inc(j)
          else
            c:=True;
        Items.Insert(j, aValue);
      end;
  end;

var
  i:Integer;
  c:String;
const
  csizes:array[0..MaxStdSizes-1] of Integer=(8,9,10,11,12,14,16,18,20,22,24,26,28,36,48,72);

begin

  FontSizeComboBox := TLMDFontSizeComboBox(Data);

  result:=0;
  with FontSizeComboBox do
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
  FontType: DWORD; Data:Pointer): Integer; stdcall;

var
  CSize:Integer;
begin

  with TLMDFontSizeComboBox(Data) do

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
procedure TLMDFontSizeComboBox.SetEditorEnabled(aValue:Boolean);
begin
  if aValue<>FEditorEnabled then
    begin
      FEditorEnabled:=aValue;
      if FEditorEnabled then Style:=csDropDown else Style:=csDropDownList;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.SetFontControl (aValue : TWinControl);
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
            TLMDSpecialFontComboBox(FFontControl).OnFontChange := GetChange;
           if FFontControl is TLMDFontListBox then
            TLMDSpecialFontListBox(FFontControl).OnFontChange := GetChange;
          FFontControl.FreeNotification(Self);
        end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.SetFontComboControl(aValue : TLMDFontComboBox);
begin
  SetFontControl (aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.SetFontListControl(aValue : TLMDFontListBox);
begin
  SetFontControl (aValue);
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeComboBox.GetFontComboControl : TLMDFontComboBox;
begin
  result := nil;
  if not Assigned(FFontControl) then exit;
  if FFontControl is TLMDFontComboBox then
    result := TLMDFontComboBox (FFontControl);
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeComboBox.GetFontListControl : TLMDFontListBox;
begin
  result := nil;
  if not Assigned(FFontControl) then exit;
  if FFontControl is TLMDFontListBox then
    result := TLMDFontListBox (FFontControl);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.SetSelected(aValue:Integer);
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
      Change;
    except
      on Exception do ItemIndex:=-1;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.SetFont(const aValue:TFontName);
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
procedure TLMDFontSizeComboBox.GetNearestValue(var aValue:Integer);
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
function TLMDFontSizeComboBox.GetSelected:Integer;
begin
  result:=-1;
  if Text<>'' then
    try
      result:=StrToInt(Text);
    except
      on exception do ;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeComboBox.CheckValue(aValue:Integer):Integer;
begin
  if (aValue<1) or (aValue>999) or (FFontName='') then aValue:=FDefaultSize;
  if FUseNearest then GetNearestValue(aValue);
  result:=aValue;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.CreateFontSizeList;
var
  DC:HDC;

  procedure DoList;

  var
    buffer:array[0..255] of Char;

  begin

    StrPCopy(Buffer, FFontName);

    vres:=GetDeviceCaps(DC, LOGPIXELSY);

    EnumFontFamilies(DC, Buffer, @EnumFontFamiliesProc, LPARAM(self));

    {no entries? maybe printer font?}
    if Items.Count = 0 then
      begin
        try
          vres:=GetDeviceCaps(Printer.Handle, LOGPIXELSY);

          EnumFontFamilies(Printer.Handle, Buffer, @EnumFontFamiliesProc,
                           LPARAM(self));

        except
          On Exception do ;
        end;
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
procedure TLMDFontSizeComboBox.InitHeight;
begin
  if LMDGetFontHeight(Font)<defBufferHeight then
    ItemHeight:=defbufferHeight
  else
    ItemHeight:=LMDGetFontHeight(Font)+1;
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.CMExit(var Message: TCMExit);
begin
  inherited;
  if not FEditorEnabled then exit;
  if FFontName='' then
    begin
      text:='';
      exit;
    end;

  if Text='' then SetSelected(-1) else SetSelected(StrToInt(Text));
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  InitHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.CMFontChange(var Message: TMessage);
var
  Old:TFontName;
begin
  Old:=FontName;
  inherited;
  InitHeight;
  SetFont(Old);
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFontSizeComboBox.CreateWnd;
var
  Old:TFontName;
begin
  Old:=FontName;
  inherited CreateWnd;
  SetFont(Old);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.GetChange(Sender:TObject);
begin
  if FFontControl is TLMDFontComboBox then
    FontName:=TLMDFontComboBox(FFontControl).SelectedFont
  else
    FontName:=TLMDFontListBox(FFontControl).SelectedFont;
end;

{------------------------------------------------------------------------------}
function TLMDFontSizeComboBox.IsValidChar(Key: Char): Boolean;
var
  ValidChar: set of AnsiChar;
begin
  ValidChar:=['+','-','0'..'9'];
  result:=(AnsiChar(Key) in ValidChar) or (Key < #32);
  if not FEditorEnabled and Result and
     ((Key>=#32) or (Key=Char(VK_BACK)) or (Key=Char(VK_DELETE))) then
    result:=false;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.KeyPress(var Key: Char);
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
procedure TLMDFontSizeComboBox.Loaded;
begin
  inherited Loaded;
  CreateFontSizeList;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent=FFontControl) then SetFontControl(nil);
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFontSizeComboBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=ControlStyle-[csSetCaption];
  FFontControl:=nil;
  FDefaultSize:=10;
  FEditorEnabled:=True;
  Sorted:=False;
  Style:=csDropDown;
  ItemHeight:=defHeight;
end;

{------------------------------------------------------------------------------}
destructor TLMDFontSizeComboBox.Destroy;
begin
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontSizeComboBox.Init;
begin
  CreateFontSizeList;
end;

{ TLMDLabeledFontSizeComboBox }

constructor TLMDLabeledFontSizeComboBox.Create(AOwner: TComponent);
begin
  inherited;
  HasBoundLabel := True;
end;

end.
