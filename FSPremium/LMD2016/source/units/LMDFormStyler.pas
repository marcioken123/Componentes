unit LMDFormStyler;
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

LMDFormStyler unit ()
---------------------

Changes
-------
Release 8.05 (February 2008)
- fsUseFormCaption: No longer AV is generated when flag is switched off

Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Graphics, Messages,
  LMDGraph, LMDDwmAPI, LMD3DCaption, LMDCustomFormFill, LMDWndProcComponent;

type
  {------------------------- TLMDFormStyler -----------------------------------}
  TLMDFormStyleOption=(fsAdjustRect, fsUseDefaultFont, fsUseFontColor,
                       fsInactiveGradient, fsDrawCaptionEvent, fsUseFormCaption,
                       fsCheckSystemGradient);

  TLMDFormStyleOptions=set of TLMDFormStyleOption;

  TLMDFormStyler = class(TLMDWndProcComponent)
  private
    FHideGradient:Boolean;
    FAlignment:TAlignment;
    FColors:TLMDColorCount;
    FCanvas:TCanvas;
    FFont:TFont;
    FFont3D:TLMD3DCaption;
    FWNDActive:Boolean;
    FPaintMode:TLMDPaintMode;
    FOptions:TLMDFormStyleOptions;
    FSmallCaption:Boolean;

    FOnPaint,
    FOnCaptionPaint:TLMDPaintEvent;

    {Internal}
    FCaption:String;
    FIconBitmap:TBitmap;

    Painting:Boolean;
    procedure PaintTitleBar(CreateIcon:Boolean);
    procedure SetAlignment(aValue:TAlignment);
    procedure SetCaption(const aValue:String);
    procedure SetColors(aValue:TLMDColorCount);
    procedure SetFont(aValue:TFont);
    procedure SetFont3D(aValue:TLMD3DCaption);
    procedure SetOptions(aValue:TLMDFormStyleOptions);
    procedure SetPaintMode(aValue:TLMDPaintMode);
  protected
    procedure EnabledChanged;override;
    procedure Init;override;
    procedure GetChange(Sender:TObject);override;
    procedure RestoreState;override;
    procedure WndProc(var Message: TMessage);override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure ForceNCPaint;
    procedure NCPaint;
    property Caption:String read FCaption write SetCaption;
    property CaptionActive:Boolean read FWndActive;
    property SmallCaption:Boolean read FSmallCaption;
  published
    property About;
    property Alignment:TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property Colors:TLMDColorCount read FColors write SetColors default 32;
    property Enabled;
    property Font:TFont read FFont write SetFont;
    property Font3D:TLMD3DCaption read FFont3D write SetFont3D;
    property PaintMode:TLMDPaintMode read FPaintMode write SetPaintMode default pcControl;
    property Options:TLMDFormStyleOptions read FOptions write SetOptions default
                     [fsAdjustRect, fsUseDefaultFont, fsUseFormCaption, fsCheckSystemGradient];

    property OnPaint:TLMDPaintEvent read FOnPaint write FOnPaint;
    property OnCaptionPaint:TLMDPaintEvent read FOnCaptionPaint write FOnCaptionPaint;

  end;

implementation

uses
  Types, Controls, SysUtils, Forms,
  LMDClass, Themes, LMDSysIn, LMDProcs, LMDGraphUtils;

{--------------------------- Private ------------------------------------------}

procedure TLMDFormStyler.PaintTitleBar(CreateIcon:Boolean);
var
  {aCanvas:TCanvas;}
  WndDC:HDC;
  Rgn:HRGN;
  tocl:TColor;
  flags:Word;
  {TmpBmp:TBitmap;}
  dRect, rText:TRect;
  NC:TNonClientMetrics;

const
  Alignments: array[TAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);

