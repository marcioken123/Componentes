unit LMDRTFBase;
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

LMDRTFBase unit (RM)
--------------------
Common Base classes for LMD RichPack

Changes
-------
Release 4.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Sysutils, Classes, Forms, Windows, Controls, Messages, StdCtrls,
  LMDCustomComponent, LMDTypes, LMDClass, LMDConversion, LMDBaseControl, intfLMDBase;

  {$R LMDRichPack.res}

// checks current selected printer
function LMDRichIsPrinterValid:Boolean;

type
  // common event type
  TLMDRichURLClickEvent = procedure(Sender: TObject; const URLText: string;
                                    Button: TMouseButton) of object;
  TLMDLinkMouseMoveEvent = procedure(Sender: TObject; const URLText: string;
                                     IsLink: Boolean) of object;

  {-------------------- TLMDRichComponent -------------------------------------}
  TLMDRichComponent = class(TLMDCustomComponent)
  public
    function getLMDPackage:TLMDPackageID;override;
  published
    property About;
  end;

  TLMDRichDialogOptions=set of (rdoShowHelpButton, rdoCenterDialog, rdoCenterOwnerForm);
  TLMDRichDialogPosition=(rdpOwner, rdpMainForm, rdpScreen);

const
  def_TLMDRichDialogOptions=[rdoCenterDialog, rdoCenterOwnerForm];

type
  TLMDRichBaseDialog=class(TLMDRichComponent)
  private
    FOnCustomize,
    FOnHelp: TNotifyEvent;
    Foptions:TLMDRichDialogOptions;
  protected
    // Use this method to position dialog and to call OnCustomoze event handler
    procedure PrepareDialog(Dlg:TCustomForm;AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1);
    property OnHelpClick: TNotifyEvent read FOnHelp write FOnHelp;
  public
    constructor Create (aOwner : TComponent); override;
    function Execute(AOwner:TCustomForm=nil; X: Integer = -1; Y: Integer = -1):Boolean;virtual;abstract;
    property OnCustomize: TNotifyEvent read FOnCustomize write FOnCustomize;
    property Options:TLMDRichDialogOptions read FOptions write FOptions default def_TLMDRichDialogOptions;
  end;

  TLMDMeasurement = TLMDUnits;

  {-------------------- TLMDRichPageMargins -----------------------------------}
  TLMDRichPageMargins = class(TPersistent)
  private
    FLeft,
    FTop,
    FBottom,
    FRight:Double;
    FUnits:TLMDMeasurement;
    FInternal:LongInt;
    FOnChange: TNotifyEvent;
    function GetAsRect: TRect;
    procedure SetAsRect(aValue: TRect);
    procedure SetDouble(Index:Integer; aValue:Double);
    procedure SetUnits(aValue:TLMDMeasurement);
    procedure SetInternal(aValue:TLMDMeasurement);
  public
    constructor Create;
    procedure DoChange; dynamic;
    property AsRect: TRect read GetAsRect write SetAsRect;
    property Units:TLMDMeasurement read FUnits write SetUnits;
    property UnitFactor:LongInt read FInternal;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    procedure Assign(aValue: TPersistent); override;
    procedure Translate(FromUnits, ToUnits: TLMDMeasurement);
//    procedure MulDiv(Numerator, Denominator: integer);
  published
    property Left: Double index 0 read FLeft write SetDouble;
    property Top: Double index 1 read FTop write SetDouble;
    property Right: Double index 2 read FRight write SetDouble;
    property Bottom: Double index 3 read FBottom write SetDouble;
  end;

  {-------------------- TLMDRichGraphicControl ---------------------------------}
  TLMDRichGraphicControl = class(TLMDBaseControl)
  public
     function getLMDPackage:TLMDPackageID;override;
  published
     //VB Dec 2008 - (BTS #676)
     property OnResize;
  end;

  // -> move later to global runtime package
  {-------------------- TLMDRichWinControl ------------------------------------}
  TLMDRichBaseComboBox = class(TCustomComboBox, ILMDComponent)
  private
    FAbout:TLMDAboutVar;
    FMouseOver,
    FFlat: Boolean;
    FDropDownWidth:Integer;

    procedure SetFlat(const aValue: Boolean);
    procedure SetDropDownWidth(const aValue:Integer);

    procedure DrawBorder;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CNCommand (var Message: TWMCommand); message CN_COMMAND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint (var Message: TMessage); message WM_NCPAINT;
  protected
    procedure CreateWnd;override;
    property Flat:Boolean read FFlat write SetFlat default false;
    property DropDownWidth:Integer read FDropDownWidth write SetDropDownWidth default 0;
  public
    constructor Create(AOwner: TComponent); override;
    function getLMDPackage:TLMDPackageID;virtual;
  published
    property About:TLMDAboutVar read FAbout write FAbout stored false;
  end;

