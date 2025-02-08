unit LMDMRUList;
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

LMDMRUList unit (RM)
--------------------
TLMDMRUList now derived from TLMDBaseMRUList. Adds additional support for
TLMDBaseGraphicButton.

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Menus,
  LMDBaseGraphicButton, LMDBaseMRUList;

type
  {------------------------- TLMDMRUList --------------------------------------}
  {$EXTERNALSYM TLMDMRUListOption}
  TLMDMRUListOption=LMDBaseMRUList.TLMDMRUListOption;
  {$EXTERNALSYM TLMDMRUDisplay}
  TLMDMRUDisplay=LMDBaseMRUList.TLMDMRUDisplay;
  {$EXTERNALSYM TLMDMRUListStyle}
  TLMDMRUListStyle=LMDBaseMRUList.TLMDMRUListStyle;

  TLMDMRUList = class(TLMDBaseMRUList)
  private
    FButton:TLMDBaseGraphicButton;
    procedure SetSpeedButton(aValue:TLMDBaseGraphicButton);
  protected
    procedure AssignPopupMenu;override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function InternalPopupRequired:Boolean;override;
  public
    destructor Destroy; override;
  published
    property Button:TLMDBaseGraphicButton read FButton write SetSpeedButton;
  end;

implementation

{************************* Class TLMDMRUList***********************************}
{--------------------------- Private ------------------------------------------}
procedure TLMDMRUList.SetSpeedButton(aValue:TLMDBaseGraphicButton);
begin
  if aValue<>FButton then
    begin
      if (FButton<>nil) and (aValue=nil) then
        FButton.DropDownMenu:=nil;
      FButton:=aValue;
      if FButton<>nil then
        FButton.FreeNotification(Self);
      UpdateMenu;
    end;
end;

{--------------------------- Protected ----------------------------------------}
procedure TLMDMRUList.AssignPopupMenu;
begin
  inherited;
  if Assigned(FButton) then
    FButton.DropDownMenu:=FPopupMenu;
end;

{------------------------------------------------------------------------------}
function TLMDMRUList.InternalPopupRequired: Boolean;
begin
  result:=inherited InternalPopupRequired or Assigned(FButton);
end;

{------------------------------------------------------------------------------}
procedure TLMDMRUList.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (AComponent=FButton) and (Operation=opRemove) then Button:=nil;
end;

{--------------------------- Public -------------------------------------------}
destructor TLMDMRUList.Destroy;
begin
  if Assigned(FPopupMenu) and Assigned(FButton) then
    FButton.DropDownMenu:=nil;
  inherited Destroy;
end;

end.
