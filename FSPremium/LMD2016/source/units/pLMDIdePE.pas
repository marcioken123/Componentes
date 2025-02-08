unit pLMDIdePE;
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

pLMDIdePE unit (YB)
------------------------
Unit contains property editors needed in LMD IDE-Tools pack.

Changes
-------

###############################################################################}

interface

uses
  Classes, SysUtils, Types, TypInfo, Graphics, ImgList, DesignIntf,
  DesignEditors, VCLEditors, LMDIdeCst, LMDIdeClass;

type
  {************************ TLMDIdeImageIndexProperty *************************}

  TLMDIdeImageIndexProperty = class(TIntegerProperty, ICustomPropertyListDrawing)
  protected
    function GetImages: TCustomImageList; virtual;
    function GetImagesPropertyName: string; virtual;
  protected
    { ICustomPropertyListDrawing }

    procedure ListMeasureWidth(const Value: string; ACanvas: TCanvas;
                               var AWidth: Integer);
    procedure ListMeasureHeight(const Value: string; ACanvas: TCanvas;
                                var AHeight: Integer);
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
                            const ARect: TRect; ASelected: Boolean);
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

{ TLMDIdeImageIndexProperty }

function TLMDIdeImageIndexProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paValueList];
end;

function TLMDIdeImageIndexProperty.GetImages: TCustomImageList;
var
  cmp: TPersistent;
begin
  cmp    := GetComponent(0);
  Result := TCustomImageList(GetObjectProp(cmp, GetImagesPropertyName,
                             TCustomImageList));
end;

function TLMDIdeImageIndexProperty.GetImagesPropertyName: string;
begin
  Result := 'Images';
end;

procedure TLMDIdeImageIndexProperty.GetValues(Proc: TGetStrProc);
var
  i:    Integer;
  imgs: TCustomImageList;
begin
  imgs := GetImages;
  if imgs <> nil then
  begin
    for i := 0 to imgs.Count - 1 do
      Proc(IntToStr(i));
  end;
end;

procedure TLMDIdeImageIndexProperty.ListDrawValue(const Value: string;
  ACanvas: TCanvas; const ARect: TRect; ASelected: Boolean);
var
  tr: TRect;
  b:  TBitmap;
  imgs: TCustomImageList;
begin
  tr   := ARect;
  imgs := GetImages;

  if imgs <> nil then
  begin
    Inc(tr.Left, 1 + imgs.Width + 1);

    with ARect do
      ACanvas.FillRect(Rect(Left, Top, tr.Left, Bottom));

    b := TBitmap.Create;
    try
      b.Width  := imgs.Width;
      b.Height := imgs.Height;
      if imgs.Height > ARect.Bottom - ARect.Top - 2 then
        b.Height := ARect.Bottom - ARect.Top - 2;

      b.Canvas.Brush.Color := ACanvas.Brush.Color;
      b.Canvas.FillRect(Rect(0, 0, b.Width, b.Height));
      imgs.Draw(b.Canvas, 0, 0, StrToInt(Value));

      ACanvas.Draw(ARect.Left + 1, ARect.Top + 1, b);
    finally
      b.Free;
    end;
  end;
  with tr, ACanvas do
    ACanvas.TextRect(tr, Left + 1, (Top + Bottom - TextHeight(Value)) div 2, Value);
end;

procedure TLMDIdeImageIndexProperty.ListMeasureHeight(const Value: string;
  ACanvas: TCanvas; var AHeight: Integer);
var
  imgs: TCustomImageList;
begin
  imgs    := GetImages;
  AHeight := ACanvas.TextHeight('Wg');

  if (imgs <> nil) and (AHeight < 1 + imgs.Height + 1) then
    AHeight := 1 + imgs.Height + 1;
end;

procedure TLMDIdeImageIndexProperty.ListMeasureWidth(const Value: string;
  ACanvas: TCanvas; var AWidth: Integer);
var
  imgs: TCustomImageList;
  i:    Char;
  wd:   Integer;
begin
  AWidth := 0;
  for i := '0' to '9' do
  begin
    wd := ACanvas.TextWidth(i);
    if wd > AWidth then
      AWidth := wd;
  end;
  AWidth := ACanvas.TextWidth('-') + (7 * AWidth);

  imgs := GetImages;
  if imgs <> nil then
    Inc(AWidth, 1 + imgs.Width + 1);
end;

end.
