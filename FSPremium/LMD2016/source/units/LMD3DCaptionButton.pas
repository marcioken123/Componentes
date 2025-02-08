unit LMD3DCaptionButton;
{$I lmdcmps.inc}

{
  ##############################################################################
  # Author: LMD Innovative ()
  # Created: 1996
  # Description: Outdated button control. Kept for backward compatibility.
  #              Please do not use this component in new projects.
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
  LMDCustom3DButton;

type
  {----------------------------------------------------------------------------}
  TLMD3DCaptionButton=class(TLMDCustom3DButton)
  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{------------------------- Protected ------------------------------------------}
constructor TLMD3DCaptionButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FKind:=1;
end;

end.
