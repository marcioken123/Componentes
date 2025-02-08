unit LMD3DShapeButton;
{$I lmdcmps.inc}

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description:
  # State: release
  # Comments: Outdated button control. Kept for backward compatibility.
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
  TLMD3DShapeButton=class(TLMDCustomShapeButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  LMDBaseShape;

constructor TLMD3DShapeButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBevel3D:=True;
  FStyle:=sbs3D;
end;

end.
