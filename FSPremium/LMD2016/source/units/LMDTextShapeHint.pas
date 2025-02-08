unit LMDTextShapeHint;
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

LMDTextShapeHint unit (JH)
--------------------------

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls, Graphics, LMDTypes, LMD3DCaption, LMDTextObject,
  LMDText, LMDCustomShapeHint, LMDShapeHint;

type
  TLMDTextShapeHint = class;

  {-------------------- class TLMDTextShapeHintWindow -------------------------}

  TLMDTextShapeHintWindow = class(TLMDShapeHintWindow)
  protected
    procedure DrawTextTo(Canvas: TCanvas; ACaption: TLMDString;
                         TextRect: TRect); override;
    procedure GetTextSize(Caption: TLMDString; var aRect: TRect); override;
  public
    function HintControl: TLMDTextShapeHint;
  end;

  {------------------------- class TLMDShapeHint ------------------------------}

  TLMDTextShapeHint = class(TLMDCustomShapeHint)
  private
    FText:           TLMDTextObject;
    FOnGetVariable:  TLMDGetVariableEvent;
    FOnGraphicError: TLMDGraphicErrorEvent;

    procedure SetTextObject(aValue: TLMDTextObject);
  protected
    function  GetHintClass: THintWindowClass; override;
    procedure DoGraphicError(Sender: TObject; aPicture: TPicture;
                             const aFileName: String; aImageIndex: LongInt);
    function  DoGetVariable(Sender: TObject; const aVarName: string): string;
  public
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
  published
    property Enabled;
    property DefaultIcon;
    property DefaultTitle;
    property TextSettings: TLMDTextObject read FText write SetTextObject;
    property OnGetVariable: TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
    property OnGraphicError: TLMDGraphicErrorEvent read FOnGraphicError write FOnGraphicError;
    property Distance;
    property Gradient;
    property NoseLength;
    property NoseWidth;
    property NoseAngleWidth;
    property Options;
    property Position;
    property RoundRectWidth;
    property Shadow;
    property Style;
    property ThemeMode;
    property ThemeGlobalMode;
    property TitleFont3D;
    property UseGradient;
    property UseSystemShadow;
  end;

implementation

uses
  LMDUtils, LMDClass;

{------------------------------------------------------------------------------}
procedure TLMDTextShapeHintWindow.GetTextSize(Caption: TLMDString;
  var aRect: TRect);
begin
  if HintControl = nil then
    Exit;
  HintControl.TextSettings.Parse(Caption + #10);
  aRect := HintControl.TextSettings.GetClientRect(Canvas, aRect,
    HintControl.GetHintFont, false, true);
  InflateRect (aRect, 2, 2);
  OffsetRect (aRect, 2, 2);
end;

function TLMDTextShapeHintWindow.HintControl: TLMDTextShapeHint;
begin
  Result := (inherited HintControl) as TLMDTextShapeHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextShapeHintWindow.DrawTextTo(Canvas: TCanvas;
  ACaption: TLMDString; TextRect: TRect);
begin
  if HintControl = nil then
    Exit;
  HintControl.TextSettings.ParseAndRender(ACaption + #10, Canvas,
    TextRect, Point(0,0), HintControl.GetHintFont,
    HintControl.Color, False, True);
end;

{ ******************** TLMDTextShapeHint **************************************}
{---------------------------- Private -----------------------------------------}
procedure TLMDTextShapeHint.SetTextObject(aValue: TLMDTextObject);
begin
  FText.Assign(aValue);
end;

{---------------------------- Protected ---------------------------------------}
procedure TLMDTextShapeHint.DoGraphicError(Sender: TObject; aPicture: TPicture;
  const aFileName: String; aImageIndex: LongInt);
begin
  if Assigned(FOnGraphicError) then
    FOnGraphicError(self, aPicture, aFileName, aImageIndex);
end;

function TLMDTextShapeHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDTextShapeHintWindow;
end;

{------------------------------------------------------------------------------}
function TLMDTextShapeHint.DoGetVariable(Sender: TObject;
  const aVarName: string): string;
begin
  if Assigned(FOnGetVariable) then
    Result := FOnGetVariable(Self, aVarName)
  else
    Result := '';
end;

{----------------------------- public -----------------------------------------}
constructor TLMDTextShapeHint.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  HideAccelChar := False;
  FText := TLMDTextObject.Create;
  FText.OnGetVariable := DoGetVariable;
  FText.OnGraphicError := DoGraphicError;
end;

{------------------------------------------------------------------------------}
destructor TLMDTextShapeHint.Destroy;
begin
  FText.Free;
  inherited Destroy;
end;

end.
