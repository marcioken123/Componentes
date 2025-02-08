unit LMDFontComboBox;
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

LMDFontComboBox unit ()
-----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Graphics, Messages, Classes, Controls, StdCtrls,
  LMDCustomComboBox;

type
  TLMDFontCBOption=(foPrinterFonts,
                    foScreenFonts,
                    foTrueTypeOnly,
                    foDisplayFont,
                    foDisplaySymbol,
                    foDisplaySelectedFont,
                    foHideAtPrefixedFonts);

  TLMDFontCBOptions=set of TLMDFontCBOption;

  TLMDFontComboExampleAlign = (eaComboBox, eaDropDownList{, eaMousePos});

  TLMDFontComboBox = class(TLMDCustomComboBox)
  private
    FBuffer          : TBitmap;
    FOptions         : TLMDFontCBOptions;
    FSizeChange      : TNotifyEvent;
    FShowExample,
    FFastMode        : Boolean;
    FHintWnd         : THintWindow;
    FExampleFontSize : Integer;
    FExampleText     : String;
    FExampleAlign    : TLMDFontComboExampleAlign;

//    procedure SetFastMode(aValue:Boolean);
    procedure SetSelectedFont(const aValue:TFontName);
    procedure SetOptions(aValue:TLMDFontCBOptions);
//    procedure SetBoolean(aValue : Boolean);
//    procedure SetInteger(aValue : Integer);
    function GetSelectedFont: TFontName;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMFontChange(var Message: TMessage); message CM_FONTCHANGE;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;

  protected
    procedure Change; override;
    procedure CreateWnd; override;
    procedure CreateFontList;
    procedure DrawItem(Index: Integer; pRect: TRect; State: TOwnerDrawState); override;
    procedure InitFontHeight;
    {for TLMDFontSizeControls}
    property OnFontChange:TNotifyEvent read FSizeChange write FSizeChange;
    public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    property SelectedFont:TFontName read GetSelectedFont write SetSelectedFont;
    property Text;

    // 7.0 - Rebuilds full fontlist
    procedure Init;
    property CtlXP; // compatibility
  published
    property About;
    property Color;
    property Ctl3D;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property DropDownWidth;
    property Enabled;
    property ExampleAlign : TLMDFontComboExampleAlign read FExampleAlign write FExampleAlign default eaComboBox;
    property ExampleText : String read FExampleText write FExampleText;
    property ExampleFontSize : Integer read FExampleFontSize write FExampleFontSize default 12;
    property FastMode:Boolean read FFastMode write FFastMode default false;
    property Flat;
    property FocusControl;
    property Font;
    property MRUList;
    property MRUMax;
    property Options:TLMDFontCBOptions read FOptions write SetOptions
                     default [foScreenFonts, foDisplaySymbol, foDisplaySelectedFont];
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    //property Search;
    property ShowExample : Boolean read FShowExample write FShowExample default false;
    property ShowHint;
    // 9.0
    property ThemeMode;
    property ThemeGlobalMode;
    property TabOrder;
    property TabStop;
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

  TLMDLabeledFontComboBox = class(TLMDFontComboBox)
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
  Types, SysUtils, Printers, Forms, 
  LMDClass, LMDBase, LMDUtils, LMDGraphUtils, LMDGraph;

{******************** Class TLMDFontComboBox **********************************}

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  with TLMDFontComboBox(Data) do
    if Items.IndexOf(LogFont.lfFaceName)=-1 then
       if not ((foTrueTypeOnly in Options) and ((FontType and TRUETYPE_FONTTYPE)=0)) and not ((foHideAtPrefixedFonts in Options) and (LogFont.lfFaceName[0] = '@')) then
          Items.AddObject(LogFont.lfFaceName, TObject(FontType));
  Result := 1;
end;

{--------------------------- Private ------------------------------------------}
procedure TLMDFontComboBox.SetSelectedFont(const aValue:TFontName);
var
  i:integer;
  b:Boolean;
