unit LMDShapeLabelButton;
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
  LMDCustomShapeButton;

type
  TLMDShapeLabelButton=class(TLMDCustomShapeButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  LMDShapeBase;

constructor TLMDShapeLabelButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FMode:=sbmShapeFill;
end;

end.
 
