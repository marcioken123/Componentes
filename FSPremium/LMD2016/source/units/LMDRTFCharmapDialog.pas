unit LMDRTFCharmapDialog;
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

LMDRTFCharmapDialog unit (RM)
-----------------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ToolWin, ComCtrls, ExtCtrls, StdCtrls,
  LMDRTFBase, LMDRTFRichEdit, LMDRTFFontComboBox;

type

  { ************************************************************************** }
  TfrmLMDRTFCharmapDialog = class(TForm)
    lblFont: TLabel;
    lblCharSet: TLabel;
    cbCharSet: TComboBox;
    CharTable: TPaintBox;
    ScrollBar: TScrollBar;
    CharZoom: TPaintBox;
    edSelChar: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    cbFont: TLMDRichFontComboBox;
    procedure FormCreate(Sender: TObject);
    procedure CharTablePaint(Sender: TObject);
    procedure cbFontChange(Sender: TObject);
    procedure CharZoomPaint(Sender: TObject);
    procedure CharTableMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure CharTableDblClick(Sender: TObject);
  private
    FColPerPage : integer;
    FRowPerPage : integer;
    FCellSize   : integer;
    FSmallSize  : integer;
    FLargeSize  : integer;
    FSelOffset  : integer;
    FDblCLick:Boolean;
    function GetSelChar : string;
    function  GetFontName:TFontName;
    function  GetCharSet:TFontCharSet;
    procedure FillCharSet(const s:string);
  public
    property InsertText: string read GetSelChar;
    property FontName: TFontName read GetFontName;
    property CharSet: TFontCharSet read GetCharSet;
  end;

const
  def_CharMapFont='WingDings';

