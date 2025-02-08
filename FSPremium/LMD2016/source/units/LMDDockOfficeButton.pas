unit LMDDockOfficeButton;
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
  LMDDockSpeedButton;
  
type
  TLMDDockOfficeButton=class(TLMDDockSpeedButton)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Style;
  end;

implementation

uses
  Controls,
  LMDGraph;

{-------------------------- Public --------------------------------------------}
constructor TLMDDockOfficeButton.Create(aOwner:TComponent);
begin
  inherited Create(aOwner);
  ControlStyle:=[csCaptureMouse, csDoubleClicks, csReplicatable];
  FStyle:=ubsFlat;
  FAllowTransparency:=False;
  AllowMouseOver:=True;
  Width:=23;
  Height:=22;
end;

end.
 
