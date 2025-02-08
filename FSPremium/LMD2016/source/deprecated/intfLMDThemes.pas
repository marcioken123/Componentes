unit intfLMDThemes;
{$I lmdcmps.inc}
{###############################################################################

intfLMDThemes unit (JH)
---------------------------
Interface for themes support.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}


interface

uses
  Windows, Forms, Graphics, Controls, Classes,
  LMDClass, intfLMDBase;

type
  ILMDThemes = interface(IInterface)
    ['{E795105E-6BB6-4A44-84D3-2E9664BBC1FE}']
    function get_CtlXP:Boolean;
    procedure set_CtlXP (aValue: Boolean);
    function ControlSupportsXP: Boolean;
    property CtlXP: Boolean read get_CtlXP write set_CtlXP;
  end;


  // set CtlXP property for all controls on aParen form
  procedure LMDSetCtlXP(aParent: TCustomForm; Value:Boolean);overload;
  procedure LMDSetCtlXP(aParent: TWinControl; Value:Boolean);overload;

implementation

{ ---------------------------------------------------------------------------- }
procedure LMDSetCtlXP(aParent: TCustomForm; Value:Boolean);
var
  i:Integer;
  itmp:ILMDThemes;
begin
  if not (aParent is TCustomForm) or (aParent = nil) then exit;
  with aParent do
    for i:=0 to ComponentCount-1 do
      if LMDSupports(Components[i], ILMDThemes, itmp) then
         itmp.CtlXp:=Value;
end;

{ ---------------------------------------------------------------------------- }
procedure LMDSetCtlXP(aParent: TWinControl; Value:Boolean);
var
  i:Integer;
  itmp:ILMDThemes;
begin
  if (aParent = nil) then exit;
  with aParent do
    for i:=0 to ControlCount-1 do
      if LMDSupports(Controls[i], ILMDThemes, itmp) then
         itmp.CtlXp:=Value;
end;

end.
