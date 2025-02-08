unit LMDShapeLabel;
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
  LMDShapeControl;

type
  TLMDShapeLabel = class(TLMDShapeControl)
  public
    constructor Create(aOwner: TComponent);override;
  end;

implementation

uses
  LMDBaseShape;

{------------------------- Public ---------------------------------------------}
constructor TLMDShapeLabel.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Mode:=scmShapeFill;
end;

end.
 
