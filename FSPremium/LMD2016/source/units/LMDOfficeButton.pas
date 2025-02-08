unit LMDOfficeButton;
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
  LMDCustomSpeedButton;

type
  TLMDOfficeButton=class(TLMDCustomSpeedButton)
  protected
    function RepaintOnMouse: Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AllowAllUp;
    property GroupIndex;
    property Pressed;
    property DropDownMenu;
    property DropDownIndent;
    property DropDownRight;
    property Style;
  end;

implementation

uses
  Controls,
  LMDGraph;

{ ------------------------------ protected ----------------------------------- }
function TLMDOfficeButton.RepaintOnMouse:Boolean;
begin
  result := Style in [ubsFlat, ubsNavigator, ubsDelphiFlat, ubsFlatUnColored];
end;

{------------------------- Public ---------------------------------------------}
constructor TLMDOfficeButton.Create(AOwner: TComponent);
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
 
