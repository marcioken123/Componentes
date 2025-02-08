unit LMDObject;
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

LMDObject unit (RM)
------------------
Base class for all LMD TPersistent objects.

ToDo
----

Changes
-------
Release 8.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes;

type
  {----------------------TLMDObject--------------------------------------------}
  TLMDObject = class(TPersistent)
  private
    FOwner    : TPersistent;
    FOnChange : TNotifyEvent;
    FUpdate   : Byte;
  protected
    procedure GetChange(Sender: TObject); dynamic;
    procedure Change; dynamic;
    constructor Create(Owner: TPersistent=nil); virtual;
  public
    function GetSetStr : String; dynamic;
    procedure BeginUpdate;
    procedure EndUpdate(aValue:Boolean=false);
    function IsUpdating:Boolean;
    property Owner:TPersistent read FOwner;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
  uses windows, dialogs;
  {$I C2.INC}
{$ENDIF}
{------------------------- Protected ------------------------------------------}
procedure TLMDObject.Change;
begin
  if FUpdate=1 then exit;
  if Assigned(FOnChange) then FOnChange(Self);
end;

{------------------------------------------------------------------------------}
procedure TLMDObject.GetChange(Sender:TObject);
begin
  Change;
end;

{---------------------------- Public ------------------------------------------}
constructor TLMDObject.Create;
begin
  inherited Create;
  FUpdate := 0;
  FOwner := Owner;
end;

{------------------------------------------------------------------------------}
function TLMDObject.GetSetStr : String;
begin
  result := '';
end;

{------------------------------------------------------------------------------}
procedure TLMDObject.BeginUpdate;
begin
  FUpdate:=1;
end;

{------------------------------------------------------------------------------}
procedure TLMDObject.EndUpdate(aValue:Boolean);
begin
  FUpdate:=0;
  if aValue then Change;
end;

{------------------------------------------------------------------------------}
function TLMDObject.IsUpdating:Boolean;
begin
  result:=FUpdate<>0;
end;

{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C1.INC}
{$ENDIF}

end.