begin

  if (csDesigning in ComponentState) or
     not Enabled or
     (FPaintMode=pcNone) or
     (IsIconic(WNDHandle) and not NewStyleControls) or
     not IsWindow(WndHandle) or
     not IsWindowVisible(WndHandle) or
     not WndOwner.HandleAllocated or
     Painting then Exit;

  {4.0}
  if FHideGradient then
    if (fsCheckSystemGradient in Options) and (LMDSIColorDepth>8) then exit;

  if (fsUseFormCaption in FOptions) then FCaption:=WNDOwner.Caption;

  {if WndHandle=0 then exit;}
  WndDC := GetWindowDC(WNDHandle);
  try
     Painting:=True;
     with FCanvas do
       begin
         FCanvas.Handle:=WndDC;
         flags:=NC_ADJUSTRIGHT;

         if (FPaintMode=pcOwnerDraw) and (fsAdjustRect in FOptions) then
           flags:=flags OR NC_ADJUSTLEFT;

         if WndOwner.BorderStyle=TFormBorderStyle(bsSingle) then flags:=flags or NC_SINGLEBORDER;

         LMDNCCalcDrawingArea(WNDHandle, dRect, rText, flags);

         FSmallCaption:=flags and NC_SMALLCAPTION=NC_SMALLCAPTION;

         if FPaintMode=pcOwnerDraw then
           begin
             if assigned(FOnPaint) then
               begin
                 Rgn:=CreateRectRgnIndirect(dRect);
                 try
                   SelectClipRgn(FCanvas.Handle, Rgn);
                   FOnPaint(Self, FCanvas, dRect);
                 finally
                   SelectClipRgn(FCanvas.Handle, 0);
                   DeleteObject(Rgn);
                 end;
               end;
           end
         else
           begin

            if flags and NC_HASICON=NC_HASICON then
              if CreateIcon then
                with FIconBitmap do
                  begin
                    Height:=dRect.Bottom-dRect.Top;
                    Width:=rText.Left-dRect.Left;
                    Canvas.CopyRect(Rect(0,0,Width, Height), FCanvas,
                                    Bounds(dRect.Left, dRect.Top, Width, Height));
                    {BitBlt(Canvas.Handle, 0,0, Width, Height, FCanvas.Handle,
                           dRect.Left, dRect.top, SRCCOPY);}
                  end;

             if FWNDActive or ((not FWNDActive) and (fsInactiveGradient in FOptions)) then
               begin
                 if FWndActive then tocl:=clActiveCaption else tocl:=clInActiveCaption;
                 LMDGradientPaint(FCanvas, dRect, clBlack, tocl, FColors, gstHorizontal,
                                  0, 0);
                 if (flags and NC_HASICON=NC_HASICON) and NewStyleControls then
                   with dRect, FIconBitmap do
                     LMDBMPDraw(FCanvas, Bounds(Left, Top, Width, Height), FIconBitmap,
                                DSF_TRANSPARENCY, TransparentColor);
               end;
           end;

         {Text Output}
         if fsUseDefaultFont in FOptions then
           begin
             Font.Style:=[fsBold];
             if NewStyleControls then
               begin

                 NC.cbSize:=Sizeof(TNonClientMetrics);
                 SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @nc, 0);

                 if flags and NC_SMALLCAPTION=NC_SMALLCAPTION then
                   Font.Handle:=CreateFontIndirect(nc.lfSmCaptionFont)
                 else
                   Font.Handle:=CreateFontIndirect(nc.lfCaptionFont);
                 Font.Assign(FFont);
               end
             else
               begin
                 SelectObject(Handle, GetStockObject(SYSTEM_FONT));
                 Font.Height:=rText.Bottom-rText.Top;
               end;
           end
         else
           begin
             Font.Assign(FFont);
           end;

         brush.Style:=bsClear;
         if not FWNDActive then
           Font.Color:=clInactiveCaptionText
         else
           if (fsUseDefaultFont in FOptions) or not (fsUseFontColor in FOptions) then
             if ColorToRGB(clBlack)=ColorToRGB(clCaptionText) then
               Font.Color:=clWhite
             else
               Font.Color:=clCaptionText;

         if (fsDrawCaptionEvent in FOptions) or (FPaintMode=pcOwnerDraw) then
           begin
             if Assigned(FOnCaptionPaint) then
               begin
                 Rgn:=CreateRectRgnIndirect(rText);
                 try
                   SelectClipRgn(FCanvas.Handle, Rgn);
                   FOnCaptionPaint(Self, FCanvas, rText);
                 finally
                   SelectClipRgn(FCanvas.Handle, 0);
                   DeleteObject(Rgn);
                 end;
               end;
             exit;
           end;

         if not FWNDActive then
           if (fsUseFormCaption in FOptions) and not (fsInactiveGradient in FOptions) then exit;

         flags:=DT_SINGLELINE or DT_NOPREFIX or DT_VCENTER or Alignments[FAlignment];
         if fsUseDefaultFont in FOptions then
           DrawText(Handle, int_Ref(FCaption), Length(FCaption), rText, flags)
         else
            LMDDrawTextExt(FCanvas, FCaption, FFont3D, rText, flags,
                          [dtEnabled, dtClip], nil);
       end;
  finally
     FCanvas.Handle:=0;
     ReleaseDC(WNDHandle, WNDDC);
     Painting:=False;
  end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.SetAlignment(aValue:TAlignment);
