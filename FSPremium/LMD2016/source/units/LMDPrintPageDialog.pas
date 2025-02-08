unit LMDPrintPageDialog;
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

LMDPrintPageDialog unit
-----------------------
Implementation of the System's PageSetup Dialog and other PrintPack dialogs

Changes
-------
Release 1.05 (February 2008)
- Problem with Printer property at designtime fixed.

Release 1.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  CommDlg,  Controls, Dialogs, Windows, Messages, SysUtils, Classes, Forms,
  Printers, ComCtrls, Graphics,
  intfLMDBase, LMDTypes, LMDPrinter;

type
  {********************** Class TLMDPrintPageSetupDialog **********************}
  TLMDPageSetupDialogPosition = (rdpOwner, rdpMainForm, rdpScreen);

  TLMDPageSetupDialogOption = (psoDisableMargins, psoDisableOrientation,
                               psoDisablePagePainting, psoDisablePaper,
                               psoDisablePrinter, psoDisableHeaderFooter,
                               psoShowHelp, psoWarning, psoNoNetworkButton);

  TLMDPageSetupDialogOptions = set of TLMDPageSetupDialogOption;

const
  LMDPageSetupDefaultOptions = [];

type

  TLMDPaintPageEvent = procedure(Sender: TObject; Canvas: TCanvas;
                                 PageRect: TRect;
                                 var DoneDrawing: Boolean) of object;

  TLMDPageType = (ptEnvelope, ptPaper);

  TLMDPageSetupBeforePaintEvent = procedure (Sender: TObject;
                                             const PaperSize: SmallInt;
                                             const Orientation: TPrinterOrientation;
                                             const PageType: TLMDPageType;
                                             var DoneDrawing: Boolean) of object;

  {************************* TLMDPrintBaseDialog ******************************}
  TLMDPrintBaseDialog = class(TCommonDialog, ILMDComponent)
  private
    FAbout: TLMDAboutVar;
  protected
    FPrinter: TLMDPrinterBase;

    procedure SetPrinter(const Value: TLMDPrinterBase); virtual;
    function  DoExecute(ParentWnd: HWND): Boolean; virtual; abstract;

    procedure Notification(AComponent: TComponent; Operation: TOperation); override ;
    procedure CheckPrinterSet;
    property Printer: TLMDPrinterBase read FPrinter write SetPrinter;

  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function getLMDPackage: TLMDPackageID;

    {$IFDEF LMDCOMP9}
    function Execute(ParentWnd: HWND): Boolean; override;
    {$ELSE}
    function Execute: Boolean; override;
    {$ENDIF}

  published
    property About: TLMDAboutVar read FAbout write FAbout stored false;
  end;

  {************************* TLMDPrintPageSetupDialog *************************}
  TLMDPrintPageSetupDialog = class(TLMDPrintBaseDialog)
  private
    // Margin and common Page Settings
    FMargin: TLMDDoubleRect;
    //Options and unit settings
    FOptions: TLMDPageSetupDialogOptions;
    //events
    FBeforePaint: TLMDPageSetupBeforePaintEvent;
    FOnDrawRetAddress,
    FOnDrawMinMargin,
    FOnDrawEnvStamp,
    FOnDrawFullPage,
    FOnDrawGreekText,
    FOnDrawMargin: TLMDPaintPageEvent;

    FTmpPrinter: TLMDPrinter;

    FDlgPosition: TLMDPageSetupDialogPosition;
    procedure SetMargin(const AValue: TLMDDoubleRect);
    function IntToUnitsRect(const ARect: TRect): TLMDDoubleRect;
    function UnitsToIntRect(const ARect: TLMDDoubleRect): TRect;
    function IntToUnits(AInt: Integer): Double;
    function UnitsToInt(AUnits: Double): Integer;
    function GetDlgParentHandle: HWnd;
    procedure SetHeader(const Value: TStrings);
    function  GetHeader: TStrings;
    function  GetFooter: TStrings;
    procedure SetFooter(const Value: TStrings);
  protected
    function DoExecute(ParentWnd: HWND): Boolean; override;
    procedure SetPrinter(const Value: TLMDPrinterBase); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;

    property Margins: TLMDDoubleRect read FMargin write SetMargin;
  published
    property Printer;

    property HeaderTemplate: TStrings read  GetHeader
                                      write SetHeader;

    property FooterTemplate: TStrings read  GetFooter
                                      write SetFooter;

    property Options: TLMDPageSetupDialogOptions read FOptions write FOptions
                                                 default LMDPageSetupDefaultOptions;

    property DlgPosition: TLMDPageSetupDialogPosition read FDlgPosition
                                                      write FDlgPosition
                                                      default rdpOwner;

    property OnBeforePaint: TLMDPageSetupBeforePaintEvent read FBeforePaint
                                                          write FBeforePaint;
    property OnDrawFullPage:  TLMDPaintPageEvent read FOnDrawFullPage
                                                 write FOnDrawFullPage;
    property OnDrawMinMargin: TLMDPaintPageEvent read FOnDrawMinMargin
                                                 write FOnDrawMinMargin;
    property OnDrawMargin:    TLMDPaintPageEvent read FOnDrawMargin
                                                 write FOnDrawMargin;
    property OnDrawGreekText: TLMDPaintPageEvent read FOnDrawGreekText
                                                 write FOnDrawGreekText;
    property OnDrawEnvStamp:  TLMDPaintPageEvent read FOnDrawEnvStamp
                                                 write FOnDrawEnvStamp;
    property OnDrawRetAddress: TLMDPaintPageEvent read FOnDrawRetAddress
                                                  write FOnDrawRetAddress;
  end;

  {************************* TLMDPrintDialog **********************************}
  TLMDPrintDialog = class(TLMDPrintBaseDialog)
  private
    FFromPage: Integer;
    FToPage: Integer;
    FCollate: Boolean;
    FOptions: TPrintDialogOptions;
    FPrintToFile: Boolean;
    FPrintRange: TPrintRange;
    FMinPage: Integer;
    FMaxPage: Integer;
    FCopies: Integer;
    procedure SetNumCopies(Value: Integer);
  protected
    function DoExecute(ParentWnd: HWND): Boolean; override;
  published
    property Printer;

    property Collate: Boolean read FCollate write FCollate default False;
    property Copies: Integer read FCopies write SetNumCopies default 0;
    property FromPage: Integer read FFromPage write FFromPage default 0;
    property MinPage: Integer read FMinPage write FMinPage default 0;
    property MaxPage: Integer read FMaxPage write FMaxPage default 0;
    property Options: TPrintDialogOptions read FOptions write FOptions default [];
    property PrintToFile: Boolean read FPrintToFile write FPrintToFile default False;
    property PrintRange: TPrintRange read FPrintRange write FPrintRange default prAllPages;
    property ToPage: Integer read FToPage write FToPage default 0;
  end;

  {************************* TLMDPrinterSetupDialog ***************************}
  TLMDPrinterSetupDialog = class(TLMDPrintBaseDialog)
  protected
    function DoExecute(ParentWnd: HWND): Boolean; override;
  published
    property Printer;
  end;

