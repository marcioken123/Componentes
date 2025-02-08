unit LMDCustomComponent;
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

LMDCustomComponent unit (RM)
-----------------------------
Base control for all nonvisual LMD Controls

Changes
-------
Release 8.0 (September 2006)
 - Initial Release

###############################################################################}

interface

uses
  Windows, Classes, intfLMDBase, LMDTypes;

type
  TLMDCustomComponent = class(TComponent, ILMDComponent)
  private
    FAbout    : TLMDAboutVar;
    FOnChange : TNotifyEvent;
  protected
    FUpdateCount: Word;
    procedure GetChange(Sender:TObject);dynamic;
    procedure Change; dynamic;
    property About:TLMDAboutVar read FAbout write FAbout stored false;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create (AOwner: TComponent); override;
    procedure BeginUpdate;
    function IsUpdating:Boolean;
    procedure EndUpdate(aValue:Boolean=True);
    function getLMDPackage:TLMDPackageID;virtual;
  end;

implementation

{$IFDEF LMD_DEBUGTRACE}
uses
  Dialogs;{$I C2.INC}{$ENDIF}
  {****************** Object TLMDCustomComponent ********************************}
{------------------------- Protected ------------------------------------------}
procedure TLMDCustomComponent.Change;
begin
  if IsUpdating then exit;
  if Assigned(FOnChange) then FOnChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComponent.GetChange(Sender:TObject);
begin
  Change;
end;

{------------------------------------------------------------------------------}
constructor TLMDCustomComponent.Create (AOwner: TComponent);
begin
  inherited Create(AOwner);
  FUpdateCount:=0;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComponent.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

{------------------------------------------------------------------------------}
function TLMDCustomComponent.IsUpdating: Boolean;
begin
  result:=FUpdateCount>0;
end;

{------------------------------------------------------------------------------}
procedure TLMDCustomComponent.EndUpdate(aValue:Boolean=True);
begin
  if FUpdateCount>0 then Dec (FUpdateCount);
  if FUpdateCount = 0 then
    if aValue then Change;
end;

{------------------------------------------------------------------------------}
function TLMDCustomComponent.getLMDPackage: TLMDPackageID;
begin
  result:=pi_LMD_TOOLS;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC} 
{$ENDIF}
end.
