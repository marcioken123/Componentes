unit LMDTextRadioGroupButton;
{$I lmdcmps.inc}

{###############################################################################

LMD VCL Series 2016
© by LMD Innovative
-------------------

For support or information contact us at:

email              : mail@lmdsupport.com
WWW                : http://www.lmdinnovative.com
SupportSite        : http://www.lmdsupport.com
Wiki               : http://wiki.lmd.de
Fax                : ++49 6131 4984372

This code is for reference purposes only and may not be copied
or distributed in any format electronic or otherwise except one
copy for backup purposes.

No Component Kit or Component individually or in a collection,
subclassed or otherwise from the code in this unit, or associated
.pas, .dfm, .dcu, .ocx, .dll or ActiveX files may be sold or
distributed without express permission from LMD Innovative.

For further license information please refer to the associated
license html file in \info folder.

################################################################################

LMDTextRadioGroupButton unit ()
-------------------------------

Always keep LMDRadioGroupButton and TLMDTextRadioGroupButton on an equal 
development level!!!!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Messages, classes,
  LMDCustomRadioGroup,
  LMDCustomButtonGroup,
  LMDTextRadioButton;

type
  TLMDTextRadioGroupButton = class(TLMDTextRadioButton)
  public
    constructor CreateExt(Group: TLMDCustomRadioGroup);
    destructor Destroy; override;
    property Transparent default True;
  end;

implementation

uses
  Windows,
  Controls;

{ ------------------------------- public ------------------------------------- }
constructor TLMDTextRadioGroupButton.CreateExt(Group:TLMDCustomRadioGroup);
begin
  inherited Create(Group);
  ControlStyle:=ControlStyle+[csReplicatable];
  Visible:=False;
  ParentShowHint := False;
  Transparent:=True;

  with Group do
    begin
      RegisterButton(Self);
      self.Enabled := Enabled;
    end;
  Parent := Group;
end;

{ ---------------------------------------------------------------------------- }
destructor TLMDTextRadioGroupButton.Destroy;
begin
  TLMDCustomRadioGroup(Owner).UnRegisterButton(Self);
  inherited Destroy;
end;

end.
