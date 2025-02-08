unit LMDTextHint;
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

LMDTextHint unit (JH)
---------------------

Hint control component. The hint window can contain formatted HTML text

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Graphics, Forms, Controls, Windows, LMDTextObject, LMDText,
  LMDCustomHint, LMDHint;

type
  TLMDTextHint = class;

  TLMDTextHintWindow = class(TLMDCustomHintWindow)
  protected
    procedure DrawTextTo(Canvas : TCanvas; Caption : String; TextRect : TRect); override;
    procedure GetTextSize(Caption : String; var aRect : TRect); override;
    function  HintControl: TLMDTextHint;
  end;

  TLMDTextHint = class(TLMDCustomHint)
  private
    FText           : TLMDTextObject;
    FOnGetVariable  : TLMDGetVariableEvent;
    FOnGraphicError : TLMDGraphicErrorEvent;
    procedure SetTextObject (aValue : TLMDTextObject);
  protected
    function  GetHintClass: THintWindowClass; override;
    procedure DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt);
    function  DoGetVariable(Sender: TObject; const aVarName: string): string;
  public
    constructor Create(AOwner:TComponent);Override;
    destructor Destroy;override;
  published
    property About;
    property Bevel;
    property Color;
    property Enabled;
    property TextSettings : TLMDTextObject read FText write SetTextObject;

    property OnGetVariable : TLMDGetVariableEvent read FOnGetVariable write FOnGetVariable;
    property OnGraphicError: TLMDGraphicErrorEvent read FOnGraphicError write FOnGraphicError;
  end;

implementation

uses
  SysUtils, 
  LMDClass, LMDGraph;

{ ********************** TLMDTextHintWindow ***********************************}
{--------------------------- Protected ----------------------------------------}
procedure TLMDTextHintWindow.DrawTextTo(Canvas: TCanvas; Caption: String;
  TextRect: TRect);
begin
  if HintControl = nil then
    Exit;
  HintControl.TextSettings.ParseAndRender(Caption+ #10, Canvas, TextRect,
                                          Point(0,0), HintControl.GetHintFont,
                                          HintControl.Color, false, true);
end;

{------------------------------------------------------------------------------}
function TLMDTextHintWindow.HintControl: TLMDTextHint;
begin
  Result := (inherited HintControl) as TLMDTextHint;
end;

{------------------------------------------------------------------------------}
procedure TLMDTextHintWindow.GetTextSize(Caption: String; var aRect: TRect);
begin
  if HintControl = nil then
    Exit;
  HintControl.TextSettings.Parse (Caption + #10);
  aRect := HintControl.TextSettings.GetClientRect(Canvas, aRect,
    HintControl.GetHintFont, false, true);
end;

{ ************************** TLMDTextHint *************************************}
{---------------------------- Private -----------------------------------------}
procedure TLMDTextHint.SetTextObject (aValue : TLMDTextObject);
begin
  FText.Assign (aValue);
end;

{---------------------------- Protected ---------------------------------------}
procedure TLMDTextHint.DoGraphicError(Sender: TObject; aPicture: TPicture; const aFileName: String; aImageIndex: LongInt);
begin
  if Assigned (FOnGraphicError) then FOnGraphicError (self, aPicture, aFileName, aImageIndex);
end;

function TLMDTextHint.GetHintClass: THintWindowClass;
begin
  Result := TLMDTextHintWindow;
end;

{------------------------------------------------------------------------------}
function TLMDTextHint.DoGetVariable(Sender: TObject; const aVarName: string): string;
begin
  if Assigned (FOnGetVariable) then
    result := FOnGetVariable (self, aVarName)
  else
    result := '';
end;

{--------------------------- Public -------------------------------------------}
constructor TLMDTextHint.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  FText := TLMDTextObject.Create;
  FText.OnGetVariable := DoGetVariable;
  FText.OnGraphicError := DoGraphicError;
end;

{------------------------------------------------------------------------------}
destructor TLMDTextHint.Destroy;
begin
  FreeAndNil(FText);
  inherited Destroy;
end;

end.