begin
  if aValue<>FAlignment then
    begin
      FAlignment:=aValue;
      if FPaintMode<>pcNone then PaintTitleBar(False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.SetCaption(const aValue:String);
begin
  if aValue<>FCaption then
    begin
      FCaption:=aValue;
      if (FPaintMode<>pcNone) then PaintTitleBar(False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.SetColors(aValue:TLMDColorCount);
begin
  if aValue<>FColors then
    begin
      FColors:=aValue;
      if (FPaintMode=pcControl) then PaintTitleBar(False);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.SetFont(aValue:TFont);
begin
  FFont.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.SetFont3D(aValue:TLMD3DCaption);
begin
  FFont3D.Assign(aValue);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.SetOptions(aValue:TLMDFormStyleOptions);
begin
  if aValue<>FOptions then
    begin
      FOptions:=aValue;
      {$IFDEF LMDCOMP11}
      if ([csLoading,csReading, csDestroying]*ComponentState=[]) then
        begin
          Enabled:=not Enabled;
          Enabled:=not Enabled;
        end
      else
      {$ELSE}
      EnabledChanged;
      {$ENDIF}
      if FPaintMode=pcNone then
        NCPaint
      else
        PaintTitleBar(True);
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.SetPaintMode(aValue:TLMDPaintMode);
begin
  if aValue<>FPaintMode then
    begin
      FPaintMode:=aValue;
      if FPaintMode=pcNone then NCPaint else PaintTitleBar(True);
    end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDFormStyler.Init;
begin
  if Enabled then
    begin
      inherited Init;
      if not (fsUseFormCaption in FOptions) then
        begin
          FCaption:=WndOwner.Caption;
          WndOwner.Caption:=Chr(32);
        end;
      if not (csLoading in ComponentState) then
        PaintTitleBar(True);
    end;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDFormStyler.EnabledChanged;
begin
   if not LMDSIWindowsVistaUp then exit;
   // 7.11
   if Enabled and not (fsCheckSystemGradient in Options) then
     begin
       if LMDWndIsDwmEnabled(WndHandle) then
         LMDWndDwmDisable(WndHandle);
     end
   else
     begin
       if LMDDwmEnabled and not LMDWndIsDwmEnabled(WndHandle) then
         LMDWndDwmEnable(WndHandle);
     end;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.GetChange(Sender:TObject);
begin
  if (FPaintMode<>pcNone) and  not (fsUseDefaultFont in FOptions) then
    PaintTitleBar(False);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.RestoreState;
begin
  {inherited RestoreState;}
  FIconBitmap.FreeImage;
  if not (fsUseFormCaption in FOptions) then
    WndOwner.Caption:=FCaption;

  if not (csDestroying in ComponentState) then NCPaint;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.WndProc(var Message: TMessage);

  procedure Default;
  begin
    CallPrevWndProc(Message);
//    with Message do
//      Result:=CallWindowProc(PrevWndProc, WndHandle, Msg,wParam,lParam);
  end;
begin
   if not Enabled or (PaintMode=pcNone) or FDestroying then
    begin
      Default;
      exit;
    end;

   with Message do
     begin
       case msg of
         WM_NCActivate:
             begin
               with TWMNCACTIVATE(Message) do
               FWNDActive:=Active;

               Default;
               if FWNDActive or (fsInactiveGradient in FOptions) then PaintTitleBar(False);
               result:=1;
               exit;
            end;
         WM_NCPaint:
            begin
              Default;
              if FWNDActive or (fsInactiveGradient in FOptions) then PaintTitleBar(True);
              result:=0;
              exit;
           end;
         WM_GETTEXTLENGTH:
           if not (fsUseFormCaption in FOptions) then
             with TMessage(Message) do
             begin
                 Result := 0;
                 exit;
               end;
         WM_GETTEXT:
           if not (fsUseFormCaption in FOptions) then
             with TWMGETTEXT(Message) do
               begin
                 TextMax:=0;
                 StrPCopy(Text, Chr(32));
                 result:=1;
                 exit;
               end
            else
             result := 0;
       end;
       Default;
     end;
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDFormStyler.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  FHideGradient:=LMDSIWindows98 or LMDSIWindows2000 or ThemeServices.ThemesAvailable;
  FFont:=TFont.Create;
  FFont.OnChange:=GetChange;

  FAlignment:=taLeftJustify;
  FColors:=32;
  FHandleMDI:=True;
  FOptions:=[fsAdjustRect, fsUseDefaultFont, fsUseFormCaption, fsCheckSystemGradient];
  FSmallCaption:=False;
  FPaintMode:=pcControl;

  FIconBitmap:=TBitmap.Create;

  FFont3D:=TLMD3DCaption.Create;
  FFont3D.OnChange:=GetChange;

  Painting:=False;
  FCanvas:=TCanvas.Create;
  FCanvas.Handle:=0;

  if csDesigning in ComponentState then
    if LMDCheckForSameClass(aOwner, self.ClassType, false) then
      raise ELMDOneInstError.Create(self.ClassName,0);
end;

{------------------------------------------------------------------------------}
destructor TLMDFormStyler.Destroy;
begin

  FFont.OnChange:=nil;
  FFont3D.OnChange:=nil;

  FCanvas.Handle:=0;
  FCanvas.Free;
  FFont.Free;
  FFont3D.Free;
  FIconBitmap.Free;
  inherited Destroy;
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.NCPaint;
begin
   if ValidOwner then WndOwner.Perform(WM_NCActivate, 1,0);
end;

{------------------------------------------------------------------------------}
procedure TLMDFormStyler.ForceNCPaint;
begin
   if ValidOwner then PaintTitleBar(false);
end;

end.
