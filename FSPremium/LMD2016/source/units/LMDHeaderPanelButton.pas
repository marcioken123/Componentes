unit LMDHeaderPanelButton;
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

LMDHeaderPanelButton unit (JH)
------------------------------

Control button for the TLMDHeaderPanel control Can reopen a closed 
TLMDHeaderPanel Displays the header panels state ... 
This button can be used, but must not!

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, Controls,
  LMDCustomSpeedButton, LMDCustomHeaderPanel;

type
  TLMDHeaderPanelButton = class (TLMDCustomSpeedButton)
  private
    FHeaderPanel         : TLMDCustomHeaderPanel;
    procedure SetHeaderPanel (aValue: TLMDCustomHeaderPanel);
  protected
    procedure DoModeChange (Sender: TObject);
    public
    procedure Notification(AComponent: TComponent; Operation: TOperation ); override;
    procedure Click; override;
    published
    property HeaderPanel: TLMDCustomHeaderPanel read FHeaderPanel write SetHeaderPanel;
    property ButtonStyle;
  end;

implementation

uses
  LMDGraph,
  LMDButtonBase;

type
  TLMDHPCrack = class (TLMDCustomHeaderPanel)
  public
    property OnModeChange;
  end;

{ ------------------------------------ private ------------------------------- }
procedure TLMDHeaderPanelButton.SetHeaderPanel (aValue: TLMDCustomHeaderPanel);
begin
  if Assigned (FHeaderPanel) then
    TLMDHPCrack(FHeaderPanel).OnModeChange := nil;
    FHeaderPanel := aValue;
  if Assigned (FHeaderPanel) then
    begin
      TLMDHPCrack(FHeaderPanel).OnModeChange := DoModeChange;
      DoModeChange (self); //update ourselves ...
    end;
end;

{ ------------------------------------ protected----------------------------- }
procedure TLMDHeaderPanelButton.DoModeChange (Sender: TObject);
begin
  DisabledGrayed := false;
  self.StateChange (bsUp); //remove any bsDropDownOpen state
  if FHeaderPanel.Pinned then
    begin
      ButtonLayout.Arrow := false;
      Enabled := false;
    end
  else
    begin
      ButtonLayout.Arrow := true;
      Enabled := true;
    end;
end;

{ ------------------------------------ public -------------------------------- }
procedure TLMDHeaderPanelButton.Notification(AComponent: TComponent; Operation: TOperation );
begin
  inherited Notification (AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FHeaderPanel) then
    HeaderPanel := nil;
end;

{ ---------------------------------------------------------------------------- }
procedure TLMDHeaderPanelButton.Click;
begin
  inherited;
  if not Assigned (FHeaderPanel) then exit;

  if FHeaderPanel.Visible = false then
    begin //popup header panel, sysbutton style sbPin
      FHeaderPanel.Open;
      //make button look like pressed
      self.StateChange (bsDropDownOpen);
    end
  else
    if FHeaderPanel.UnPinned then
      FHeaderPanel.Close; //hide it again
end;

end.