begin
  if SelectedFont<>aValue then
    begin
      b:=False;
      for i:=0 to Pred(Items.Count) do
        if CompareText(aValue, Items[i])=0 then
           begin
             ItemIndex:=i;
             b:=True;
             break;
           end;
      if not b then ItemIndex:=-1;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
{procedure TLMDFontComboBox.SetFastMode(aValue:Boolean);
begin
  if FFastMode<>aValue then
    begin
      FFastMode:=aValue;
      if csLoading in ComponentState then Exit;
      if FFastMode then
        Items.Assign(Screen.Fonts)
      else
        CreateFontList;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.SetOptions(aValue:TLMDFontCBOptions);
var
  old:TFontName;
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      if FFastMode then
        Refresh
      else
        if not (csDesigning in ComponentState) then
          begin
            old:=SelectedFont;
            CreateFontList;
            SetSelectedFont(old);
          end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDFontComboBox.GetSelectedFont:TFontName;
begin
  Result:=Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.CreateFontList;
var
  DC:HDC;

  procedure DoList;
  begin
    if foScreenFonts in FOptions then
      begin
        DC:=GetDC(0);
        try

          EnumFonts(DC, nil, @EnumFontsProc, Pointer(Self));

        finally
          ReleaseDC(0, DC);
        end;
      end;
    if (foPrinterFonts in FOptions) then
      try
        if (Printer.Printers.Count>0) and (Printer.PrinterIndex<>-1) then

          EnumFonts(Printer.Handle, nil, @EnumFontsProc, Pointer(Self));

      except
        On Exception do ;
      end;
  end;

begin
  if (csDesigning in ComponentState) or FFastMode then exit;

  Items.BeginUpdate;
  try
    Items.Clear;
    DoList;
  finally
    Items.EndUpdate;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  InitFontHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.CMFontChange(var Message: TMessage);
var
  Old:TFontName;
begin
  Old:=SelectedFont;
  inherited;
  CreateFontList;
  InitFontHeight;
  SetSelectedFont(Old);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  case message.NotifyCode of
    CBN_CLOSEUP :
        FHintWnd.ReleaseHandle;
  end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFontComboBox.Change;
begin
  if Assigned(FSizeChange) then FSizeChange(self);
  inherited Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.CreateWnd;
var
  Old:TFontName;
begin
  Old:=SelectedFont;
  inherited CreateWnd;
  SetSelectedFont(Old);
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.DrawItem(Index: Integer; pRect: TRect;
  State: TOwnerDrawState);
var
  w     : Integer;
  aRect : TRect;
  p     : TPoint;
begin
  if Index = -1 then
    Exit; //added JH April 02

  with Canvas do
  begin
    if odSelected in State then
    begin
      Brush.Color := clHighlight;
      Font.Color  := clHighlightText;

      if DroppedDown and FShowExample then
      begin
        FHintWnd.Color := clWhite;
        FHintWnd.ReleaseHandle;
        FHintWnd.Canvas.Font.Name := Items[Index];
        FHintWnd.Canvas.Font.Size := FExampleFontSize;
        FHintWnd.Canvas.Font.Charset := self.Font.CharSet;

        aRect := Rect(p.X, p.Y, Left+Width+100, Top+Height);
        aRect := FHintWnd.CalcHintRect (200, FExampleText, nil);

        case FExampleAlign of
          eaComboBox     : p := ClientToScreen (Point (Width, 0));
          eaDropDownList : if Width > DropDownWidth then
                            p := ClientToScreen (Point (Width, Height))
                           else
                             p := ClientToScreen (Point (DropDownWidth, Height));
          {eaMousePos     : begin
                       GetCursorPos (p);
                       dec(p.y, aRect.Bottom - aRect.Top);
                     end;}
        end;

        OffsetRect(aRect, p.X, p.Y);
        FHintWnd.ActivateHint(aRect, FExampleText);
      end;
    end
    else
    begin
      Brush.Color := GetThemedBkColor; // Color;
      if odDisabled in State then
        Font.Color := clInactiveCaption
      else
        Font.Color := GetThemedFontColor; // Self.Font.Color;
    end;

    FillRect(pRect);

    if odFocused in State then
      DrawFocusRect(pRect);

    if FFastMode and (Items.Objects[Index] = nil) then
    begin
      Canvas.Font.Name := Items[Index];
      if LMDIsTrueTypeFontCheck(Canvas) then
        Items.Objects[Index] := TObject(TRUETYPE_FONTTYPE)
      else
        Items.Objects[Index] := TObject(0);
    end;

    if foDisplaySymbol in FOptions then
    begin
      w:=FBuffer.Width Div 2;
      if (Integer(Items.Objects[Index]) and TRUETYPE_FONTTYPE) = TRUETYPE_FONTTYPE then
      LMDBmpDrawExt(Canvas, Bounds(pRect.Left+2, pRect.Top, 4+w, pRect.Bottom-pRect.Top),
                      FBuffer.Canvas, Bounds(0,0, w, FBuffer.Height),DSF_TRANSPARENCY
                      or DSF_CENTER, FBuffer.TransparentColor, 0, nil)
      else
        if Integer(Items.Objects[Index]) and DEVICE_FONTTYPE=DEVICE_FONTTYPE then
        LMDBmpDrawExt(Canvas, Bounds(pRect.Left+2, pRect.Top, 4+w, pRect.Bottom-pRect.Top),
                        FBuffer.Canvas, Rect(w+1, 0, 2*w, FBuffer.Height),DSF_TRANSPARENCY
                        or DSF_CENTER, FBuffer.TransparentColor, 0, nil);
      Inc(w, 10);
    end
    else
      w:=3;

    Brush.Style := bsClear;
    if foDisplayFont in FOptions then
      Font.Name:=Items[Index]
    else if Font.Name <> self.Font.Name then
     Font.Name := Self.Font.Name;

    if (not (foDisplaySelectedFont in FOptions)) and
       (SelectedFont = Items[index]) and
       (Canvas.ClipRect.Bottom < self.Height) and
       (Font.Name <> self.Font.Name) then
      Font.Name := Self.Font.Name;

    PaintSeparatorLine(pRect, Index);
    TextRect(pRect, w, pRect.Top + 1, Items[Index]); //changed 2409JH old:Top+2
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.InitFontHeight;
begin
  if LMDGetFontHeight(Font)<defBufferHeight then
    ItemHeight:=defbufferHeight
  else
    ItemHeight:=LMDGetFontHeight(Font)+1; //changed 2409JH old +2
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.Loaded;
begin
  inherited Loaded;
  if FFastMode then
    Items.Assign(Screen.Fonts)
  else
    CreateFontList;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFontComboBox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  {buffer for Bitmaps}
  FBuffer:=TBitmap.Create;

  FBuffer.Handle:=LoadBitmap(HInstance, MakeIntResource(IDB_FONTBMP));

  FOptions:=[foScreenFonts, foDisplaySymbol, foDisplaySelectedFont];
  Sorted:=True;
  Style:=csOwnerDrawFixed;
  ItemHeight:=defHeight-1; //changed 2409JH old:+0
  FHintWnd := THintWindow.Create(self);
  FExampleFontSize := 12;
  FExampleText := 'Abc';
  FShowExample := false;
  FExampleAlign := eaComboBox;
end;

{------------------------------------------------------------------------------}
destructor TLMDFontComboBox.Destroy;
begin
  FHintWnd.Free;
  FBuffer.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontComboBox.Init;
var
  Old:TFontName;
begin
  Old:=SelectedFont;
  Items.Clear;
  CreateFontList;
  InitFontHeight;
  SetSelectedFont(Old);
end;

{ TLMDLabeledFontComboBox }

constructor TLMDLabeledFontComboBox.Create(AOwner: TComponent);
begin
  inherited;
  HasBoundLabel := True;
end;

end.
