unit LMDPNGImageFilters;
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

LMDPNGImageFilters unit (AH)
----------------------------

Changes
-------
Release 8.0 (July 2007)
 - Initial Release

###############################################################################}

interface

uses
  Windows,
  LMDGraphUtils, LMDPNGImage;

type
  TLMDPNGImageFilter = class(TObject)
  private
    FSourceImage: TLMDPNGObject;
    FResultImage: TLMDPNGObject;
    FModified: Boolean;
    procedure SetSourceImage(const Value: TLMDPNGObject);
    function GetResultImage: TLMDPNGObject;
  protected
    procedure Transform; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property ResultImage: TLMDPNGObject read GetResultImage;
    property SourceImage: TLMDPNGObject read FSourceImage write SetSourceImage;
  end;

  TLMDPNGGrayscaleFilter = class(TLMDPNGImageFilter)
  protected
    procedure Transform; override;
  end;

  TLMDPNGAlphaBlendFilter = class(TLMDPNGImageFilter)
  private
    FAlpha: byte;
    procedure SetAlpha(const Value: byte);
  protected
    procedure Transform; override;
  public
    constructor Create; override;
    property AlphaPercent: byte read FAlpha write SetAlpha;
  end;

implementation

{ TLMDPNGImageFilter }

constructor TLMDPNGImageFilter.Create;
begin
  inherited;
  FModified := False;
  FSourceImage := nil;
  FResultImage := TLMDPNGObject.Create;
end;

destructor TLMDPNGImageFilter.Destroy;
begin
  FResultImage.Free;
  inherited;
end;

function TLMDPNGImageFilter.GetResultImage: TLMDPNGObject;
begin
  if FModified then
    Transform;
  Result := FResultImage;
end;

procedure TLMDPNGImageFilter.SetSourceImage(const Value: TLMDPNGObject);
begin
  if FSourceImage <> Value then
  begin
    FModified := True;
    FSourceImage := Value;
    FResultImage.Assign(Value);
  end;
end;

{ TLMDPNGGrayscaleFilter }

procedure TLMDPNGGrayscaleFilter.Transform;
var
  i: Integer;
  j: Integer;
  LLine: PRGBLine;
  LTemp: Integer;
begin
  if not FSourceImage.Header.ColorType in [COLOR_RGB, COLOR_RGBALPHA] then
    exit;

  for i := 0 to FResultImage.Height - 1 do
  begin
    LLine := FResultImage.Scanline[i];
    for j := 0 to FResultImage.Width - 1 do
    begin
      LTemp := (LLine^[j].rgbtBlue * 77 + LLine^[j].rgbtGreen * 151 + LLine^[j].rgbtRed * 28) shr 8;
      LLine^[j].rgbtBlue := LTemp;
      LLine^[j].rgbtGreen := LTemp;
      LLine^[j].rgbtRed := LTemp;
    end;
  end;
  end;

{ TLMDPNGAlphaBlendFilter }

constructor TLMDPNGAlphaBlendFilter.Create;
begin
  inherited;
  FAlpha := 255 div 2;
end;

procedure TLMDPNGAlphaBlendFilter.SetAlpha(const Value: byte);
begin
  if (FAlpha <> Value) and (Value in [0..100]) then
  begin
    FModified := True;
    FAlpha := Value;
  end;
end;

procedure TLMDPNGAlphaBlendFilter.Transform;
var
  i: Integer;
  j: Integer;
  LLine: PByteArray;
begin
  if not FSourceImage.Header.ColorType in [COLOR_RGB, COLOR_RGBALPHA, COLOR_PALETTE] then
    exit;
  FResultImage.CreateAlpha;
  for i := 0 to FResultImage.Height - 1 do
  begin
    LLine := FSourceImage.AlphaScanline[i];
    for j := 0 to FResultImage.Width - 1 do
      if LLine <> nil then
        FResultImage.AlphaScanline[i]^[j] := round((LLine^[j] * FAlpha) / 100)
      else
        FResultImage.AlphaScanline[i]^[j] := round((255 * FAlpha) / 100);
  end;
  end;

end.