implementation
uses
  Graphics, Printers, WinSpool, ShellApi,
  {$IFDEF LMD_DEBUGTRACE}Dialogs,{$ENDIF}
  LMDRTFConst, LMDUtils;

{ TLMDRichComponent }
{------------------------------------------------------------------------------}
function TLMDRichComponent.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_RTF;
end;

{ TLMDRichGraphicControl }
{------------------------------------------------------------------------------}
function TLMDRichGraphicControl.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_RTF;
end;

{------------------------------------------------------------------------------}
function LMDRichIsPrinterValid: Boolean;
var

  Device, Driver, Port : array[0..255] of char;
  hDeviceMode: THandle;

  pHandle : THandle;
begin
  result := False;
  // no printer at all
  if Printer.Printers.Count=0 then exit;
  try
    Printer.GetPrinter(Device, Driver, Port, hDeviceMode);
  if OpenPrinter(@Device, pHandle, nil) then
  begin
        ClosePrinter(pHandle);  // Free printer Handle directly!
        result := True;
      end;
   except
     On Exception do ;
   end;
end;

{ ********************** TLMDRichBaseDialog ********************************** }
{ --------------------------- protected -------------------------------------- }
procedure TLMDRichBaseDialog.PrepareDialog(Dlg:TCustomForm; AOwner: TCustomForm; X, Y: Integer);
begin
  // Generate OnCustomizeEvent for programmer changes
  if Assigned(FOnCustomize) then
    FOnCustomize(dlg);

  if (AOwner<>nil) then
    LMDCenterChild(TCustomForm(AOwner), Dlg, false)
  else
    if rdoCenterDialog in FOptions then
      begin
        if not (rdoCenterOwnerForm in FOptions) then
          LMDCenterForm(Dlg)
        else
          begin

            if Owner is TCustomForm then
              AOwner:=TCustomForm(owner)
            else
              if Owner.Owner is TCustomForm then
                AOwner:=TCustomForm(Owner.Owner);
            LMDCenterChild(AOwner, Dlg, false)
          end;
      end
    else
      begin
        if X <> -1 then Dlg.Left := X;
        if Y <> -1 then Dlg.Top := Y;
      end;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRichBaseDialog.Create(aOwner: TComponent);
begin
  inherited;
  FOptions:=def_TLMDRichDialogOptions;
end;

{ ********************** TLMDRichPageMargins **********************************}
{ ---------------------------- private --------------------------------------- }
procedure TLMDRichPageMargins.SetDouble(Index:Integer; aValue:Double);
begin
  case index of
    0: if aValue=FLeft then exit else FLeft:=aValue;
    1: if aValue=FTop then exit else FTop:=aValue;
    2: if aValue=FRight then exit else FRight:=aValue;
    3: if aValue=FBottom then exit else FBottom:=aValue;
  end;
  DoChange;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichPageMargins.SetAsRect(aValue: TRect);
begin
  FLeft:= aValue.Left / FInternal;
  FRight:= aValue.Right  / FInternal;
  FTop:= aValue.Top  / FInternal;
  FBottom:= aValue.Bottom  / FInternal;
  DoChange;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichPageMargins.SetUnits(aValue:TLMDMeasurement);
begin
  if aValue<>FUnits then
    begin
      Translate(FUnits, aValue);
      FUnits:=aValue;
      SetInternal(FUnits);
      DoChange;
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichPageMargins.Translate(FromUnits, ToUnits: TLMDMeasurement);
begin
  if  FromUnits <> ToUnits  then
    begin
      FLeft := LMDConvertUnits(FLeft, FromUnits, ToUnits);
      FTop := LMDConvertUnits(FTop, FromUnits, ToUnits);
      FBottom := LMDConvertUnits(FBottom, FromUnits, ToUnits);
      FRight := LMDConvertUnits(FRight, FromUnits, ToUnits);
    end;
