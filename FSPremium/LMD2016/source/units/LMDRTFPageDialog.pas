unit LMDRTFPageDialog;
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

LMDRTFPageDialog unit (RM)
--------------------------
Implementation of the System's PageSetup Dialog

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Controls, Dialogs, Commdlg, Windows, Messages, SysUtils, Classes, Forms, Printers,

  LMDRTFBase, intfLMDBase, LMDTypes;

type
  {********************** Class TLMDRTFPageSetupDialog ************************}
  TLMDRichPageType = (ptEnvelope, ptPaper);
  TLMDRichPageSetupDialogOption = (psoDefaultMinMargins, psoIgnoreMinMargins,
                                   psoDisableMargins,
                                   psoDisableOrientation, psoDisablePagePainting,
                                   psoDisablePaper, psoDisablePrinter,
                                   psoShowHelp, psoNoWarning, psoNoNetworkButton);
  TLMDRichPageSetupDialogOptions = set of TLMDRichPageSetupDialogOption;

  TLMDRichPageSetupBeforePaintEvent = procedure(Sender: TObject; PaperSize: SmallInt;
                                                Orientation: TPrinterOrientation; PageType: TLMDRichPageType;
                                                var DoneDrawing: Boolean) of object;
  TLMDRichPaintPageEvent = procedure(Sender: TObject; Handle: THandle; PageRect: TRect; var DoneDrawing: Boolean) of object;

  TLMDRichPageSetupDialog = class(TCommonDialog, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
    // Margin and common Page Settings
    FMargin,
    FMinMargin:TLMDRichPageMargins;
    FPageWidth,
    FPageHeight: Double;
    FDlgPosition:TLMDRichDialogPosition;
    //Options and unit settings
    FOptions: TLMDRichPageSetupDialogOptions;
    FUnits: TLMDMeasurement;
    //events
    FBeforePaint: TLMDRichPageSetupBeforePaintEvent;
    FOnDrawRetAddress,
    FOnDrawMinMargin,
    FOnDrawEnvStamp,
    FOnDrawFullPage,
    FOnDrawGreekText,
    FOnDrawMargin: TLMDRichPaintPageEvent;
    procedure SetUnits(aValue:TLMDMeasurement);
    procedure SetMargin(index:Integer; aValue:TLMDRichPageMargins);
  protected
  function GetDlgParentHandle:HWnd;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy;override;
    function getLMDPackage:TLMDPackageID;virtual;
    function GetDefaults: Boolean;
    function GetMinMarginDefaults:Boolean;
  function Execute: Boolean; override;
  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
    property DlgPosition:TLMDRichDialogPosition read FDlgPosition write FDlgPosition default rdpOwner;
    property Margin:TLMDRichPageMargins index 0 read FMargin write SetMargin;
    property MinMargin:TLMDRichPageMargins index 1 read FMinMargin write SetMargin;
    property Options: TLMDRichPageSetupDialogOptions read FOptions write FOptions default [psoDefaultMinMargins];
    property PageWidth: Double read FPageWidth write FPageWidth;
    property PageHeight: Double read FPageHeight write FPageHeight;
    property Units: TLMDMeasurement read FUnits write SetUnits default unMillimeters;

    property OnBeforePaint: TLMDRichPageSetupBeforePaintEvent read FBeforePaint write FBeforePaint;
    property OnDrawFullPage: TLMDRichPaintPageEvent read FOnDrawFullPage write FOnDrawFullPage;
    property OnDrawMinMargin: TLMDRichPaintPageEvent read FOnDrawMinMargin write FOnDrawMinMargin;
    property OnDrawMargin: TLMDRichPaintPageEvent read FOnDrawMargin write FOnDrawMargin;
    property OnDrawGreekText: TLMDRichPaintPageEvent read FOnDrawGreekText write FOnDrawGreekText;
    property OnDrawEnvStamp: TLMDRichPaintPageEvent read FOnDrawEnvStamp write FOnDrawEnvStamp;
    property OnDrawRetAddress: TLMDRichPaintPageEvent read FOnDrawRetAddress write FOnDrawRetAddress;
  end;

implementation
uses
  LMDUtils, LMDConversion;

var
  LMDRichDlg: TLMDRichPageSetupDialog;
//  CreationControl: TCommonDialog = nil;

function LMDRichPagePaint(Wnd: HWND; Message: UINT; wParam: WPARAM; lParam: LPARAM): {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;

const
  PageType: array[Boolean] of TLMDRichPageType = (ptEnvelope, ptPaper);
  Orientation: array[Boolean] of TPrinterOrientation = (poPortrait, poLandscape);
var
  DoneDrawing: Boolean;

begin
  if not Assigned(LMDRichDlg) then
    begin
      Result:= UINT(False);
      exit;
    end;
  DoneDrawing:= False;
  with LMDRichDlg do
    begin
    case Message of
        WM_PSD_PAGESETUPDLG:
          if Assigned(FBeforePaint) then
          FBeforePaint(LMDRichDlg, Lo(wParam), Orientation[Hi(wParam) in [$001,
              $0003, $000B, $0019]], PageType[Lo(wParam) > $000B], DoneDrawing);
          WM_PSD_FULLPAGERECT:
          if Assigned(FOnDrawFullPage) then
          FOnDrawFullPage(LMDRichDlg, wParam, PRect(lParam)^, DoneDrawing);
          WM_PSD_MINMARGINRECT:
          if Assigned(FOnDrawMinMargin) then
          FOnDrawMinMargin(LMDRichDlg, wParam, PRect(lParam)^, DoneDrawing);
          WM_PSD_MARGINRECT:
          if Assigned(FOnDrawMargin) then
          FOnDrawMargin(LMDRichDlg, wParam, PRect(lParam)^, DoneDrawing);
          WM_PSD_GREEKTEXTRECT:
          if Assigned(FOnDrawGreekText) then
          FOnDrawGreekText(LMDRichDlg, wParam, PRect(lParam)^, DoneDrawing);
          WM_PSD_ENVSTAMPRECT:
          if Assigned(FOnDrawEnvStamp) then
          FOnDrawEnvStamp(LMDRichDlg, wParam, PRect(lParam)^, DoneDrawing);
          WM_PSD_YAFULLPAGERECT:
          if Assigned(FOnDrawRetAddress) then
          FOnDrawRetAddress(LMDRichDlg, wParam, PRect(lParam)^, DoneDrawing);
          end;
    end;
  Result:= UINT(DoneDrawing);
end;

{------------------------------------------------------------------------------}

function LMDRichDialogHook(Wnd: HWnd; Msg: UINT; WParam: WPARAM; LParam:
  LPARAM): {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;

begin
  Result:= 0;
  if Msg = WM_INITDIALOG then
    begin
      if LMDRichDlg.FDlgPosition=rdpScreen then
        LMDCenterWindow(Wnd);
      Result:= 1;
    end;
end;

{********************** Class TLMDRichPageSetupDialog *************************}
{------------------------- Private --------------------------------------------}
procedure TLMDRichPageSetupDialog.SetUnits(aValue:TLMDMeasurement);
begin
  if aValue<>FUnits then
    begin
      FUnits:=aValue;
      FMargin.Units:=FUnits;
      FMinMargin.Units:=FUnits;
//      if not (csLoading in ComponentState) then
//        GetDefaults;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichPageSetupDialog.SetMargin(index:Integer; aValue:TLMDRichPageMargins);
begin
  case index of
    0: FMargin.Assign(aValue);
    1: FMinMargin.Assign(aValue);
  end;
end;

{------------------------------------------------------------------------------}
function TLMDRichPageSetupDialog.GetMinMarginDefaults:Boolean;
var
  PageSetupDlgRec: TPageSetupDlg;
begin

  FillChar(PageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);

  with PageSetupDlgRec do
    begin
    lStructSize := SizeOf(PageSetupDlgRec);
      hInstance:= SysInit.HInstance;
    hwndOwner := 0;
      Flags := Flags or PSD_INTHOUSANDTHSOFINCHES or PSD_DEFAULTMINMARGINS or PSD_RETURNDEFAULT;
      Result := PageSetupDlg(PageSetupDlgRec);
      if Result then
        begin
          FMinMargin.Units := unInches;
          FMinMargin.AsRect :=rtMinMargin;
          FMinMargin.Units := self.Units;
          if hDevMode <> 0 then GlobalFree(hDevMode);
          if hDevNames <> 0 then GlobalFree(hDevNames);
        end;
    end;
end;

{------------------------------------------------------------------------------}
function TLMDRichPageSetupDialog.GetDefaults: Boolean;
var
  PageSetupDlgRec: TPageSetupDlg;
begin

  FillChar(PageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);

  with PageSetupDlgRec do
    begin
    lStructSize:= SizeOf(PageSetupDlgRec);
      hInstance:= SysInit.HInstance;
    hwndOwner:= 0;
      Flags:= Flags or PSD_INTHOUSANDTHSOFINCHES or PSD_DEFAULTMINMARGINS
        or PSD_RETURNDEFAULT;
      Result:= PageSetupDlg(PageSetupDlgRec);
      if Result then
        begin
          FMinMargin.Units := unInches;
          FMinMargin.AsRect:=rtMinMargin;
          FMinMargin.Units := self.Units;

          FMargin.Units := unInches;
          FMargin.AsRect:=rtMargin;
          FMargin.Units := self.Units;

          FPageWidth := LMDConvertUnits(ptPaperSize.X * InchFactor / 1000,
              unInches, self.Units);
          FPageHeight := LMDConvertUnits(ptPaperSize.Y * InchFactor / 1000,
              unInches, self.Units);
          if hDevMode <> 0 then GlobalFree(hDevMode);
          if hDevNames <> 0 then GlobalFree(hDevNames);
        end;
    end;
end;
{------------------------- Protected ------------------------------------------}

function  TLMDRichPageSetupDialog.GetDlgParentHandle:HWnd;
begin
  result:=0;  // Desktop
  case FDlgPosition of
    rdpOwner:
      if Owner is TWinControl then
        result:=TWinControl(Owner).Handle;
    rdpMainForm:
      result:=Application.Mainform.Handle;
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDRichPageSetupDialog.Create(aOwner: TComponent);
begin
  inherited Create(AOwner);
  Options:= [psoDefaultMinMargins];
  FMargin:=TLMDRichPageMargins.Create;
  FMinMargin:=TLMDRichPageMargins.Create;
  FUnits := unPoints;

  //GetDefaults;
end;

{------------------------------------------------------------------------------}
destructor TLMDRichPageSetupDialog.Destroy;
begin
  FreeAndNil(FMargin);
  FreeAndNil(FMinMargin);
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
function TLMDRichPageSetupDialog.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{------------------------------------------------------------------------------}

function TLMDRichPageSetupDialog.Execute: Boolean;

const
  PrintRanges: array[TPrintRange] of Integer = (PD_ALLPAGES, PD_SELECTION, PD_PAGENUMS);

var
  PageSetupDlgRec: TPageSetupDlg;
  DevHandle: THandle;

  {----------------------------------------------------------------------------}

  function CopyData(Handle: THandle): THandle;
  var
  Src, Dest: PChar;
  Size:      Integer;
  begin
    if Handle <> 0 then
    begin
      Size   := GlobalSize(Handle);
      Result := GlobalAlloc(GHND, Size);

      if Result <> 0 then
      try
        Src  := GlobalLock(Handle);
        Dest := GlobalLock(Result);
        if (Src <> nil) and (Dest <> nil) then
          Move(Src^, Dest^, Size);
      finally
        GlobalUnlock(Handle);
        GlobalUnlock(Result);
      end;
    end
    else
      Result := 0;
  end;

  {----------------------------------------------------------------------------}

  procedure GetPrinter(var DeviceMode, DeviceNames: THandle);
  var
    Device, Driver, Port: array[0..79] of Char;
    DevNames: PDevNames;
    Offset: PChar;
    sz: Integer;
  begin
    Printer.GetPrinter(Device, Driver, Port, DeviceMode);

    if DeviceMode <> 0 then
    begin
      sz := SizeOf(TDevNames) + (StrLen(Device) + StrLen(Driver) +
            StrLen(Port) + 3) * SizeOf(Char);
      DeviceNames := GlobalAlloc(GHND, sz);
      DevNames := PDevNames(GlobalLock(DeviceNames));
      try
        Offset:= PChar(DevNames) + SizeOf(TDevnames);
        with DevNames^ do
        begin
          wDriverOffset:= TLMDPtrInt(Offset) - TLMDPtrInt(DevNames);
          Offset:= StrECopy(Offset, Driver) + 1;
          wDeviceOffset:= TLMDPtrInt(Offset) - TLMDPtrInt(DevNames);
          Offset:= StrECopy(Offset, Device) + 1;
          wOutputOffset:= TLMDPtrInt(Offset) - TLMDPtrInt(DevNames);

          StrCopy(Offset, Port);
        end;
      finally
        GlobalUnlock(DeviceNames);
      end;
    end;
  end;

  {----------------------------------------------------------------------------}

  procedure SetPrinter(DeviceMode, DeviceNames: THandle);
  var
    DevNames: PDevNames;
  begin
    DevNames:= PDevNames(GlobalLock(DeviceNames));
    try
      with DevNames^ do
        Printer.SetPrinter(PChar(DevNames) + wDeviceOffset,
          PChar(DevNames) + wDriverOffset,
          PChar(DevNames) + wOutputOffset, DeviceMode);
    finally
      GlobalUnlock(DeviceNames);
      GlobalFree(DeviceNames);
    end;
  end;

var
  IsMetric: Boolean;

begin
  // Retrieve default values
  if psoDefaultMinMargins in FOptions then
    GetMinMarginDefaults;

  // check Values
  if not (psoIgnoreMinMargins in FOptions) then
    begin
      if FMargin.Left<FMinMargin.Left then FMargin.Left:=FMinMargin.Left;
      if FMargin.Top<FMinMargin.Top then FMargin.Top:=FMinMargin.Top;
      if FMargin.Right<FMinMargin.Right then FMargin.Right:=FMinMargin.Right;
      if FMargin.Bottom<FMinMargin.Bottom then FMargin.Bottom:=FMinMargin.Bottom;
    end;

  IsMetric := (StrToIntDef(GetLocaleChar(GetThreadLocale, LOCALE_IMEASURE, '0'), 0) = 0);

  FillChar(PageSetupDlgRec, SizeOf(PageSetupDlgRec), 0);

  with PageSetupDlgRec do
    begin
      hwndOwner := GetDlgParentHandle;
      hInstance := SysInit.HInstance;
      lStructSize := SizeOf(PageSetupDlgRec);

      GetPrinter(DevHandle, hDevNames);
      hDevMode := CopyData(DevHandle);
    //      Flags:= PSD_RETURNDEFAULT;
//      PageSetupDlg(PageSetupDlgRec);
      Flags:= PSD_ENABLEPAGEPAINTHOOK or PSD_ENABLEPAGESETUPHOOK or PSD_MARGINS;

      case FUnits of
        unPoints: ;   //  System default
        unInches: IsMetric := False;
        unMillimeters: IsMetric := True;
      end;

      if  IsMetric  then
        begin
          FMargin.Units := unMillimeters;
          FMinMargin.Units := unMillimeters;
        end
      else
        begin
          FMargin.Units := unInches;
          FMinMargin.Units := unInches;
        end;
{
      case FUnits of
        unPoints:
          begin
            if  IsMetric  then
              Flags:= Flags or PSD_INHUNDREDTHSOFMILLIMETERS
            else
              Flags:= Flags or PSD_INTHOUSANDTHSOFINCHES;
          end;
        unInches: Flags:= Flags or PSD_INTHOUSANDTHSOFINCHES;
        unMillimeters: Flags:= Flags or PSD_INHUNDREDTHSOFMILLIMETERS;
      end;
}

      rtMargin:= FMargin.AsRect;
      if psoIgnoreMinMargins in FOptions then
      rtMinMargin := Bounds(0,0,0,0)
      else
        rtMinMargin:=FMinMargin.AsRect;

      Flags := Flags or PSD_MINMARGINS;
      if psoDisableMargins in FOptions then
        Flags := Flags or PSD_DisableMargins;
      if psoDisableOrientation in FOptions then
        Flags := Flags or PSD_DISABLEORIENTATION;
      if psoDisablePagePainting in FOptions then
        Flags := Flags or PSD_DISABLEPAGEPAINTING
      else
        begin
          LMDRichDlg:= Self;
          lpfnPagePaintHook:= LMDRichPagePaint;
        end;
      if psoDisablePaper in FOptions then
        Flags := Flags or PSD_DISABLEPAPER;
      if psoDisablePrinter in FOptions then
        Flags := Flags or PSD_DISABLEPRINTER;
      if psoShowHelp in FOptions then
        Flags := Flags or PSD_SHOWHELP;
      if psoNoWarning in FOptions then
        Flags := Flags or PSD_NOWARNING;

      if  FPageWidth > 0  then
        ptPaperSize.x := Round(FPageWidth*FMargin.UnitFactor);

      if  FPageHeight > 0 then
        ptPaperSize.y := Round(FPageHeight*FMargin.UnitFactor);

      lpfnPageSetupHook:= LMDRichDialogHook;

    Result := TaskModalDialog(@PageSetupDlg, PageSetupDlgRec);
    try
        if Result then
          begin
            SetPrinter(hDevMode, hDevNames);
            FMargin.AsRect:=rtMargin;
            //FMinMargin.AsRect:=rtMinMargin;
            FPageWidth := LMDConvertUnits(ptPaperSize.X / FMargin.UnitFactor,
                                          FMargin.Units, self.Units);
            FPageHeight := LMDConvertUnits(ptPaperSize.Y / FMargin.UnitFactor,
                                               FMargin.Units, self.Units);

  //          if hDevMode <> 0 then GlobalFree(hDevMode);
  //          if hDevNames <> 0 then GlobalFree(hDevNames);
          end;

        FMargin.Units := self.Units;
        FMinMargin.Units := self.Units;
      finally
      end;
    end;
end;

end.
