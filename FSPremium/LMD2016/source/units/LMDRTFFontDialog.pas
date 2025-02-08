unit LMDRTFFontDialog;
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

LMDRTFFontDialog unit (RM)
--------------------


Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, LMDTypes,
  CommDlg, LMDRTFRichEdit;

type
{ ************************** TLMDRTFFontDialog  *************************** }
  TLMDRTFFontDialog = class(TCommonDialog)
  private
    FDisabled      : Boolean;
    FLink          : Boolean;
    FRevised       : Boolean;
    FHidden        : Boolean;
    FRichEdit      : TLMDCustomRichEdit;
    FAttributeType : TLMDAttributeType;
    FSubscriptStyle: TLMDRichSubscriptStyle;
    FUnderlineType : TLMDUnderlineType;
    FBkColor       : TColor;
  procedure UpdateFromLogFont(const LogFont: TLogFont);
    function GetTextAttributes: TLMDTextAttributes;
    procedure SetRichEdit(Value: TLMDCustomRichEdit);
    procedure SetAttributeType(Value: TLMDAttributeType);
  protected
  public
    constructor Create(aOwner: TComponent); override;
  function Execute: Boolean; override;
  property TextAttributes: TLMDTextAttributes read GetTextAttributes;
  published
    property RichEdit: TLMDCustomRichEdit read FRichEdit write SetRichEdit;
    property AttributeType: TLMDAttributeType read FAttributeType write SetAttributeType default atDefaultText;
  end;

implementation

uses Printers;

const
  IDC_DISABLED = 1001;
  IDC_HIDDEN = 1002;
  IDC_REVISED = 1003;
  IDC_LINK = 1004;
  cmb6 = $475;
  cmb7 = $476;
  cmb8 = $477;

  ColorValues: array[0..16] of TColor = (clNone,
    clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal, clGray,
    clSilver, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);

var
  FontDialog: TLMDRTFFontDialog;

{ ************************** TLMDRTFFontDialog  *************************** }
{ ------------------------------------------------------------------------- }

function DialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM): UINT;
  stdcall;

{ Center the given window on the screen }

  procedure CenterWindow(Wnd: HWnd);
  var
    Rect: TRect;
    Monitor: TMonitor;
  begin
    GetWindowRect(Wnd, Rect);
    if Application.MainForm <> nil then
      Monitor:= Application.MainForm.Monitor
    else
      Monitor:= Screen.Monitors[0];
    SetWindowPos(Wnd, 0,
      Monitor.Left + ((Monitor.Width - Rect.Right + Rect.Left) div 2),
      Monitor.Top + ((Monitor.Height - Rect.Bottom + Rect.Top) div 3),
      0, 0, SWP_NOACTIVATE or SWP_NOSIZE or SWP_NOZORDER);
  end;

var
  I: LongInt;
const
  txtSS: array[0..2] of string = ('None', 'Subscript', 'Superscript');
  txtUT: array[0..7] of string = ('None', 'Solid', 'Word', 'Dotted', 'Dash',
    'DashDot', 'DashDotDot', 'Thick');
begin
  Result:= 0;
  if Msg = WM_INITDIALOG then
    begin
      CenterWindow(Wnd);
      SendDlgItemMessage(Wnd, IDC_REVISED, BM_SETCHECK,
        Ord(FontDialog.FRevised), 0);
      SendDlgItemMessage(Wnd, IDC_LINK, BM_SETCHECK, Ord(FontDialog.FLink), 0);
      SendDlgItemMessage(Wnd, IDC_DISABLED, BM_SETCHECK,
        Ord(FontDialog.FDisabled), 0);
      SendDlgItemMessage(Wnd, IDC_HIDDEN, BM_SETCHECK, Ord(FontDialog.FHidden),
        0);
      for I:= 0 to 7 do
        SendDlgItemMessage(Wnd, cmb7, CB_ADDSTRING, 0,
          Windows.LPARAM(PChar(txtUT[I])));
      SendDlgItemMessage(Wnd, cmb7, CB_SETCURSEL,
        Ord(FontDialog.FUnderlineType), 0);
      for I:= 0 to 2 do
        SendDlgItemMessage(Wnd, cmb8, CB_ADDSTRING, 0,
          Windows.LPARAM(PChar(txtSS[I])));
      SendDlgItemMessage(Wnd, cmb8, CB_SETCURSEL,
        Ord(FontDialog.FSubscriptStyle), 0);
      for I:= 0 to 16 do
        begin
          SendDlgItemMessage(Wnd, cmb6, CB_ADDSTRING, 0,
            Windows.LPARAM(PChar(Copy(ColorToString(ColorValues[I]), 3, MaxInt))));
          SendDlgItemMessage(Wnd, cmb6, CB_SETITEMDATA, I,
            Windows.LPARAM(ColorValues[I]));
        end;
      for I:= 0 to 16 do
        begin
          if FontDialog.FBkColor = ColorValues[I] then
            begin
              SendDlgItemMessage(Wnd, cmb6, CB_SETCURSEL, I, 0);
              Exit;
            end;
        end;
      SendDlgItemMessage(Wnd, cmb6, CB_SETCURSEL, 0, 0);
    end;