end;

{ ------------------------------------------------------------------------- }
procedure TLMDRichPageMargins.SetInternal(aValue:TLMDMeasurement);
begin
  Case aValue of
    unMillimeters:FInternal:=100; //PSD_INHUNDREDTHSOFMILLIMETERS
    unInches:FInternal:=1000 div InchFactor;     //PSD_INTHOUSANDTHSOFINCHES
    unPoints:FInternal:=1;        // ??
  end;
end;

{ ------------------------------------------------------------------------- }
function TLMDRichPageMargins.GetAsRect: TRect;
begin
  Result:= Rect(Round(FLeft*FInternal),Round(FTop*FInternal), Round(FRight*FInternal), Round(FBottom*FInternal))
end;

{ ------------------------- Protected ---------------------------------------- }
procedure TLMDRichPageMargins.DoChange;
begin
  if Assigned(FOnChange) then OnChange(Self)
end;

{ --------------------------- Public------------------------------------------ }
constructor TLMDRichPageMargins.Create;
begin
  inherited Create;
  FLeft:={38}0;
  FTop:={38}0;
  FBottom:={38}0;
  FRight:={38}0;
  FUnits:=unMillimeters;
  SetInternal(FUnits);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichPageMargins.Assign(aValue: TPersistent);
begin
  if aValue is TLMDRichPageMargins then
  begin
    FLeft:= TLMDRichPageMargins(aValue).FLeft;
    FTop:= TLMDRichPageMargins(aValue).FTop;
    FBottom:= TLMDRichPageMargins(aValue).FBottom;
    FRight:= TLMDRichPageMargins(aValue).FRight;
    FUnits:= TLMDRichPageMargins(aValue).FUnits;
    FInternal:= TLMDRichPageMargins(aValue).FInternal;
  end
  else
    inherited;
  DoChange;
end;

{ ************************* TLMDRichBaseComboBox**************************** }
{ ----------------------------- private -------------------------------------- }
procedure TLMDRichBaseComboBox.SetDropDownWidth(const aValue: integer);
begin
  FDropDownWidth := aValue;
  if aValue > 0 then
    Perform(CB_SETDROPPEDWIDTH, FDropDownWidth, 0);
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.SetFlat(const aValue:Boolean);
begin
  if FFlat<>aValue then
    begin
      FFlat:=aValue;
      RecreateWnd;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.CNCommand(var Message: TWMCommand);
var
  aRect : TRect;
