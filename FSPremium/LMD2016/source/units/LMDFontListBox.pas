unit LMDFontListBox;
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

LMDFontListBox unit ()
----------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  Classes,
  Controls,
  Graphics,
  Messages,
  StdCtrls,
  LMDFontComboBox,
  LMDCustomImageListBox;

type
  TLMDFontListExampleAlign = (eaListRightTop, eaMousePos, eaRow);

  TLMDFontListBox = class (TLMDCustomDerivedImageListBox)
  private
    FOptions         : TLMDFontCBOptions;
    FBuffer          : TBitmap;
    FShowExample     : Boolean;
    FHintWnd         : THintWindow;
    FLastExample,
    FExampleFontSize : Integer;
    FExampleText     : String;
    FExampleAlign    : TLMDFontListExampleAlign;
    FMousePos        : TPoint;
    FSizeChange      : TNotifyEvent;
    procedure SetOptions(aValue:TLMDFontCBOptions);
    procedure SetSelectedFont(const aValue:TFontName);
    function GetSelectedFont: TFontName;

    procedure WMMOUSEMOVE (var Msg : TWMMouse); message WM_MOUSEMOVE;
    procedure WMCAPTURECHANGED (var Msg : TMessage); message WM_CAPTURECHANGED;
    procedure CMMouseLeave (var Msg : TMessage); message CM_MOUSELEAVE;
    procedure CMFontChange(var Message: TMessage); message CM_FONTCHANGE;    

  protected
    procedure DrawItem(Index: Integer; pRect: TRect; State: TOwnerDrawState); override;
    procedure ShowExampleFor (i : Integer);
    procedure DoSelect; override;
    {for TLMDFontSizeControls}
    property OnFontChange:TNotifyEvent read FSizeChange write FSizeChange;
    public
    procedure CreateFontList;
    constructor Create (aOwner : TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    // 7.0
    procedure Init;
    // ---
    property SelectedFont:TFontName read GetSelectedFont write SetSelectedFont;
  published
    property Options:TLMDFontCBOptions read FOptions write SetOptions
                     default [foScreenFonts, foDisplaySymbol];
    property ExampleText : String read FExampleText write FExampleText;
    property ExampleFontSize : Integer read FExampleFontSize write FExampleFontSize default 12;
    property ExampleAlign    : TLMDFontListExampleAlign read FExampleAlign write FExampleAlign default eaListRightTop;
    property ShowExample : Boolean read FShowExample write FShowExample default false;
  end;

  TLMDLabeledFontListBox = class(TLMDFontListBox)
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
  Types, SysUtils, Printers, Forms,
  LMDClass, LMDBase, LMDUtils, LMDGraphUtils, LMDGraph;

{******************** Class TLMDFontComboBox **********************************}

function EnumFontsProc(var LogFont: TLogFont; var TextMetric: TTextMetric;
  FontType: Integer; Data: Pointer): Integer; stdcall;
begin
  with TLMDFontListBox(Data) do
    if Items.IndexOf(LogFont.lfFaceName)=-1 then
       if not ((foTrueTypeOnly in Options) and ((FontType and TRUETYPE_FONTTYPE)=0)) then
          Items.AddObject(LogFont.lfFaceName, TObject(FontType));
  Result := 1;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontListBox.SetOptions(aValue:TLMDFontCBOptions);
var
  old:TFontName;
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
{      if FFastMode then
        Refresh
      else}
        if not (csDesigning in ComponentState) then
          begin
            old:=SelectedFont;
            CreateFontList;
            SetSelectedFont(old);
          end;
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.SetSelectedFont(const aValue:TFontName);
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
      if Assigned(FSizeChange) then FSizeChange(self);
    end;
end;

{ ---------------------------------------------------------------------------- }
function TLMDFontListBox.GetSelectedFont:TFontName;
begin
  if ItemIndex = -1 then exit;
  result:=Items[ItemIndex];
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.WMMOUSEMOVE (var Msg : TWMMouse);
var
  i : Integer;
begin
  FMousePos := Point(Msg.XPos, Msg.YPos);
  i := ItemAtPos(FMousePos, true);
  if i <> -1 then
    ShowExampleFor (i)
  else
    FHintWnd.ReleaseHandle;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.WMCAPTURECHANGED (var Msg : TMessage);
begin
  inherited;
  FHintWnd.ReleaseHandle;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.CMMouseLeave (var Msg : TMessage);
begin
  inherited;
  FHintWnd.ReleaseHandle;
end;

{------------------------------------------------------------------------------}
procedure TLMDFontListBox.CMFontChange(var Message: TMessage);
var
  Old:TFontName;
begin
  Old:=SelectedFont;
  inherited;
  CreateFontList;
  SetSelectedFont(Old);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.CreateFontList;
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
//  if (csDesigning in ComponentState) {or FFastMode} then exit;

  Items.BeginUpdate;
  try
    Items.Clear;
    DoList;
  finally
    Items.EndUpdate;
  end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.DrawItem(Index: Integer; pRect: TRect; State: TOwnerDrawState);
var
  w     : Integer;
  flags : Word;
  styles : TLMDDrawTextStyles;
begin

  Dec(pRect.Right,Margin);
  Inc(pRect.Left, Margin);
  Dec(pRect.Bottom);

  with Canvas do
    begin
      FHintWnd.ReleaseHandle;

      if foDisplaySymbol in FOptions then
        begin
          w:=FBuffer.Width Div 2;
          if Integer(Items.Objects[Index]) and TRUETYPE_FONTTYPE=TRUETYPE_FONTTYPE then
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

      Brush.Style:=bsClear;
      if foDisplayFont in FOptions then
        Font.Name:=Items[Index]
      else
        if Font.Name<>self.Font.Name then Font.Name:=self.Font.Name;

//      PaintSeparatorLine (Rect, Index);
      flags:=DT_SINGLELINE or DT_NOPREFIX;
      flags:=flags or DrawTextBiDiModeFlags(flags);

      inc(prect.left, w);
      inc (prect.Top, 1);

      styles := [dtClip];

      if not (odDisabled in State) then
        styles := styles + [dtEnabled];

      LMDDrawTextExt (Canvas, Items[Index], Font3D, pRect, flags, styles, nil);
    end
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.ShowExampleFor (i : Integer);
var
  aRect : TRect;
  p : TPoint;
begin
  if i = FLastExample then exit;
  FLastExample := i;
  if {DroppedDown and} FShowExample then
    begin
      FHintWnd.Color := clWhite;
      FHintWnd.ReleaseHandle;
      FHintWnd.Canvas.Font.Name := Items[i];
      FHintWnd.Canvas.Font.Size := FExampleFontSize;
      FHintWnd.Canvas.Font.Charset := self.Font.CharSet;

      aRect := Rect (p.X, p.Y, Left+Width+100, Top+Height);
      aRect := FHintWnd.CalcHintRect (200, FExampleText, nil);
      case FExampleAlign of
        eaListRightTop : p := ClientToScreen (Point (Width, 0));
        eaMousePos     : p := ClientToScreen (Point(FMousePos.X + 10, FMousePos.Y));
        eaRow          : p := ClientToScreen (Point (Width, FMousePos.Y));
      end;
      OffsetRect (aRect, p.X, p.Y);
      FHintWnd.ActivateHint (aRect, FExampleText);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.DoSelect;
begin
  inherited DoSelect;
  if Assigned (FSizeChange) then FSizeChange (self);
end;

{ ---------------------------------------- public ---------------------------- }
constructor TLMDFontListBox.Create (aOwner : TComponent);
begin
  inherited Create (aOwner);
  FBuffer:=TBitmap.Create;

  FBuffer.Handle:=LoadBitmap(HInstance, MakeIntResource(IDB_FONTBMP));

  FHintWnd := THintWindow.Create(self);
  FOptions:=[foScreenFonts, foDisplaySymbol];
  FLastExample := -1;
  FExampleFontSize := 12;
  FExampleText := 'Abc';
  FShowExample := false;
  FExampleAlign := eaListRightTop;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDFontListBox.Destroy;
begin
  FBuffer.Free;
  FHintWnd.Free;
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.Loaded;
begin
  inherited Loaded;
  Init;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFontListBox.Init;
begin
  CreateFontList;
end;

{ ------------------------- public ------------------------------------------- }
constructor TLMDLabeledFontListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  HasBoundLabel := true;
end;

end.