end;

{ ------------------------------------------------------------------------- }

function FontDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam: LPARAM):
{$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;

const
  ColorWidth = 25;
var
  Canvas: TCanvas;
  ARect: TRect;
  Text: array[0..255] of Char;
begin
  Result:= 1;
  if (Msg = WM_COMMAND) and (TLMDIntRec(WParam).Hi = BN_CLICKED) then
    case TLMDIntRec(WParam).Lo of
      IDC_DISABLED:
        FontDialog.FDisabled:= SendDlgItemMessage(Wnd, IDC_DISABLED,
          BM_GETCHECK, 0, 0) = BST_CHECKED;
      IDC_LINK:
        FontDialog.FLink:= SendDlgItemMessage(Wnd, IDC_LINK,
          BM_GETCHECK, 0, 0) = BST_CHECKED;
      IDC_REVISED:
        FontDialog.FRevised:= SendDlgItemMessage(Wnd, IDC_REVISED,
          BM_GETCHECK, 0, 0) = BST_CHECKED;
      IDC_HIDDEN:
        FontDialog.FHidden:= SendDlgItemMessage(Wnd, IDC_HIDDEN,
          BM_GETCHECK, 0, 0) = BST_CHECKED;
    else
      Result:= DialogHook(Wnd, Msg, wParam, lParam);
    end
  else if (Msg = WM_COMMAND) and (TLMDIntRec(WParam).Hi = CBN_SELCHANGE) then
    begin
      case TLMDIntRec(WParam).Lo of
        cmb6:
          begin
            FontDialog.FBkColor:=
              TColor(SendDlgItemMessage(Wnd, cmb6, CB_GETITEMDATA,
              SendDlgItemMessage(Wnd, cmb6, CB_GETCURSEL, 0, 0), 0));
          end;
        cmb7:
          FontDialog.FUnderlineType:=
            TLMDUnderlineType(SendDlgItemMessage(Wnd, cmb7, CB_GETCURSEL, 0,
            0));
        cmb8:
          FontDialog.FSubscriptStyle:=
            TLMDRichSubscriptStyle(SendDlgItemMessage(Wnd, cmb8, CB_GETCURSEL, 0,
            0));
      else
        Result:= DialogHook(Wnd, Msg, wParam, lParam);
      end
    end
  else if (Msg = WM_DRAWITEM) and (WParam = cmb6) then
    begin
      Canvas:= TCanvas.Create;
      try
        Canvas.Handle:= PDrawItemStruct(LParam)^.hDC;
        aRect:= PDrawItemStruct(LParam)^.rcItem;
        Inc(aRect.Top, 1);
        Inc(aRect.Left, 1);
        Dec(aRect.Bottom, 1);
        aRect.Right:= aRect.Left + ColorWidth;
        with Canvas do
          begin
            if (PDrawItemStruct(LParam)^.itemState and ODS_SELECTED) <> 0 then
              begin
                Brush.Color:= clHighlight;
                Font.Color:= clWhite;
              end;
            FillRect(PDrawItemStruct(LParam)^.rcItem);
            SendDlgItemMessage(Wnd, cmb6, CB_GETLBTEXT,
              PDrawItemStruct(LParam)^.itemID, TLMDPtrInt(@Text));
            PDrawItemStruct(LParam)^.rcItem.Left:=
              PDrawItemStruct(LParam)^.rcItem.Left + ColorWidth + 6;
            DrawText(Handle, Text, StrLen(Text),
              PDrawItemStruct(LParam)^.rcItem,
              DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
            Pen.Color:= clBlack;
            Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
            if TColor(SendDlgItemMessage(Wnd, cmb6, CB_GETITEMDATA,
              PDrawItemStruct(LParam)^.itemID, 0)) <> clNone then
              Brush.Color:= TColor(SendDlgItemMessage(Wnd, cmb6, CB_GETITEMDATA,
                PDrawItemStruct(LParam)^.itemID, 0))
            else
              Brush.Color:= clWindow;
            InflateRect(aRect, -1, -1);
            FillRect(aRect);
          end;
      finally
        Canvas.Free;
      end;
    end
  else
    Result:= DialogHook(Wnd, Msg, wParam, lParam);
end;

{ ------------------------------------------------------------------------- }

{ ------------------------------------------------------------------------- }

constructor TLMDRTFFontDialog.Create(aOwner: TComponent);
begin
  inherited;
  FAttributeType:= atDefaultText;
  FRichEdit := nil;
  Template := 'LMDFONTEDITORDLG';
end;

{ ------------------------------------------------------------------------- }

{ ------------------------------------------------------------------------- }

procedure TLMDRTFFontDialog.UpdateFromLogFont(const LogFont: TLogFont);
var
  Style: TFontStyles;
  DC: HDC;
begin
  with LogFont do
    begin
      TextAttributes.Name:= lfFaceName;
      TextAttributes.Charset:= TFontCharset(lfCharSet);
      Style:= [];
      if lfWeight > FW_REGULAR then Include(Style, fsBold);
      if lfItalic <> 0 then Include(Style, fsItalic);
      if lfUnderline <> 0 then Include(Style, fsUnderline);
      if lfStrikeOut <> 0 then Include(Style, fsStrikeOut);
      TextAttributes.Style:= Style;
      DC:= GetDC(0);
//      TextAttributes.Size:= -Trunc(lfHeight*75/GetDeviceCaps(DC, LOGPIXELSY));//-MulDiv(lfHeight, 75, GetDeviceCaps(DC, LOGPIXELSY));
      TextAttributes.Size:= -MulDiv(lfHeight, 72, GetDeviceCaps(DC, LOGPIXELSY));
      ReleaseDC(0, DC);
    end;
end;

{ ------------------------------------------------------------------------- }

{ ------------------------------------------------------------------------- }

function TLMDRTFFontDialog.Execute: Boolean;

var
  ChooseFontRec: TChooseFont;
  LogFont: TLogFont;
  SaveFontDialog: TLMDRTFFontDialog;
  OriginalFaceName: string;

begin
  with LogFont do
    begin
      lfHeight := TextAttributes.Height;
      lfWidth := 0;
      lfEscapement := 0;
      lfOrientation := 0;
      if fsBold in TextAttributes.Style then
        lfWeight := FW_BOLD
      else
        lfWeight := FW_NORMAL;
      lfItalic:= Ord(fsItalic in TextAttributes.Style);
      lfUnderline := 0;
      lfStrikeOut := Ord(fsStrikeOut in TextAttributes.Style);
      lfCharSet := TextAttributes.Charset;
      lfPitchAndFamily := DEFAULT_PITCH;
    StrCopy(@lfFaceName, PChar(TextAttributes.Name));
    end;

  with ChooseFontRec do
    begin
    lStructSize := SizeOf(ChooseFontRec);
    hDC := 0;
    lpLogFont := @LogFont;
    try
        OriginalFaceName := LogFont.lfFaceName;
        Flags:= CF_SCREENFONTS or CF_INITTOLOGFONTSTRUCT or CF_ENABLEHOOK or
          CF_EFFECTS;
      hInstance := SysInit.HInstance;
      if Template <> '' then
          begin
            Flags:= Flags or CF_ENABLETEMPLATE;
            lpTemplateName := Template;
          end;
        rgbColors := TextAttributes.Color;
        lCustData := 0;
      lpfnHook := FontDialogHook;
      nSizeMin := 0;
        nSizeMax := 0;
        if nSizeMin > nSizeMax then Flags:= Flags and (not CF_LIMITSIZE);

        hWndOwner := Application.Handle;
        SaveFontDialog := FontDialog;
        FontDialog := Self;
        FDisabled := TextAttributes.Disabled;
        FLink := TextAttributes.Link;
        FRevised := TextAttributes.Revised;
        FHidden := TextAttributes.Hidden;
        FUnderlineType := TextAttributes.UnderlineType;
        FSubscriptStyle := TextAttributes.SubscriptStyle;
        FBkColor := TextAttributes.BackColor;
      Result := TaskModalDialog(@ChooseFont, ChooseFontRec);
      try
          if Result then begin
          FontDialog := SaveFontDialog;
            UpdateFromLogFont(LogFont);
            TextAttributes.Color := rgbColors;
            TextAttributes.Disabled := FDisabled;
            TextAttributes.Link := FLink;
            TextAttributes.Revised := FRevised;
            TextAttributes.Hidden := FHidden;
            TextAttributes.UnderlineType := FUnderlineType;
            TextAttributes.SubscriptStyle := FSubscriptStyle;
            TextAttributes.BackColor := FBkColor;
          end;
        finally
        end;
      finally
      end;
    end;
end;

{ ------------------------------------------------------------------------- }

function TLMDRTFFontDialog.GetTextAttributes: TLMDTextAttributes;
begin
  Result:= nil;
  if Assigned(FRichEdit) then
    case AttributeType of
      atDefaultText: Result:= FRichEdit.DefAttributes;
      atSelected: Result:= FRichEdit.SelAttributes;
      atWord: Result:= FRichEdit.WordAttributes;
    end
  else
    raise Exception.Create('You must specify ''RichEdit'' property!');
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFFontDialog.SetRichEdit(Value: TLMDCustomRichEdit);
begin
  if Value <> FRichEdit then begin
    FRichEdit := Value;
  end;
end;

{ ------------------------------------------------------------------------- }

procedure TLMDRTFFontDialog.SetAttributeType(Value: TLMDAttributeType);
begin
  if Value <> FAttributeType then begin
    FAttributeType := Value;
  end;
end;

end.