type
  TLMDRichCharmapDialog = class(TLMDRichBaseDialog)
  private
    FFontName:TFontName;
    FFontCharSet:TFontCharSet;
    FControl:TLMDCustomRichEdit;
    FInsertText:String;
    FRestoreFont:Boolean;
    function IsNotDefaultFont:Boolean;
    procedure SetControl(const Value: TLMDCustomRichEdit);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    function Execute(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;override;
    property FontCharSet:TFontCharSet read FFontCharset write FFontCharSet default 1;
    property InsertText:String read FInsertText;
  published
    property FontName:TFontName read FFontName write FFontName stored IsNotDefaultFont;
    property RichEditControl:TLMDCustomRichEdit read FControl write SetControl;
    property RestoreFont:Boolean read FRestoreFont write FRestoreFont default True;
    property OnHelpClick;
    property OnCustomize;
    property Options;
  end;

implementation
uses
  LMDRTFConst;
{$R *.DFM}

{ ************************** TLMDRTFCharmapDialog  *************************** }
{------------------------------------------------------------------------------}
function TfrmLMDRTFCharmapDialog.GetSelChar : string;
begin
  result := edSelChar.Text;
end;

{------------------------------------------------------------------------------}
function TfrmLMDRTFCharmapDialog.GetFontName: TFontName;
begin
  result:=cbFont.FontName;
end;

{------------------------------------------------------------------------------}
function TfrmLMDRTFCharmapDialog.GetCharSet: TFontCharSet;
begin
  if cbCharSet.ItemIndex=-1 then
    result:=1
  else
    result:=TFontCharSet(cbCharSet.Items.Objects[cbCharSet.ItemIndex]);
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRTFCharmapDialog.FillCharSet;
var
  tmp : LongInt;
begin
  IdentToCharset(s, tmp);

  cbCharSet.Items.AddObject(s, Pointer(tmp));

end;

{------------------------------------------------------------------------------}

procedure TfrmLMDRTFCharmapDialog.FormCreate(Sender: TObject);
begin
  cbCharSet.Items.BeginUpdate;
  GetCharsetValues(FillCharSet);
  cbCharSet.Items.EndUpdate;

  FColPerPage := 20;
  FRowPerPage := 11;
  FSmallSize  := 10;
  FLargeSize  := 60;
  FCellSize   := 24;
  FSelOffset  := 0;

  btnOk.Caption := IDRTF_OK;
  btnHelp.Caption:=IDRTF_HELP;
  btnCancel.Caption := IDRTF_CANCEL;
  LblFont.Caption := IDRTF_FONT;
  lblCharSet.Caption := IDRTF_CHARSET;
  Caption := IDRTF_CHARMAP;
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRTFCharmapDialog.CharTablePaint(Sender: TObject);
var
  R             : TRect;
  i             : integer;
  lFont         : LOGFONT;
  TM            : TTextMetric;
  CharFrom      : Char;
  CharCur       : Char;
  CharTo        : Char;
  Col           : integer;
  Row           : integer;

begin
  if [csLoading, csReading]*ComponentState<>[] then exit;

  R:= CharTable.ClientRect;
  CharTable.Canvas.Brush.Color:= clWhite;
  CharTable.Canvas.FillRect(R);

  CharTable.Canvas.Pen.Color := clBlack;
  CharTable.Canvas.Pen.Style := psSolid;

  for i := 0 to FColPerPage do
    begin
      CharTable.Canvas.MoveTo(R.Left + i*FCellSize, R.Top);
      CharTable.Canvas.LineTo(R.Left + i*FCellSize, R.Bottom);
    end;

  for i := 0 to FRowPerPage do
    begin
      CharTable.Canvas.MoveTo(R.Left, R.Top + i*FCellSize);
      CharTable.Canvas.LineTo(R.Right, R.Top + i*FCellSize);
    end;

  lFont.lfOutPrecision := OUT_DEFAULT_PRECIS;
  lFont.lfQuality := DEFAULT_QUALITY;
  lFont.lfPitchAndFamily := (240 and lFont.lfPitchAndFamily) or DEFAULT_PITCH ;
  lFont.lfHeight := -MulDiv(FSmallSize, GetDeviceCaps(CharTable.Canvas.Handle, LOGPIXELSY), 72);
  lFont.lfWidth := 0;
  lFont.lfEscapement := 0;
  lFont.lfOrientation := 0;
  lFont.lfWeight := FW_NORMAL;
  lFont.lfCharSet := CharSet;

  StrPCopy(lFont.lfFaceName, cbFont.FontName);

  lFont.lfItalic := 0;
  lFont.lfUnderline := 0;
  lFont.lfStrikeOut := 0;

  SelectObject (CharTable.Canvas.Handle, CreateFontIndirect (lFont)) ;
  if GetTextMetrics(CharTable.Canvas.Handle, TM) then
    begin
      ScrollBar.Max := Trunc((Integer(TM.tmLastChar) - integer(TM.tmFirstChar))/(FRowPerPage*FColPerPage));
      ScrollBar.Enabled:=ScrollBar.Max>0;
      CharFrom := Char(integer(TM.tmFirstChar) + ScrollBar.Position*FColPerPage);
      CharCur := CharFrom;
      if Ord(TM.tmLastChar)<255 then CharTo:=TM.tmLastChar else CharTo:=Chr(255);
      row:=0; col:=0;
      while CharCur < CharTo do
        begin
          CharTable.Canvas.TextOut(Col*FCellSize+4,Row*FCellSize+4, CharCur);
          Inc(col);if col=FColPerPage then
            begin
              col:=0;
              inc(row);
              if row=FRowPerPage then break;
            end;
          CharCur := Char(Ord(CharCur) + 1);
        end;
  end;
  DeleteObject (SelectObject (CharTable.Canvas.Handle, GetStockObject (SYSTEM_FONT))) ;
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRTFCharmapDialog.cbFontChange(Sender: TObject);
begin
  ScrollBar.Position:=0;
  ScrollBar.Enabled:=True;
  CharTable.Refresh;
  edSelChar.Font.Name:=FontName;
  edSelChar.Font.CharSet:=CharSet;
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRTFCharmapDialog.CharZoomPaint(Sender: TObject);
var
  R             : TRect;
  i             : integer;
  lFont         : LOGFONT;
  TM            : TTextMetric;
  CharCur       : Char;
  SaveFont      : HFont;
begin
  R:= CharZoom.ClientRect;
  CharZoom.Canvas.Brush.Color:= clWhite;
  CharZoom.Canvas.FillRect(R);

  CharZoom.Canvas.Pen.Color := clBlack;
  CharZoom.Canvas.Pen.Style := psSolid;
  CharZoom.Canvas.Rectangle(R);

  if Sender<>self then exit;

  lFont.lfOutPrecision := OUT_DEFAULT_PRECIS;
  lFont.lfQuality := DEFAULT_QUALITY;
  lFont.lfPitchAndFamily := (240 and lFont.lfPitchAndFamily) or DEFAULT_PITCH ;
  lFont.lfHeight := -MulDiv(FLargeSize, GetDeviceCaps(CharZoom.Canvas.Handle, LOGPIXELSY), 72);
  lFont.lfWidth := 0;
  lFont.lfEscapement := 0;
  lFont.lfOrientation := 0;
  lFont.lfWeight := FW_NORMAL;
  lFont.lfCharSet := CharSet;

  StrPCopy(lFont.lfFaceName, cbFont.FontName);

  lFont.lfItalic := 0;
  lFont.lfUnderline := 0;
  lFont.lfStrikeOut := 0;

  SaveFont:=SelectObject (CharZoom.Canvas.Handle, CreateFontIndirect (lFont)) ;
  try
    if GetTextMetrics(CharZoom.Canvas.Handle, TM) then
      begin
        i:=integer(TM.tmFirstChar) + FSelOffset;
        if i>Ord(TM.tmLastChar) then
          exit;
        CharCur := Char(i);
        if CharCur < TM.tmLastChar then
          begin
            CharZoom.Canvas.TextOut(Round((CharZoom.Width - TM.tmAveCharWidth)/3)-10,Round((CharZoom.Height - TM.tmHeight)/3), CharCur);
            if FDblClick then
              edSelChar.Text := edSelChar.Text+CharCur;
            FDblClick:=False;
          end;
      end;
  finally
    SelectObject (CharZoom.Canvas.Handle, SaveFont);
  end;
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRTFCharmapDialog.CharTableDblClick(Sender: TObject);
begin
  FDblClick:=True;
end;

{------------------------------------------------------------------------------}
procedure TfrmLMDRTFCharmapDialog.CharTableMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  P : TPoint;

  function LMDFloor(X: Extended): Integer;
  begin
    Result := Integer(Trunc(X));
    if Frac(X) < 0 then Dec(Result);
  end;

begin

  P := Point(X,Y);

  P.X := LMDFloor(P.X/FCellSize);
  P.Y := LMDFloor(P.Y/FCellSize);
  FSelOffset := ScrollBar.Position*FColPerPage + (P.Y*FColPerPage) + P.X;
  CharZoomPaint(self);
end;

{ ************************** TLMDRTFCharmapDialog  *************************** }
{ ----------------------------- private -------------------------------------- }
procedure TLMDRichCharmapDialog.SetControl(const Value: TLMDCustomRichEdit);
begin
  if Value <> FControl then
    begin
      FControl:= Value;
      if Value <> nil then
        Value.FreeNotification(Self);
    end;
end;

{------------------------------------------------------------------------------}
function TLMDRichCharmapDialog.IsNotDefaultFont:Boolean;
begin
  result:=FFontName<>def_CharMapFont;
end;

{ --------------------------- protected -------------------------------------- }
procedure TLMDRichCharmapDialog.Notification(AComponent: TComponent;Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FControl) then RichEditControl:= nil;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRichCharmapDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFontCharSet:=1;
  FFontName:=def_CharMapFont;
  FRestoreFont:=True;
end;

{------------------------------------------------------------------------------}
function TLMDRichCharmapDialog.Execute(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;
var
  dlg:TfrmLMDRTFCharmapDialog;
  tmp, tmp2:LongInt;
  tmpfont:TFontName;
  tmpCharSet:TFontCharSet;
begin
  result:=false;
  tmpCharSet:=0;
  FInsertText:='';
  dlg:=TfrmLMDRTFCharmapDialog.Create(AOwner);
  with dlg do
    try
      PrepareDialog(dlg, aOwner, x, y);

      if rdoShowHelpButton in Options then
        begin
          btnHelp.Visible:=True;
          if Assigned(OnHelpClick) then btnHelp.OnClick:=OnHelpClick;
        end;

      cbFont.FontName:=self.FFontName;
    cbCharSet.ItemIndex:=cbCharSet.Items.IndexOfObject(Pointer(self.FFontCharSet));
    cbFontChange(nil);
      if ShowModal=mrOk then
        begin
          result:=true;
          self.FInsertText:=InsertText;
          FFontName:=cbFont.Text;
          IdentToCharSet(cbCharSet.Text,tmp);
          FFontCharSet:=TFontCharSet(tmp);
          if Assigned(RichEditControl) then
            begin
              if not RichEditControl.Visible or (csDesigning in ComponentState) then exit;
              if FRestoreFont then
                begin
                  tmpFont:=RichEditControl.SelAttributes.Name;
                  tmpCharSet:=RichEditControl.SelAttributes.CharSet;
                end;
              tmp:=RichEditControl.SelStart;
              RichEditControl.SelText := InsertText;
              tmp2:=RichEditControl.SelStart;
              RichEditControl.SelStart:=tmp;
              RichEditControl.SelLength:=Length(InsertText);
              RichEditControl.SelAttributes.CharSet := CharSet;
              RichEditControl.SelAttributes.Name := FontName;
              if RichEditControl.CanFocus then
                RichEditControl.SetFocus;
              RichEditControl.SelStart:=tmp2;
              RichEditControl.SelLength:=0;
              if FRestoreFont then
                begin
                  RichEditControl.SelAttributes.Name:=tmpFont;
                  RichEditControl.SelAttributes.CharSet:=tmpCharSet;
                end;
            end;
        end;
    finally
      free
    end;
end;

end.
