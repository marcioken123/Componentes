unit LMDThemesGradientThemeRenderer;
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

LMDThemesGradientThemeRenderer unit (VB)
----------------------------------------

This unit contains reference to TLMDThemesGradientThemeRenderer singleton which
implements Office2007-like gradient theme rendering

Changes
-------
Release 10.0 (January 2009)
- Initial Release

###############################################################################}

interface

uses
  Classes, LMDTypes, LMDThemes, LMDThemesGradientThemeBase;

type
  TLMDGradientThemeRenderer = class(TLMDBaseGradientThemeRenderer)
  public
    class function Controller: TLMDThemesControllerBase; override;
    class procedure Init; override;
    class function GetThemeRendererName: TLMDString; override;
  end;

  { --------------------- TLMDThemesGradientThemeController -------------------}
  TLMDThemesGradientThemeController = class (TLMDThemesControllerBase)
  private
    FOnDrawElement: TLMDThemesOnDrawElement;
    FOnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent;
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
    constructor Create (aOwner: TComponent); override;
  published
    property OnDrawElement: TLMDThemesOnDrawElement read FOnDrawElement write FOnDrawElement;
    property OnDrawCheckMark: TLMDThemesOnDrawCheckMarkEvent read FOnDrawCheckMark write FOnDrawCheckMark;
    property OnDrawScrollThumbGripper: TLMDThemesOnDrawScrollThumbGripperEvent read FOnDrawScrollThumbGripper write FOnDrawScrollThumbGripper;
    property OnDrawArrow: TLMDThemesOnDrawArrowEvent read FOnDrawArrow write FOnDrawArrow;
    property OnDrawGradientArrow: TLMDThemesOnDrawGradientArrowEvent read FOnDrawGradientArrow write FOnDrawGradientArrow;
    property OnDrawPlus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawPlus write FOnDrawPlus;
    property OnDrawMinus: TLMDThemesOnDrawSimpleSignEvent read FOnDrawMinus write FOnDrawMinus;
    property OnDrawCross: TLMDThemesOnDrawSimpleSignEvent read FOnDrawCross write FOnDrawCross;
  end;

var
  LMDGradientThemeRenderer: TLMDGradientThemeRenderer;
  LMDGradientThemeController: TLMDThemesGradientThemeController;

procedure RegisterRenderer;

implementation

uses
  SysUtils, LMDStrings, LMDXML, LMDThemesConst, LMDProcs, LMDGraphUtils;

{------------------------------------------------------------------------------}
procedure RegisterRenderer;
begin
  if LMDGradientThemeRenderer = nil then
  begin
    LMDGradientThemeRenderer := TLMDGradientThemeRenderer.Create;
    LMDThemeServices.RegisterThemeRenderer(LMDGradientThemeRenderer);
  end;  
end;

{----------------------- TLMDGradientThemeRenderer ----------------------------}
class function TLMDGradientThemeRenderer.Controller: TLMDThemesControllerBase;
begin
  result :=  LMDGradientThemeController;
end;


{------------------------------------------------------------------------------}
class function TLMDGradientThemeRenderer.GetThemeRendererName: TLMDString;
begin
  result := 'LMD Gradient Themes Renderer';
end;

{------------------------------------------------------------------------------}
class procedure TLMDGradientThemeRenderer.Init;
begin
  RegisterRenderer;
end;

{-------------------- TLMDThemesGradientThemeController -----------------------}
constructor TLMDThemesGradientThemeController.Create(aOwner: TComponent);
begin
  if Assigned(LMDGradientThemeController) then
    raise Exception.Create('An instance of ' + ClassName + ' already exists (owner: ' + LMDGradientThemeController.Owner.Name +')');
  inherited;
  if not Assigned(LMDGradientThemeRenderer) and not (csDesigning in ComponentState) then
    TLMDGradientThemeRenderer.Init;
end;

{------------------------------------------------------------------------------}
function TLMDThemesGradientThemeController.GetThemeRenderer: TLMDThemeRenderer;
begin
  result := LMDGradientThemeRenderer;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesGradientThemeController.Loaded;
begin
  inherited;
  if GetThemeRenderer <> nil then
    with TLMDGradientThemeRenderer(GetThemeRenderer) do
    begin
      OnDrawElement := FOnDrawElement;
      OnDrawCheckMark := FOnDrawCheckMark;
      OnDrawScrollThumbGripper := FOnDrawScrollThumbGripper;
      OnDrawArrow := FOnDrawArrow;
      OnDrawGradientArrow := FOnDrawGradientArrow;
      OnDrawPlus := FOnDrawPlus;
      OnDrawMinus := FOnDrawMinus;
      OnDrawCross := FOnDrawCross;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesGradientThemeController.RegisterController;
begin
  LMDGradientThemeController := Self;
end;

{------------------------------------------------------------------------------}
procedure TLMDThemesGradientThemeController.UnregisterController;
begin
  LMDGradientThemeController := nil;
end;

initialization

  LMDGradientThemeRenderer := nil;
  LMDGradientThemeController := nil;

finalization

  if LMDGradientThemeRenderer <> nil then
    FreeAndNil(LMDGradientThemeRenderer);

end.