implementation
uses
  Math,
  LMDUtils, LMDConversion, LMDPrintTemplateEditDlg, LMDPrintConst
  ;

const HeaderBtnID = 5001; FooterBtnID = 5002; PaperGroupID = 1073;
      SizeLabelID = 1089; PaperFeedLabelID = 1090; OrientGroupID = 1072;
      PortraitRadioID = 1056; LandscapeRadioID = 1057; MarginsGroupID = 1075;
      LeftMarginLabelID = 1102; RightMarginLabelID = 1103;
      TopMarginLabelID = 1104; BottomMarginLabelID = 1105;
      OkButtonID = 1; CancelButtonID = 2; PrinterButtonID = 1026;
      HelpButtonID = 1038; HeaderButtonID = 5001; FooterButtonID = 5002;

{------------------------------------------------------------------------------}

function LMDPagePaint(Wnd: HWND; Message: UINT; wParam: WPARAM; lParam: LPARAM): {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;

const
  PageType: array[Boolean] of TLMDPageType = (ptEnvelope, ptPaper);
  Orientation: array[Boolean] of TPrinterOrientation = (poPortrait, poLandscape);
var
  DoneDrawing: Boolean;
  R : TRect;
  Dlg: TLMDPrintPageSetupDialog;

  procedure TriggerEvent(Event: TLMDPaintPageEvent);
  var
    Canvas: TCanvas;
  begin
    Canvas := TCanvas.Create;
    try
      Canvas.Handle := HDC(wParam);
      if Assigned(Event) then
        Event(Dlg, Canvas, R, DoneDrawing);
    finally
      Canvas.Free;
    end;
  end;

var
    Cust: Integer;
    DlgData: TPAGESETUPDLG;

begin
  DoneDrawing := False;

  case Message of
    WM_PSD_PAGESETUPDLG,
    WM_PSD_FULLPAGERECT,
    WM_PSD_MINMARGINRECT,
    WM_PSD_MARGINRECT,
    WM_PSD_GREEKTEXTRECT,
    WM_PSD_ENVSTAMPRECT,
    WM_PSD_YAFULLPAGERECT:
    begin
    R := PRect(lParam)^;
    Cust := GetWindowLong(Wnd, GWL_USERDATA);

      Dlg := TLMDPrintPageSetupDialog(Cust);
      end;
  end;

  case Message of
    WM_PSD_PAGESETUPDLG:
    begin
    DlgData := PPAGESETUPDLG(lParam)^;
      Dlg := TLMDPrintPageSetupDialog(DlgData.lCustData);
    SetWindowLong(Wnd, GWL_USERDATA, DlgData.lCustData);

      if Assigned(Dlg.FBeforePaint) then
        Dlg.FBeforePaint(Dlg,
                         WParam and $FFFF,
                         Orientation[WParam shr 16 in
                                     [$001, $0003, $000B, $0019]],
                         PageType[WParam shr 16 > $000B],
                         DoneDrawing);
    end;

    WM_PSD_FULLPAGERECT  : TriggerEvent(Dlg.FOnDrawFullPage);
    WM_PSD_MINMARGINRECT : TriggerEvent(Dlg.FOnDrawMinMargin);
    WM_PSD_MARGINRECT    : TriggerEvent(Dlg.FOnDrawMargin);
    WM_PSD_GREEKTEXTRECT : TriggerEvent(Dlg.FOnDrawGreekText);
    WM_PSD_ENVSTAMPRECT  : TriggerEvent(Dlg.FOnDrawEnvStamp);
    WM_PSD_YAFULLPAGERECT: TriggerEvent(Dlg.FOnDrawRetAddress);
  end;

  Result := UINT(DoneDrawing);
end;

{------------------------------------------------------------------------------}

function LMDDialogHook(Wnd: HWND; Msg: UINT; WParam: WPARAM; LParam: LPARAM): {$IFDEF LMDCOMP16}NativeUInt{$ELSE}UINT{$ENDIF}; stdcall;

var
    Ids: array of Integer;
    Caps: array of TLMDString;
    i: Integer;

    procedure CreateIds(AIds: array of Integer);
    var
        i: Integer;
    begin
      SetLength(Ids, Length(AIds));

      for i:=0 to Length(Ids)-1 do
        Ids[i] := AIds[i];
    end;

    procedure CreateCaps(ACaps: array of TLMDString);
    var
        i: Integer;
    begin
      SetLength(Caps, Length(ACaps));

      for i:=0 to Length(Caps)-1 do
        Caps[i] := ACaps[i];
    end;

    procedure SetWinText(AWnd: HWND; const AStr: TLMDString);
    begin
      {$IFDEF LMD_UNICODE}
          SetWindowTextW(AWnd, PWideChar(AStr));
        {$ELSE}
          SetWindowText(AWnd, PChar(AStr));
        {$ENDIF}
      end;

var
  ItmID: Integer;
  Template: TLMDPageTemplateBlock;
  Caption: TLMDString;
  DlgCaption: TLMDString;
  hItem: HWnd;
  Dlg: TLMDPrintPageSetupDialog;
  Cust: Integer;
  DlgData: TPAGESETUPDLG;
  begin
  Result := 0;

  case Msg of
    WM_COMMAND:
      begin
        Cust := GetWindowLong(Wnd, GWL_USERDATA);

        Dlg := TLMDPrintPageSetupDialog(Cust);
        end;

    WM_INITDIALOG:
      begin
      DlgData := PPAGESETUPDLG(lParam)^;
        Dlg := TLMDPrintPageSetupDialog(DlgData.lCustData);
      SetWindowLong(Wnd, GWL_USERDATA, DlgData.lCustData);

        Assert(Dlg<>nil);
      end
  else
    Dlg := nil;
  end;

  case Msg of
    WM_INITDIALOG:
      begin
        CreateIds([HeaderBtnID, FooterBtnID,
                   PaperGroupID, SizeLabelID,
                   PaperFeedLabelID, OrientGroupID,
                   PortraitRadioID, LandscapeRadioID,
                   MarginsGroupID, LeftMarginLabelID,
                   RightMarginLabelID, TopMarginLabelID,
                   BottomMarginLabelID, OkButtonID,
                   CancelButtonID, PrinterButtonID,
                   HelpButtonID, HeaderButtonID,
                   FooterButtonID]);

        CreateCaps([SLMDPrintPageSetupHeaderBtn,
                    SLMDPrintPageSetupFooterBtn,
                    SLMDPrintPageSetupPaperGroup,
                    SLMDPrintPageSetupSizeLabel,
                    SLMDPrintPageSetupPaperFeedLabel,
                    SLMDPrintPageSetupOrientGroup,
                    SLMDPrintPageSetupPortraitRadio,
                    SLMDPrintPageSetupLandscapeRadio,
                    SLMDPrintPageSetupMarginsGroup,
                    SLMDPrintPageSetupLeftMarginLabel,
                    SLMDPrintPageSetupRightMarginLabel,
                    SLMDPrintPageSetupTopMarginLabel,
                    SLMDPrintPageSetupBottomMarginLabel,
                    SLMDPrintPageSetupOkButton,
                    SLMDPrintPageSetupCancelButton,
                    SLMDPrintPageSetupPrinterButton,
                    SLMDPrintPageSetupHelpButton,
                    SLMDPrintPageSetupHeaderButton,
                    SLMDPrintPageSetupFooterButton]);

        Assert(Length(Caps)=Length(Ids));

        for i:=0 to Length(Ids)-1 do
          begin
            hItem := GetDlgItem(Wnd, Ids[i]);
            SetWinText(hItem, Caps[i]);
          end;

        Caption := SLMDPrintPageSetupTitle;
        SetWinText(Wnd, Caption);

        if Dlg.FDlgPosition=rdpScreen then
          LMDCenterWindow(Wnd);

        Result := 1;
      end;

    WM_COMMAND:
      begin
        ItmID := LOWORD(WParam);
        case ItmID of
          HeaderBtnID,
          FooterBtnID:
            begin
              Assert(Dlg<>nil);

              if ItmID=HeaderBtnID then
                begin
                  Template := Dlg.FTmpPrinter.Header;
                  DlgCaption := SLMDPrintHeaderEdit;
                end
              else
                begin
                  Template := Dlg.FTmpPrinter.Footer;
                  DlgCaption := SLMDPrintFooterEdit;
                end;

              LMDPrintExecTemplateDlg(DlgCaption, Template.Template);

              Result := 0;
            end;
        end;
      end;
  end;
end;

{ ******************** TLMDPrintBaseDialog ************************************}
{-------------------------- private -------------------------------------------}
procedure TLMDPrintBaseDialog.SetPrinter(const Value: TLMDPrinterBase);
begin
  if Assigned(FPrinter) then
    FPrinter.RemoveFreeNotification(self);
  FPrinter := Value;
  if Assigned(FPrinter) then
    FPrinter.FreeNotification(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintBaseDialog.CheckPrinterSet;
begin
  if not Assigned(FPrinter) then
    raise ELMDPrintPackError.Create(SLMDPrintPageSetupPrinterNotAssigned);
end;

{------------------------- protected ------------------------------------------}
procedure TLMDPrintBaseDialog.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation=opRemove) and (AComponent=FPrinter) then
    SetPrinter(nil);
end;

{-------------------------- public --------------------------------------------}
constructor TLMDPrintBaseDialog.Create(AOwner: TComponent);
begin
  inherited;
  FPrinter := nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDPrintBaseDialog.Destroy;
begin
  SetPrinter(nil);
  inherited;
end;

{$IFDEF LMDCOMP9}
function TLMDPrintBaseDialog.Execute(ParentWnd: HWND): Boolean;
{$ELSE}
function TLMDPrintBaseDialog.Execute: Boolean;
{$ENDIF}
begin
  DoShow;

  Result := DoExecute({$ifdef LMDCOMP9} ParentWnd {$else} 0 {$endif});

  DoClose;
end;

{------------------------------------------------------------------------------}
function TLMDPrintBaseDialog.getLMDPackage: TLMDPackageID;
begin
  result := pi_LMD_PRINT;
end;

{********************** Class TLMDPrintPageSetupDialog ************************}
{------------------------- Private --------------------------------------------}
procedure TLMDPrintPageSetupDialog.SetFooter(const Value: TStrings);
begin
  if Value=nil then
    raise ELMDPrintPackError.Create(SLMDPrintNilArgument)
  else
    FTmpPrinter.Footer.AssignLines(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPageSetupDialog.SetHeader(const Value: TStrings);
begin
  if Value=nil then
    raise ELMDPrintPackError.Create(SLMDPrintNilArgument)
  else
    FTmpPrinter.Header.AssignLines(Value);
end;

{------------------------------------------------------------------------------}
procedure TLMDPrintPageSetupDialog.SetMargin(const AValue: TLMDDoubleRect);
begin
  CheckPrinterSet;
  LMDPrintCheckMarginsRect(AValue, FPrinter);
  FMargin := AValue;
end;

{------------------------------------------------------------------------------}
function TLMDPrintPageSetupDialog.GetFooter: TStrings;
begin
  Result := FTmpPrinter.Footer.Template;
end;

{------------------------------------------------------------------------------}
function TLMDPrintPageSetupDialog.GetHeader: TStrings;
begin
  Result := FTmpPrinter.Header.Template;
end;

{------------------------------------------------------------------------------}
function TLMDPrintPageSetupDialog.UnitsToInt(AUnits: Double): Integer;
var
  Mlt: Double;
begin
  Assert(FPrinter<>nil);
  Mlt := 0;
  case FPrinter.RealUnits of
    unInches: Mlt := 1000;
    unMillimeters: Mlt := 100;
  else
    Assert(false);
  end;
  Result := Ceil(AUnits * Mlt);
end;

{------------------------------------------------------------------------------}
function TLMDPrintPageSetupDialog.UnitsToIntRect(const ARect: TLMDDoubleRect): TRect;
begin
  Result.Left := UnitsToInt(ARect.Left);
  Result.Right := UnitsToInt(ARect.Right);
  Result.Top := UnitsToInt(ARect.Top);
  Result.Bottom := UnitsToInt(ARect.Bottom);
end;

{------------------------------------------------------------------------------}
function TLMDPrintPageSetupDialog.IntToUnitsRect(const ARect: TRect): TLMDDoubleRect;
begin
  Result.Left := IntToUnits(ARect.Left);
  Result.Right := IntToUnits(ARect.Right);
  Result.Top := IntToUnits(ARect.Top);
  Result.Bottom := IntToUnits(ARect.Bottom);
end;

{------------------------- Protected ------------------------------------------}
function  TLMDPrintPageSetupDialog.GetDlgParentHandle:HWnd;
begin
  case FDlgPosition of
    rdpOwner:
      if Owner is TWinControl then
        Result := TWinControl(Owner).Handle
      else
        Result := 0;

    rdpMainForm:
      Result := Application.Mainform.Handle;

    rdpScreen:
      Result := 0;

  else
    Result := 0;
    Assert(false);
  end;
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDPrintPageSetupDialog.Create(AOwner: TComponent);
begin
  inherited;
  Options := LMDPageSetupDefaultOptions;
  FTmpPrinter := TLMDPrinter.Create(nil);
  FMargin.Left := 0;
  FMargin.Right := 0;
  FMargin.Top := 0;
  FMargin.Bottom := 0;
  FDlgPosition := rdpOwner;
end;

{------------------------------------------------------------------------------}
destructor  TLMDPrintPageSetupDialog.Destroy;
begin
  if Assigned(FTmpPrinter) then
    FreeAndNil(FTmpPrinter);
  inherited;
end;

{------------------------------------------------------------------------------}
function TLMDPrintPageSetupDialog.IntToUnits(AInt: Integer): Double;
var
  Dvd: Double;
begin
  Assert(FPrinter<>nil);

  Dvd := 0;

  case FPrinter.RealUnits of
    unInches: Dvd := 1000;
    unMillimeters: Dvd := 100;
  else
    Assert(false);
  end;

  Result := AInt / Dvd;
end;

{------------------------------------------------------------------------------}
function TLMDPrintPageSetupDialog.DoExecute(ParentWnd: HWND): Boolean;
const
  DlgName: string = 'LMDPAGESETUPDLG';
var
  DlgRec: TPageSetupDlg;
  Res: DWORD;
  Fr: HGLOBAL;

function Run: Boolean;
begin
  DlgRec.lCustData := LPARAM(self);
  Result := TaskModalDialog(@PageSetupDlg, DlgRec);
end;

procedure SetDlgTempl;
var
    Res: TResourceStream;
    hgl: HGLOBAL;
    bytes: PByte;
begin
  Res := TResourceStream.Create(HInstance, DlgName, RT_DIALOG);
  try
    hgl := GlobalAlloc(GPTR, Res.Size);
    bytes := GlobalLock(hgl);
    try
      Res.ReadBuffer(bytes^, Res.Size);
    finally
      GlobalUnlock(hgl);
    end;

    DlgRec.lpPageSetupTemplateName := nil;
    DlgRec.hPageSetupTemplate := hgl;
  finally
    Res.Free;
  end;
end;

begin
  CheckPrinterSet;

  FillChar(DlgRec, SizeOf(DlgRec), 0);
  DlgRec.hInstance := SysInit.HInstance;
  DlgRec.lStructSize := SizeOf(DlgRec);
  DlgRec.hwndOwner := GetDlgParentHandle;
  FPrinter.GetPrinter(DlgRec.hDevMode, DlgRec.hDevNames);

  DlgRec.Flags := PSD_ENABLEPAGEPAINTHOOK or
                  PSD_ENABLEPAGESETUPHOOK or
                  PSD_MARGINS;

  case FPrinter.RealUnits of
    unInches     : DlgRec.Flags := DlgRec.Flags or PSD_INTHOUSANDTHSOFINCHES;
    unMillimeters: DlgRec.Flags := DlgRec.Flags or PSD_INHUNDREDTHSOFMILLIMETERS;
  else
    Assert(false);
  end;

  if not (psoDisableHeaderFooter in FOptions) then
    begin
      DlgRec.Flags := DlgRec.Flags or PSD_ENABLEPAGESETUPTEMPLATEHANDLE;
      SetDlgTempl;
    end
  else
    begin
      DlgRec.hPageSetupTemplate := 0;
    end;

  DlgRec.rtMargin := UnitsToIntRect(FMargin);
  DlgRec.rtMinMargin := UnitsToIntRect(FPrinter.MinMarginsUnits);

  DlgRec.Flags := DlgRec.Flags or PSD_MINMARGINS;

  if psoDisableMargins in FOptions then
    DlgRec.Flags := DlgRec.Flags or PSD_DisableMargins;

  if psoDisableOrientation in FOptions then
    DlgRec.Flags := DlgRec.Flags or PSD_DISABLEORIENTATION;

  if psoDisablePagePainting in FOptions then
  begin
      DlgRec.Flags := DlgRec.Flags or PSD_DISABLEPAGEPAINTING;
      //DlgRec.lpfnPagePaintHook := nil;
  end;
  DlgRec.lpfnPagePaintHook := LMDPagePaint;

  if psoDisablePaper in FOptions then
    DlgRec.Flags := DlgRec.Flags or PSD_DISABLEPAPER;

  if psoDisablePrinter in FOptions then
    DlgRec.Flags := DlgRec.Flags or PSD_DISABLEPRINTER;

  if psoShowHelp in FOptions then
    DlgRec.Flags := DlgRec.Flags or PSD_SHOWHELP;

  if not (psoWarning in FOptions) then
    DlgRec.Flags := DlgRec.Flags or PSD_NOWARNING;

  if psoNoNetworkButton in FOptions then
    DlgRec.Flags := DlgRec.Flags or PSD_NONETWORKBUTTON;

  DlgRec.ptPaperSize.X := UnitsToInt(FPrinter.PageWidthFullUnits);
  DlgRec.ptPaperSize.Y := UnitsToInt(FPrinter.PageHeightFullUnits);

  DlgRec.lpfnPageSetupHook := LMDDialogHook;

  try
    Result := Run;
  finally
    if DlgRec.hPageSetupTemplate<>0 then
      GlobalFree(DlgRec.hPageSetupTemplate);
  end;

  if not Result then
    begin
      Res := CommDlgExtendedError;
      Assert(Res=0);
    end;

  try
    if Result then
      begin
        FMargin := IntToUnitsRect(DlgRec.rtMargin);
        FPrinter.SetPrinter(DlgRec.hDevMode, DlgRec.hDevNames);
      end;
  finally
    if DlgRec.hDevMode <> 0 then
      begin
        Fr := GlobalFree(DlgRec.hDevMode);
        Assert(Fr=0);
      end;

    if DlgRec.hDevNames <> 0 then
      begin
        Fr := GlobalFree(DlgRec.hDevNames);
        Assert(Fr=0);
      end;
  end;
end;

{------------------------------------------------------------------------------}

procedure TLMDPrintPageSetupDialog.SetPrinter(const Value: TLMDPrinterBase);
begin
  inherited;

  if FPrinter<>nil then
  begin
    FMargin.Left := Max(FMargin.Left, FPrinter.MinMarginsUnits.Left);
    FMargin.Right := Max(FMargin.Right, FPrinter.MinMarginsUnits.Right);
    FMargin.Top := Max(FMargin.Top, FPrinter.MinMarginsUnits.Top);
    FMargin.Bottom := Max(FMargin.Bottom, FPrinter.MinMarginsUnits.Bottom);
  end;
end;

{ *************************** TLMDPrintDialog *********************************}
{-------------------------- private -------------------------------------------}
procedure TLMDPrintDialog.SetNumCopies(Value: Integer);
begin
  FCopies := Value;
end;

{-------------------------- public --------------------------------------------}
function TLMDPrintDialog.DoExecute(ParentWnd: HWND): Boolean;
var
    OldPrinter: TPrinter;
    PrintDlg: TPrintDialog;
begin
  CheckPrinterSet;

  OldPrinter := Printers.Printer;

  Printers.SetPrinter(FPrinter.GetSysPrinter);
  try
    PrintDlg := TPrintDialog.Create(Owner);
    try
      PrintDlg.Collate  := Collate;
      PrintDlg.Copies   := Copies;
      PrintDlg.FromPage := FromPage;
      PrintDlg.MinPage  := MinPage;
      PrintDlg.MaxPage  := MaxPage;
      PrintDlg.Options  := Options;
      PrintDlg.PrintToFile := PrintToFile;
      PrintDlg.PrintRange  := PrintRange;
      PrintDlg.ToPage      := ToPage;

      Result := PrintDlg.Execute({$IFDEF LMDCOMP9}ParentWnd{$ENDIF});

      FCollate := PrintDlg.Collate;
      FCopies := PrintDlg.Copies;
      FFromPage := PrintDlg.FromPage;
      FMinPage := PrintDlg.MinPage;
      FMaxPage := PrintDlg.MaxPage;
      FPrintToFile := PrintDlg.PrintToFile;
      FPrintRange := PrintDlg.PrintRange;
      FToPage := PrintDlg.ToPage;

    finally
      PrintDlg.Free;
    end;
  finally
    Printers.SetPrinter(OldPrinter);
  end;
end;

{ ************************ TLMDPrinterSetupDialog *****************************}
{-------------------------- public --------------------------------------------}
function TLMDPrinterSetupDialog.DoExecute(ParentWnd: HWND): Boolean;
var
    OldPrinter: TPrinter;
    PrintDlg: TPrinterSetupDialog;
begin
  CheckPrinterSet;

  OldPrinter := Printers.Printer;

  Printers.SetPrinter(FPrinter.GetSysPrinter);
  try
    PrintDlg := TPrinterSetupDialog.Create(Owner);
    try
      Result := PrintDlg.Execute({$IFDEF LMDCOMP9}ParentWnd{$ENDIF});
    finally
      PrintDlg.Free;
    end;
  finally
    Printers.SetPrinter(OldPrinter);
  end;
end;

end.
