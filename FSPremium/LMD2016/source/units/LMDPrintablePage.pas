unit LMDPrintablePage;
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

LMDPrintablePage unit (RS)
-----------------------------------
LMDPrintablePage represents a logical page (of a printable document) which consistns
of several rectangular areas, each such area contains a TLMDDocElement
(or its part if it was split into several areas during layout process)

Changes
-------
* Not released yet

###############################################################################}

interface

uses Classes, Windows, LMDPrinter, LMDDocModel;

type

  TLMDPrintablePage = class(TPersistent)
  private
    FPageAreas: TList;
    FPageNumber: integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property PageAreas: TList read FPageAreas;
    property PageNumber: integer read FPageNumber write FPageNumber;
  end;

  TLMDPageArea = class(TPersistent)
  private
    FDocElements: array of TLMDDocElement;

    FArea: TRect;

    FPage: TLMDPrintablePage;
    FHorizPartIndex: integer;
    FVertPartIndex: integer;
    function GetDocElementsCount: integer;
    function GetDocElement(AIndex: Integer): TLMDDocElement;
  public
    constructor Create;
    destructor Destroy; override;

    //I will own this Element!
    procedure AddDocElement(AElement: TLMDDocElement);
    //Clear documents list and don't free, don't own elements
    procedure DetachElements;

    property DocElements[AIndex: Integer]: TLMDDocElement read GetDocElement;
    property DocElementsCount: integer read GetDocElementsCount;
    
    property Page: TLMDPrintablePage read FPage write FPage;
    property Area: TRect read FArea write FArea;
    property HorizPartIndex: integer read FHorizPartIndex write FHorizPartIndex;
    property VertPartIndex: integer read FVertPartIndex write FVertPartIndex;
  end;

implementation

{ TLMDPrintablePage }

constructor TLMDPrintablePage.Create;
begin
  inherited;

  FPageAreas := TList.Create;
end;

destructor TLMDPrintablePage.Destroy;
begin
  FPageAreas.Free;

  inherited;
end;

{ TLMDPageArea }

procedure TLMDPageArea.AddDocElement(AElement: TLMDDocElement);
var
    L: Integer;
begin
  L := Length(FDocElements);
  SetLength(FDocElements, L+1);

  FDocElements[L] := AElement;
end;

constructor TLMDPageArea.Create;
begin
  inherited;

  FArea.Left := -1;
  FArea.Top := -1;
  FArea.Right := -1;
  FArea.Bottom := -1;

  SetLength(FDocElements, 0);

  FPage := nil;

  FHorizPartIndex := -1;
  FVertPartIndex := -1;
end;

destructor TLMDPageArea.Destroy;
var
    i: Integer;
begin
  for i := 0 to Length(FDocElements) - 1 do
    FDocElements[i].Free;

  inherited;
end;

procedure TLMDPageArea.DetachElements;
begin
  SetLength(FDocElements, 0);
end;

function TLMDPageArea.GetDocElement(AIndex: Integer): TLMDDocElement;
begin
  Result := FDocElements[AIndex];
end;

function TLMDPageArea.GetDocElementsCount: integer;
begin
  Result := Length(FDocElements);
end;

end.
