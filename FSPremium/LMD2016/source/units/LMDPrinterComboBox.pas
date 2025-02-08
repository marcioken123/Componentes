unit LMDPrinterComboBox;
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

LMDPrinterComboBox unit (JH)
----------------------------

Printer selection combo box. ComboBox which lists all printers installed in the system the program is running on

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, Classes, Controls, StdCtrls, Graphics,
  LMDCustomComboBox;

type
  {-------------------------- TLMDPrinterComboBox -----------------------------}

  TLMDPrinterCBOption = (poDisplaySymbol,
                         poActivatePrinter,
                         poStartWithActive   //added Okt 2001, JH
                        );
  TLMDPrinterCBOptions = set of TLMDPrinterCBOption;

  TLMDPrinterComboBox = class(TLMDCustomComboBox)
  private
    FBuffer:  TBitmap;
    FOptions: TLMDPrinterCBOptions;

    procedure SetOptions(aValue : TLMDPrinterCBOptions);
    procedure SetSelectedPrinter(const aValue:String);
    function  GetSelectedPrinter: String;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMFontChange(var Message: TMessage); message CM_FONTCHANGE;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
  protected
    procedure Change; override;
    procedure CreateWnd; override;
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure InitHeight;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InitPrinterList;
    procedure Init;
    property SelectedPrinter:String read GetSelectedPrinter write SetSelectedPrinter;
    property Text;
    property CtlXP;  // compatibility
  published
    property About;
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
    property Options : TLMDPrinterCBOptions read FOptions write SetOptions default [poDisplaySymbol];
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    //property Search;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property ThemeMode;
    property ThemeGlobalMode;
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

  TLMDLabeledPrinterCombobox = class(TLMDPrinterComboBox)
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
  SysUtils, Printers,
  LMDBase, LMDUtils;

{--------------------------- Private ------------------------------------------}
procedure TLMDPrinterComboBox.SetSelectedPrinter(const aValue:String);
var
  i:integer;
  b:Boolean;
begin
  if SelectedPrinter<>aValue then
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
procedure TLMDPrinterComboBox.SetOptions(aValue : TLMDPrinterCBOptions);
begin
  if aValue <> FOptions then
    begin
      FOptions := aValue;
      Change;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDPrinterComboBox.GetSelectedPrinter:String;
begin
  Result:=Text;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterCombobox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  InitHeight;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterComboBox.CMFontChange(var Message: TMessage);
var
  Old:String;
begin
  Old:=SelectedPrinter;
  inherited;
//  CreatePrinterList;
  InitHeight;
  SetSelectedPrinter(Old);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterComboBox.CNCommand(var Message: TWMCommand);
begin
  inherited;
  case message.NotifyCode of
    CBN_SELCHANGE :
      begin
        //added Okt 2001, JH
        if poActivatePrinter in FOptions then
         Printers.Printer.PrinterIndex := Printers.Printer.Printers.indexOf (Text);
      end;
  end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDPrinterCombobox.Change;
begin
//  if Assigned(FSizeChange) then FSizeChange(self);
  inherited Change;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterComboBox.CreateWnd;
var
  Old:String;
begin
  Old:=SelectedPrinter;
  inherited CreateWnd;
  SetSelectedPrinter(Old);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterComboBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  w: Integer;
begin
  with Canvas do
  begin
    if odSelected in State then
    begin
      Brush.Color := clHighlight;
      Font.Color:=clHighlightText;
    end
    else
    begin
      Brush.Color := GetThemedBkColor; // Color;
      if oddisabled in State then
        Font.Color := clInactiveCaption
      else
       Font.Color := GetThemedFontColor; // Self.Font.Color;
    end;

    FillRect(Rect);

    if odFocused in State then
      DrawFocusRect(Rect);

{      if FFastMode then
      if Items.Objects[Index]=nil then
        begin
          Canvas.Font.Name:=Items[Index];
          if LMDIsTrueTypePrinterCheck(Canvas) then
            Items.Objects[Index]:=TObject(TRUETYPE_FONTTYPE)
          else
            Items.Objects[Index]:=TObject(0);
        end;

    if foDisplaySymbol in FOptions then
      begin
        w:=FBuffer.Width Div 2;
        if Integer(Items.Objects[Index]) and TRUETYPE_PrinterTYPE=TRUETYPE_PrinterTYPE then
          LMDBmpDrawExt(Canvas, Bounds(Rect.Left+2, Rect.Top, 4+w, Rect.Bottom-Rect.Top),
                        FBuffer.Canvas, Bounds(0,0, w, FBuffer.Height),DSF_TRANSPARENCY
                        or DSF_CENTER, FBuffer.TransparentColor, 0, nil)
        else
          if Integer(Items.Objects[Index]) and DEVICE_PrinterTYPE=DEVICE_PrinterTYPE then
            LMDBmpDrawExt(Canvas, Bounds(Rect.Left+2, Rect.Top, 4+w, Rect.Bottom-Rect.Top),
                          FBuffer.Canvas, Classes.Rect(w+1, 0, 2*w, FBuffer.Height),DSF_TRANSPARENCY
                          or DSF_CENTER, FBuffer.TransparentColor, 0, nil);
        Inc(w, 10);
      end
    else     }

      w:=3;

    Brush.Style:=bsClear;
{     if foDisplayPrinter in FOptions then
      Printer.Name:=Items[Index]
    else
      if Printer.Name<>self.Printer.Name then Printer.Name:=self.Printer.Name; }

    TextRect(Rect, w, Rect.Top+1, Items[Index]); //changed 2409JH old:Top+2
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterCombobox.InitHeight;
begin
  if LMDGetFontHeight(Font)<defBufferHeight then
    ItemHeight:=defbufferHeight
  else
    ItemHeight:=LMDGetFontHeight(Font)+1; //changed 2409JH old +2
  RecreateWnd;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterCombobox.Loaded;
begin
  inherited Loaded;
  InitPrinterList;
end;

{------------------------------------------------------------------------------}
procedure TLMDPrinterCombobox.InitPrinterList;
begin
  Items.Assign(Printer.Printers);
  //added Okt 2001, JH
  if poStartWithActive in FOptions then
    ItemIndex := Printers.Printer.PrinterIndex;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDPrinterComboBox.Init;
begin
  InitPrinterList;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDPrinterCombobox.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  {buffer for Bitmap}
  FBuffer:=TBitmap.Create;

  FBuffer.Handle:=LoadBitmap(HInstance, MakeIntResource(IDB_FONTBMP));

  Sorted:=True;
  Style:=csOwnerDrawFixed;
  ItemHeight:=defHeight-1;
end;

{------------------------------------------------------------------------------}
destructor TLMDPrinterComboBox.Destroy;
begin
  FBuffer.Free;
  inherited Destroy;
end;

{ TLMDLabeledPrinterCombobox }

constructor TLMDLabeledPrinterCombobox.Create(AOwner: TComponent);
begin
  inherited;
  HasBoundLabel := true;
end;

end.