begin
  inherited;
  if Message.NotifyCode in [CBN_CLOSEUP,CBN_DROPDOWN] then
    begin
      aRect := ClientRect;
      aRect.Left := aRect.Right - (GetSystemMetrics(SM_CXVSCROLL) + 2);
    InvalidateRect(Handle, @aRect, False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.CMEnter(var Message: TCMEnter);
begin
  inherited;
  DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.CMExit(var Message: TCMExit);
begin
  inherited;
  DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Enabled and not FMouseOver then
    begin
      FMouseOver:=True;
      DrawBorder;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Enabled and FMouseOver then
    begin
     FMouseOver:=False;
     DrawBorder;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.CMEnabledChanged(var Msg: TMessage);
begin
 inherited;
end;

{------------------------------------------------------------------------------}

procedure TLMDRichBaseComboBox.WMNCPaint(var Message: TMessage);
begin

  inherited;

end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.WMPaint(var Message: TWMPaint);
var
   DC: HDC;
   PS: TPaintStruct;

   procedure DrawComboButton;
   var
     ARect: TRect;
     tmp:Integer;
   begin
     tmp:=GetSystemMetrics(SM_CXVSCROLL)+2;
     GetWindowRect(Handle, ARect);
     OffsetRect(ARect, -ARect.Left, -ARect.Top);
     Inc(ARect.Left, ClientWidth - tmp);
     Dec(aRect.Bottom);
     Dec(aRect.Right);
     InflateRect(ARect, -1, -1);
     DrawFrameControl(DC, ARect, DFC_SCROLL,DFCS_SCROLLCOMBOBOX or DFCS_FLAT);
     ExcludeClipRect(DC,ClientWidth-tmp-2,0,ClientWidth,ClientHeight);  // default handler should left out button area
   end;

begin
  if not FFlat then
    begin
      inherited;
      exit;
    end;
  if LMDApplication.XPThemesSupported and not (csDesigning in ComponentState) then   // if themes are active, we need at least in D7 to draw button ourselves
    begin
      if Message.DC = 0 then
        DC:=BeginPaint(Handle, PS)
      else
        DC:=Message.DC;
      try
        if (Style<>csSimple) then
          begin
           FillRect(DC, ClientRect, Brush.Handle);
           DrawComboButton;
          end;
        PaintWindow(DC);
      finally
        if Message.DC=0 then
          EndPaint(Handle, PS);
      end;
    end
  else
    inherited;
  DrawBorder;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.DrawBorder;
var
  DC: HDC;
  parentColor, controlColor: HBrush;
  aRect:TRect;
  tmp:Integer;

const
   Flags: array[Boolean] of Integer = (0, BF_FLAT);

begin
  if not FFlat or (csDesigning in ComponentState) then Exit;
  DC := GetWindowDC(Handle);
  try
    // paint border
    if Parent is TWinControl then
      parentColor:=CreateSolidBrush(ColorToRGB(TWinControl(Parent).Brush.Color))
    else
      parentColor:=CreateSolidBrush(ColorToRGB(clBtnFace));
    controlColor:=CreateSolidBrush(ColorToRGB(Color));
    try
      GetWindowRect(Handle, aRect);
      OffsetRect(aRect,-aRect.Left,-aRect.Top);

      if (Screen.ActiveControl=self) or Focused or FMouseOver then
        begin
          FrameRect(DC, ARect, parentColor);
          DrawEdge(DC, aRect, BDR_SUNKENOUTER, BF_RECT  or BF_ADJUST);
          DrawEdge(DC, aRect, BDR_SUNKENINNER, BF_TOPLEFT or BF_ADJUST);
        end
      else
        begin
          FrameRect(DC, aRect, parentColor);
          InflateRect(aRect,-1,-1);
          FrameRect(DC, aRect, parentColor);
          InflateRect(aRect,-1,-1);
          FrameRect(DC, aRect, controlColor);
        end;
     finally
       DeleteObject(parentColor);
       DeleteObject(controlColor);
     end;

    // draw combo-button
    if (Style<>csSimple) then
      begin
        aRect:=ClientRect;
        tmp:=GetSystemMetrics(SM_CXVSCROLL)+2;
        ExcludeClipRect(DC,aRect.Right-tmp+4,4,aRect.Right-4,aRect.Bottom-4);
        Inc(aRect.Left, ClientWidth-tmp-2);
        InflateRect(aRect,-2,-2);

        if FMouseOver or (Screen.ActiveControl=self) or Focused then
          DrawEdge(DC, aRect, EDGE_RAISED, BF_RECT or Flags[DroppedDown])
        else
          begin
            controlColor:=CreateSolidBrush(ColorToRGB(clBtnFace));
            try
              InflateRect(aRect,0,-1);
              aRect.Right:=aRect.Right-1;
              FillRect(DC, aRect, controlColor);
            finally
              DeleteObject(controlColor);
            end;
          end;
         ExcludeClipRect(DC, ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
      end;
  finally
     ReleaseDC(DC, Handle);
  end;
end;

{----------------------------- public -----------------------------------------}
constructor TLMDRichBaseComboBox.Create(AOwner: TComponent);
begin
  inherited;
  FFlat := False;
  FMouseOver := False;
end;

{------------------------------------------------------------------------------}
function TLMDRichBaseComboBox.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_RTF;
end;

{------------------------------------------------------------------------------}
procedure TLMDRichBaseComboBox.CreateWnd;
begin
  inherited CreateWnd;
  Perform(CB_SETDROPPEDWIDTH, FDropDownWidth, 0);
end;

{------------------------------------------------------------------------------}
{$IFDEF LMD_DEBUGTRACE}
  {$I C2.INC}
{$ENDIF}

initialization
{$IFDEF LMD_DEBUGTRACE}
  {$I C1.INC}
{$ENDIF}

end.
