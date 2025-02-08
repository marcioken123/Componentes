unit LMDExplorerButton;
{$I lmdcmps.Inc}

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description:
  # State: release
  # Comments:
  #---------------------------------- CHANGES ----------------------------------
  # Author:
  # Date:
  # Description:
  # %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # Author:
  # Date:
  # Description:
  ##############################################################################
}

interface

uses
  Classes,
  LMDButtonBase,
  LMDOfficeButton;

type
  TLMDExplorerButton=class(TLMDOfficeButton)
  protected
    procedure ColReadIdent(Reader:TReader);
    procedure TransReadIdent(Reader:TReader);
    procedure DefineProperties(Filer:TFiler);override;
  public
    constructor Create(AOwner: TComponent); override;
    property Transparent;
  published
    property AllowAllUp: Boolean read GetAllowAllUp write SetAllowAllUp default False;
    property UnColorMain:Boolean read GetUnColorMain write SetUnColorMain default True;
    property GroupIndex;
    property Pressed;
    property Style;
  end;

implementation

uses
  Controls,
  LMDGraph,
  LMDGlyph;

{------------------------------------------------------------------------------}
constructor TLMDExplorerButton.Create(AOwner: TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=ControlStyle-[csOpaque];
  FTransparent:=True;
  FStyle:=ubsExplorer;
  TLMDGlyph(FGlyph).Style:=gsExplorer; //.FStyle changed due to extracting TLMDGylph to lmdglyph
  AllowMouseOver:=True;
  Width:=54;
  Height:=40;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerButton.ColReadIdent(Reader: TReader);
var
  TempB: Boolean;
begin
  Reader.Read(TempB,SizeOf(Boolean));
  UnColorMain:=TempB;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerButton.TransReadIdent(Reader: TReader);
var
  TempB: Boolean;
begin
  Reader.Read(TempB,SizeOf(Boolean));
  Transparent:=TempB;
end;

{------------------------------------------------------------------------------}
procedure TLMDExplorerButton.DefineProperties(Filer:TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('UnColorMain', ColReadIdent, nil, False);
  Filer.DefineProperty('Transparent', TransReadIdent, nil, False);
end;

end.
