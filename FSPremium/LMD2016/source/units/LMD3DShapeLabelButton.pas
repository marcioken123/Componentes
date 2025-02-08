unit LMD3DShapeLabelButton;
{$I lmdcmps.inc}

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description:
  # State: release
  # Comments: Outdated label control. Kept for backward compatibility.
  #           Please do not use this component in new projects.
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
  TLMD3DShapeLabelButton=class(TLMDCustomShapeButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  LMDGraph,
  LMDShapeBase;

{----------------------TLMD3DShapeLabelButton----------------------------------}
constructor TLMD3DShapeLabelButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBevel3D:=True;
  FStyle:=sbs3D;
  FMode:=sbmShapeFill;
end;

end.
