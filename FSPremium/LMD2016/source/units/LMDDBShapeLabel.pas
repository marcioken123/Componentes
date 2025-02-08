unit LMDDBShapeLabel;
{$I lmdcmps.inc}

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
  LMDDBShapeControl;

type
  {------------------------------- TLMDDBShapeLabel ---------------------------}
  TLMDDBShapeLabel=class(TLMDDBShapeControl)
  public
    constructor Create(AOwner: TComponent); override;
  published
  end;

implementation

uses
  LMDBaseShape;

{------------------------------ Public ----------------------------------------}
constructor TLMDDBShapeLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Mode:=scmShapeFill;
end;

end.
 
