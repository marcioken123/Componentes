unit LMDTeethShape;
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
  TLMDTeethShape = class(TLMDShapeControl)
  public
    constructor Create(aOwner: TComponent);override;
  end;

implementation

uses
  LMDBaseShape;

{------------------------- Public ---------------------------------------------}
constructor TLMDTeethShape.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Mode:=scmTeethFast;
end;

end.
 
