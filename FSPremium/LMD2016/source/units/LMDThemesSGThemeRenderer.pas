unit LMDThemesSGThemeRenderer;
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

LMDThemesSGThemeRenderer unit (VB)
----------------------------------

This unit contains reference to LMDThemesSGThemeRenderer singleton which
implements Office2003-like gradient theme rendering

Changes
-------
Release 10.0 (January 2009)
- Initial Release

###############################################################################}

interface

uses
  Classes, LMDTypes, LMDThemes, LMDThemesSGThemeBase;

type
  TLMDSimpleGradientThemeRenderer = class(TLMDBaseSGThemeRenderer)
  public
    class function Controller: TLMDThemesControllerBase; override;  
    class procedure Init; override;
    class function GetThemeRendererName: TLMDString; override;
  end;

  TLMDSimpleGradientThemeController = class(TLMDThemesControllerBase)
  private
    FOnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent;
    FOnDrawRadioBtn: TLMDThemesOnDrawCheckMarkEvent;
    FOnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent;
    FOnDrawArrow: TLMDThemesOnDrawArrowEvent;
    FOnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent;
    FOnDrawPlus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawMinus: TLMDThemesOnDrawSimpleSignEvent;
    FOnDrawCross: TLMDThemesOnDrawSimpleSignEvent;
  protected
    function GetThemeRenderer: TLMDThemeRenderer; override;
    procedure RegisterController; override;
    procedure UnregisterController; override;
    procedure Loaded; override;
  public
    constructor Create(aOwner: TComponent); override;
  published
    property OnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent read FOnDrawCheckMark write FOnDrawCheckMark;
    property OnDrawRadioBtn: TLMDThemesOnDrawCheckMarkEvent read FOnDrawRadioBtn write FOnDrawRadioBtn;
    property OnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent read FOnDrawScrollThumbGripper write FOnDrawScrollThumbGripper;
    property OnDrawArrow: TLMDThemesOnDrawArrowEvent read FOnDrawArrow write FOnDrawArrow;
    property OnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent read FOnDrawGradientArrow write FOnDrawGradientArrow;
    property OnDrawPlus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawPlus write FOnDrawPlus;
    property OnDrawMinus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawMinus write FOnDrawMinus;
    property OnDrawCross: TLMDThemesOnDrawSimpleSignEvent read FOnDrawCross write FOnDrawCross;
  end;

var
  LMDSGThemeRenderer: TLMDSimpleGradientThemeRenderer;
  LMDSGThemeController: TLMDSimpleGradientThemeController;

procedure RegisterRenderer;

implementation

uses
  SysUtils, LMDStrings, LMDXML, LMDThemesConst, LMDProcs, LMDGraphUtils;

{------------------------------------------------------------------------------}
procedure RegisterRenderer;
begin
  if LMDSGThemeRenderer = nil then
  begin
    LMDSGThemeRenderer := TLMDSimpleGradientThemeRenderer.Create;
    LMDThemeServices.RegisterThemeRenderer(LMDSGThemeRenderer);
  end;  
end;

{----------------- TLMDSimpleGradientThemeRenderer ----------------------------}
class function TLMDSimpleGradientThemeRenderer.Controller: TLMDThemesControllerBase;
begin
  result := LMDSGThemeController;
end;

{------------------------------------------------------------------------------}
class function TLMDSimpleGradientThemeRenderer.GetThemeRendererName: TLMDString;
begin
  result := 'LMD Simple Gradient Themes Renderer';
end;

{------------------------------------------------------------------------------}
class procedure TLMDSimpleGradientThemeRenderer.Init;
begin
  RegisterRenderer;
end;

{------------------- TLMDSimpleGradientThemeController ------------------------}
constructor TLMDSimpleGradientThemeController.Create(aOwner: TComponent);
begin
  if Assigned(LMDSGThemeController) then
    raise Exception.Create('An instance of ' + ClassName + ' already exists (owner: ' + LMDSGThemeController.Owner.Name +')');
  inherited;
  if not Assigned(LMDSGThemeRenderer) and not (csDesigning in ComponentState) then
    TLMDSimpleGradientThemeRenderer.Init;
end;

function TLMDSimpleGradientThemeController.GetThemeRenderer: TLMDThemeRenderer;
begin
  result := LMDSGThemeRenderer;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientThemeController.Loaded;
begin
  inherited;
  if GetThemeRenderer <> nil then
    with TLMDSimpleGradientThemeRenderer(GetThemeRenderer) do
    begin
      OnDrawCheckMark := FOnDrawCheckMark;
      OnDrawRadioBtn := FOnDrawRadioBtn;
      OnDrawScrollThumbGripper := FOnDrawScrollThumbGripper;
      OnDrawArrow := FOnDrawArrow;
      OnDrawGradientArrow := FOnDrawGradientArrow;
      OnDrawPlus := FOnDrawPlus;
      OnDrawMinus := FOnDrawMinus;
      OnDrawCross := FOnDrawCross;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientThemeController.RegisterController;
begin
  LMDSGThemeController := Self;
end;

{------------------------------------------------------------------------------}
procedure TLMDSimpleGradientThemeController.UnregisterController;
begin
  LMDSGThemeController := nil;
end;

initialization

  LMDSGThemeRenderer := nil;
  LMDSGThemeController := nil;

finalization

  if LMDSGThemeRenderer <> nil then
    FreeAndNil(LMDSGThemeRenderer);

end.
