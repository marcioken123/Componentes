unit LMDBaseDialog;
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

LMDBaseDialog unit (RM)
-----------------------

Base dialog component

This class is used as base component for most of the LMD Tools dialogs

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Forms, StdCtrls, Controls, Graphics,
  LMDClass, LMDFormStyler, LMDCustomFormFill, LMDContainerComponent;

type
  {------------------------- TLMDBaseDialog -----------------------------------}
  TLMDBaseDialog=class(TLMDContainerComponent)
  private
    FCaptionTitle :String;
    FCustomButton :String;
    FEffect       :TLMDDlgEffect;
    FHints        :TStringList;
    FShowHint,
    FFillCaption  :Boolean;
    FColors       :Byte;
    FFont         :TFont;
    FPosition     :TLMDDlgPosition;
    FDlgPosRel    :TLMDDlgPosRel;
    FOnCustomize,
    FOnCustomClick:TNotifyEvent;
    procedure PaintBack(Sender:TObject; aCanvas:TCanvas; Dest:TRect);
    procedure SetCaptionTitle (aValue: String);
    procedure SetFont(aValue:TFont);
    procedure SetHints(aValue:TStrings);
    function GetHints:TStrings;
  protected
    //V6, JH June 02
    FOpenedDlg    :TCustomForm;
    function BaseExecute(aForm, aParentForm: TCustomForm; Custom:TButton;
                         fs:TLMDFormStyler; b:TLMDCustomFormFill;
                         defCaption:String):TModalResult;
    procedure DoCustomize(Sender:TObject);virtual;
    {base properties}
    property CaptionFill: Boolean read FFillCaption write FFillCaption default false;
    property CaptionTitle:String read FCaptionTitle write SetCaptionTitle;
    property CustomButton:String read FCustomButton write FCustomButton;
    property Effect: TLMDDlgEffect read FEffect write FEffect default deNone;
    property Colors: Byte read FColors write FColors default 32;
    property Hints:TStrings read GetHints write SetHints;
    property ShowHints:Boolean read FShowHint write FShowHint default True;
    {events}
    property OnCustomize:TNotifyEvent read FOnCustomize write FOnCustomize;
    property OnCustomClick:TNotifyEvent read FOnCustomClick write FOnCustomClick;
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function ControlSupportsXP: Boolean;
    function Execute:Boolean;virtual;
    property ImageList;
    property ImageIndex;
    property ListIndex;
    property Dlg: TCustomForm read FOpenedDlg; //only available if the dialog is opened!
    property Position:TLMDDlgPosition read FPosition write FPosition default bpCenter;
    property RelatePos:TLMDDlgPosRel read FDlgPosRel write FDlgPosRel default brScreen;
    // 8.0
    property Font:TFont read FFont write SetFont;
  end;

implementation
uses
  SysUtils,
  LMDUtils, LMDGraph, LMDThemes, LMDGraphUtils, LMDSysIn, LMDCont;

{----------------------------- Private ----------------------------------------}
procedure TLMDBaseDialog.SetCaptionTitle (aValue: String);
var
  i: Integer;
begin
  FCaptionTitle := aValue;
  if Assigned (FOpenedDlg) then //a dialog opened?
    begin
      FOpenedDlg.Caption := aValue; //set new caption
      //ierate through all components on the dialog
      for i := 0 to FOpenedDlg.ComponentCount-1 do
        //if we have found the form styler
        if FOpenedDlg.Components[i] is TLMDFormStyler then
          begin
            //we'll force the form's non-client area to be repainted
            //(for restoring any gradient)
            (FOpenedDlg.Components[i] as TLMDFormStyler).ForceNCPaint;
            //now we can leave the iteration - there can only be one form styler
            break;
          end;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDBaseDialog.SetHints(aValue:TStrings);
begin
  FHints.Assign(aValue);
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseDialog.SetFont(aValue:TFont);
begin
  FFont.Assign(aValue);
end;

{------------------------------------------------------------------------------}
function TLMDBaseDialog.GetHints:TStrings;
begin
  result:=FHints;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseDialog.PaintBack(Sender:TObject; aCanvas:TCanvas; Dest:TRect);
var
  flags:Word;
begin
  flags:=DSF_TILE;
  if not ((aoAutoRealizePalette in LMDApplication.Options) and (LMDSIColorDepth<9)) then
    flags:=flags or DSF_PALETTEREALIZE;
  LMDIMLClipDraw(aCanvas, Dest, flags, 0, 0, ImageList, ListIndex, ImageIndex)
end;

{------------------------------ Protected -------------------------------------}

function TLMDBaseDialog.BaseExecute(aForm, aParentForm: TCustomForm;
                                    Custom:TButton;
                                    fs: TLMDFormStyler; b: TLMDCustomFormFill;
                                    defCaption: String):TModalResult;
var
  aRect:TRect;
begin
  FOpenedDlg := aForm; //JH June 02, remember pointer to openend dialog

   {ab hier überall das Gleiche}
   if Length(FCaptionTitle)>0 then aForm.Caption:=FCaptionTitle else aForm.Caption:=defCaption;

   with Custom do
     if FCustomButton<>'' then
       begin
         Caption:=FCustomButton;
         Visible:=True;
         if Assigned(FOnCustomClick) then OnClick:=FOnCustomClick;
       end
     else
       Visible:=False;

   if csDesigning in ComponentState then
     aRect:=LMDDlgGetTargetRect(brScreenWorkArea)
   else
     If Assigned(aParentForm) then
        aRect:=aParentForm.BoundsRect
     else
       aRect:=LMDDlgGetTargetRect(FDlgPosRel);

   if aForm is TForm  then
     TForm(aForm).Position := poDesigned;

   LMDPositionWindow(aForm.Handle, aRect, FPosition, false);

   case FEffect of
     deExplode:LMDExplodeForm(aForm);
     deExplodeExt:LMDExplodeForm2(aForm);
   end;

   fs.Enabled:=FFillCaption;
   if FFillCaption then fs.Colors:=Colors;
   fs.Options:=fs.Options+[fsCheckSystemGradient];

   if ImageList <> nil then
     begin
       b.ImageList := ImageList;
       b.ListIndex := ListIndex;
       b.ImageIndex := ImageIndex;
       b.OnPaint:=PaintBack;
       b.Enabled := True;
     end;

   LMDSetThemeMode(aForm, LMDThemeServices.UseTheme(ThemeMode));

   aForm.Font:=FFont;
   DoCustomize(aForm);

   Result := aForm.ShowModal;
   FOpenedDlg := nil; //dialog no longer available
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDBaseDialog.DoCustomize(Sender: TObject);
begin
 if Assigned(FOnCustomize) then FOnCustomize(Sender);
end;

{------------------------------ Public ----------------------------------------}
constructor TLMDBaseDialog.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FHints:=TStringList.Create;
  FFont:=TFont.Create;
  FEffect:=deNone;
  FShowHint:=True;
  FFillCaption:=False;
  FColors:=32;
  FPosition:=bpCenter;
  FDlgPosRel:=brScreen;
  FOpenedDlg:=nil;
end;

{------------------------------------------------------------------------------}
destructor TLMDBaseDialog.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FHints);
  inherited Destroy;
end;

{ ---------------------------------------------------------------------------- }
function TLMDBaseDialog.ControlSupportsXP: Boolean;
begin
 result:=true;
end;

{------------------------------------------------------------------------------}
function TLMDBaseDialog.Execute:Boolean;
begin
  result:=False;
end;

end.
