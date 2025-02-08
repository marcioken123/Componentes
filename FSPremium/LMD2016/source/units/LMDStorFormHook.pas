unit LMDStorFormHook;
{$I LMDCmps.inc}

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

LMDStorFormHook unit (VO)
------------------------------


Changes
-------
Release 2.0 (October 2006)
 - Initial Release

###############################################################################}

interface

uses
  Classes, Forms, TypInfo, LMDStorBase;

type
  {****************** TLMDStorFormHook ****************************************}
  //----------------------------------------------------------------------------
  // This class hooks into the FormCreate, FormClose and FormDestroy Event of a
  // Form. Mainly used for components which save/restore certain states
  // of the component
  TLMDStorFormHook = class(TLMDStorComponent)
  private
    FEnabled,                 // replace Form Events?
    FHandled: Boolean;
    FOwnerFormCreate,
    FOwnerFormShow,
    FOwnerFormDestroy,
    FOnLoading,
    FOnSaving: TNotifyEvent;
    FOwnerFormClose: TCloseQueryEvent;
    FID: Integer;
    function GetOwnerForm: TForm;
  protected
    procedure Loaded; override;
    procedure RestoreEvents;
    procedure SetEvents;
    procedure OwnerFormCreate(Sender: TObject); dynamic;
    procedure OwnerFormClose(Sender: TObject; var CanClose: Boolean); dynamic;
    procedure OwnerFormDestroy(Sender: TObject); dynamic;    
    // method for custom features in descendants
    procedure DoOnLoading; dynamic;
    procedure DoOnSaving; dynamic;
  public
    constructor Create(aOwner: TComponent); override;
    property Form: TForm read GetOwnerForm;
    property Enabled: Boolean read FEnabled write FEnabled default True;
    property OnLoading: TNotifyEvent read FOnLoading write FOnLoading;
    property OnSaving: TNotifyEvent read FOnSaving write FOnSaving;
    property ID: Integer read FID;
  end;

implementation
{$IFDEF LMD_DEBUGTRACE}
uses
  Windows, Dialogs;
  {$I C2.INC}
{$ENDIF}

{ ********************** TLMDStorFormHook *************************************}
{------------------------------------------------------------------------------}
function TLMDStorFormHook.GetOwnerForm: TForm;
begin
  result := TForm(Owner);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.OwnerFormCreate(Sender:TObject);
begin
  if Assigned(FOwnerFormCreate) then FOwnerFormCreate(Sender);
  if FEnabled then
    try
      DoOnLoading;
    except
      // eat all Exceptions
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.OwnerFormClose(Sender: TObject;
 var CanClose: Boolean);
begin
  if Assigned(FOwnerFormClose) then FOwnerFormClose(Sender, CanClose);
//  if CanClose and FEnabled then
//    try
//      RestoreEvents;
//    except
      // eat all Exceptions
//    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.OwnerFormDestroy(Sender:TObject);
begin
  if FEnabled and not FHandled then  // for the case not already done afrer OnCloseQuery
    try
      RestoreEvents;
    except
      // eat all Exceptions
    end;
  if Assigned(FOwnerFormDestroy) then FOwnerFormDestroy(Sender);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.Loaded;
begin
  inherited Loaded;
  if not (csDesigning in ComponentState) then SetEvents;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.RestoreEvents;
begin
  // replace our Form events with the original ones
  if Assigned(Form) then
    begin
      Form.OnCloseQuery:=FOwnerFormClose;
      Form.OnCreate:=FOwnerFormCreate;
      Form.OnShow := FOwnerFormShow;
      Form.OnDestroy:=FOwnerFormDestroy;
      FHandled:=True;
      DoOnSaving;
    end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.SetEvents;
begin
  // Replace Form events with our own ones
  if Assigned(Form) then
    with Form do
      begin
        FOwnerFormClose:=OnCloseQuery;
        OnCloseQuery:=OwnerFormClose;
        FOwnerFormCreate:=OnCreate;
        OnCreate:=OwnerFormCreate;
        FOwnerFormDestroy:=OnDestroy;
        OnDestroy:=OwnerFormDestroy;
        FHandled:=True;
      end;
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.DoOnLoading;
begin
  if Assigned(FOnLoading) then FOnLoading(self);
end;

{------------------------------------------------------------------------------}
procedure TLMDStorFormHook.DoOnSaving;
begin
  if Assigned(FOnSaving) then FOnSaving(self);
end;

{------------------------------------------------------------------------------}
constructor TLMDStorFormHook.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  FEnabled:=True;
  FHandled:=False;
end;
{$IFDEF LMD_DEBUGTRACE}
initialization
  {$I C3.INC}
{$ENDIF}

end.
