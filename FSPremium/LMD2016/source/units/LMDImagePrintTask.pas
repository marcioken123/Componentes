unit LMDImagePrintTask;
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

LMDImagePrintTask unit (RS)
-----------------------------------
Base class for all the Print Tasks of printing support package for printing images (graphics)
(including LMD Chart control etc.).

Changes
-------
* Not released yet

###############################################################################}

interface

uses Math, Classes, SysUtils,
    Windows, Printers, Graphics, Dialogs, Types,
    LMDCustomComponent, LMDPrinter, LMDDocModel, LMDPrintablePage,
    LMDCustomPrintTask, LMDPageLayout, LMDSimpleRectPageLayout,
    LMDLayoutRenderPrintTask, LMDDocElementRenderer;

type
    TLMDImagePrintMode = (ipmAsIs, ipmFitToPage, ipmFixedSize, ipmFixedPageCount);
  TLMDCustomImagePrintTask = class(TLMDLayoutRenderPrintTask)
  private
    FFixedSizeX: double;
    FFixedSizeY: double;
    FMaxPagesCountY: integer;
    FMaxPagesCountX: integer;
    FDrawingMode: TLMDImagePrintMode;
    FStretch: boolean;
    FKeepRatio: boolean;
    FPixelFormat: TPixelFormat;
    procedure SetPixelFormat(const Value: TPixelFormat);
  protected
    FPicture: TBitmap;
    procedure CreateLayoutManager; override;
    procedure ConstructDocument; override;
    procedure SetImageSize(ADocImage: TLMDDocImage; APagesX, APagesY: integer);
    procedure SetExpectedPictureSize; virtual;
    procedure RenderTargetPicture; virtual;
  published
    property About;
    property DrawingMode: TLMDImagePrintMode read FDrawingMode write FDrawingMode default ipmAsIs;
    property PixelFormat: TPixelFormat read FPixelFormat write SetPixelFormat default pfDevice;
    property Stretch: boolean read FStretch write FStretch default false;
    property KeepRatio: boolean read FKeepRatio write FKeepRatio default false;
    property FixedSizeX: double read FFixedSizeX write FFixedSizeX;
    property FixedSizeY: double read FFixedSizeY write FFixedSizeY;
    property MaxPagesCountX: integer read FMaxPagesCountX write FMaxPagesCountX default 0;
    property MaxPagesCountY: integer read FMaxPagesCountY write FMaxPagesCountY default 0;
  end;

  TLMDImagePrintTask = class(TLMDCustomImagePrintTask)
    procedure SetPicture(const Value: TBitmap);
  public
    constructor Create (AOwner: TComponent); override;
    destructor Destroy; override;  
  published
    property Picture: TBitmap read FPicture write SetPicture;
  end;

implementation

{ TLMDCustomImagePrintTask }

procedure TLMDCustomImagePrintTask.ConstructDocument;
var
  LDocImage: TLMDDocImage;
begin
  Self.FDocument := TLMDDocument.Create;

  LDocImage := TLMDDocImage.Create;
  LDocImage.Top := 0;
  LDocImage.Left := 0;
  Self.SetExpectedPictureSize;
  LDocImage.Picture := Self.FPicture;
  LDocImage.Picture.PixelFormat := Self.PixelFormat;
  Assert(FPageWidth<>-1);

  case Self.DrawingMode of
  ipmFitToPage:         begin
                          Self.SetImageSize(LDocImage, 1, 1);
                        end;
  ipmFixedSize:         begin
                          LDocImage.Width := Self.Printer.UnitsToPixelsX(Self.FixedSizeX);
                          LDocImage.Height := Self.Printer.UnitsToPixelsY(Self.FixedSizeY);
                        end;
  ipmFixedPageCount:    begin
                          Self.SetImageSize(LDocImage, Self.MaxPagesCountX, Self.MaxPagesCountY);
                        end;
  else
                        begin
                          LDocImage.Width := LDocImage.Picture.Width;
                          LDocImage.Height := LDocImage.Picture.Height;
                        end;                      
  end;
  Self.RenderTargetPicture;
  Self.FDocument.ChildElements.Add(LDocImage);
end;

procedure TLMDCustomImagePrintTask.CreateLayoutManager;
begin
  FLayout := TLMDSimpleRectPageLayout.Create;
end;

procedure TLMDCustomImagePrintTask.RenderTargetPicture;
begin

end;

procedure TLMDCustomImagePrintTask.SetExpectedPictureSize;
begin

end;

procedure TLMDCustomImagePrintTask.SetImageSize(ADocImage: TLMDDocImage; APagesX,
  APagesY: integer);
var
  LToPageRatio: double;
  LTestWidth, LTestHeight: integer;  
begin
  if Self.Stretch then
  begin
    LTestWidth := FPageWidth * APagesX;
    LTestHeight := FPageHeight * APagesY;
  end
  else
  begin
    LTestWidth := ADocImage.Picture.Width;
    LTestHeight := ADocImage.Picture.Height;
  end;

  if Self.KeepRatio then
  begin
    LToPageRatio := LTestWidth / ADocImage.Picture.Width;
    if ADocImage.Picture.Height * LToPageRatio <= FPageHeight * APagesY then
    begin
      ADocImage.Width := LTestWidth;
      ADocImage.Height := Round(ADocImage.Picture.Height * LToPageRatio);
    end
    else
    begin
      LToPageRatio := LTestHeight / ADocImage.Picture.Height;
      ADocImage.Height := LTestHeight;
      ADocImage.Width := Round(ADocImage.Picture.Width * LToPageRatio);
    end;
  end
  else
  begin
    ADocImage.Width := LTestWidth;
    ADocImage.Height := LTestHeight;
  end;
end;

procedure TLMDCustomImagePrintTask.SetPixelFormat(const Value: TPixelFormat);
begin
  FPixelFormat := Value;
end;

{ TLMDImagePrintTask }

constructor TLMDImagePrintTask.Create(AOwner: TComponent);
begin
  inherited;
  Self.FPicture := TBitmap.Create;
end;

destructor TLMDImagePrintTask.Destroy;
begin
  Self.FPicture.Free;
  inherited;
end;

procedure TLMDImagePrintTask.SetPicture(const Value: TBitmap);
begin
  FPicture.Assign(Value);
end;

end.
